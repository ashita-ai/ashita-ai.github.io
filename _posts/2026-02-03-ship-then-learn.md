---
layout: post
title: "Ship, Then Learn"
date: 2026-02-03
---

Engineers spend [33% of their time firefighting](https://newrelic.com/blog/observability/top-trends-in-observability-the-2025-forecast-is-here) and another 33% on maintenance. Two-thirds of engineering effort goes to understanding what already shipped, not building what ships next.

This is not a failure of engineering. It is a failure of investment. Teams over-invest in the stage before shipping and under-invest in the stage after.

## The pattern

I have been writing about AI systems, data platforms, and engineering decisions for a while now. Looking back, there is a through-line I did not fully see until recently:

[The AI Pilot Graveyard](/blog/the-ai-pilot-graveyard/) argues that pilots fail because they are designed to not reach production. The investment goes into demos, not deployment.

[Your Evals Won't Save You](/blog/your-evals-wont-save-you/) argues that teams over-invest in pre-production measurement and under-invest in production learning. The feedback loop matters more than the test suite.

[The RAG Trap](/blog/the-rag-trap/) argues that most retrieval failures are data failures. Teams debug the LLM layer while the data layer rots.

[Healthy Metrics, Broken Agent](/blog/healthy-metrics-broken-agent/) argues that dashboards lie. The metrics are green while the system is broken.

The common thread: the valuable information lives in production, but the investment goes to pre-production.

## Visibility is allocation

At Mailchimp, we had a problem with slow MySQL queries. Every team knew slow queries existed. Nobody knew which ones mattered.

We built a tool to ingest, analyze, and visualize slow query logs. Nothing fancy. Just visibility into what was actually happening.

Within three months, slow query volume dropped by 20%. The worst pages went from 60-second loads to under a second. The tool did not fix anything. It showed people where to look.

This is the leverage that gets ignored. [Splunk's research](https://www.splunk.com/en_us/blog/observability/state-of-observability-2025.html) found that organizations with mature observability practices achieve 53% higher ROI than their peers. [65% report](https://www.splunk.com/en_us/newsroom/press-releases/2025/splunk-report-shows-observability-is-a-business-catalyst-for-ai-adoption-customer-experience-and-product-innovation.html) that observability positively impacts revenue.

But observability is unsexy. It does not demo well. It does not justify new headcount. So teams keep investing in architecture and deferring visibility, then wonder why [75% of developer time](https://coralogix.com/blog/this-is-what-your-developers-are-doing-75-of-the-time-and-this-is-the-cost-you-pay/) goes to debugging.

Attention is the scarcest resource. Visibility is how you allocate it.

## Coordination is infrastructure

At Netflix, the studio engineering teams moved fast. APIs were constantly being rewritten. New data sources appeared weekly. The velocity was a feature, not a bug.

But velocity creates coordination debt. When one team changes a schema, every downstream team breaks. When nobody knows who depends on what, every change is a gamble. Coordination debt becomes data quality debt. Data quality debt becomes wrong decisions.

Netflix solved this with [Data Mesh](https://www.infoq.com/news/2022/08/netflix-data-mesh/), a platform that treats data as a product with explicit ownership, schema management, and visibility into dependencies. I wrote about similar ideas in [Tessera](/blog/introducing-tessera/), a data contract system that makes dependencies explicit before changes ship.

The pattern is the same: invest in coordination infrastructure before the coordination problems become data quality problems. [The decisions you make about data infrastructure](/blog/the-data-platform-decisions-that-haunt-you/) in year one determine whether you can move fast in year three.

## Convergence as validation

At a fintech startup, we had a tight timeline to ship a new data product. New territory. No prior art to guide us. Data quality was paramount because financial data does not get second chances.

We did not have time to build a proper validation pipeline. So we did something old-fashioned: three engineers analyzed the data independently, using AI tools to accelerate the mechanical work (documentation, SQL queries, basic analytics). By the time we shipped, all three had arrived at the same conclusions.

That was our validation. Not a test suite. Not a fancy framework. Three humans converging on the same answer from different directions.

The code was messy. We threw it together in a scratchpad repo with copious documentation for later. We took on code debt deliberately. But we did not take on knowledge debt. The documentation was thorough. The reasoning was preserved.

[Research on software redundancy](https://www.researchgate.net/publication/3187358_An_Experimental_Evaluation_of_Software_Redundancy_as_a_Strategy_For_Improving_Reliability) confirms what we stumbled into: independent verification improves reliability more than process improvements. The expensive part is not writing code twice. It is having two people who can write it independently.

This connects to [Technical Debt as Strategy](/blog/technical-debt-as-strategy/). Debt on how you build is recoverable. Debt on what you know is not. We shipped ugly code with clean knowledge. That was the right tradeoff.

## The stage you are ignoring

The [Lean Startup methodology](https://theleanstartup.com/principles) is built on a simple observation: you learn more from one day in production than from six months of planning. The build-measure-learn loop works because measurement happens after shipping, not before.

But most teams invert this. They spend months on architecture. They run pilots that never reach production. They build evaluation suites for systems that do not exist yet. The investment goes to the stage before shipping because that stage is controllable. Production is messy. Production has users who do unexpected things. Production reveals that your assumptions were wrong.

That is exactly why production is where the learning happens.

[95% of AI pilots fail to deliver measurable ROI](/blog/the-ai-pilot-graveyard/). The failure is not technical. The failure is never reaching the stage where learning is possible.

## What this means

If you are building AI systems, data platforms, or really any software that matters:

**Invest in visibility before architecture.** You cannot improve what you cannot see. The slow query tool at Mailchimp cost a few weeks to build. It saved years of debugging.

**Treat coordination as infrastructure.** Schema changes, API contracts, dependency tracking. These are not nice-to-haves. They are the foundation that lets you move fast without breaking things.

**Accept messy code with clean knowledge.** Document your reasoning. Preserve the why. You can refactor the code later. You cannot recover the context.

**Ship to learn, not to finish.** The goal is not to complete a project. The goal is to reach the stage where learning becomes possible. Everything before that is guessing.

---

The stage after shipping is where the value lives. The question is whether you are investing there or still polishing the demo.
