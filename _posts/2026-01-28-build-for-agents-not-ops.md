---
layout: post
title: "Build for Agents, Not Ops"
date: 2026-01-28
---

A [$500,000 model cost $3.5 million to operate](https://itsoli.ai/the-hidden-tax-of-ai/) over three years. Gartner found that for every dollar spent on AI development, enterprises spend [$4-6 on ongoing operations](https://itsoli.ai/the-hidden-tax-of-ai/). [60% of enterprise GenAI investments](https://menlovc.com/2024-the-state-of-generative-ai-in-the-enterprise/) come from innovation budgets, not operational budgets. The money funds the build. The maintenance is someone else's problem.

This is the conventional framing: AI has a reliability tax. Budget for it. Staff for it. Accept it.

That framing is already obsolete.

## The old model is failing

[MIT research](https://www.nannyml.com/blog/91-of-ml-perfomance-degrade-in-time) found that 91% of ML models degrade over time. [CloudZero](https://www.cloudzero.com/state-of-ai-costs/) found that only 51% of organizations can track whether their AI investments deliver returns. The conventional response is to staff up: hire ML engineers, build monitoring dashboards, create retraining pipelines, run incident response.

It is not working. For the first time in five years, [operational toil increased](https://runframe.io/blog/state-of-incident-management-2025): from 25% to 30% of developer time. That is roughly $37,500 wasted per engineer annually. For a 250-person engineering team, $9.4 million in human labor spent on tasks that should not require humans.

The expectation was that AI would reduce toil, not exacerbate it. But 69% of AI-powered decisions still require human verification. Organizations added new monitoring layers, alerts, and code review burdens without removing equivalent work. 73% experienced outages caused by ignored or suppressed alerts (alert fatigue means teams miss real incidents).

Google's research team called ML systems ["the high-interest credit card of technical debt"](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/43146.pdf) in 2015. For a decade, the answer was to pay down that debt with human labor. That approach is hitting a ceiling.

## The new model

[Devin](https://devin.ai/) writes code, debugs it, runs tests, and fixes issues autonomously. Goldman Sachs made it ["Employee #1"](https://www.ibm.com/think/news/goldman-sachs-first-ai-employee-devin) in their hybrid AI workforce. Nubank used it for migrating their core ETL (a 6-million line monolith) and reported [12x efficiency improvement and 20x cost savings](https://devin.ai/customers/nubank). For security vulnerabilities, one organization saw [20x efficiency gains](https://cognition.ai/blog/devin-annual-performance-review-2025): human developers averaged 30 minutes per fix, Devin averaged 1.5 minutes.

Claude Code reads logs, diagnoses issues, and fixes code. Cursor and Windsurf do the same. [Ardent](https://tryardent.com/) builds AI agents that handle engineering workflows end-to-end. These are not research demos. They are production tools that thousands of engineers use daily.

The reliability tax assumed humans do the ops. If agents do the ops, the multiplier collapses.

## The real question

The question is not "how much should I budget for ops?" The question is "can agents maintain this system?"

This changes what you optimize for. Instead of building systems that humans can monitor and debug, you build systems that agents can monitor and debug. The requirements are different:

**Structured outputs over ambiguity.** Agents work best when the shape of the data is predictable. Schemas, typed APIs, consistent formats. The more your system relies on implicit conventions or unstructured blobs, the harder it is for agents to reason about. [The decisions you make about data infrastructure](/blog/the-data-platform-decisions-that-haunt-you/) in year one determine whether agents can maintain your system in year three.

**Explicit error states over silent failures.** Agents cannot infer what went wrong from vibes. They need clear signals. Systems that fail loudly are systems agents can fix.

**Reproducible environments over tribal knowledge.** An agent cannot ask the senior engineer what that config flag does. It needs documentation, tests, and environments it can spin up and test against.

**Observable pipelines over black boxes.** [Healthy metrics on a broken agent](/blog/healthy-metrics-broken-agent/) fools humans. It also fools agents. The monitoring has to be real.

## The transition cost

The operational cost multiplier (that $4-6 spent on ops for every $1 on development) is real today. You cannot pretend you are post-tax when you are not.

But the trajectory is clear. Observability platforms like Arize and WhyLabs are using AI to detect drift automatically. LLM monitoring tools like Langfuse and Braintrust are building toward automated evaluation and retraining triggers. The agents are getting better every quarter.

The companies that will pay the lowest reliability tax are not the ones that budget the most for human ops. They are the ones building systems that agents can maintain.

## What to actually do

Do not staff for permanent human ops. Staff for the transition. Build the systems, processes, and documentation that let agents take over operational work as they become capable.

Measure agent maintainability, not just human maintainability. Can Claude Code understand your codebase? Can Devin reproduce your bugs? If not, you are building a system that will require expensive human labor forever.

Invest in structured observability. [Organizations waste 30% or more of cloud budgets](https://www.datastackhub.com/insights/cloud-wastage-statistics/) on unused or misconfigured resources, and in 54% of cases the waste stems from lack of visibility. Fix visibility first.

Accept that the tax exists today. Budget for human ops while building for agent ops. The companies that pretend the transition is complete end up with systems that neither humans nor agents can maintain.

## What I am still figuring out

The transition timing is genuinely uncertain. Devin and Claude Code are impressive, but I do not know whether they can handle the long tail of operational complexity (the weird edge cases, the undocumented infrastructure quirks, the incidents that require institutional knowledge). The optimistic read is that structured observability solves this. The pessimistic read is that some operational knowledge is inherently tacit and will resist automation for years. I have not seen enough production deployments to know which is true.

---

In 2015, Google called ML the "high-interest credit card of technical debt." For a decade, organizations paid that debt with human labor. The interest kept compounding: 25% became 30%, and $9.4 million in toil became the cost of doing business.

The debt is still real. But the payment method is changing.
