---
layout: post
title: "The Seeing Problem"
date: 2026-02-05
---

A startup used AI to translate their codebase into a new language. The AI generated a hardcoded UUID that assigned every new user the identical identifier. The code worked perfectly for the first user. For everyone after that, the signup flow crashed on database uniqueness constraints.

The outage lasted [five days](https://allinconsulting.substack.com/p/how-ai-generated-code-caused-a-10000). At least $10,000 in lost revenue. Dozens of angry support messages before anyone figured out what was wrong.

The fix would have been trivial. A basic alert on signup failures. An error log anyone was monitoring. But the startup had neither. They discovered the bug from customer complaints, not observability.

This is the seeing problem: AI makes building faster while making understanding harder. Researchers call it [comprehension debt](https://arxiv.org/abs/2512.08942): what happens when teams build systems more sophisticated than they can independently understand. Traditional technical debt means someone understood the code when it was written. Comprehension debt means nobody ever did.

## The velocity trap

AI coding tools work. The productivity gains are documented. But velocity has a cost that does not show up in sprint metrics. [Research on AI-generated projects](https://arxiv.org/html/2512.22387) found that only 68.3% execute successfully. Of the failures, 52.6% stemmed from code generation errors. The dependency gap is worse: projects claiming 3 dependencies actually required an average of 37 packages. A 13.5x difference between what the AI said and what the code needed.

When [Veracode tested over 100 LLMs](https://www.veracode.com/blog/genai-code-security-report/), 45% of the generated code failed security tests. SQL injection points. Exposed API keys. Insecure authentication patterns.

These are not edge cases discovered in research labs. These are production codebases at companies that thought they were moving fast.

## The visibility gap

The building tools are mature. Cursor, Copilot, Claude Code, Devin. They are production-ready and getting better every quarter. [The industry built the factory](/blog/the-factory-without-a-design-department/).

The seeing tools are not.

[Only 4% of organizations](https://www.unleash.ai/artificial-intelligence/just-4-of-organizations-are-seeing-true-roi-from-ai-finds-atlassian/) are seeing true ROI from AI, according to Atlassian research. The other 96% have productivity gains that do not translate to organizational outcomes. The gap is visibility. Teams are, in the words of [one industry analysis](https://portkey.ai/blog/the-complete-guide-to-llm-observability/), "flying blind, unable to explain why costs suddenly spiked, struggling to reproduce bugs in non-deterministic systems, and lacking visibility into whether their models were actually performing well or slowly degrading."

The problem is structural. Traditional software is deterministic: same input, same output, traceable logic. AI systems are not. The same prompt produces different outputs. The reasoning is opaque. The failure modes are silent. The model returns a confident wrong answer and your logs show success.

This is why [healthy metrics hide broken agents](/blog/healthy-metrics-broken-agent/). The dashboard is green. The system is failing. You cannot see the difference.

## What AI changes

The old visibility problem was about scale. Too many logs, too many metrics, too many services. The solution was aggregation, sampling, dashboards.

The new visibility problem is about comprehension. The code exists but nobody understands it. The system works but nobody knows why. The failure happened but nobody can reproduce it.

This changes what visibility means. You need to see:

**The reasoning, not just the output.** When an agent makes a decision, you need the chain of thought. What did it consider? What did it reject? Why did it choose this path? Output-level monitoring tells you what happened. It does not tell you whether it should have happened.

**The drift, not just the snapshot.** AI systems degrade differently than traditional software. They do not crash. They get slowly worse. A prompt that worked last month works less well this month. A model that was accurate is now confidently wrong. Without continuous visibility into performance over time, you cannot see the degradation until users complain.

**The dependencies, not just the claims.** The 13.5x dependency gap means the declared architecture and the actual architecture are different. You need visibility into what the system actually does, not what the AI said it would do.

## The counterarguments

"AI tools show their reasoning." Claude has chain-of-thought. Copilot has confidence scores. This is true but insufficient. Tool-level transparency is not system-level visibility. You can see what Claude Code is doing in the moment. You cannot see how that code behaves in production, how it interacts with other systems, how it degrades over time. The visibility gap is at the integration layer.

"We just need better tests." Tests catch what you anticipate. The 52.6% failure rate from code generation errors was not caught by tests. The dependency gap was not caught by tests. Production reveals what you did not anticipate. [Pre-production evals](/blog/your-evals-wont-save-you/) are not the same as production learning.

"AI will solve the observability problem too." Probably true eventually. But right now we are in a gap. The building tools are years ahead of the seeing tools. Investment needs to catch up. And even with AI-assisted observability, you still need visibility into what the AI observer is doing. The turtles go all the way down.

## What actually works

At Mailchimp, we built a tool to ingest, analyze, and visualize MySQL slow query logs. Nothing sophisticated. Just visibility into what was actually happening.

Within three months, slow query volume dropped by 20%. The worst pages went from 60-second loads to under a second. The tool did not fix anything. It showed people where to look.

This is the leverage that keeps getting ignored. [Splunk's research](https://www.splunk.com/en_us/blog/observability/state-of-observability-2025.html) found that organizations with mature observability practices achieve 53% higher ROI than their peers. [75% of organizations](https://www.dynatrace.com/news/blog/state-of-observability-2025-ai-trust-roi/) are increasing their observability budgets. The data is clear. The investment is not.

The Mailchimp tool cost days to build. It saved months of debugging. The ROI was obvious in retrospect. It was not obvious in advance because visibility does not demo well. It does not justify new headcount. It does not generate press releases.

AI makes this worse. AI-generated code ships faster, which means the codebase grows faster, which means the surface area for bugs expands faster. [92% of developers](https://runframe.io/blog/state-of-incident-management-2025) report that AI tools have increased the "blast radius" of bad deployments. [75% of developer time](https://coralogix.com/blog/this-is-what-your-developers-are-doing-75-of-the-time-and-this-is-the-cost-you-pay/) already goes to debugging. AI velocity is increasing the numerator without decreasing the denominator.

## The investment mismatch

The pattern is consistent. Teams invest heavily in AI coding tools (mature, demonstrable, exciting) and under-invest in AI observability (emerging, unglamorous, essential). The ratio is wrong.

If you are shipping 12x more code, you need 12x more visibility. If you are generating code that 52.6% of the time has errors, you need to see those errors before production. If your dependencies explode 13.5x beyond what was specified, you need to know what you actually deployed.

The seeing problem is not a technical limitation. The tools exist. [Datadog](https://www.datadoghq.com/product/llm-observability/), [Honeycomb](https://www.honeycomb.io/resources/getting-started/what-is-llm-observability), [Arize](https://arize.com/), [Langfuse](https://langfuse.com/). The problem is prioritization. Teams treat observability as something to add after the system works. But with AI-generated code, you may not know if the system works until you can see what it is actually doing.

## What I am still figuring out

The Mailchimp story suggests that simple visibility tools have outsized impact. But that was traditional software with deterministic behavior. I am not sure whether the same approach scales to AI-generated systems where behavior is non-deterministic by design. The chain-of-thought reasoning that worked for one prompt may not apply to the next. Production may be fundamentally less reproducible than it was before. If so, "observability" as we understood it may need to become something closer to continuous auditing. I do not know what the right abstraction is yet.

---

That startup's five-day outage cost at least $10,000. The fix was a basic alert that would have caught the UUID collision in minutes.

AI solved the building problem. It created the seeing problem. Velocity without visibility is not speed. It is a $10,000 lesson you have not learned yet.
