---
layout: post
title: "The Context Window Illusion"
date: 2026-02-15
---

In May 2024, Google rolled out AI Overviews to hundreds of millions of search users. Within days, the system was [telling people to add glue to pizza sauce](https://www.washingtonpost.com/technology/2024/05/24/google-ai-overviews-wrong/) (sourced from a decade-old Reddit joke) and to [eat rocks for minerals](https://searchengineland.com/google-ai-overview-fails-442575) (from a satirical Onion article republished on a geology company's website).

Google had the largest information corpus ever assembled. The model was not the problem. The system [could not tell a joke from a recipe](/blog/context-windows-are-not-free/).

## Context rot

Chroma's 2025 [Context Rot study](https://research.trychroma.com/context-rot) tested 18 production LLMs with realistic workloads and named the phenomenon: "context rot." As context length increases, retrieval accuracy drops, latency spikes, and costs balloon. Models do not use context uniformly. They barely process what sits in the middle.

Liu et al.'s [peer-reviewed TACL paper](https://direct.mit.edu/tacl/article/doi/10.1162/tacl_a_00638/119630) confirmed this is architectural, not model-specific: every transformer they tested showed the same U-shaped attention curve. Performance does not degrade gradually. It breaks suddenly.

Every model has a cliff, and that cliff comes well before the advertised maximum.

## The confidence trap

The worst failures are not the glue-on-pizza moments. Those are obvious. The dangerous failures are the ones that sound right.

When Melanie Mitchell, an AI researcher at the Santa Fe Institute, [asked Google](https://www.cnbc.com/2024/05/24/google-criticized-as-ai-overview-makes-errors-like-saying-president-obama-is-muslim.html) how many Muslim presidents the US has had, AI Overviews answered: one, Barack Hussein Obama. The system cited an academic chapter analyzing the conspiracy theory as evidence for it. "Google's AI system is not smart enough to figure out that this citation is not actually backing up the claim," Mitchell said. The system did not flag uncertainty. It presented a confident answer with a scholarly citation.

[Semantic entropy research from Nature (2024)](https://www.nature.com/articles/s41586-024-07421-0) explained why this is hard to catch: models express uncertainty by giving different answers to the same question, not by signaling low confidence. Users cannot detect this without specialized measurement.

This is why context window size is a trap. More information without better filtering does not produce better answers. It produces more confident wrong ones.

## What works

Do not use the context window as a database. Build a pipeline: embed, search, rerank, compress, query. Each stage filters. The model sees a few thousand highly relevant tokens instead of hundreds of thousands of mostly-irrelevant ones.

Chunk size matters more than most teams realize. Chroma's [chunking evaluation](https://research.trychroma.com/evaluating-chunking) found that retrieval with 200-400 token chunks achieved 88-90% recall. The optimal size varies by dataset and embedding model, but the direction is consistent: precision beats volume. [Hybrid search](/blog/the-rag-trap/) (combining dense vector embeddings with BM25 sparse retrieval) outperforms either approach alone, and reranking results before they reach the primary model filters further.

If your system needs 200K tokens to answer a question, your retrieval is broken. The correct answer almost always fits in under 16K tokens when the semantic work is done right. A [CLAUDE.md](/blog/the-intelligence-is-in-the-document/) is the extreme version of this principle: a few hundred tokens of precisely curated context outperforms dumping the entire repository into the window.

## Three failure modes

**Context dumping.**
Symptom: "We put all our docs in the prompt."
Cost: Quadratic API spend, degraded accuracy, high-confidence hallucinations.
Fix: Chunked retrieval with reranking. Do not let the model see irrelevant information.

**Blind scaling.**
Symptom: "We upgraded to the million-token tier."
Cost: Quadratic compute scaling, hitting context rot thresholds.
Fix: Compress context aggressively. Use the smallest window that works.

**No validation.**
Symptom: "The model seems confident, ship it."
Cost: Invisible failures from corrupted or contradictory context.
Fix: Semantic entropy checks, confidence calibration, citation verification.

## What I am still figuring out

The research is clear that more context degrades performance. What is less clear: when is long-form context actually necessary?

Legal contracts, medical records, and codebases have structure that does not compress well. You need continuity across sections. Does that justify 100K+ tokens, or is there a better chunking approach I have not seen?

Whether the degradation curve is fixed or moving. Some architectures maintain performance at longer contexts than others. If the ceiling keeps rising, the retrieval-versus-stuffing trade-off changes. But the ceiling has been rising for three years, and the research keeps showing the same U-shaped curve.

The long tail is also uncertain. Benchmarks measure average-case performance. Production systems fail on edge cases. How do you validate context strategies for the 1% of queries that break your assumptions?

---

Google indexed the entire internet and could not tell a satirical article from a nutrition guide. The context window was not the problem. What was in it was.

The model does not need everything you have. It needs the right things, retrieved precisely, filtered aggressively. Design for that window, not the one on the spec sheet.
