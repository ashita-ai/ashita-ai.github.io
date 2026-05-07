---
layout: post
title: "Observable Post-conditions"
date: 2026-05-12
category: "architecture"
---

On January 17, 1987, a Therac-25 radiation accelerator at the Yakima Valley Memorial Hospital fired its full 25-MeV electron beam at a patient with the X-ray target out of position. The dose was about a hundred times what had been prescribed. The mechanism was a one-byte integer.

The Therac-25's safety interlock read a malfunction flag called `F$mal`. If `F$mal` was zero at the end of the prescription setup, the system was understood to be consistent and treatment was allowed to proceed. `F$mal` was set by a routine called `Chkcol`, which verified the upper collimator's physical position. `Chkcol` was only called when a counter named `Class3` was non-zero. `Class3` was incremented on every pass through the setup routine. It was never reset.

A one-byte integer holds values from zero to 255. On every 256th pass through the setup, `Class3` overflowed back to zero. On those passes, `Chkcol` was not called. `F$mal` stayed at zero — not because the collimator had been verified, but because the verification had not run. The interlock read the zero, treated it as consent, and the beam fired.

The Therac-25 had several bugs and the Yakima accident is not the most famous one. It is the cleanest. The bug was not the integer overflow. The bug was that a flag whose zero value could mean two different things — *verified clean* or *not checked* — was the only signal the interlock had. The post-condition the safety system actually depended on was the upper collimator's physical position. The interlock could not observe the post-condition. It could only observe a proxy. The proxy was wrong on the worst possible path.

Every account of the Therac-25 reaches for the dramatic detail — 25 MeV through a target-less beamline, the months between exposure and death. The structural detail is the one that travels. A `void` post-condition leaves the next caller to read whatever residue is at hand, and the residue is rarely sufficient. This essay is about that shape. It does not require a one-byte counter or a radiation accelerator to reproduce.

## The pattern

A helper does work, catches its own exceptions, logs the failure, and returns void. The caller continues to the next line. What does the next line prove?

It proves the helper did not raise. It does not prove the side effect happened. The two are not the same.

If the caller's subsequent control flow — a guard flag, a branch, an `if rows_present:`, a "did we publish" check, a downstream telemetry stamp — depends on the side effect, then "no exception propagated" is not enough. Success has to come from the helper's return value, or the helper has to raise. Otherwise the post-condition is unobservable to the caller, and the caller is reading the same shape of zero that the Therac-25 read: a value that means either *it happened* or *it failed and was logged*, with no way to distinguish.

The two contracts a helper can have are different in kind, not in degree. The first raises on failure: the next line proves the side effect succeeded, and failure is loud at the call site. The second swallows on failure, logs, and returns void: the next line proves only that the helper did not throw, and failure is silent at the call site, audible only to whoever reads the log later, when the consequence has already happened.

The second contract is fine where no subsequent decision depends on the side effect — true fire-and-forget telemetry, optional caches whose absence the caller is prepared for, idempotent stamping where the caller has already accepted that the call may or may not have stuck. The contract is a bug factory the moment a guard, a branch, or any "did this land?" check downstream hangs off the side effect. Which is most places.

## The shapes that recur

The pattern repeats in unrelated parts of a codebase, joined only by this one structural property.

**Locks.** A `try_acquire(timeout)` helper that catches the timeout internally and returns void. The caller continues, believes it has the lock, does not. The fix is in the helper signature: `bool try_acquire(timeout)` returns whether acquisition succeeded; the caller branches on the return.

**Idempotent writes.** An `upsert` helper that catches duplicate-key on retry — fine for idempotency, but the caller often needs to know whether *this* call wrote or whether a prior call already had. "It is idempotent" does not say which. If a downstream "first writer wins" branch reads the wrong answer, the data path forks.

**Telemetry and audit stamps.** A `_stamp_audit_row` helper that catches DB errors, logs, and continues. Three lines later, downstream code branches on `audit_row_present` as a guard. The audit row is missing on exactly the failure paths where the guard is most load-bearing. The system runs. The paper trail rots.

**Message publishes.** A `queue.publish()` that catches broker errors. The caller continues, hands the customer a 200, and the message is lost. The customer's downstream system expects the message and stalls. The producer's logs name the broker error; the consumer has nothing to read.

**Cache writes.** A `cache.set()` that swallows transient connection errors. Call sites that depend on read-your-writes consistency drift. The drift is silent until a user notices their dashboard is stale.

**Replication acks.** Code that treats *WAL flushed locally* as *WAL persisted to every replica*. A failover later loses writes. The post-mortem reconstructs from upstream logs because the WAL paper trail does not extend across the break.

