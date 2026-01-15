---
layout: post
title: "Healthy Metrics, Broken Agent"
date: 2025-01-13
---

An infinite agent loop ran for [11 days at GetOnStack](https://www.zenml.io/blog/what-1200-production-deployments-reveal-about-llmops-in-2025) before anyone noticed. Costs went from $127/week to $47,000. A 370x increase.

The latency metrics looked fine. The error rates were zero. The dashboard was green. The agents were burning money in a conversation with themselves.

This is what happens when you have visibility into performance but no visibility into reasoning.

## The debugging loop from hell

When [researchers interviewed practitioners](https://arxiv.org/abs/2512.17896) building multi-agent systems, they found a consistent pattern. Something goes wrong. The operator opens the logs. The logs are a wall of text with no structure. The operator re-runs the workflow. Ten minutes pass. The output is different but still wrong. They tweak a prompt. Ten more minutes. Still wrong, differently.

Onboarding to existing observability tools took a week. The tools were designed for developers who understand the internals. The people actually running these systems in production are not those developers.

One practitioner described waiting ten minutes just to check if a fix worked. Another said they could not interrupt a failing workflow to test a hypothesis. The system runs to completion or it fails completely. No checkpoints. No inspection points. No ability to ask "what were you thinking at step 4?"

## The metrics everyone tracks

Token usage. Latency. Cost per query. Error rates.

These metrics tell you the economics of your system. They do not tell you whether your system is working.

A query can complete in 200ms, cost $0.02, use 1,500 tokens, and be completely wrong. The metrics look healthy. The output is garbage. You will not know until a user complains.

Here is the problem: [68% of agent trajectories](https://arxiv.org/html/2511.04032v1) in one research dataset were anomalous. Cycles, errors, drift. Most never crashed. They completed successfully with wrong results. Silent failures that your error rate dashboard will never catch.

It gets worse. When tools return wrong answers, [agents do not reject them](https://arxiv.org/html/2406.19228v1). They copy the incorrect output and hallucinate a justification. Accuracy drops up to 47%, but the agent looks confident. The response is fluent. The reasoning sounds plausible. The answer is wrong.

The metrics that matter are harder to compute:

| Metric | What it reveals | Why it's hard |
|--------|-----------------|---------------|
| Retrieval precision | Did you fetch relevant context? | Requires ground truth labels |
| Groundedness | Is output supported by context? | Requires semantic evaluation |
| Reasoning coherence | Did the chain of thought make sense? | Requires LLM-as-judge |
| Tool selection accuracy | Did the agent pick the right tool? | Requires knowing the right answer |

Every useful metric requires either human labels or an LLM evaluating another LLM's output. This is expensive. Many teams skip it and hope their latency graphs will catch problems.

They will not.

## The semantic gap

Traditional distributed tracing answers: which service was slow? Which call failed?

Agent debugging requires different questions: Why did the agent choose tool A instead of tool B? What was in memory when it made that decision? At what point did reasoning go off track?

The tooling landscape is crowded but immature. Langfuse and Arize Phoenix offer open-source tracing with self-hosting options. LangSmith integrates deeply with LangChain but locks you into their ecosystem. Research tools like [AgentSight](https://arxiv.org/abs/2508.02736) use eBPF to monitor at system boundaries, catching prompt injection and coordination deadlocks with under 3% overhead.

None of these fully solve the semantic gap. They tell you what happened. They improve on raw logs. But "why did the agent reason incorrectly" remains a question you answer by reading transcripts and guessing. The tools surface the data. The interpretation is still manual.

## Making failures attributable

When a multi-agent workflow produces wrong output, the first question is: which agent broke it?

This is harder than it sounds. An upstream agent produces subtly wrong output. A downstream agent accepts it without question. The final result is confidently incorrect in ways that are difficult to trace back to the source.

[XAgen](https://arxiv.org/abs/2512.17896) attacks this by scoring each step against the task goal. An LLM evaluator asks: did this step move toward the objective or away from it? This surfaces where things went wrong, not just where the workflow crashed.

In user studies, participants found failures faster with this approach than with raw logs plus commercial dashboards. The difference was attribution. Knowing the failure happened is easy. Knowing which agent caused it is the hard part.

Even automated attribution can mislead. Zalando built an LLM pipeline to analyze incident postmortems and found it [blamed technologies just because they were mentioned](https://www.zenml.io/blog/what-1200-production-deployments-reveal-about-llmops-in-2025), not because they caused the problem. S3 appeared in the logs, so the model blamed S3. Even with Claude Sonnet, roughly 10% of attributions were wrong.

## What I am still figuring out

The tradeoff between observability depth and cost is not well understood.

Structural tracing (request flows, timing, errors) is cheap. Under 3% overhead.

Semantic evaluation (LLM judging each step) is expensive. It adds latency, cost, and complexity that scales with workflow length.

For high-stakes workflows where a single failure is unacceptable, semantic evaluation probably pays for itself. For high-volume low-stakes queries, the cost may exceed the benefit. I do not have a principled way to decide where the threshold is.

The other open question: how much to log. Full prompts and completions enable detailed debugging but create storage costs and privacy risks. Truncated logs are cheaper but lose the detail you need when something breaks. The extremes are both wrong. I have not found the middle ground.

---

Cubic built an AI code review agent and [gave it more tools](https://www.zenml.io/blog/what-1200-production-deployments-reveal-about-llmops-in-2025). More capabilities meant more false positives. Developers stopped trusting it entirely. They had to remove tools and require explicit reasoning logs before actions. Fewer capabilities yielded better results.

The Sentry team learned this the hard way: "shipped early without observability and paid for it: when AI tooling breaks, users don't retry the next day but abandon it for months."

The cost of operating blind is not just $47,000 in runaway API bills. It is users who quietly leave and never come back.
