---
layout: post
title: "Context Windows Are Not Free"
date: 2025-01-11
---

Gemini offers a 2 million token context window. Claude goes to 200K, with a 1M beta. GPT-4.1 handles 1M tokens.

The pitch is seductive: dump everything in and let the model figure it out. No retrieval pipeline to build. No chunking strategy to tune. Just concatenate your documents and ask your question.

This is expensive, slow, and often wrong.

## The bill adds up fast

Token pricing looks cheap until you multiply. A 100K context query generating a 2K response on Claude Sonnet costs $0.33. Run that 1,000 times a day and you're spending $10K/month on a single query type.

The compute cost is worse. Transformer attention is [quadratic](https://towardsdatascience.com/extending-context-length-in-large-language-models-74e59201b51f/). Double the context, quadruple the compute. Long context windows consume enormous GPU memory for the KV cache alone.

But money and latency are problems you can throw resources at. The accuracy problem is different.

## The spec sheet lies

When researchers [tested actual performance](https://arxiv.org/abs/2509.21361) against claimed context windows, they found models falling short by up to 99%. Some failed with as little as 100 tokens. Most showed severe degradation by 1,000. The number on the spec sheet is marketing, not engineering.

The failure pattern is predictable. [Stanford's "Lost in the Middle" paper](https://arxiv.org/abs/2307.03172) showed that models handle information at the beginning and end of context well, but the middle becomes a blind spot. In some tests, GPT-3.5 answered questions more accurately with no context at all than with the answer buried mid-document.

More context made the answers worse.

[Chroma's research](https://research.trychroma.com/context-rot) found something stranger: models perform worse when context has logical flow. Shuffling documents randomly actually improved retrieval. The structure we add to help models parse information makes them worse at finding it.

And [recent work](https://arxiv.org/abs/2510.05381) isolated the effect of length itself. Even when models perfectly retrieve all relevant information, even when the irrelevant tokens are just whitespace, performance degrades 13.9% to 85%. Length alone hurts. No distractions required.

## Real conversations are worse

These benchmarks test single-turn interactions. Real applications involve multi-turn conversations where context accumulates.

[Microsoft and Salesforce researchers](https://arxiv.org/abs/2505.06120) measured a 39% average performance drop in multi-turn underspecified conversations. OpenAI's o3, their most capable reasoning model, dropped from 98.1 to 64.1 as conversation history grew.

Sebastian Lund [describes](https://fastpaca.com/blog/failure-case-memory-layout/) how this plays out:

- **Poisoning**: an early error compounds through every subsequent response
- **Distraction**: past 100K tokens, models start repeating themselves and drifting
- **Confusion**: contradictory information causes the model to oscillate between answers
- **Clash**: system prompts fight with user-provided context.

The dangerous failure mode is what Lund calls "silent false negatives." The model confidently omits crucial information without signaling uncertainty. An auditing agent loses version numbers during summarization, then asserts a system is secure without realizing it forgot to check the logs. False confidence is worse than honest uncertainty.

## When to actually use long context

Long context is not useless. It wins when a task genuinely requires holding multiple sources in mind simultaneously: analyzing an entire codebase for architectural patterns, synthesizing a legal document, comparing research papers.

For synthesis tasks, [long context outperforms RAG](https://arxiv.org/abs/2501.01880) 56.3% to 49%. The model sees relationships that chunked retrieval would miss.

But for most retrieval tasks (finding specific facts, answering questions from documents) RAG matches or beats long context while costing 10-100x less. The question is whether you need synthesis or retrieval.

## Design for loss

The alternative to stuffing everything into context is deciding what matters.

Lund [recommends](https://fastpaca.com/blog/failure-case-memory-layout/) categorizing information by the consequences of losing it. Some context is sacred (version numbers, security constraints) and must never be dropped. Some is critical and cannot be compressed without losing meaning. Some is expendable and can be reconstructed if needed.

Most systems treat all tokens equally, evicting whatever is oldest. This guarantees that something important will eventually be lost. [Designing explicit eviction policies](/blog/introducing-engram/) based on what information matters is harder but more honest about the tradeoffs.

The question is not how much you can fit. It's what happens when something has to go.

Because two million tokens is not two million opportunities to be right. It's two million opportunities to get lost.
