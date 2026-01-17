---
layout: post
title: "The Reliability Tax"
date: 2026-01-28
---

A [$500,000 model cost $3.5 million to operate](https://itsoli.ai/the-hidden-tax-of-ai/) over three years. Gartner found that for every dollar spent on AI development, enterprises spend [$4-6 on ongoing operations](https://itsoli.ai/the-hidden-tax-of-ai/). [60% of enterprise GenAI investments](https://menlovc.com/2024-the-state-of-generative-ai-in-the-enterprise/) come from innovation budgets, not operational budgets. The money funds the build. The maintenance is someone else's problem.

This is the conventional framing: AI has a reliability tax. Budget for it. Staff for it. Accept it.

That framing is already obsolete.

## The old model

[MIT research](https://www.nannyml.com/blog/91-of-ml-perfomance-degrade-in-time) found that 91% of ML models degrade over time. [CloudZero](https://www.cloudzero.com/state-of-ai-costs/) found that only 51% of organizations can track whether their AI investments deliver returns. The conventional response is to staff up: hire ML engineers, build monitoring dashboards, create retraining pipelines, run incident response.

Google's research team called ML systems ["the high-interest credit card of technical debt"](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/43146.pdf) in 2015. For a decade, the answer was to pay down that debt with human labor.

That answer assumed humans were the only ones who could do the work.

## The new model

[Devin](https://devin.ai/) writes code, debugs it, runs tests, and fixes issues autonomously. Goldman Sachs made it ["Employee #1"](https://www.ibm.com/think/news/goldman-sachs-first-ai-employee-devin) in their hybrid AI workforce. Nubank used it for migrating their core ETL (a 6-million line monolith) and reported [12x efficiency improvement and 20x cost savings](https://devin.ai/customers/nubank).

Claude Code reads logs, diagnoses issues, and fixes code. Cursor and Windsurf do the same. These are not research demos. They are production tools that thousands of engineers use daily.

The reliability tax assumed humans do the ops. If agents do the ops, the multiplier collapses.

## The real question

The question is not "how much should I budget for ops?" The question is "can agents maintain this system?"

This changes what you optimize for. Instead of building systems that humans can monitor and debug, you build systems that agents can monitor and debug. The requirements are different:

**Structured outputs over natural language.** Agents parse JSON reliably. They struggle with prose. [The decisions you make about data infrastructure](/blog/the-data-platform-decisions-that-haunt-you/) in year one determine whether agents can maintain your system in year three.

**Explicit error states over silent failures.** Agents cannot infer what went wrong from vibes. They need clear signals. Systems that fail loudly are systems agents can fix.

**Reproducible environments over tribal knowledge.** An agent cannot ask the senior engineer what that config flag does. It needs documentation, tests, and environments it can spin up and test against.

**Observable pipelines over black boxes.** [Healthy metrics on a broken agent](/blog/healthy-metrics-broken-agent/) fools humans. It also fools agents. The monitoring has to be real.

## The transition cost

The 4-6x multiplier is real today. You cannot pretend you are post-tax when you are not.

But the trajectory is clear. Observability platforms like Arize and WhyLabs are using AI to detect drift automatically. LLM monitoring tools like Langfuse and Braintrust are building toward automated evaluation and retraining triggers. The agents are getting better every quarter.

The companies that will pay the lowest reliability tax are not the ones that budget the most for human ops. They are the ones building systems that agents can maintain.

## What to actually do

Do not staff for permanent human ops. Staff for the transition. Build the systems, processes, and documentation that let agents take over operational work as they become capable.

Measure agent maintainability, not just human maintainability. Can Claude Code understand your codebase? Can Devin reproduce your bugs? If not, you are building a system that will require expensive human labor forever.

Invest in structured observability. The [30-50% of AI cloud spend](https://www.cloudzero.com/state-of-ai-costs/) that evaporates into waste does so because nobody (human or agent) can see what is happening. Fix visibility first.

Accept that the tax exists today. Budget for human ops while building for agent ops. The companies that pretend the transition is complete end up with systems that neither humans nor agents can maintain.

---

The reliability tax is real. It is also shrinking. The question is whether you are building for the tax rate of 2024 or the tax rate of 2027.
