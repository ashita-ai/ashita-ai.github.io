---
layout: post
title: "The Context Window Illusion"
date: 2026-02-15
---

[Context windows are not free.](/blog/context-windows-are-not-free/) The cost is quadratic. The accuracy degrades in the middle. Multi-turn conversations compound the problem. That post covered why bigger context windows make things worse.

This post is about what to do instead.

## Context Rot

Chroma's 2025 [Context Rot study](https://research.trychroma.com/context-rot) tested 18 production LLMs with realistic workloads and named the phenomenon: "context rot." As context length increases, retrieval accuracy drops, latency spikes, and costs balloon. Models do not use context uniformly. They barely process what sits in the middle.

The degradation threshold varies by model. Claude maintains coherence longer than most. Gemini 2.5 Pro appears to maintain performance further into its context window than competitors in benchmarks. But every model has a cliff, and that cliff comes well before the advertised maximum.

Liu et al.'s [peer-reviewed TACL paper](https://direct.mit.edu/tacl/article/doi/10.1162/tacl_a_00638/119630) confirmed this is architectural, not model-specific: every transformer they tested showed the same U-shaped attention curve. Performance does not degrade gradually. It breaks suddenly.

## The Confidence Trap

The worst failures are invisible. When a model hallucinates from insufficient context, the failure is obvious. When a model produces plausible-sounding answers from malformed context, you ship bugs to production.

Models can produce plausible-sounding wrong answers that are difficult to detect. [Semantic entropy research from Nature (2024)](https://www.nature.com/articles/s41586-024-07421-0) showed that models express uncertainty through semantic variation—giving different answers to the same question—but users cannot detect this without specialized measurement. The system does not know it failed. Neither do you, until a customer complains.

This is why context window size is a trap. Systems succeed with partial context, wrong context, or no context—and produce confident garbage. "Information flooding" does not just waste money. It actively degrades quality.

Chunking strategy alone can produce dramatic performance variance. The optimal chunk size across models: 400-512 tokens. Not 4,000. Not 40,000. Four hundred.

More context hurts.

## What Actually Works

The pattern that works: do not use the context window as a database.

First, chunk intelligently. Semantic chunking (splitting on topic boundaries) outperforms fixed-size chunking by 23% in retrieval benchmarks. Aim for 400-512 token chunks. Overlap by 10-15% to preserve context across boundaries.

Second, retrieve precisely. Use embeddings for semantic search, not keyword matching. [Hybrid search](/blog/the-rag-trap/) (combining dense vectors with BM25 sparse retrieval) outperforms either approach alone. Rerank results with a smaller model before sending to your primary LLM.

Third, compress context. Send summaries instead of raw documents. Use chain-of-thought to make the model process incrementally rather than all-at-once. Research on prompt compression shows significant context reduction is possible without proportional accuracy loss.

Fourth, architect for small contexts. If your system needs 200K tokens to answer a question, your retrieval is broken. The correct answer almost always fits in 8-16K tokens if the semantic work is done correctly. A [CLAUDE.md that encodes project-specific lessons](/blog/the-intelligence-is-in-the-document/) is a concrete example: a few hundred tokens of precisely curated context outperforms dumping the entire repo into the window.

Build a pipeline: embed → search → rerank → compress → query. Each stage filters. The LLM sees 5-10K highly relevant tokens instead of 200K mostly-irrelevant ones.

## Three Failure Modes

**Failure Mode 1: Context Dumping**
Symptom: "We put all our docs in the prompt."
Cost: 4x API spend, degraded accuracy, high-confidence hallucinations.
Fix: Semantic chunking + vector search. Do not let the model see irrelevant information.

**Failure Mode 2: Blind Scaling**
Symptom: "We upgraded to the million-token tier."
Cost: Quadratic compute scaling, hitting context rot thresholds.
Fix: Compress context aggressively. Use the smallest window that works.

**Failure Mode 3: No Validation**
Symptom: "The model seems confident, ship it."
Cost: Invisible failures from corrupted/contradictory context.
Fix: Semantic entropy checks, confidence calibration, citation verification.

## What I am still figuring out

The research is clear that more context degrades performance. What is less clear: when is long-form context actually necessary?

Legal contracts, medical records, and codebases have structure that does not compress well. You need continuity across sections. Does that justify 100K+ tokens, or is there a better chunking approach I have not seen?

Gemini 2.5 Pro's performance at 192K tokens suggests the degradation is not fundamental—it is architectural. Will sparse attention, sliding windows, or hierarchical transformers solve this? Or is the solution always "use less context"?

The long tail is also uncertain. Benchmarks measure average-case performance. Production systems fail on edge cases. How do you validate context strategies for the 1% of queries that break your assumptions?

---

Million-token windows are a marketing number. The effective window—where the model actually uses what you give it—is much smaller. Design for that.
