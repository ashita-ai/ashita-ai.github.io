---
layout: post
title: "Review After Generation Got Cheap"
date: 2026-05-12
category: "architecture"
---

In October 1978, Stephen C. Johnson published a Bell Laboratories technical report titled *Lint, a C Program Checker*. It described a small program he had written earlier that year. The program read C source files and flagged constructs that compiled cleanly but were probably wrong: assignments inside conditionals, fall-through in switch statements, dead code, type misuse. The compilers it was meant to complement focused on producing object code; they did not perform deep analysis. Johnson took those checks and made them their own program.

The shape was older than the tool. Generation and verification could not share the same discipline. The compiler's job was to accept code and produce object files. The linter's job was to read the same code with a different mindset and doubt it. Composing the two was what made the system safe to write code in fast.

That asymmetry has reopened. AI agents generate code at unprecedented rates. The compiler accepts it. The bot reviewer fires off a comment in 15 seconds. The diff is well-formed. The PR description is plausible. The bug rate per line is in roughly the same neighborhood as human-written code; the rate of code is much higher. The bottleneck has moved.

This post is about what good review has to do in this regime. It is also about what does not change.

## Where the bottleneck went

Generation got an order of magnitude faster, depending on the task. Sometimes two. Review did not. The math: the new bottleneck is reviewer attention.

Three naive responses fail.

**Trust the bots wholesale.** A bot whose findings are fifty percent noise teaches the reviewer to ignore everything the bot says. After the third spurious finding the reviewer is no longer reading. The bot's signal is the next real bug it flags, which the reviewer will skim past with the rest. There is no policy that recovers from this short of the reviewer regaining trust, which they will not.

**LGTM faster.** Skipping review at higher rates lets a specific class of bug travel through unchanged. A helper catches its own exceptions, logs the failure, and returns void. The caller's next line uses absence-of-exception as proof the side effect happened. The two are not the same. A bot reading the syntax catches it; a human reading the diff does not, because the helper's name is reassuring. The bug ships, and the cost lands later, on a path nobody is watching.

**Ban AI-generated code.** The floor moves. Competitors who figure out review at scale ship faster, with more variations, against the same backlog. Banning is a temporary measure for a few weeks while a team builds the discipline that lets it accept the change. It is not a strategy.

Adding reviewers is linear cost. The asymmetry is sublinear in machine time and linear in human time, and that gap cannot be papered over with headcount. It has to be closed structurally.

## What good review has to do

Five principles. Each is a design move that the bottleneck makes mandatory.

**Editorial bias.** Not every review axis is equal. The cost of missing a perf regression is recoverable; the cost of missing a durability or paper-trail issue is asymmetric and often invisible until much later. A review prompt that scores eleven dimensions on a 1–100 scale and treats them as commutative is decoration. A review prompt that says *durability and paper-trail are paramount* and weights them load-bearing is an instrument. The bias is the thing the prompt is for. The numerical scores are anchoring theater; the editorial weighting is what actually changes what the reviewer reads.

**Observable post-conditions.** The class of bug AI reviewers catch and humans skim past is the swallow-helper-with-position-flag pattern. A helper catches its own exceptions, returns void; the caller's next line treats absence-of-exception as proof of side effect. Therac-25's `Class3` overflow is the canonical instance at safety-critical scale. A one-byte counter, incremented every cycle, never reset; it overflowed to zero on every 256th pass; the collimator-position check was gated on `Class3 != 0` and was therefore skipped on those passes; the malfunction flag the interlock read stayed at zero — not because the collimator had been verified, but because the verification had not run. The interlock could not tell the difference. The flag value was a proxy. The proxy was wrong on the worst possible path. Software is full of the same shape at smaller scale: lock acquisitions that swallow timeout, audit-stamp helpers that log on failure, message publishes that catch broker errors. The reason bots catch this and humans don't is that bots don't trust the helper's contract. They read the syntax and ask what does the proxy actually prove.

**Calibrated approximation.** Review tools have heuristic context. Callers found by import-grep instead of type resolution. A subset of files indexed. A sample of tests run. The approximation is real and unavoidable; the discipline is to make it observable downstream. A review system that knows its context is heuristic should: cap confidence on findings built from heuristic context, annotate the prompt the model itself sees with the approximation note, and disclose coverage in the summary comment so the human reviewer reads the calibration alongside the finding. A finding that does not surface its own uncertainty is the same shape of `Class3 == 0` at a higher layer. The reader cannot tell whether the silence is consent or absence.

