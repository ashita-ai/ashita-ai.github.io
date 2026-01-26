---
layout: post
title: "The RAG Trap"
date: 2025-01-17
---

[72% of enterprise RAG implementations](https://ragaboutit.com/why-72-of-enterprise-rag-implementations-fail-in-the-first-year-and-how-to-avoid-the-same-fate/) fail in the first year. A Stanford study found that legal RAG tools from LexisNexis and Thomson Reuters [hallucinate 17-33% of the time](https://dho.stanford.edu/wp-content/uploads/Legal_RAG_Hallucinations.pdf), despite vendor claims that RAG "eliminates" hallucination.

RAG powers an estimated 60% of production AI applications. The gap between promise and reality is enormous.

## The misdiagnosis

When RAG fails, teams debug the wrong layer. They tweak prompts, swap embedding models, adjust temperature. The LLM gets blamed.

But most RAG failures are not LLM failures. A [research paper](https://arxiv.org/html/2401.05856v1) identified seven failure points in RAG systems:

1. **Missing content** - the answer does not exist in your documents
2. **Missed in retrieval** - the answer exists but was not in the top-K results
3. **Not in context** - retrieved but dropped due to token limits
4. **Not extracted** - in context but the LLM failed to identify it
5. **Wrong format** - LLM ignores formatting instructions
6. **Incorrect specificity** - response too vague or too detailed
7. **Incomplete** - response misses available information

The first three are retrieval problems. The rest are generation problems. But even the generation failures often trace back to noisy or insufficient context.

As IBM's Dinesh Nirmal [put it](https://www.ibm.com/think/insights/rag-problems-five-ways-to-fix): "Pure RAG is not really giving the optimal results that were expected." The real challenges are ingestion, retrieval optimization, metadata management, and data quality. [If your vector store is bloated with junk](https://www.cloudfactory.com/blog/rag-is-breaking), your retrieval will reflect that.

## The paradox

Here is what makes RAG counterintuitive: adding retrieval context can make hallucination worse.

Google researchers [found](https://research.google/blog/deeper-insights-into-retrieval-augmented-generation-the-role-of-sufficient-context/) that RAG increases model confidence while reducing its ability to abstain. When context is insufficient, the model should say "I don't know." Instead, it hallucinates more confidently.

The study showed models correctly answered questions 35-62% of the time even when the retrieved context was insufficient to answer them. They were not using the context. They were guessing with more confidence.

Larger models excel when context is sufficient. But when context is insufficient, they fail to abstain. Smaller models hallucinate even with sufficient context. RAG does not fix this. It masks it.

## What actually breaks

**Chunking.** You split a document into pieces. The split lands in the middle of a table. Now you retrieve half a table. Fixed-size chunking fragments narrative. Small chunks lose context. Large chunks introduce noise. There is no universal best strategy, and most teams never revisit their initial choice.

**Lost in the middle.** LLMs have U-shaped attention. They process information at the beginning and end of context well. Information in the middle [degrades performance by 30% or more](https://www.getmaxim.ai/articles/solving-the-lost-in-the-middle-problem-advanced-rag-techniques-for-long-context-llms/). Even million-token context windows do not solve this.

**Semantic mismatch.** Top-K similarity search returns chunks that are thematically similar but semantically irrelevant. The embedding captures topic proximity, not answer relevance. You retrieve paragraphs that share keywords but do not actually answer the question.

## What actually works

**Hybrid search.** Combining BM25 keyword search with vector embeddings [outperforms either alone](https://superlinked.com/vectorhub/articles/optimizing-rag-with-hybrid-search-reranking). IBM research found three-way retrieval (BM25 + dense vectors + sparse vectors) is optimal. Pure vector search misses exact keyword matches. Pure keyword search misses semantic relationships. Hybrid gets both.

**Reranking.** This is the highest-leverage fix most teams skip.

Standard embedding models (bi-encoders) compress each document into a single vector before you know the query. It is like summarizing a book into one sentence. Fast, but you lose information.

Cross-encoder rerankers work differently. They look at the query and document together at query time. It is like actually reading the relevant pages with the question in mind. [Slower, but significantly more accurate](https://www.pinecone.io/learn/series/rag/rerankers/).

The two-stage approach: use fast embeddings to retrieve the top 100 candidates, then use a cross-encoder to pick the best 5-10. You get speed and precision.

**Data curation.** This is the unsexy answer no one wants to hear. [Simple RAG baselines often match complex pipelines](https://arxiv.org/abs/2506.03989) when the underlying data is clean. Teams over-engineer retrieval while ignoring data quality. Multiple document versions. Missing metadata. Uncurated PDFs. Outdated content mixed with current.

The retrieval layer cannot fix what the data layer broke.

## The real question

RAG has become the default. Team builds chatbot, team adds RAG. But RAG is not a solution. It is a tradeoff: you exchange the cost of fine-tuning or long context for the cost of maintaining a retrieval pipeline.

That pipeline has all the problems of any data pipeline. [Schema drift](/blog/introducing-tessera/). Ownership gaps. Quality degradation over time. The retrieval layer cannot fix what the data layer broke.

Most RAG failures are not retrieval failures. They are data failures wearing a retrieval costume.

---

Before you add another embedding model, another reranker, another retrieval strategy: is the answer even in your documents?
