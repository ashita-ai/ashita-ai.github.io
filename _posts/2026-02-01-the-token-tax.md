---
layout: post
title: "The Token Tax"
date: 2026-02-01
---

Perplexity spent [164% of their revenue](https://www.theinformation.com/articles/perplexity-ai-faces-ballooning-aws-costs-as-user-growth-slows) on AWS, Anthropic, and OpenAI bills in 2025. They were not training models. They were running searches. The cost structure made profitability mathematically impossible at their current scale.

OpenAI projected [$5 billion in losses](https://www.cnbc.com/2024/09/27/openai-sees-5-billion-loss-this-year-on-3point7-billion-in-revenue.html) for 2024 on $3.7 billion in revenue. The companies selling AI infrastructure are hemorrhaging money faster than the companies buying it.

Token costs dropped 1,000x in three years. Spending increased anyway.

## The paradox

This is [Jevons' Paradox](https://en.wikipedia.org/wiki/Jevons_paradox) in real time. When a resource becomes more efficient, total consumption increases rather than decreases. Coal engines got more efficient. Britain burned more coal, not less.

LLM inference costs dropped dramatically from GPT-3 era pricing to current levels. Per-token costs for frontier models fell by an order of magnitude or more year over year. Companies responded by spending [$37 billion on generative AI in 2025](https://menlovc.com/2025-the-state-of-generative-ai-in-the-enterprise/), up from $11.5 billion in 2024.

The invoice tripled because the invoice changed form.

## Where the cost moved

GPT-4's training cost was around $100 million. Its inference cost over its lifecycle is estimated at [$2.3 billion](https://www.semianalysis.com/p/gpt-4-architecture-infrastructure)—fifteen times the training spend. Training costs are one-time. Inference costs compound with every query, forever.

But inference is not where organizations are bleeding. The real multipliers are invisible:

A significant fraction of tokens in production LLM deployments are redundant—Anthropic's [prompt caching documentation](https://www.anthropic.com/news/prompt-caching) shows that cached prefixes can reduce costs by up to 90%, implying most of what gets sent is repeated context. System prompts get repeated with every call because the architecture is stateless. Context windows scale quadratically due to the attention mechanism: doubling context length quadruples compute cost. Organizations routinely discover their API costs are multiples of what they budgeted because inefficient context management compounds with scale.

Meanwhile, [50-70% of AI project budgets](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai) go to data preparation. Infrastructure consumes [roughly half of total AI spend](https://menlovc.com/2025-the-state-of-generative-ai-in-the-enterprise/). Compliance and governance are line items that did not exist two years ago.

The token got cheaper. Everything around the token got expensive.

## The architectural tax

The decisions made during early pilots create exponential multipliers at scale.

[84% of enterprises](https://www.gartner.com/en/newsroom/press-releases/2024-10-17-gartner-poll-finds-ai-costs-cutting-into-gross-margins-for-84-percent-of-enterprises) report AI costs cutting gross margins by more than 6%. [87% of data science projects](https://venturebeat.com/ai/why-do-87-of-data-science-projects-never-make-it-into-production/) never reach production. Gartner warned that CIOs who do not understand GenAI cost scaling could make [500%-1,000% errors](https://www.gartner.com/en/newsroom/press-releases/2024-08-19-gartner-identifies-top-three-genai-risks-for-cios-and-it-leaders) in budget calculations.

The pattern is consistent: pilot with synthetic data, prove the model works, scale to production, discover the architecture does not. The cost structure that worked for 100 queries per day collapses at 100,000.

Stateless API calls mean system prompts get retransmitted thousands of times per day. No caching layer. No shared context. Every request starts from scratch. A pilot does not notice this. Production does.

RAG pipelines retrieve the same documents repeatedly. A [Stanford study found that legal RAG tools hallucinate 17-33% of the time](https://dho.stanford.edu/wp-content/uploads/Legal_RAG_Hallucinations.pdf) despite vendor claims, and retrieval costs are often modeled in isolation while integration costs are ignored. The vector database is cheap. The data pipeline feeding it is not.

Multi-agent systems use [approximately 15x more tokens](https://www.anthropic.com/engineering/multi-agent-research-system) than single-agent interactions. Agents coordinate by passing context back and forth. Each handoff repeats information the previous agent already processed. [The factory scales linearly](/blog/the-factory-without-a-design-department/). The token cost scales quadratically.

## The three types of waste

**Repeated context.** System prompts, few-shot examples, and boilerplate instructions get sent with every request. Anthropic's [prompt caching](https://www.anthropic.com/news/prompt-caching) can reduce costs by 90% for these patterns, but only if the architecture is designed to use it. Retrofitting caching into a stateless system requires rewriting the entire call pattern.

**Irrelevant retrieval.** RAG systems retrieve top-K results by similarity. Similarity is not relevance. You pay to process documents that share keywords with the query but do not answer it. The embedding model does not know which chunks matter until after you have already paid to retrieve them.

**Redundant reasoning.** The LLM re-derives the same conclusions repeatedly because nothing persists between calls. A customer support agent answers the same question fifty times per day. Each time, the model processes the full context, reasons through the answer, and generates the response. Caching the answer would cost nearly nothing. Re-computing it costs 50x.

## What actually works

**Prompt caching.** Anthropic's implementation can reduce costs by 90% for repeated context. But the benefit only materializes if your system is architected to reuse prompts. The savings are not automatic. They require deliberate design.

**Structured outputs.** JSON mode, function calling, and structured generation reduce token waste from retry loops. When the model outputs malformed JSON, you pay to re-generate. Structured outputs eliminate the failure mode. The token savings are small per request but compound over millions of calls.

**Stateful context.** Maintaining state between turns eliminates repeated transmission of conversation history. A stateless system sends the full conversation with every message. A stateful system sends only the delta. The difference at scale is not marginal—it is the difference between profitability and burning 164% of revenue.

**Selective retrieval.** Hybrid search (BM25 + vector embeddings + reranking) costs more per query but retrieves fewer irrelevant documents. You pay more for retrieval and less for processing. The net is often cheaper because you are not paying the LLM to ignore junk.

## The real cost

The token tax is not the API bill. The token tax is the architectural decisions you made when tokens were cheap and mistakes were free.

You built a stateless system because stateless is simple. You skipped caching because the pilot worked without it. You designed agents to over-communicate because coordination failures were worse than redundant context. These were rational choices when the cost was $50/month.

They are not rational at $500,000/month.

The companies that survive are not the ones with the best models. They are the ones that designed for cost from the beginning. Netflix, Stripe, and Uber deploy models constantly because their infrastructure was built to make deployment cheap. [Shadow deployments, automated rollback, and guardrails](/blog/the-ai-pilot-graveyard/) are not features—they are cost controls dressed up as reliability engineering.

The invoice arrived in 2025. It showed up as missed margin targets, budget overruns, and AI initiatives that worked technically but failed economically.

## What I am still figuring out

Prompt caching reduces costs by 90% in Anthropic's examples, but those examples are optimized demos. Production systems have more complex call patterns. The real savings are probably lower. I have not seen enough public data to know how much lower.

The Perplexity revenue-to-infrastructure ratio (164%) is extreme, but it may not be representative. They are a search company, which means every query hits retrieval + LLM + reranking. Most AI applications have lower per-query costs. The 164% figure is a warning, not a baseline.

---

Tokens got cheap. Systems got expensive.

The cost moved from training to inference, from models to context, from prompts to architecture. The companies bleeding money are not the ones using AI poorly. They are the ones who designed for capability and discovered too late that capability is not the constraint.

The constraint is cost per query at scale, and the architectural decisions you make in the pilot determine whether that cost is sustainable or catastrophic.
