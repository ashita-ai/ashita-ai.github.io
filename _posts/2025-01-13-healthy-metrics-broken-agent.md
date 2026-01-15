---
layout: post
title: "Healthy Metrics, Broken Agent"
date: 2025-01-13
---

An infinite agent loop ran for [11 days at GetOnStack](https://www.zenml.io/blog/what-1200-production-deployments-reveal-about-llmops-in-2025) before anyone noticed. Costs went from $127/week to $47,000.

The latency metrics looked fine. Error rates were zero. The dashboard was green. The agents were burning money in a conversation with themselves.

This is what happens when you have visibility into performance but no visibility into reasoning.

## The silent majority

Token usage. Latency. Cost per query. Error rates. These metrics tell you the economics of your system. They do not tell you whether it is working.

[68% of agent trajectories](https://arxiv.org/html/2511.04032v1) in one research dataset were anomalous. Cycles, errors, drift. Most never crashed. They completed successfully with wrong results.

When tools return wrong answers, [agents do not reject them](https://arxiv.org/html/2406.19228v1). They copy the incorrect output and hallucinate a justification. The response is fluent. The reasoning sounds plausible. The answer is wrong. [Errors cascade](/blog/your-agents-need-a-supervisor/).

Your error rate dashboard will not catch this.

## The tooling landscape

The tools exist. They are immature.

[Langfuse](https://langfuse.com) and [Arize Phoenix](https://phoenix.arize.com) offer open-source tracing with self-hosting options. [LangSmith](https://smith.langchain.com) integrates deeply with LangChain but locks you in. [Pydantic Logfire](https://pydantic.dev/logfire) gives you full-stack observability (LLM calls, HTTP, databases) on OpenTelemetry.

None of these fully solve the semantic gap. They tell you what happened. "Why did the agent reason incorrectly" remains a question you answer by reading transcripts.

## What I am still figuring out

The tradeoff between observability depth and cost is unclear. Structural tracing is cheap (under 3% overhead). [Semantic evaluation](/blog/introducing-arbiter/) (LLM judging each step) is expensive and scales with workflow length.

For high-stakes workflows, semantic evaluation probably pays for itself. For high-volume queries, maybe not. I do not have a principled way to decide where the threshold is.

---

The Sentry team [learned this the hard way](https://www.zenml.io/blog/what-1200-production-deployments-reveal-about-llmops-in-2025): "shipped early without observability and paid for it: when AI tooling breaks, users don't retry the next day but abandon it for months."

The cost of operating blind is not just $47,000 in runaway bills. It is users who quietly leave and never come back.
