---
title: Engram
layout: project
logo: /assets/images/engram.jpg
github: https://github.com/ashita-ai/engram
description: AI memory that preserves ground truth. Because most memory systems hallucinate more than the models they serve.
---

Memory is strange.

AI memory systems have an accuracy crisis. Recent benchmarks show answer accuracies below 56%, with hallucination and omission rates remaining high. Most systems use LLM extraction on every message, compounding errors until the original truth is lost. [RAG is not the answer](/blog/the-rag-trap/) when your memory layer is the problem.

Engram takes a different approach: memory you can trust.

## What it does

Engram is a memory system for AI applications that preserves ground truth and tracks confidence:

- **Store first, derive later** — Raw conversations stored verbatim. LLM extraction happens in background where errors can be caught.
- **Track confidence** — Every fact carries provenance: `verbatim` (highest), `extracted` (high), `inferred` (variable).
- **Verify on retrieval** — Applications filter by confidence. High-stakes queries use only trusted facts.
- **Enable recovery** — Derived facts trace to sources. Errors can be corrected by re-deriving.

## Memory types

Six memory types, each with different confidence and decay characteristics:

- **Working** — Current conversation context, volatile and in-memory
- **Episodic** — Immutable ground truth, verbatim storage
- **Factual** — Pattern-extracted facts (emails, dates, names)
- **Semantic** — LLM-inferred knowledge with variable confidence
- **Procedural** — Behavioral patterns and preferences
- **Negation** — What is explicitly NOT true

## The philosophy

Ground truth is sacred. Every derived memory points back to source episodes. If extraction makes a mistake, re-derive from the original. Forgetting is a feature—memories decay over time, keeping the store relevant.

## Status

Engram is in pre-alpha. Built on Pydantic AI with durable execution (DBOS/Temporal) and Qdrant for vector storage.
