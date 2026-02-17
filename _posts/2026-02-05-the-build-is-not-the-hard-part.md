---
layout: post
title: "The Build Is Not the Hard Part"
date: 2026-02-05
---

Nubank used [Devin to migrate their core ETL](https://devin.ai/customers/nubank) (a 6-million line monolith) and reported 8-12x efficiency improvement and over 20x cost savings. GitHub Copilot now [writes 46% of code](https://medium.com/@aminsiddique95/ai-is-writing-46-of-all-code-github-copilots-real-impact-on-15-million-developers-787d789fcfdc) for its 20 million users, reaching 61% in Java projects.

The narrative writes itself: AI makes building cheaper. Custom development should finally beat buying off-the-shelf.

It will not.

## The perception gap

A [METR study](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/) gave 16 experienced open-source developers 246 real tasks from repositories where they had an average of 5 years of prior experience. Half were allowed to use AI tools. Half were not.

Before starting, developers expected AI would reduce completion time by 24%. After finishing, they estimated AI had saved them 20%. The measured result: AI increased completion time by 19%.

The developers thought they were faster. They were slower. And they still believed AI had helped.

This is not a story about AI tools being bad. It is a story about where AI tools work and where they do not. Nubank's migrations were routine, repetitive, well-defined. The METR developers were working on mature codebases with complex dependencies and institutional context.

AI tools excel at the former. They struggle with the latter.

## What the 67% stat actually means

[MIT research](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/) found that purchased AI tools succeed 67% of the time, while internal builds succeed about one-third as often. (The study measured P&L impact within six months, a narrow but useful frame.) The instinct is to read this as "building is hard." It is not.

Building is cheap. Building the right thing is hard.

The 67% stat reflects decision quality, not construction difficulty. Vendors force you to deploy something that exists. Internal builds let you spend eighteen months building something nobody will use. The discipline is different.

AI tools make the construction cheaper. They do not make the decisions better. If anything, they make bad decisions faster. You can now build the wrong thing in weeks instead of months.

## What AI tools actually change

AI tools collapse the cost of routine work: migrations, boilerplate, greenfield projects, repetitive refactoring. Nubank's 8-12x efficiency gains came from exactly this kind of work.

They do not collapse the cost of understanding complex systems. The METR developers were slower because they had to verify AI outputs against institutional knowledge. The AI did not know why that config flag existed. Neither did the AI-assisted developer, but they had to figure it out anyway.

They do not make good decisions for you. AI tools do not tell you whether the feature should exist. They do not tell you whether the architecture will scale. They do not tell you whether anyone will use this. [The industry built the factory but forgot the design department](/blog/the-factory-without-a-design-department/).

And they do not help you reach production. [The pilot graveyard](/blog/the-ai-pilot-graveyard/) is full of systems that worked in development and died before deployment. AI tools accelerate development. They do not accelerate the organizational decisions required to ship.

## The real risk

The risk is not that AI makes building too expensive. The risk is that AI makes building too cheap.

When building is expensive, you are forced to prioritize. You cannot build everything, so you have to decide what matters. When building is cheap, you can build everything. And you will. And most of it will be wrong.

The discipline that came from scarcity (clear requirements, defined success criteria, commitment to production) does not automatically transfer to abundance. Teams that could barely ship one feature per quarter will use AI to ship five features per quarter, learn nothing five times faster, and wonder why success rates have not improved.

## What I am still figuring out

The METR study troubles me because I cannot tell if it is a task selection problem or a verification problem. If AI tools create a confidence bubble where developers stop checking outputs properly, the productivity gains we are measuring elsewhere may be illusory.

---

The METR developers thought AI saved them 20%. It cost them 19%. The perception gap was 39 percentage points.

AI tools are real. The productivity gains on routine work are real. But on complex work, we may be measuring confidence instead of competence. The hard part of software was never typing. It was knowing whether what you typed was right.
