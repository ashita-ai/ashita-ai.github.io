---
layout: post
title: "The Three Debts"
date: 2026-02-17
---

Three engineers at Pivotal Software spent three years building a system without ever talking to potential users. When it shipped, it did not fulfill user needs. [After nine months trying to salvage it, management scrapped the project](https://link.springer.com/chapter/10.1007/978-1-4842-4221-6_19).

The code was fine. The architecture was fine. The debt was not in the implementation.

Everyone knows technical debt. Few teams distinguish between the three types of debt that actually kill projects. The distinction matters because each debt requires a different intervention. Treating comprehension debt like technical debt wastes refactoring effort on code nobody understands. Treating decision debt like technical debt produces clean implementations of the wrong thing.

## Technical Debt

Ward Cunningham [coined the term in 1992](https://www.agilealliance.org/introduction-to-the-technical-debt-concept/) while building a financial product. His original metaphor was precise: "Shipping first time code is like going into debt. A little debt speeds development so long as it is paid back promptly with a rewrite."

The key characteristic of technical debt is that someone understood the code when it was written. The debt is the gap between what you knew then and what you know now. You wrote code that reflected your partial understanding of the problem, and later you learned more.

This is healthy debt when managed. [Segment rebuilt their analytics pipeline three times](/blog/technical-debt-as-strategy/) as they scaled from startup to acquisition. Each version was the right decision at the time. The debt was intentional, taken on with full knowledge, and paid down when the interest became too expensive.

Technical debt has a known remediation: refactor. You can see the code. You understand what it does. You know what it should do instead. The work is mechanical, even if tedious.

**Technical debt is code that someone understood when written, that now needs to be updated to reflect current understanding.**

## Comprehension Debt

Researchers have recently [identified a new form of debt](https://arxiv.org/abs/2512.08942) emerging from AI-assisted development: comprehension debt. This is what happens when AI helps teams build systems more sophisticated than they can independently understand or maintain.

The distinction from technical debt is fundamental. Technical debt means someone understood the code when it was written. Comprehension debt means nobody ever did.

A developer uses Claude to generate a caching layer. The code works. The tests pass. Six months later, the cache returns stale data under load. The developer cannot debug it because they never understood how it worked. They understood what it did, not why.

You cannot refactor comprehension debt. Refactoring assumes understanding of both the current and desired implementation. Without that, you are rewriting blind, likely introducing new comprehension debt in the process. The only remediation is to build understanding or accept permanent dependency on AI assistance for that part of the system. Neither is free.

**Comprehension debt is code that nobody understood when written, and that accumulates interest every time someone touches it without understanding it.**

## Decision Debt

The third debt is rarely named but compounds the fastest: decision debt. This is the cost of choices made for the wrong reasons.

The [first startup I worked for](/blog/the-attention-economy-of-engineering/) built an intelligent scraper with infrastructure engineered for Netflix-scale when we were a tiny fraction of it. The code was clean. The architecture was sound. The engineers understood every line. There was no technical debt and no comprehension debt.

The company was acquired for less than a million dollars.

The debt was in the decision itself: engineering attention allocated to technically interesting infrastructure instead of the product that would determine whether anyone cared. This is resume-driven development at the organizational level, building what looks impressive instead of what matters.

Decision debt is invisible in the codebase. The code is fine. The architecture might even be elegant. The debt is in what you chose to build, when you chose to build it, and why. It compounds through a specific mechanism: each decision constrains future decisions, and the constraints are invisible until they bind. A team that chose the wrong abstraction in month one builds six months of features on top of it. By month seven, the cost of changing course includes not just the abstraction but everything built on the assumption that it was right. The original debt was one bad choice. The compounded debt is an entire system shaped by that choice.

Quibi is the clearest example. Jeffrey Katzenberg raised $1.75 billion for a mobile-only premium streaming service. The Turnstyle technology (seamless portrait-to-landscape switching) was genuinely innovative. Content budgets ran $100,000 per minute. The engineering was competent. The decision to charge for short-form video when YouTube and TikTok already owned the format cost everything. [Six months after launch, Quibi shut down](https://www.cnbc.com/2020/10/21/quibi-to-shut-down-after-just-6-months.html). No amount of refactoring could have saved it. The technology was not the problem. The decision was.

Only [28% of executives and middle managers](https://sloanreview.mit.edu/article/no-one-knows-your-strategy-not-even-your-top-leaders/) responsible for executing strategy could list three of their company's strategic priorities. The decisions being made are not aligned with any coherent strategy. Each decision is locally rational, individually defensible, and collectively incoherent. The debt compounds with every sprint.

You cannot refactor decision debt. You cannot improve your way out of building the wrong thing. Sony's Concord game [cost over $200 million to develop](https://kotaku.com/firewalk-studios-concord-ps5-sony-live-service-shutdown-1851684290) and lasted 14 days after launch before being pulled. The code worked. The decisions did not.

**Decision debt is the cost of choices made for the wrong reasons, compounding silently until the consequences become unavoidable.**

## The Taxonomy

| Debt Type | Definition | Detection | Remediation |
|-----------|------------|-----------|-------------|
| **Technical** | Code someone understood, now outdated | Code review, static analysis | Refactor incrementally |
| **Comprehension** | Code nobody ever understood | Production incidents, debugging time | Build understanding or accept dependency |
| **Decision** | Choices made for wrong reasons | Market feedback, strategic review | Live with it or rewrite entirely |

The intervention must match the debt type:

- **Technical debt** responds to engineering effort. Refactor, pay it down, move on.
- **Comprehension debt** responds to learning. Slow down, understand the system, or accept the dependency.
- **Decision debt** responds only to strategic change. No amount of engineering excellence fixes building the wrong thing.

Most organizations have all three. The dangerous ones are the invisible debts: comprehension debt hiding in AI-generated code, decision debt hiding in locally-rational choices.

## The objections

The first: this is splitting hairs. Debt is debt. Just pay it down. But the intervention determines the outcome. When you treat comprehension debt as technical debt, you refactor code you do not understand into different code you do not understand. When you treat decision debt as technical debt, you polish implementations of the wrong thing.

The stronger critique: comprehension debt resolves itself through maintenance, converging with technical debt over time. And decision debt is just bad product management wearing a metaphor.

The convergence argument has merit for small systems. A team that maintains a codebase long enough will eventually understand it. But when generating code costs nearly nothing, the rate of accumulation outpaces the rate of understanding. And the "bad product management" framing misses what the debt metaphor captures: compounding. A bad decision is a one-time mistake. Decision debt is a series of locally reasonable choices, each constraining the next, accumulating interest that only becomes visible when it is too expensive to pay down. CodeScene found that developers spend [23-42% of their time](https://codescene.com/hubfs/calculate-business-costs-of-technical-debt.pdf) dealing with technical debt, the debt they can see. Comprehension debt and decision debt do not show up in static analysis. They surface as production incidents, market failures, and strategic confusion.

## What I am still figuring out

Whether comprehension debt is temporary. If AI tools improve to the point where they can explain their own code reliably, comprehension debt might self-resolve. But this requires the same models that introduce the debt to also clear it, which seems circular.

The decision debt taxonomy is also less rigorous than I would like. The line between "wrong decision" and "right decision that aged badly" is often only visible in hindsight. Sony's Concord might have been a reasonable bet when it was funded. The $200 million loss does not prove the decision was wrong when it was made.

---

Cunningham's original insight was that debt is not inherently bad. Taking on debt consciously, with a plan to repay it, accelerates progress. The danger is debt you do not know you have.

Technical debt is visible. Comprehension debt hides in code that works until it does not. Decision debt hides in roadmaps that feel productive until they are not.

The Pivotal engineers spent three years building. The code shipped. The project was scrapped. Somewhere in those three years, someone should have asked which debt they were accumulating, and whether anyone would ever want to pay it off.
