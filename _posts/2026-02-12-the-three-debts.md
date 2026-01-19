---
layout: post
title: "The Three Debts"
date: 2026-02-12
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

Carnegie Mellon researchers recently [identified a new form of debt](https://arxiv.org/abs/2512.08942) emerging from AI-assisted development: comprehension debt. This is what happens when AI helps teams build systems more sophisticated than they can independently understand or maintain.

The distinction from technical debt is fundamental. Technical debt means someone understood the code when it was written. Comprehension debt means nobody ever did.

A junior developer uses Claude to generate a caching layer. The code works. The tests pass. Six months later, the cache starts returning stale data under load. The developer who wrote it cannot debug it because they never understood how it worked. They understood what it did, not why.

This is [the hollow codebase problem](/blog/the-hollow-codebase/). AI-assisted developers produce [3-4x more commits](https://apiiro.com/blog/4x-velocity-10x-vulnerabilities-ai-coding-assistants-are-shipping-more-risks/) while generating 10x more security findings. The ratio of code produced to code understood is diverging.

You cannot refactor comprehension debt. Refactoring assumes you understand both the current implementation and the desired implementation. When you do not understand the current implementation, you are not refactoring. You are rewriting blind, likely introducing new comprehension debt in the process.

The only remediation is to build understanding—or to accept permanent dependency on AI assistance for that part of the system. Neither is free. The first requires slowing down to learn what you skipped. The second means [your seeing problem never gets solved](/blog/the-seeing-problem/).

**Comprehension debt is code that nobody understood when written, and that accumulates interest every time someone touches it without understanding it.**

## Decision Debt

The third debt is rarely named but compounds the fastest: decision debt. This is the cost of choices made for the wrong reasons.

The [first startup I worked for](/blog/the-attention-economy-of-engineering/) built an intelligent scraper with infrastructure engineered for Netflix-scale when we were a tiny fraction of it. The code was clean. The architecture was sound. The engineers understood every line. There was no technical debt and no comprehension debt.

The company was acquired for less than a million dollars.

The debt was in the decision itself—engineering attention allocated to technically interesting infrastructure instead of the product that would determine whether anyone cared. This is [resume-driven development](/blog/the-attention-economy-of-engineering/) at the organizational level: building what looks impressive instead of what matters.

Decision debt is invisible in the codebase. The code is fine. The architecture might even be elegant. The debt is in what you chose to build, when you chose to build it, and why. It surfaces years later when you realize the decisions made in year one have [compounded into constraints](/blog/the-data-platform-decisions-that-haunt-you/) you cannot escape without starting over.

[28% of executives cannot name their company's strategic priorities](/blog/the-28-percent-problem/). The decisions being made are not aligned with any coherent strategy. Each decision is locally rational, individually defensible, and collectively incoherent. The debt compounds with every sprint.

You cannot refactor decision debt. You cannot improve your way out of building the wrong thing. Sony's Concord game [cost $200 million to develop and lasted 14 days](https://medium.com/javarevisited/the-biggest-software-failures-of-2024-8e9413350f4c) after launch before being pulled. The code worked. The decisions did not.

**Decision debt is the cost of choices made for the wrong reasons, compounding silently until the consequences become unavoidable.**

## The Taxonomy

| Debt Type | Definition | Detection | Remediation |
|-----------|------------|-----------|-------------|
| **Technical** | Code someone understood, now outdated | Code review, static analysis | Refactor incrementally |
| **Comprehension** | Code nobody ever understood | Production incidents, debugging time | Build understanding or accept dependency |
| **Decision** | Choices made for wrong reasons | Market feedback, strategic review | Live with it or rewrite entirely |

## Why the distinction matters

Teams misdiagnose debt constantly.

A system built with AI assistance starts failing in production. Leadership authorizes a refactoring sprint. Engineers spend weeks cleaning up code they still do not understand. The system fails again. The problem was comprehension debt, not technical debt. The intervention made no difference.

A product loses market share. Leadership authorizes a "modernization" initiative. Engineers rebuild the platform with better architecture. Market share continues declining. The problem was decision debt—the product strategy was wrong. Better code did not fix the strategy.

The intervention must match the debt type:

- **Technical debt** responds to engineering effort. Refactor, pay it down, move on.
- **Comprehension debt** responds to learning. Slow down, understand the system, or accept the dependency.
- **Decision debt** responds only to strategic change. No amount of engineering excellence fixes building the wrong thing.

Most organizations have all three. The dangerous ones are the invisible debts—comprehension debt hiding in AI-generated code, decision debt hiding in locally-rational choices.

## The objection

The obvious critique: this is splitting hairs. Debt is debt. Just pay it down.

But the intervention determines the outcome. CodeScene found that developers spend [42% of their time](https://www.blueoptima.com/post/the-real-price-of-technical-debt) dealing with technical debt. That is the debt they can see. Comprehension debt and decision debt do not show up in static analysis. They do not trigger code quality alerts. They surface as production incidents, market failures, and strategic confusion.

When you treat comprehension debt as technical debt, you refactor code you do not understand into different code you do not understand. When you treat decision debt as technical debt, you polish implementations of the wrong thing. The debt remains. The interest compounds.

Precise diagnosis enables precise treatment. Vague diagnosis produces vague effort.

---

Cunningham's original insight was that debt is not inherently bad. Taking on debt consciously, with a plan to repay it, accelerates progress. The danger is debt you do not know you have.

Technical debt is visible. Comprehension debt hides in code that works until it does not. Decision debt hides in roadmaps that feel productive until they are not.

The Pivotal engineers spent three years building. The code shipped. The project was scrapped. Somewhere in those three years, someone should have asked which debt they were accumulating—and whether anyone would ever want to pay it off.
