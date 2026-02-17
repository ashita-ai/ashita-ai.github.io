---
layout: post
title: "Healthy Metrics, Broken Agent"
date: 2026-01-13
---

An infinite agent loop ran undetected for [11 days at GetOnStack](https://www.zenml.io/blog/what-1200-production-deployments-reveal-about-llmops-in-2025). Weekly costs escalated from $127 to $47,000 over four weeks.

The latency metrics looked fine. Error rates were zero. The dashboard was green. The agents were burning money in a conversation with themselves.

## The pattern

GetOnStack is not unique. The pattern is older than AI and more expensive than most teams expect.

In 2022, Unity's ad-targeting algorithm ingested corrupted training data from a single client. The model continued serving predictions with normal latency and zero errors. Ad targeting quality degraded silently. The failure surfaced at quarterly earnings: an estimated [$110 million in lost revenue](https://www.datachecks.io/post/unity-technologies-110m-ad-targeting-error). CEO John Riccitiello called it a "self-inflicted wound." The stock dropped 40%.

A healthcare algorithm used by major insurers [assigned the same risk scores](https://www.science.org/doi/10.1126/science.aax2342) to Black patients who had 26.3% more chronic conditions than white patients at the same score. Aggregate accuracy looked strong. But the algorithm used healthcare spending as a proxy for health needs, and Black patients spent $1,800 less per year due to systemic access barriers. The metric was accurate. The proxy was wrong. The algorithm affected an estimated 70 million patients; similar commercial risk-prediction tools were applied to roughly 200 million Americans.

This pattern predates AI. Knight Capital [lost $460 million in 45 minutes](https://en.wikipedia.org/wiki/Knight_Capital_Group#2012_stock_trading_disruption) in 2012 when a deployment activated dead code on one of eight servers. Monitoring reported a successful deployment. The algorithm traded in the wrong direction four million times before anyone noticed. The British Post Office's Horizon software [created phantom shortfalls](https://en.wikipedia.org/wiki/British_Post_Office_scandal) for twenty-five years while system-level metrics balanced.

Every one of these systems passed its operational checks. Every one was failing at its actual purpose.

## The gap

Token usage, latency, cost per query, error rates: these tell you the economics of your system. They do not tell you whether it is working.

[68% of agent trajectories](https://arxiv.org/html/2511.04032v1) in one research dataset were anomalous: cycles, errors, drift. Most never crashed. They completed successfully with wrong results. When tools return wrong answers, [agents do not reject them](https://arxiv.org/html/2406.19228v1). They copy the incorrect output and hallucinate a justification. The response is fluent. The reasoning sounds plausible. The answer is wrong.

A systematic review of [84 AI evaluation papers](https://arxiv.org/abs/2506.02064) found that 83% measured technical performance but only 15% measured both technical and human-centered outcomes. The gap is structural. Operational metrics measure what the system is doing. Outcome metrics measure whether what the system is doing matters. Most teams build the former and never build the latter.

## What catches it

GetOnStack's loop would have been caught by a cost anomaly detector: weekly spend exceeding 3x baseline triggers a halt. Not a dashboard someone checks. A trigger that fires.

Unity's degradation would have been caught by continuous A/B testing: comparing model predictions against a holdout group on business metrics (revenue per impression), not operational metrics (latency, throughput).

The healthcare algorithm's racial bias would have been caught by disaggregating performance metrics by demographic group, not just measuring aggregate accuracy. The [aggregate hid the disparity](/blog/the-ai-pilot-graveyard/).

The common thread: measure the outcome, not the operation. Cost per query tells you the system is running. Revenue per decision tells you the system is working. The gap between these two measurements is where hundreds of millions of dollars disappear.

LLM tracing tools (Langfuse, Arize Phoenix, LangSmith, Pydantic Logfire) are maturing, but they solve a different problem. They trace what happened in the model's reasoning. They do not tell you whether the reasoning produced the right business result. That requires connecting model outputs to downstream outcomes, which requires data lineage most organizations do not have.

## What I am still figuring out

The tradeoff between observability depth and cost is unclear. Structural tracing is cheap (under 3% overhead). Semantic evaluation (LLM judging each step) is expensive and scales with workflow length. For high-stakes workflows, semantic evaluation probably pays for itself. For high-volume queries, maybe not. I do not have a principled way to decide where the threshold is.

Whether outcome metrics are even possible for some AI applications. Ad targeting can measure revenue per impression. Legal research can measure citation accuracy. But what is the "outcome metric" for a code generation tool? Lines that compile? Lines that survive code review? Lines that are still in the codebase a year later? The metric depends on the time horizon, and the right time horizon is not obvious.

---

GetOnStack's agents burned $47,000 in a conversation with themselves. Unity lost $110 million to silently degraded ad targeting. A healthcare algorithm covering 70 million patients used spending as a proxy for sickness, underserving Black patients with 26% more chronic conditions at the same risk score. Knight Capital lost $460 million in 45 minutes to dead code on one server.

The dashboards were green. The businesses were not.

The question is not whether your AI is running. The question is whether anyone is measuring what it is doing.
