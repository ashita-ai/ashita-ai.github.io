---
layout: post
title: "Build for Agents, Not Ops"
date: 2026-01-29
---

A [$500,000 model cost $3.5 million to operate](https://itsoli.ai/the-hidden-tax-of-ai/) over three years. Gartner found that for every dollar spent on AI development, enterprises spend [$4-6 on ongoing operations](https://itsoli.ai/the-hidden-tax-of-ai/). Google spends [10-20x more on inference than model training](https://ficustechnologies.com/blog/why-ai-is-so-expensive-in-2025-breaking-down-the-real-costs/). [60% of enterprise GenAI investments](https://menlovc.com/2024-the-state-of-generative-ai-in-the-enterprise/) come from innovation budgets, not operational budgets.

The money funds the build. The maintenance is someone else's problem.

This is the conventional framing: AI has a reliability tax. Budget for it. Staff for it. Accept it.

That framing is already obsolete. But the replacement is more complicated than the vendors claim.

## The old model is failing

[A peer-reviewed study](https://www.nature.com/articles/s41598-022-15245-z) by researchers from MIT, Harvard, Cambridge, and the University of Monterrey found that 91% of ML models degrade over time. Without monitoring, [75% of businesses observed performance declines](https://smartdev.com/ai-model-drift-retraining-a-guide-for-ml-system-maintenance/). [CloudZero](https://www.cloudzero.com/state-of-ai-costs/) found that only 51% of organizations can track whether their AI investments deliver returns.

The conventional response is to staff up: hire ML engineers, build monitoring dashboards, create retraining pipelines, run incident response.

It is not working. For the first time in five years, [operational toil increased](https://runframe.io/blog/state-of-incident-management-2025): from 25% to 30% of developer time. That is roughly $37,500 wasted per engineer annually. For a 250-person engineering team, $9.4 million in human labor spent on tasks that should not require humans.

The expectation was that AI would reduce toil, not exacerbate it. But [69% of AI-powered decisions](https://www.dynatrace.com/news/press-release/state-of-observability-2025/) still require human verification. Organizations added new monitoring layers, alerts, and code review burdens without removing equivalent work. [73% experienced outages](https://www.splunk.com/en_us/blog/observability/state-of-observability-2025.html) caused by ignored or suppressed alerts—alert fatigue means teams miss real incidents.

Google's research team called ML systems ["the high-interest credit card of technical debt"](https://static.googleusercontent.com/media/research.google.com/en//pubs/archive/43146.pdf) in 2015. For a decade, the answer was to pay down that debt with human labor. That approach is hitting a ceiling.

## The new model

[Devin](https://devin.ai/) writes code, debugs it, runs tests, and fixes issues autonomously. Goldman Sachs treats it ["like a new employee"](https://www.ibm.com/think/news/goldman-sachs-first-ai-employee-devin) in their hybrid AI workforce. Nubank used it for migrating their core ETL—a 6-million line monolith—and reported [12x efficiency improvement and 20x cost savings](https://devin.ai/customers/nubank). For security vulnerabilities, one organization saw [20x efficiency gains](https://cognition.ai/blog/devin-annual-performance-review-2025): human developers averaged 30 minutes per fix, Devin averaged 1.5 minutes.

Claude Code reads logs, diagnoses issues, and fixes code. Cursor and Windsurf do the same. [Ardent](https://tryardent.com/) builds AI agents that handle engineering workflows end-to-end. These are not research demos. They are production tools that thousands of engineers use daily.

The reliability tax assumed humans do the ops. If agents do the ops, the multiplier collapses.

That is the theory. The evidence is more mixed than the case studies suggest.

## The split

McKinsey's [State of AI 2025](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai) found that 80% of companies deployed generative AI. It also found that 80% report no material impact on earnings. Deployment went up. Results did not follow.

The evidence on AI-assisted development is [split along a clear line](/blog/the-build-is-not-the-hard-part/): agents excel at structured, repeatable work and struggle with judgment-heavy complexity. Nubank's 6-million-line ETL migration was mechanical. The gains were real. The [METR randomized trial](https://metr.org/blog/2025-07-10-early-2025-ai-experienced-os-dev-study/) tested experienced developers on complex, context-heavy tasks. They were 19% slower with AI tools.

The implication for ops is direct: if your operational work is structured and repeatable, agents can handle it. If it requires deep institutional context and judgment, they cannot. The question is not whether agents can do ops. It is whether your ops are designed so that agents can.

## The real question

The question is not "how much should I budget for ops?" The question is "can agents maintain this system?"

This changes what you optimize for. Instead of building systems that humans can monitor and debug, you build systems that agents can monitor and debug. The requirements are different:

**Structured outputs over ambiguity.** Agents work best when the shape of the data is predictable. Schemas, typed APIs, consistent formats. The more your system relies on implicit conventions or unstructured blobs, the harder it is for agents to reason about. [The decisions you make about data infrastructure](/blog/the-data-platform-decisions-that-haunt-you/) in year one determine whether agents can maintain your system in year three.

**Explicit error states over silent failures.** Agents cannot infer what went wrong from vibes. They need clear signals. Systems that fail loudly are systems agents can fix.

**Reproducible environments over tribal knowledge.** An agent cannot ask the senior engineer what that config flag does. It needs documentation, tests, and environments it can spin up and test against.

**Observable pipelines over black boxes.** [Healthy metrics on a broken agent](/blog/healthy-metrics-broken-agent/) fools humans. It also fools agents. The monitoring has to be real.

**Mechanical tasks over judgment calls.** Design your systems so the operational work is as structured and repeatable as possible. The judgment-heavy work stays with humans. The mechanical work migrates to agents.

## What to actually do

Do not staff for permanent human ops. Staff for the transition. Build the systems, processes, and documentation that let agents take over operational work as they become capable.

Measure agent maintainability, not just human maintainability. Can Claude Code understand your codebase? Can Devin reproduce your bugs? If not, you are building a system that will require expensive human labor forever.

Invest in structured observability. [Organizations waste 32% of cloud budgets](https://www.datastackhub.com/insights/cloud-wastage-statistics/) on unused or misconfigured resources—[$44.5 billion projected for 2025](https://www.prnewswire.com/news-releases/44-5-billion-in-infrastructure-cloud-waste-projected-for-2025-due-to-finops-and-developer-disconnect-finds-finops-in-focus-report-from-harness-302385580.html). [54% of executives](https://www.anodot.com/news-item/survey-nearly-50-of-businesses-are-struggling-to-control-cloud-costs/) cite lack of visibility as the primary cause. Fix visibility first.

Separate the mechanical from the judgment-heavy. Agents are not general-purpose replacements for senior engineers. They are force multipliers for structured work. Design your operations so the mechanical parts are clearly delineated and agent-friendly.

Accept that the tax exists today. Budget for human ops while building for agent ops. The companies that pretend the transition is complete end up with systems that neither humans nor agents can maintain.

## What I am still figuring out

The mechanical 80% may not be the bottleneck. If the judgment-heavy 20% is where the real operational complexity lives, then automating the easy part changes the economics without changing the outcome. The companies building structured, well-documented systems with clear separation between mechanical and judgment-heavy work will see the biggest gains. The companies with sprawling legacy systems full of tribal knowledge will struggle regardless of how good the agents get.

---

In 2015, Google called ML the "high-interest credit card of technical debt." For a decade, organizations paid that debt with human labor. The interest kept compounding: 25% became 30%, and $9.4 million in toil became the cost of doing business.

The debt is still real. But the payment method is changing—for some kinds of work, for some kinds of systems. The question is not whether agents can do ops. It is whether your system is built so that they can.