**Triage, not capping.** Confidence-tiered posting: inline on the diff line for high, summary table for medium, suppression for low. *No cap on inline findings.* Capping creates a fix-and-rerun treadmill — the author fixes five, pushes, sees five more, pushes again, sees five more. The review never converges. Surface everything in one pass; let the author triage in one read. Capping is what teams reach for when the bot's signal-to-noise is bad. The right fix is the signal, not the cap.

**Feedback that closes the loop.** A review system without a feedback signal drifts. False-positive rate grows; reviewers stop reading; the bot becomes noise. The loop is cheap to build — emoji reactions on inline comments, post-merge incident tags, *was this helpful* footers, PR-merge-without-revert as a weak positive label — but it is not free, and it is not optional. The system that grades itself is the only one that improves. Every review tool that does not have one will reach the noise floor and be turned off, and every team that turns one off will reinvent the wheel six months later.

## The discipline that does not change

Lint introduced the discipline of *flagging suspect-but-legal patterns* — code the compiler accepts that the linter doubts. The discipline survived because it was not tied to the C compiler's specific checks. It was about a verification stage with a different mindset than the generation stage. The compiler accepts. The linter doubts.

The line runs through cflow, [splint](https://splint.org), [SonarQube](https://en.wikipedia.org/wiki/SonarQube), [Pylint](https://en.wikipedia.org/wiki/Pylint), [Pyright](https://github.com/microsoft/pyright), [eslint](https://eslint.org), and [`go vet`](https://pkg.go.dev/cmd/vet). Every one of them is the same shape. Generate. Doubt. Compose. The 1978 lint warning about `if (x = 1)` and a 2026 review finding about a swallow helper whose `F$mal`-equivalent the next caller is reading are the same kind of statement: *this is syntactically legal and looks reasonable, and I do not believe what it appears to be doing.* The verification stage holds the doubt. The generation stage, by construction, cannot hold its own doubt. That is what makes it generation.

What makes the LLM era different is the rate. Lint reviewed code humans wrote at human rates. Modern review tools review code agents wrote at agent rates. The discipline is the same; the throughput requirement is qualitatively different. That is why every serious AI-review design ends up reaching for the same five principles: editorial bias, observable post-conditions, calibrated approximation, triage rather than capping, feedback that closes the loop. The principles are not novel. They are what the bottleneck makes mandatory.

One open-source attempt at most of these is being sketched by [Dan Getz](https://www.linkedin.com/in/dangetzjr/) under the name [Mimir](https://github.com/Mimir-Review/mimir). It is largely his design — an explicit `IsApproximate()` signal on the semantic index that propagates to confidence ceilings, prompt annotations the model sees, and disclosure on the summary comment; a confidence-tiered posting strategy with no cap on inline findings; bounded fan-out with task isolation so one failed task does not cancel its siblings; feedback via PR-comment reactions stored as labeled events. We have started thinking through it together. If the design problem is interesting, reach out to him, or me.

## What I am still figuring out

Whether the asymmetry stays. The encoded layer of review — type systems, formal methods, specific lint rules — probably gets absorbed back into the generation stage as models learn to generate code that satisfies more constraints. The contradictory-signal layer — *intent vs. implementation*, *contract vs. enforcement*, *surface vs. subtext* — probably does not, because the doubt at that layer is structural, not pattern-matchable. I lean toward the asymmetry staying at that layer, with the human reviewer's job narrowing onto it. But the timeline is uncertain and I have not seen this play out long enough to be sure.

Whether the feedback loop solves itself. A bot whose findings become labeled training data eventually trains away its FP rate. But the labels are sparse, biased, and late: humans label loud findings more than quiet ones, suppressed findings never see a label, post-merge incidents arrive months after the PR. The loop probably does not solve itself. It has to be designed in, with explicit signals — reactions, merge-without-revert windows, incident-to-PR back-references — that make the otherwise-implicit calibration visible to the system. The cheap version of that design is the version most teams will skip and then need.

---

In October 1978, Stephen Johnson took a class of bugs that the compiler used to catch and put them into a separate program with a different mindset. The principle behind it has run through every static-analysis tool since, and it is now running through the AI-review tools that 2026's PR pipelines are being rebuilt around. Each generation of infrastructure externalizes another piece of what a prior tool used to do. Lint took back the checks the C compiler stopped doing. AI review is taking back the checks that scale defeated when generation got cheap. The next stage is whatever does not yet exist, and it will exist because the cost of not having it passes a threshold no one had measured in advance.

Generation accepts. Verification doubts. The principle Stephen Johnson made visible in 1978 was that the two stages could not share a discipline. He was right then for one reason. He is right now for a different one.
