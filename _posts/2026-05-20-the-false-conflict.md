---
layout: post
title: "The False Conflict"
date: 2026-05-20
category: "architecture"
description: "A data-branch promote is not a merge but a triage: an address that drifted, which a system can relocate, or a meaning that changed, which it must escalate. The line patch drew in 1985."
---

*Promoting a data branch onto a production that has moved on is not a merge. It is triage. Every mismatch is either an address that drifted, which a system can relocate on its own, or a meaning that changed, which it must hand to a human. Telling those apart is the whole problem; `patch` has been drawing that line since 1985, and a database promote still has to.*

On May 8, 1985, Larry Wall posted version 1.3 of `patch` to the `mod.sources` [Usenet newsgroup](https://en.wikipedia.org/wiki/Patch_(Unix)). It solved a distribution problem: people sharing source code over 300-baud modems could not move megabytes around, so they moved diffs instead, and `patch` applied a diff to a local copy. The interesting part is not the format it read. It is the two decisions Wall made about a diff that no longer fit.

A diff records each change, each *hunk*, at a line offset: replace what is at line 412 with this. By the time a diff reached a copy that had drifted, those offsets were wrong. `patch` did not trust them blindly: it located each hunk by the unchanged lines around it, and applied the hunk even when those lines had moved. What it genuinely could not place, it did not force. It wrote the orphaned hunk into a `.rej` reject file and left it, visibly, for a human.

Encoded there is the distinction this post is about. A line number is an address, not an identity. A hunk that fails to apply at line 412 is not necessarily in conflict with anything: line 412 may simply have moved. A hunk whose surrounding context is gone is another matter, and `patch` refused to guess about it. Forty-one years on, that is still the line a system must draw when it applies one version of a thing onto another.

## The question the last post left open

I argued [last week](/blog/branching-came-late-to-data/) that data branching reaches for the wrong primitive when it reaches for *merge*. Git's three-way merge works because most code conflicts are line-local and most lines do not depend on one another transactionally; rows, with their foreign keys and partial uniqueness, do not have that property. The better primitive is *promote*, in the sense Terraform uses *apply*: a branch is not a sibling of `main`, it is a proposed change to production, applied onto whatever production now is.

No database product has built that promote. [Neon](https://neon.com/docs/introduction/branching)'s branches are copy-on-write clones whose changes are independent from the parent; [Supabase](https://supabase.com/docs/guides/deployment/branching)'s branching is schema-first: dashboard branches review a schema diff and Git-based branches run migration files, with branch data coming from seeds rather than production by default. The closest thing that ships is [PlanetScale](https://planetscale.com/docs/vitess/schema-changes/deploy-requests)'s deploy request, instructive for what it refuses: it promotes *schema*, never row data, and when production drifts under an open request it does not guess, it marks the request *not deployable* and stops. A data-level promote is unbuilt.

That argument has an unanswered hard part. Applied to a production that moved since the fork, promotion has to look at each mismatch and decide what kind it is: a real disagreement about what the data means, or an artifact of how the data was addressed. `patch` made that decision for text in 1985; promote has to make it for rows — drawn cleanly for a table format by a recent piece of work, and much harder to draw for a database, which is the part I am still working out.

## The false conflict

A false conflict is a mismatch a system reports as a conflict but that is not one in the thing the user cares about: an artifact of representation. The term has a lineage in concurrency control: in software transactional memory, a *false conflict* is one that coarse detection reports when two transactions touch the same cache line without touching the same logical datum. The sense here is that one, widened from memory words to rows. Anyone who has merged code has resolved a conflict that, on inspection, was no disagreement about behavior at all — a reformatting pass, a function that moved. The meaning was never contested; the conflict lived entirely in the encoding.

The distinction is not new. Software-merge research has separated text-based from meaning-aware merging for decades (Tom Mens surveyed it in 2002), and structured-merge tools like [Spork](https://arxiv.org/abs/2202.05329) exist to dissolve the representational kind. Git itself ships a [`union` merge driver](https://git-scm.com/docs/gitattributes) and a `renormalize` mode its docs describe as preventing "spurious merge conflicts." What is new here is carrying the line out of source code and into data, where the drifting address is a file position or a surrogate key, not a line number.

The cost of a false conflict is not the conflict; it is what the conflict consumes: a person's attention, spent adjudicating a disagreement that does not exist. Hold that thought.

## The address that dangles

Apache Iceberg is an open table format, a layer of metadata over data files in object storage that gives them table semantics: snapshots, schema evolution, atomic commits. A row deletion can be recorded without rewriting the data file. The table writes a *position delete*: in this file, at this row position, a row is gone.

Compaction is the routine background job that rewrites many small data files into fewer large ones. It is advertised, correctly, as a logical no-op: not one row is added or removed, and the table's contents are identical before and after. It is purely a physical reorganization for read performance.

But compaction drops the old files from the current layout. A position delete prepared against that old layout carries coordinates (*file X, position 6*), and after compaction, file X is stale as an address. Iceberg's optimistic concurrency control sees the delete and the compaction both touched file X and rejects the delete's commit. The delete was logically fine; the table the user wanted is perfectly well-defined — the compacted table, minus that one row. It was rejected because the delete named its row by *location*, and compaction is exactly the operation that relocates rows without changing them.

That is a false conflict, in the exact sense above. The delete and the compaction do not disagree about the table's contents — only about where a row sits.

## The compaction map

[Chris Douglas](https://cdouglas.github.io/) has prototyped a fix on the `cmpmap` branch of a fork of Iceberg, documented in [`compaction_maps.md`](https://github.com/cdouglas/iceberg/blob/cmpmap/docs/docs/compaction_maps.md). When compaction rewrites files, it records how each surviving row position moved: a *compaction map*, a translation table from old `(file, position)` to new. That artifact lets the conflict be rebased: compaction can resolve conflicting concurrent position deletes automatically, and an application transaction can catch the conflict, remap its deletes through the map, and retry. The document is explicit that this is a correctness requirement, not an optimization — committing a stale position reference risks corrupting the table.

This is `patch`'s context matching, rebuilt for a table format. The context lines that relocate a drifted hunk and the compaction map that relocates a drifted delete are one idea: moving a change expressed against one representation onto another, with no human in the path.

The most useful part of the document is where it stops. Compaction maps cover *order-preserving* rewrites — bin-packing, merge compactions. They exclude sorted and Z-ordered compaction, not because those change the table's logical contents but because they are order-changing: the run-length encoding degenerates, and a position delete is no longer the right representation.

## The same line, for a database branch

The boundary the compaction map draws is the boundary `patch` drew with its reject file, and every promote operation has to draw it too. A branch of a production database, promoted, faces it directly: the branch worked against a fork-time copy, production moved on, and promotion has to apply that work to current production and decide, change by change, what kind of mismatch each one is. Three tiers fall out.

**Physical** mismatches are storage-level: which page a row occupies, index state, bloat. Resolved automatically, never surfaced; below the question.

**Representational** mismatches are logical but arbitrarily encoded: the effect is fixed, and only the address needs translating. The internal surrogate key is the clearest case. A branch inserted 200 rows; the forked sequence numbered them 5001–5200; production's sequence, advancing on its own, has also issued 5001–5050 to real rows. The ids collide. While the surrogate stays internal to the database it carries no external meaning. It is identity-by-allocation. Renumber the branch's rows, cascade to foreign keys, promote; no human. This is the bin-pack rewrite, and `patch`'s drifted hunk: the thing is fixed, only its address moved. But once that id has gone out — through an API, a customer-visible URL, an analytics export — it is no longer an address. It is a fact in another system, and renumbering it would falsify history.

**Semantic** mismatches are genuine disagreements about meaning. A branch computed `balance = balance - 100` against a fork-time balance of 500 and stored 400; production, meanwhile, added 50. Promoting the literal 400 is wrong (its base is stale), and re-deriving the right value needs the branch's *intent*, not its recorded result. The value depends on content that moved. It does not remap; it escalates. This is `patch`'s `.rej` file: the context is gone, I cannot honestly place it, here it is — you decide.

The test that separates the last two is one line:

> A conflict is **representational** if it dissolves under a change of representation, and **semantic** if it survives every one.

The principle under it is narrow: a system can translate an *address* when it has a proven meaning-preserving map, but it cannot reconstruct an *effect whose value depends on content that moved*; it must not pretend an internal address is still internal once it has crossed the system boundary.

The hardest case is the one where the tier is invisible from outside. Two branches each insert a row; neither violates a unique constraint alone; the union does. If the colliding column is an internal surrogate id, the conflict is representational — renumber one side. If that id has crossed the system boundary, or the column is a natural key, an email address, it is semantic: the value *is* the meaning, and renumbering it would falsify data. Same-shaped conflict, opposite tiers: the line runs through a mismatch that looks identical until you ask what the colliding column means.

## The ceiling of merge

That this is *classification* and not better merging is easiest to see against the best data merge that exists. [Dolt](https://docs.dolthub.com/concepts/dolt/git/conflicts), a SQL database with Git's operations built in, merges at the cell level rather than by text: change different columns of the same row on two branches and it merges them cleanly, with none of the line-noise a `git merge` of a CSV would throw. But [two branches that insert rows under the same `AUTO_INCREMENT` key](https://www.dolthub.com/blog/2023-10-27-uuid-keys/) produce a conflict (the representational collision from above), and Dolt has no way to tell it from a contested balance. It has one verdict, *conflict*; you can edit the conflict tables by hand, but the built-in automated resolutions are still the two blunt ones, `--ours` and `--theirs`. That is the ceiling of conflict detection as a primitive: it sees that two values differ but has nowhere to record *why*. Promote is merge with that missing axis added.

## The prerequisite nobody gets to skip

All of this depends on something that must exist first: you cannot classify a conflict without some way to recognize the moved thing that is independent of the address that moved. `patch` had context lines: the surrounding text is a content-based identity for a hunk. Iceberg's compaction map is the substitute for position deletes: not a stable row identity in the abstract, but a proven route from old position to new for the rows that survived.

Postgres branch promotion needs that identity, and it is harder to come by: the surrogate key, the column most schemas use *as* identity, is exactly the representational address promotion has to be willing to rewrite. The identity classification rests on has to come from elsewhere: a natural key, the row's content, a declared intent. Real schemas are inconsistent about natural keys — many tables lack a clean one, and a key unique within production may not be unique across two divergent branches. A schema whose only identity is its surrogate key gives a promote engine no way to tell tier 2 from tier 3; it can only guess. This sits upstream of the whole [branch contract](/blog/contracts-as-infrastructure/), and it is the part least solved.

## What the false conflict costs

This is where the false conflict's cost comes due. [The Cost of Doubt](/blog/the-cost-of-doubt/) argued that verification is paid from a finite human attention budget, and a tool that spends it on noise is a tax, not a safeguard. A promote engine that escalates every surrogate-key collision is that tax: each is a finding with no semantic content, and a reviewer fed a stream of them will, in time, wave the contested balance through too. Auto-resolving the representational tier is not a convenience; it is what keeps attention available for the conflict that genuinely needs it — the judgment [The Implicit Operator](/blog/the-implicit-operator/) called the operator's pre-commit eyeball. An attentive engineer promoting a branch by hand waves the id renumbering through and stops hard at the balance; a promote that classifies conflicts is that judgment, encoded.

## What I am still figuring out

**Whether to capture results or intents.** Record a branch's writes as literal results ("this row holds 400") and inserts relocate cleanly, but a stale computed value gets promoted silently over a balance that moved. Record them as intents ("subtract 100") and computed updates re-apply correctly, but far more overlaps become semantic conflicts, because an intent against a moved base often genuinely cannot be re-applied. The dilemma is old: Patrick O'Neil's [escrow method](https://doi.org/10.1145/7239.7265) (1986) records the intent of an increment, never the result, which is exactly what lets two concurrent updates to a total commute instead of colliding. But that works only because increments commute, and a general `UPDATE` does not. I do not think any representation escapes the trade-off.

**The asymmetry of the two errors.** Mis-tiering a semantic conflict as representational corrupts data silently; mis-tiering a representational one as semantic only wastes a person's time. A classifier should be built to fail the second way, every time. I am confident of that. I am far less sure how to *prove*, for a given classifier, that it never fails the first way, and that proof is what would actually let a team trust promote.

---

`patch` reached `mod.sources` in 1985 with two things that mattered more than the diff format it read: context matching, which relocated a change whose address had drifted, and a `.rej` file, which set down (visibly, for a human) the change it could not honestly place. Forty-one years later, a compaction map does the first for a table format and raises a conflict rather than guess when it meets the second. The shape has not changed. A system that applies one state onto another has to tell a moved address from a changed meaning, relocate the first, and refuse the second out loud. A `.rej` file is a failure. `patch` met a change it could not place. But it is a failure made honest: visible, still holding a change a person can set right by hand, instead of a corruption written silently into the source. That was Wall's real design: not a tool that never fails, but a failure that cannot hide.
