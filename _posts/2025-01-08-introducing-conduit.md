---
layout: post
title: "Route Smarter, Not Harder"
date: 2025-01-08
---

*Conduit is alpha software. Use at your own risk, expect breaking changes, and please report bugs.*

---

I have a confession: I route most of my queries to Claude Sonnet. Not because every query needs it, but because I do not want to think about which model to use.

This is expensive laziness. A simple "what time is it in Tokyo" does not need a frontier model. Neither does "summarize this paragraph" or "fix this typo." But the cognitive overhead of deciding per-query adds up fast, so I default to the expensive option.

Conduit is my attempt to stop doing that.

## The routing problem

If you use multiple LLM providers, you face three choices:

1. **Overspend** - Route everything to expensive models. Quality guaranteed, budget destroyed.
2. **Underspend** - Route everything to cheap models. Budget preserved, quality inconsistent.
3. **Manual rules** - Write if/else logic based on query patterns. Brittle, breaks when models change.

None of these are good. The first wastes money. The second wastes time debugging bad outputs. The third wastes engineering effort on routing logic that needs constant maintenance.

## Learning to route

Conduit takes a different approach: it learns which model works best for each type of query.

Conduit includes 11 routing algorithms, from simple baselines to contextual bandits. The best performer in my tests was [Dueling Bandit](https://www.cs.cornell.edu/people/tj/publications/yue_joachims_09a.pdf), which uses pairwise comparisons to find the best model for each query type. These algorithms maintain probability distributions over model performance and learn which models work best for different query types.

```python
from conduit import Router, Query

router = Router()

# Conduit picks the model
decision = await router.route(
    Query(text="What is the capital of France?")
)

# After you get results, tell Conduit how it went
await router.feedback(
    decision_id=decision.id,
    quality=0.95  # 0-1 scale
)
```

The feedback loop is the key. Every query teaches Conduit something. After a few hundred queries, it has learned your workload patterns and routes accordingly.

## What it optimizes

Conduit balances three objectives:

| Objective | Default Weight | What it measures |
|-----------|----------------|------------------|
| Quality | 70% | Did the response meet expectations? |
| Cost | 20% | How much did the API call cost? |
| Latency | 10% | How long did it take? |

The weights are configurable per-query. A user-facing chat might prioritize latency. A batch analysis job might prioritize cost. A critical decision might prioritize quality at any price.

## Benchmark results

*I am still verifying these results. Treat them as preliminary.*

I tested all 11 algorithms on two datasets:

- **MMLU** (Massive Multitask Language Understanding): 1000 multiple-choice questions across 57 subjects from STEM to humanities. Tests breadth of knowledge.
- **GSM8K** (Grade School Math 8K): 1319 math word problems requiring multi-step reasoning. Tests logical problem-solving.

For each query, algorithms route to one of the available models, then receive feedback on whether the answer was correct. Quality is the percentage of correct answers.

**MMLU (1000 queries)** - 6 models: GPT-4o-mini, GPT-4o, GPT-4-turbo, Claude Sonnet 4.5, Claude Opus 4.5, Gemini 2.5 Pro

| Algorithm | Total Cost | Quality |
|-----------|------------|---------|
| Dueling Bandit | $1.97 | 93.2% |
| Hybrid UCB1+LinUCB | $1.81 | 91.1% |
| Thompson Sampling | $2.61 | 90.3% |
| Static model (GPT-4-turbo) | $0.20 | 82.0% |

**GSM8K (1319 queries)** - 8 models: Claude Haiku/Sonnet/Opus 4.5, Gemini 2.5 Flash/Pro, GPT-5 Mini/Nano/5.1

| Algorithm | Total Cost | Quality |
|-----------|------------|---------|
| Hybrid UCB1+LinUCB | $10.68 | 95.3% |
| Dueling Bandit | $10.40 | 95.1% |
| Thompson Sampling | $11.51 | 92.9% |
| Static model (Gemini 2.5 Pro) | $17.84 | 87.0% |

The key finding: **learning algorithms outperform static model selection**. On MMLU, Dueling Bandit reached 93.2% vs 82.0% for always routing to a fixed high-quality model. On GSM8K, Hybrid UCB1+LinUCB hit 95.3% vs 87.0% for static routing. No single model dominates all query types - adaptive routing discovers which models work best for which questions. Full methodology and raw data in the [benchmark repo](https://github.com/ashita-ai/conduit-benchmark).

## What Conduit does not do

Transparency about limitations:

- **No streaming** - Batch only for now. Streaming is planned but not implemented.
- **No multi-tenancy** - Single-tenant. Deploy separate instances if you need isolation.
- **No web UI** - API and CLI only.
- **No auth** - Deploy behind your own authentication layer.
- **No fine-tuning** - Routes to existing models, does not train them.

If you need enterprise features like SSO, SOC2 compliance, or a dashboard, look at [Portkey](https://portkey.ai/) or [Martian](https://withmartian.com/). Conduit is for people who want a simple library they control.

## When to use it

Conduit makes sense if:

- You spend $500+/month on LLM APIs
- You have 1000+ queries/day with varying complexity
- You use 3+ different models
- You want automatic optimization without manual routing rules

It does not make sense if:

- You only use one model
- You have fewer than 100 queries/day
- All your queries need the same capability level

## Try it

```python
import asyncio
from conduit import Router, Query

async def main():
    router = Router()

    # Simple query - probably routes to a cheap model
    q1 = await router.route(Query(text="What is 2+2?"))
    print(f"Math query -> {q1.selected_model}")

    # Complex query - probably routes to a capable model
    q2 = await router.route(Query(
        text="Analyze the economic implications of central bank digital currencies on monetary policy transmission mechanisms"
    ))
    print(f"Analysis query -> {q2.selected_model}")

asyncio.run(main())
```

The [repo is on GitHub](https://github.com/ashita-ai/conduit). It is not pip installable yet - clone the repo and install with `uv sync`. Again: this is alpha software. The API will change. But if you are tired of overpaying for simple queries, it might be worth a look.

---

*This is part of a series on the tools I am building at Ashita AI. See also: [Engram](/blog/introducing-engram/), memory that does not lie. [Tessera](/blog/introducing-tessera/), data contracts for agentic engineering.*
