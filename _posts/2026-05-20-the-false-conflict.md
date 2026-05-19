---
layout: post
title: "The False Conflict"
date: 2026-05-20
category: "architecture"
---

On May 8, 1985, Larry Wall posted version 1.3 of `patch` to the `mod.sources` [Usenet newsgroup](https://en.wikipedia.org/wiki/Patch_(Unix)). The problem it solved was distribution: people sharing source code over 300- and 1,200-baud modems could not move megabytes of it around, so they moved diffs instead, and `patch` applied a diff to a local copy. The interesting part is not the format it consumed. It is the two design decisions Wall made about a diff that no longer fit.

A diff records each change — each *hunk* — at a line offset: replace what is at line 412 with this. By the time a diff reached a recipient whose copy had drifted, those offsets were wrong. `patch` did not trust them blindly. It located each hunk by the unchanged lines surrounding it, and if the surrounding lines had moved, it applied the hunk anyway. What it genuinely could not place, it did not force. It wrote the orphaned hunk into a `.rej` reject file and left it, visibly, for a human.

Encoded in those two decisions is a distinction the rest of this post is about. A line number is an address, not an identity. A hunk that fails to apply at line 412 is not necessarily in conflict with anything — line 412 may simply have moved. But a hunk whose surrounding context is gone is a different matter, and `patch` refused to guess about it. Forty-one years later, that is still the line a system has to draw when it applies one version of a thing onto another.

## The question the last post left open

I argued [last week](/blog/branching-came-late-to-data/) that data branching is reaching for the wrong primitive when it reaches for *merge*. Git's three-way merge works because most code conflicts are line-local and most lines do not depend on one another transactionally. Rows with foreign keys, triggers, and partial uniqueness do not have that property. The better primitive is *promote*, in the sense Terraform uses *apply*: a branch is not a sibling of `main`, it is a proposed change to production, and you apply it onto whatever production now is.

That argument has an unanswered hard part. When a branch's work is applied to a production that has moved since the fork, the system has to look at each mismatch between the two and decide what kind of mismatch it is. Some are real disagreements about what the data means. Some are not — they are artifacts of how the data was addressed. `patch` made exactly that decision for text in 1985. Promote has to make it for rows. This post is about that line, and about a piece of recent work that draws it unusually cleanly.

## The false conflict

A false conflict is a mismatch that a system reports as a conflict but that is not a conflict in the thing the user actually cares about. It is an artifact of representation. The term has a lineage in concurrency control: in software transactional memory, a *false conflict* is one that coarse conflict detection reports when two transactions touch the same cache line or hash bucket without touching the same logical datum. The sense here is that one, widened from memory words to rows. Every engineer has resolved a merge conflict that, on inspection, was not a disagreement about behavior at all — a reformatting pass, a function that moved, two unrelated edits the line-based differ could not see were unrelated. The meaning was never contested. The conflict lived entirely in the encoding.

The cost of a false conflict is not the conflict itself. It is what the conflict consumes: a person's attention, spent adjudicating a disagreement that does not exist. Hold that thought — it is where this connects to the two posts before the last one.

## The address that dangles

Apache Iceberg is an open table format: a layer of metadata over data files in object storage that gives them table semantics — snapshots, schema evolution, atomic commits. A row deletion in Iceberg can be recorded without rewriting the data file. Instead the table records a *position delete*: in this file, at this row position, a row is gone.

Compaction is the routine background job that rewrites many small data files into fewer large ones. It is advertised, correctly, as a logical no-op — not one row is added or removed; the table's contents are identical before and after. It is purely a physical reorganization for read performance.

But compaction removes the old files from the current table layout. The objects may remain for snapshot isolation and time travel until old snapshots expire, but they are no longer the files the live table is built from. A position delete prepared against the old layout carries coordinates — *file X, position 6* — and after compaction, file X is stale as an address. Iceberg's optimistic concurrency control sees that the delete and the compaction both touched file X, and rejects the delete's commit. The delete was logically fine. The table the user wanted is perfectly well-defined: it is the compacted table, minus that one row. The rejection happened because the delete identified its row by *location*, and compaction is precisely the operation that relocates rows without changing them.

That is a false conflict, in the exact sense above. The delete and the compaction do not disagree about the contents of the table. They disagree only about where a row sits.

## The compaction map

Chris Douglas has prototyped a fix on the `cmpmap` branch of a fork of Apache Iceberg, documented in [`compaction_maps.md`](https://github.com/cdouglas/iceberg/blob/cmpmap/docs/docs/compaction_maps.md). The mechanism is a *compaction map*: when compaction rewrites files, it records how each surviving row position moved — a translation table from old `(file, position)` to new `(file, position)`. That artifact lets the on-map case be rebased: compaction operations can automatically resolve conflicting concurrent position deletes when conflict resolution is enabled, while application transactions can catch the compaction conflict, remap their deletes through the map, and retry. The document is explicit that this is a correctness requirement and not an optimization: committing a stale position reference risks corrupting the table.

This is `patch`'s context matching, rebuilt for a table format. The context lines that let `patch` relocate a drifted hunk and the compaction map that relocates a drifted delete are one idea — moving a change expressed against one representation onto another, without putting a human in the path.

The most useful part of the document is where it stops. Compaction maps cover *order-preserving* rewrites — bin-packing, the combining of small files into larger ones, and merge compactions where deletes are applied during the scan. They explicitly exclude sorted and Z-ordered compaction, not because those rewrites change the table's logical contents, but because they are order-changing: the run-length encoding degenerates, and a position delete is no longer the right representation. For those cases, the document points to equality deletes or to accepting that stale position deletes are invalidated.

Where the maps reach *further* than a single rewrite is in sequence: when several compactions land between a transaction's start and commit, their maps compose, and the delete is remapped through the whole chain. But two compactions that race on the *same* files have no such composition — and here I am reasoning past the document, which treats compaction against application transactions rather than compaction against compaction. Iceberg's optimistic concurrency rejects the second commit, and nothing remaps it: each compaction produced its own target layout from the same source, so there is no single post-state to translate onto.

## What that boundary is actually about

The boundary the compaction-map document draws is the boundary `patch` drew with its reject file, and it is the boundary every promote operation has to draw. It separates two kinds of mismatch.

A mismatch is **representational** when the change's effect is fixed and known, and only its address needs translating. A bin-pack rewrite moves a row without touching its content; the row's new position is a recorded fact in the map; the delete can be relocated mechanically. `patch`'s drifted hunk is the same case — the edit is fixed, only the line number moved. So is a row in a branched database whose surrogate id collides with production's because both branches drew numbers from the same sequence: the row is fixed, only its number is wrong.

A mismatch is **off-map** when computing the safe result requires information the representation map does not carry. Off-map names a condition, not yet a verdict: the map has run out, and what lies past it still has to be identified. In Iceberg, sorted and Z-ordered compactions are off-map: still logical no-ops, but no longer address translations of the kind compaction maps are meant to encode. Two racing compactions are off-map for a different reason: they have no joint post-state at all. In an OLTP database, off-map resolves almost always to a single verdict — the one the rest of this post calls **semantic**: a value update whose correct result depends on content that changed, a predicate delete whose target row set may have drifted, or a surrogate key that has escaped through an API and become part of the outside world's history. `patch`'s `.rej` file is the same admission: the context this hunk depended on is gone, I cannot honestly place it, here it is — you decide.

The principle underneath all of it: a system can translate an *address* when it has a proven meaning-preserving map. It cannot reconstruct an *effect whose value depends on content that moved*, and it should not pretend that an internal address is still internal after it has crossed the system boundary. Holding that line is what separates an honest promote from a guess.

## The same line, for a database branch

A branch of a production database, promoted, faces exactly this. The branch did work against a fork-time copy; production moved on; promotion has to apply the branch's work to current production and decide, change by change, which side of the line each one falls on. Three tiers fall out of it.

**Physical** mismatches are storage-level — which page a row occupies, index state, bloat. They are resolved automatically and never surfaced. They are below the question.

**Representational** mismatches are logical but arbitrarily encoded, and the internal surrogate key is the clearest case. A branch inserted 200 rows; the forked sequence assigned them ids 5001–5200; production's sequence, advancing independently, has also issued 5001–5050 to real rows. The ids collide. If the surrogate is still internal to the database boundary, it carries no external meaning — it is identity-by-allocation for rows. Renumber the branch's rows, cascade the change to foreign keys, promote. No human. This is the bin-pack case: the rows' effect is fixed, only their address needs translating. If the same id has already gone out through an API, a customer-visible URL, a webhook, or an analytics export, it is not merely an address anymore. It has become a fact in another system, and renumbering it would falsify history.

**Semantic** mismatches are genuine disagreements about meaning. A branch computed `balance = balance - 100` against a fork-time balance of 500 and stored 400. Production, meanwhile, added 50. Promoting the literal 400 is wrong — its base is stale — and re-deriving the right value requires the branch's *intent*, not its recorded result. The value depends on content that moved. This is the OLTP off-map case. It does not remap. It escalates.

The test that separates the last two, stated once: a conflict is representational if it dissolves under a change of representation, and semantic if it survives every representation. Re-express both sides in terms of stable logical identity rather than identity-by-location; if the conflict disappears, it was never real.

The case worth dwelling on is the one where the tier is invisible from the outside. Two branches each insert a row; neither violates a unique constraint alone; the union does. If the colliding column is an internal surrogate id, the conflict is representational — renumber one side. If that id has crossed the system boundary, or if the colliding column is a natural key, an email address, the conflict is semantic, because the value *is* the meaning and renumbering it would be falsifying data. Same-shaped conflict, opposite tiers. The line between representational and semantic runs straight through a mismatch that looks identical until you ask what the colliding column means.

## The prerequisite nobody gets to skip

All of this depends on something that has to exist first. You cannot classify a conflict unless there is some way to recognize the thing being moved that is independent of the address that moved. `patch` had context lines — the surrounding text is a content-based identity for a hunk. Iceberg's compaction map supplies the substitute for position deletes: not a stable row identity in the abstract, but a proven route from old position to new position for the rows that survived the rewrite.

Postgres branch promotion needs the same identity, and it is harder to come by, because the surrogate key — the column most schemas use *as* identity — is exactly the representational address that promotion has to be willing to rewrite. The identity that classification depends on has to come from somewhere else: a natural key, the row's content, a declared intent. A schema whose only identity is its surrogate key gives a promote engine no way to tell tier 2 from tier 3. It can only guess. This sits upstream of the entire [branch contract](/blog/contracts-as-infrastructure/), and it is the part that is least solved.

## Why this is the same essay as those two earlier ones

[The Implicit Operator](/blog/the-implicit-operator/) argued that durable systems progressively move into the wire the judgments a competent operator once made in their head, and that Terraform's plan/apply split is the operator's pre-commit eyeball turned into a verb. Conflict classification is the *content* of that eyeball for data promotion. An attentive engineer applying a branch by hand would wave the internal id renumbering through and stop hard at the balance. A promote operation that classifies conflicts is that discrimination, encoded — resolving the representational tier in place and surfacing only the semantic tier in the plan.

[The Cost of Doubt](/blog/the-cost-of-doubt/) argued that verification is paid out of a finite human attention budget, and that an uncalibrated review bot is a tax rather than a budget, because it spends that attention on noise. A promote engine that escalates false conflicts is an uncalibrated bot. Every internal surrogate-key collision it routes to a human is a finding with no semantic content, and a reviewer trained by a stream of those will eventually wave the balance conflict through too. Auto-resolving the representational tier is not a convenience feature. It is what keeps a person's attention available for the conflict that genuinely needs it. The discipline is the one the compaction-map document holds and the one `patch` held in 1985: resolve mechanically what is mechanical, and refuse — loudly, into a reject file — what is not.

## What I am still figuring out

**Whether to capture results or intents.** The line between rebasable and not depends on a decision made much earlier — what the branch recorded. Capture a branch's writes as literal results, "this row now holds 400," and inserts relocate cleanly but a stale computed value gets promoted silently over a balance that moved. Capture them as intents, "subtract 100," and computed updates can be re-applied correctly, but far more overlaps become semantic conflicts, because an intent against a moved base often genuinely cannot be re-applied. The first choice optimizes for quiet promotion and risks silent corruption; the second optimizes for honesty and produces more escalations. I do not think any representation escapes the trade-off, and the choice sits upstream of everything else.

**Whether natural keys are load-bearing enough to carry it.** Classification needs an identity that is not the surrogate key, and real schemas are inconsistent about natural keys — some tables have a clean one, many do not, and a natural key unique within production may not be unique across two divergent branches. If the identity that classification rests on is itself unreliable, classification degrades to guessing. The safe failure is to treat any unclassifiable conflict as semantic — but that erodes the value of promotion, because the more conflicts default to tier 3, the closer promote drifts back toward merge, which the last post argued against.

**The asymmetry of the two errors.** Mis-tiering a semantic conflict as representational corrupts data silently. Mis-tiering a representational conflict as semantic only wastes a person's time. These are not equally bad, and a classifier should be built to fail in the second direction every time. I am confident of that much. I am far less sure how to *prove*, for a given classifier, that it never fails in the first direction — and that proof is the thing that would actually let a team trust promote.

---

`patch` reached `mod.sources` in May 1985 with two things that mattered more than the diff format it read: context matching, which let it relocate a change whose address had drifted, and a `.rej` file, which let it set down — visibly, for a human — the change it could not honestly place. Forty-one years later, a compaction map on a branch of Apache Iceberg does the first for a table format and raises a conflict rather than guessing when it meets the second. The shape has not changed in between. A system that applies one state onto another has to be able to tell a moved address from a changed meaning, relocate the first, and refuse the second out loud. The reject file was never the failure mode. It was the system being honest about the line it could not cross.
