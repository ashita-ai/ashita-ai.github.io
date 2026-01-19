---
title: Arbiter
layout: project
logo: /assets/images/arbiter.jpg
github: https://github.com/ashita-ai/arbiter
description: LLM evaluation with cost transparency. Know what your evals cost before the invoice arrives.
---

The only LLM evaluation framework that shows you exactly what your evaluations cost.

[Evals won't save you](/blog/your-evals-wont-save-you/) if you can't afford to run them. Most teams discover their evaluation costs after the invoice arrives. Arbiter tracks every LLM interaction automatically, so you know what you're spending as it happens.

## What it does

Arbiter provides comprehensive evaluation capabilities for large language model outputs:

- **Semantic similarity scoring** between outputs and references
- **Custom criteria evaluation** for domain-specific assessment
- **Pairwise comparison mode** for A/B testing different model responses
- **Built-in evaluators** for factuality, groundedness, and relevance
- **Batch processing** with progress tracking and concurrency control

## Cost transparency

Every evaluation shows you exactly what it costs. Real-time calculations using current pricing data. Expenses broken down by evaluator and model. No manual instrumentation required.

## The architecture

Built on PydanticAI with provider-agnostic support across OpenAI, Anthropic, Google, Groq, Mistral, and Cohere. Pure library—no platform signup or external servers. Results can persist to PostgreSQL or Redis.

## Status

Arbiter is available now. Install it with `pip install arbiter-ai`.