Each of these is a shape of `Class3 == 0`. The flag the caller reads — return value, error count, row presence, log line — can be in the desired state for two reasons: the side effect happened, or the side effect did not happen and the helper swallowed the failure. The caller cannot tell which. [Three Mile Island](/blog/reversibility-as-default/) read an indicator labeled *valve closed* that meant only *close signal sent*. [Knight Capital's 2012 deploy](/blog/the-implicit-operator/) reported success on the wire while one of eight servers retained the dormant code the new flag was supposed to be replacing. The shapes are not coincidence. They are the same failure at different scales.

## Why bots catch this and humans miss it

The reasoning that misses the bug is the reasoning that composes well: trust the contract. If a helper's signature says it does X, calling it must mean X happened. This is how composition is supposed to work. It is also how `void` swallow contracts get a free pass for years before an incident teaches the team to look at them differently.

The reasoning that catches the bug is adversarial line-by-line: for every line in a diff, ask *what if this line fails or no-ops?* — not *what if the next operation fails?* The latter is the natural human failure mode. It is the question the engineer asks during code review when the cursor is sitting on the line that has just been added. The former is the question a static analyzer asks. The analyzer does not trust the helper's contract because it does not have a notion of one. It has a syntax tree.

Lint tools and PR bots are good at this because they are not socialized into trust. They will flag a `try` block whose `except` catches a broad exception class, returns void, and is followed by code that uses a state variable as a guard. The pattern is detectable mechanically. Engineers tend to skim past it during review because the helper's name is reassuring.

The discipline this asks of human review is to apply the analyzer's stance — trust nothing, verify the post-condition observably — to a layer of the code where the human reviewer's instinct is to trust. That instinct is right most of the time. The question is what fraction of the time it is wrong, and what the cost of the wrong cases is. For data loss and audit trails, the cost is asymmetric: the cost of a missed verification is invisible until a customer notices, until an auditor asks, until a failover loses writes. The cost of an extra return value or an extra raise is one line of code.

## What survives

Three rules follow, each a post-condition discipline applied at a different scope.

**Make `void` rare on critical paths.** If the caller's next decision depends on a side effect, the helper signature has to expose whether the side effect happened. A `bool` return is the minimum. A typed `Result` with explicit error variants is better. A `void` helper is acceptable when the call is genuinely fire-and-forget — telemetry, optional caches, best-effort stamping where the caller is prepared for absence. The default for critical-path helpers should be that they raise on failure or return whether they succeeded. The default should not be silent.

**Treat *is logged* and *is durable* as different facts.** A log line that says "stamp failed" is not a stamp. The stamp's absence is the durable signal; the log is a breadcrumb that may or may not be read. Audit trails that exist only as log lines — never as rows in an append-only table — are paper trails the next caller cannot consult. The next caller can only consult what the next caller can query. Logs are for humans during incidents. The audit trail is for the system to reason about itself.

**Enforce at the layer below the application.** A `COMMENT ON TABLE … 'Immutable'` is documentation, not enforcement. A `BEFORE UPDATE OR DELETE` reject trigger plus `FORCE ROW LEVEL SECURITY` plus an explicit `REVOKE` of write permissions is enforcement. The first describes intent in a place an engineer might read it. The second makes the post-condition observable to the database engine, where bugs and compromised service-role tokens have to satisfy it. Intent in a comment and enforcement in a trigger are not the same; treating them as the same is `Class3 == 0` at a different layer of the stack.

These rules are not novel. Every senior engineer has seen one of them paid for in an incident. The reason they recur in post-mortems is not that they are unknown. It is that the cost of paying for them upfront — one extra return value, one extra reject trigger, one extra type variant — is concrete, while the benefit is counterfactual. The economics of paying for an absence are bad in the same way [the economics of paying for the implicit operator](/blog/the-implicit-operator/) are bad. The cost is paid in DX complexity now. The benefit is paid in incidents that don't happen at 3 a.m.

What durable systems have in common is not that they avoided every silent failure. It is that, every time one was paid for, the team made the next caller's post-condition observable. The function signature got longer. The schema acquired a constraint. The deploy pipeline grew a verification step. The contract grew, one signature at a time, in the direction of saying out loud what the side effect was.

## What I am still figuring out

Whether this discipline scales down to one-off scripts, glue code, ad-hoc notebooks. The cost of explicit error returns is real, and it is paid more conspicuously in code that nobody is going to read again. There is a regime in which a swallow-and-log helper is a reasonable trade — single-shot, low-stakes, the failure mode is "rerun the script." The line between that regime and the one where silent failure is unacceptable is not where I want it to be. I have caught myself and others reaching for the same swallow contract on glue code and on production helpers, with the same hand. The line probably belongs at "does the next decision in the program depend on this?" — but in a script that will be deleted next week, the answer is rarely obvious before the script writes a row that someone reads next quarter.

Whether the typed-error languages — Rust's `Result`, Go's explicit error returns, Haskell's `Either` — actually push teams toward observable post-conditions in practice, or whether the same swallow shape just shows up as `let _ = …` and `if err != nil { log.Print(err) }` and `_ <$ try`. The languages make the right thing easier. Whether the discipline follows is an empirical question I have not done justice to. The Therac-25 was written in PDP-11 assembly. A modern type system would have refused to compile some of its bugs and shrugged at others — the `Class3` overflow is a wrapping unsigned add, which release-mode Rust tolerates without complaint. The linguistic guardrails matter; they are not the whole job.

---

The Therac-25 ran for two years and three months between the first overdose at Kennestone in June 1985 and the last at Yakima in January 1987, killing at least three patients across six known accidents. The fix to the `Class3` overflow, [described by Leveson](http://sunnyday.mit.edu/papers/therac.pdf) in her standard treatment of the case, was to set `Class3` to a fixed nonzero value on each pass instead of incrementing it — a one-line change that severed the link between counter overflow and verification skip. The deeper fix was harder. It was that the safety interlock had been reading a flag that could mean two things, and the rest of the program could not tell them apart.

Every helper contract has the same choice. The function signature is the contract. `void` is a promise the caller cannot verify. A return value or a raise is one they can. The work of building durable systems is the work of making the post-conditions observable to the next caller, one signature at a time, each one paid for by an incident that the signature, written one revision earlier, would not have permitted.
