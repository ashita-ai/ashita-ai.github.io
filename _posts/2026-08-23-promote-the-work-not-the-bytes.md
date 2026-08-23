---
layout: post
title: "Promote the Work, Not the Bytes"
date: 2026-08-23
category: "architecture"
description: "Databases got the cheap branch and kept the merge. Here is the model I am working from instead, built on the instinct every engineer already has about long-lived branches, and the two places that instinct stops being enough."
image:
  path: /assets/images/promote-the-work-not-the-bytes.jpg
  width: 1200
  height: 630
  alt: "Bare tree branches forking against a pale sky"
---

In May I [wrote about Alice](/blog/the-week-long-transaction/), who forked production, worked on the branch for four weeks, and wanted her work folded back in. I could not answer which of her answers were still true.

I now think that question cannot be answered. Proving that nothing in a week of production traffic invalidated an assumption Alice made takes evidence no database keeps. Every route ends in the same two places: re-read everything, which is re-execution under another name, or issue a certificate whose completeness nobody can check.

So stop trying to certify the branch. It did not produce rows worth keeping. It produced confidence, and confidence is what carries over to a new run.

There is already a name for that instinct, and it is rebase.

Git offers two ways to end a branch. Merge computes a new tree out of two divergent ones. Rebase throws the divergent tree away and replays your commits onto the current tip. People reach for rebase on a branch that has been open a while, and the reason is not tidiness. A commit is a description of a change. A tree is only the result of one. Descriptions can be reapplied. Results can only be pasted.

Databases got the cheap branch and kept the merge. That is the gap.

The unit of promotion is a proposal: the SQL or migration or program, the tests that say it worked, and a list of what it touches outside the database. Then four steps.

**Rehearse.** Cut a fresh copy of production at today's head and run the work there, locking nothing on the primary. Record what it touched: writes by row, reads by table, because a `WHERE` clause cannot be reduced to a list of keys without losing the rows that do not exist yet.

**Seal.** Read the head. Since the rehearsal, did anything commit to the rows this work wrote? If yes, discard it and cut a new one. If no, the verdict still holds.

**Land.** One transaction on the live primary. Re-execute the work against today's rows so triggers, constraints and sequences are enforced by the engine instead of approximated by a diff. Check the postconditions in that transaction and write the verdict row there too, so no crash leaves a change with nothing recording it.

**Commit or refuse.** Those are the only two endings, and production is never left half-changed. External effects are held as data during the run and released after the commit, or not at all.

The analogy breaks in two places.

**Git replays a patch. A database should replay the query.** Say the work is *close out the orders that failed payment more than thirty days ago*, and the rehearsal touched 1,204 rows. Between the rehearsal and the landing, support refunds one of them. Git would reapply the same diff, landing on stale lines or stopping to ask you to arbitrate. Re-executing the query touches 1,203 rows, because the refunded order is no longer in the set the `WHERE` clause selects. The refund survives and nobody adjudicates anything. The query says what the author meant. The diff only says what happened last Tuesday.

**Git rebases onto a base that is holding still.** If a colleague pushes while you work, your push is rejected and you run it again, and that costs nothing because a push is one atomic pointer move. A database apply takes seconds against rows customers are reading. There is no pointer to swap, so the seal has to buy the same guarantee.

What both buy is a smaller window to defend. A merge has to be right about the whole life of the branch. A replay has to be right about the seconds between the seal and the commit, because the rehearsal already read today's rows. The week of drift stops being something you check and becomes something you skip.

## What I am still figuring out

**The derivation gap.** An agent that spent a week making judgment calls produced state instead of steps, and there is nothing to re-run. Capturing the session as a replayable object might answer that, or might only move the problem.

**Schema changes.** They do not fit inside one transaction, and a concurrent index build cannot run in one. Running a migration at the head turns into measure, then phase, then some way of proving the application has stopped using the old shape. That last step deserves its own post.

**How coarse the seal can be.** Reads are recorded by table, which is sound and blunt. Gate the seal on the whole table and a busy table never comes back clean. Gate it on the rows the work wrote and it answers a narrower question than you wanted asked. Below some write rate that is a fence. Above it, it is a loop, and I do not have the number.

---

Take the last ten changes an agent made to your database. How many could you hand to a machine as a re-runnable proposal with a test attached? If the answer is most, this model covers real work. If it is two, it covers a corner.

Is *refused* an answer your team can live with? And where does re-execution break in your schema? Not in principle. Yours.

If you have landed a long-lived branch on a live primary, I want to hear what it cost: [cal.com/evanvolgas](https://cal.com/evanvolgas).

---

*I am involved with [Ardent](https://tryardent.com), which is building in this space. The opinions here are my own.*
