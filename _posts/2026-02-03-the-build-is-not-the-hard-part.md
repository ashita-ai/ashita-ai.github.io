---
layout: post
title: "The Build Is Not the Hard Part"
date: 2026-02-03
---

Nubank used [Devin to migrate their core ETL](https://devin.ai/customers/nubank) (a 6-million line monolith) and reported 12x efficiency improvement and 20x cost savings. Visma used AI tools and [cut project costs by 50%](https://www.microsoft.com/en/customers/story/24262-cognition-ai-azure). 84% of developers now use AI tools that [write 41% of all code](https://www.netcorpsoftwaredevelopment.com/blog/ai-generated-code-statistics).

The narrative writes itself: AI makes building cheaper. Custom development should finally beat buying off-the-shelf.

It will not.

## The perception gap

A [METR study](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/) gave 16 experienced open-source developers 246 real tasks from repositories where they had an average of 5 years of prior experience. Half were allowed to use AI tools. Half were not.

Before starting, developers expected AI would reduce completion time by 24%. After finishing, they estimated AI had saved them 20%. The measured result: AI increased completion time by 19%.

The developers thought they were faster. They were slower. And they still believed AI had helped.

This is not a story about AI tools being bad. It is a story about where AI tools work and where they do not. Nubank's migrations were routine, repetitive, well-defined. The METR developers were working on mature codebases with complex dependencies and institutional context.

AI tools excel at the former. They struggle with the latter.

## What the 67% stat actually means

[MIT research](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/) found that purchased AI tools succeed 67% of the time, while internal builds succeed only one-third as often. The instinct is to read this as "building is hard." It is not.

Building is cheap. Building the right thing is hard.

The 67% stat reflects decision quality, not construction difficulty. Vendors force you to deploy something that exists. Internal builds let you spend eighteen months building something nobody will use. The discipline is different.

AI tools make the construction cheaper. They do not make the decisions better. If anything, they make bad decisions faster. You can now build the wrong thing in weeks instead of months.

## The three questions

Before you build anything (whether with AI tools or without), answer three questions:

**What is your actual advantage?** The case for building is strongest when you have something vendors cannot replicate: proprietary data, domain-specific workflows, or integration patterns unique to your business. If your advantage is in how you combine systems or automate processes that no off-the-shelf tool addresses, building makes sense. If you are using the same data and workflows as everyone else, you are building commodity infrastructure at custom prices.

**Is this core to your business?** [BCG's framework](https://www.bcg.com/publications/2018/build-buy-dilemma-artificial-intelligence) maps AI investments by strategic importance and data differentiation. If both are low, you are in "commodity" territory where buying is almost certainly right. If both are high, you are in a "gold mine" where building creates defensible advantage.

**What is the path to production?** [Annual AI maintenance](https://xenoss.io/blog/total-cost-of-ownership-for-enterprise-ai) accounts for 15-30% of total infrastructure cost, with legacy system integration adding a 2-3x implementation premium. The build is not the expensive part. Integration, maintenance, monitoring, retraining, incident response (these are the costs that compound). If you cannot answer how this reaches production, AI tools will help you build an expensive orphan faster.

## What AI tools actually change

AI tools collapse the cost of routine work: migrations, boilerplate, greenfield projects, repetitive refactoring. Nubank's 12x efficiency came from exactly this kind of work.

They do not collapse the cost of:

**Understanding complex systems.** The METR developers were slower because they had to verify AI outputs against institutional knowledge. The AI did not know why that config flag existed. Neither did the AI-assisted developer, but they had to figure it out anyway.

**Making good decisions.** AI tools do not tell you whether the feature should exist. They do not tell you whether the architecture will scale. They do not tell you whether anyone will use this.

**Reaching production.** [The pilot graveyard](/blog/the-ai-pilot-graveyard/) is full of systems that worked in development and died before deployment. AI tools accelerate development. They do not accelerate the organizational decisions required to ship.

## The hybrid approach

The companies getting this right are not asking "build or buy." They are asking "what should we build and what should we buy?"

The pattern: buy infrastructure, build differentiation. Use Snowflake for your warehouse but build custom models on your proprietary data. Use off-the-shelf monitoring but build custom agents for your specific workflows. Buy the foundation, build the layer that makes you different.

AI tools make the building layer cheaper. Use them there. Do not use them to rebuild infrastructure that vendors have already solved.

## The real risk

The risk is not that AI makes building too expensive. The risk is that AI makes building too cheap.

When building is expensive, you are forced to prioritize. You cannot build everything, so you have to decide what matters. When building is cheap, you can build everything. And you will. And most of it will be wrong.

The discipline that came from scarcity (clear requirements, defined success criteria, commitment to production) does not automatically transfer to abundance. Teams that could barely ship one feature per quarter will use AI to ship five features per quarter, learn nothing five times faster, and wonder why success rates have not improved.

## What I am still figuring out

The METR study troubles me. Developers with 5+ years of experience in their specific repositories were 19% slower with AI tools. My instinct is that this is a task selection problem (the study used complex, context-heavy work where AI tools add overhead). But I cannot rule out that AI tools create a confidence bubble where developers stop verifying outputs properly. If the latter is true, the productivity gains we are measuring elsewhere may be illusory. I do not have enough data to know.

---

The METR developers thought AI saved them 20%. It cost them 19%. The perception gap was 39 percentage points.

AI tools are real. The productivity gains on routine work are real. But on complex work, we may be measuring confidence instead of competence. The hard part of software was never typing. It was knowing whether what you typed was right.
