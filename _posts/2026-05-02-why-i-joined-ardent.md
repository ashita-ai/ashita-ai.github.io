---
layout: post
title: "Why I Joined Ardent"
date: 2026-05-02
category: "career"
---

On Friday, April 24, 2026, an AI coding agent deleted PocketOS's [production database in nine seconds](https://www.theregister.com/2026/04/27/cursoropus_agent_snuffs_out_pocketos/). Cursor, running Claude Opus 4.6, was working on a staging task. It hit a credential mismatch, found a Railway API token in an unrelated file, guessed the call would be scoped to staging, and ran a `curl` against the production volume. Railway stores volume backups on the same volume, so those went too. Founder [Jer Crane](https://x.com/lifeof_jer) spent the weekend rebuilding from Stripe receipts and email archives until Railway's CEO restored a deeper backup on Sunday night.

The agent's response is the part that has been quoted everywhere: *"NEVER FUCKING GUESS! — and that's exactly what I did."* What has not been quoted as much is the part that matters more for the rest of this post. The agent had a production credential because there was no other database for it to work against. It "guessed" the call was safe because the alternative was to wait for a human to provision a sandbox, and the human pace did not match the agent's pace.

This was not the first incident of its kind. Nine months earlier, in July 2025, Replit's "vibe coding" agent [deleted SaaStr founder Jason Lemkin's production database](https://www.theregister.com/2025/07/21/replit_saastr_vibe_coding_incident/) during a deliberate code freeze, fabricated a 4,000-row dataset, and lied about whether the rollback was possible. It will not be the last.

I am the new CTO at [Ardent](https://tryardent.com), working with founder [Vikram Chennai](https://x.com/vchennai2). This is the post explaining why.

## What I have been arguing

The structural properties that outlast paradigm shifts — [ground truth](/blog/ground-truth-as-foundation/), [provenance](/blog/the-provenance-imperative/), [contracts](/blog/contracts-as-infrastructure/), [reversibility](/blog/reversibility-as-default/) — are the same properties AI agents need to do real work on real data. Without them, agent velocity is not productivity. It is just a faster path to the [3am page](/blog/the-data-platform-decisions-that-haunt-you/).

I built [four open-source tools](/blog/what-i-learned-building-four-tools-with-ai-agents/) testing pieces of that thesis from outside any company. Tessera handles data contracts. Engram preserves ground truth in agent memory. Conduit routes by cost-quality tradeoff. Arbiter evaluates outputs. Each one targets a specific seam where agent velocity collides with infrastructure designed for human pace.

The seam I could not address from outside any company was the one underneath all of them. The database.

## Where agents test

When a coding agent writes data engineering code, it needs somewhere to test that code. Every existing option is wrong in a different way.

**Seed files** are wrong by construction. They are simplified versions of production data, which means the agent's tests pass against a world that does not exist. The assumptions baked in during testing turn into the incident report.

**Staging** is a queue. One person at a time, several days behind production, diverged in subtle ways the team has stopped noticing. Agents do not queue politely. An agent that wants to test ten variants of a migration in parallel cannot do that on a single staging environment that humans are also using.

**Read replicas** cap out around fifteen to twenty per cluster. That ceiling exists because Postgres replication was designed for human pace. It does not survive contact with agents that want to fork a database the way they fork a branch.

**Snapshots and `pg_dump`** measure their lifecycle in hours and gigabytes of cold storage. For a terabyte database, requesting a clone is a planning meeting.

The result is that agents, when they touch databases, touch them gingerly through brittle abstractions or with too much access and not enough reversibility. Every team I have watched make this work has reconstructed the same hack: a smaller, fresher staging environment with a refresh script and a Slack channel for "who is using staging right now." The hack works at five engineers and one agent. It collapses at fifty engineers and a fleet. PocketOS is what the collapse looks like.

## How Ardent got here

Vikram started Ardent in 2024 to build an autonomous data engineer — an agent that maintains pipelines across Airflow, Snowflake, and Databricks. The pitch in the [September 2025 raise](https://www.globenewswire.com/news-release/2025/09/25/3156336/0/en/Ardent-AI-Raises-2-15M-to-Build-the-First-AI-Data-Engineer.html) was "the first AI data engineer." Crane Venture Partners led, with Active Capital and Zach Wilson. The agent worked, customers paid for it, ARR grew 70% month over month.

Then Vikram ran into the same wall every team building agents on real data hits. The agent could write the pipeline code, but it had nowhere safe to test it. Seed files were wrong. Staging was a queue. Snapshots were too slow. The agent was bottlenecked not by its reasoning but by the substrate. His own [framing](https://siliconangle.com/2025/09/25/ardent-ai-beats-odds-launch-worlds-first-agentic-engineer-data-pipeline-maintenance/) of the original problem applied recursively: "the tooling wasn't broken, the entire approach was."

So he rebuilt around the substrate. Database sandboxes — sub-six-second Postgres clones, copy-on-write, isolated compute, no cap on how many can exist — became the product. The agents that need them are everyone's, not just Ardent's. That pivot, from "build the agent" to "build the substrate the agent stands on," is the move that made me want to work with him. Founders who recognize the higher-leverage layer and rebuild for it are rare. Founders who do it after their first product is already working are rarer.

## What Ardent actually does

Ardent creates an isolated, full-fidelity copy of a Postgres database in under six seconds. Not a sample. Not a staging snapshot. An exact clone with copy-on-write at the storage layer, isolated compute, scale-to-zero when idle, and no cap on how many can exist at once. The benchmark on the marketing page is 30,960x faster per terabyte than the traditional path. The number reads like a marketing claim until you remember what an order-of-magnitude difference does to user behavior. Going from "I will request a clone and check back in an hour" to "I will spawn one inside a loop" is not a faster version of the same workflow. It is a different workflow.

This is reversibility at the database layer. Same shape of thing that branching did for source code in 2005, before which engineers were copying directories and emailing diffs. Branching did not just speed up a slow operation. It changed what engineers were willing to try. You experiment more when experiments are cheap and the worst case is `git checkout main`. Cheap, isolated database clones do the same thing for data work — and the only reason this has not been obvious for a decade is that until recently, "data work" mostly meant humans. At human pace, hourly clones are tolerable. At agent pace, they are the bottleneck.

Abhay Singh at Chevron put it cleanly: Ardent is "as critical as git was for code." That comparison is correct, and it is the reason the product exists at all.

## Why now

Two facts collide.

The first: agents writing data engineering code is no longer speculative. [Over 80% of databases](/blog/the-fifty-year-stack/) provisioned on Neon last year were created by agents, not humans. dbt models, migrations, schema refactors, ad-hoc analyses — agents do this work in production today, in real codebases, generating real PRs.

The second: the testing substrate they work on was built for the world that came before them. A staging database with a four-hour refresh cycle was a reasonable design choice when it was serving twenty engineers shipping a few changes per day. It is not a reasonable design choice when it is serving a fleet of agents shipping a few changes per minute.

This gap closes one of two ways. Either agent velocity drops back to human pace — which it will not, because the economic incentive is in the other direction — or the substrate gets rebuilt for the new velocity. Ardent is the second.

## What it is not

It is not a snapshot service with better marketing. Snapshots are point-in-time backups; clones are live writable databases that diverge. It is not a staging-environment generator; staging is shared and branches are not. It is not a data masking tool; the clone is the production data, with the production schema, with isolation enforced at the compute and storage layer instead of by hoping no one runs the wrong query.

It is closer to git than to anything in the traditional database tooling ecosystem.

## Four honest reasons

**The thesis is right.** I did not have to talk myself into the argument. I spent half a year making it in [public](/blog/reversibility-as-default/) before the offer existed. Ardent is what the conclusion of that argument looks like with infrastructure attached.

**The founder builds.** Vikram shipped the original product solo, sold it, raised, and pivoted to a higher-leverage layer when the substrate problem revealed itself. That sequence — ship, listen, recognize the leverage point is one layer down, rebuild — is the loop a company has to be able to run more than once if it is going to survive a decade. I would rather join early to that founder than late to a more polished one.

**The product works today.** Sub-six-second clones at terabyte scale are running in production for paying customers — Zenn Agents, OpenLedger, Harvest, Rose AI. This is a category where the demos and the product line up, which is rarer than it should be.

**The work is unfinished.** We are early enough that the interesting questions are still open ones — what the right primitives are, where the API boundary should sit, which workflows agents actually run when sandboxes are this cheap, and what the second product looks like once the first is in enough hands to tell us. I would rather work on the questions than on the answers, and the questions are still here.

The blog is not changing. If anything, the work makes the writing sharper, because I am no longer arguing about what should exist. I am building it with Vikram and a team that will grow from here.

## What I am still figuring out

What the workflows on top of a fast clone actually look like once they are in enough hands. Branching primitives are necessary; they are not the whole story. PocketOS happened in a world where the agent had to choose between speed and safety; cheap clones remove that particular choice, but they do not by themselves answer what an agent is allowed to do on a clone, what gets recorded, or how a successful clone makes its way back to production. Those questions get sharper the more clones we run. I do not yet have confident answers, and I would rather earn them from usage than invent them on a whiteboard.

Whether the analogy to git is too tidy. Git was easy to adopt because it was a developer-facing tool with a CLI. Branchable databases sit underneath the agent that sits underneath the engineer. The user experience of "I made a clone" is mediated by the agent's code, not by a human typing `git branch`. The properties that made git invisible — local-first, fast, reversible — apply to clones, but the adoption story is different. I do not yet have a clean answer for what "git for databases" means when the user is an agent.

---

In 2007, a company that paid for an Oracle license could spin up one production database. By 2010 they could run a hundred read replicas on RDS. By 2017 they could autoscale them with a slider. The shape of database infrastructure tracks the shape of the work that runs on it.

The work running on databases now writes itself. The infrastructure should match.
