---
layout: post
title: "The RAG Trap"
date: 2026-01-17
---

In February 2024, Jake Moffatt's grandmother died. He went to Air Canada's website to book a flight for the funeral. The airline's chatbot told him he could book a full-fare ticket now and apply for the bereavement discount retroactively within 90 days.

He booked the flight. He applied for the discount. Air Canada refused. Their bereavement policy did not allow retroactive applications.

Moffatt took it to British Columbia's Civil Resolution Tribunal. Air Canada [argued](https://www.mccarthy.ca/en/insights/blogs/techlex/moffatt-v-air-canada-misrepresentation-ai-chatbot) the chatbot was "a separate legal entity that is responsible for its own actions." The tribunal [rejected this](https://www.americanbar.org/groups/business_law/resources/business-law-today/2024-february/bc-tribunal-confirms-companies-remain-liable-information-provided-ai-chatbot/) and awarded Moffatt $812.

The chatbot had access to Air Canada's policy documents. It either retrieved the wrong version, misinterpreted what it retrieved, or was never properly grounded in the real policies. Each of these is a retrieval-augmented generation failure.

## The misdiagnosis

When RAG fails, teams debug the wrong layer. They tweak prompts, swap embedding models, adjust temperature. The LLM gets blamed.

Most RAG failures are not LLM failures. A [research paper](https://arxiv.org/html/2401.05856v1) identified seven distinct failure points in RAG systems. Three are retrieval problems: the answer does not exist in your documents, it exists but was not in the top-K results, or it was retrieved but dropped due to token limits. Four are generation problems: the LLM fails to extract the answer, formats it incorrectly, gives too much or too little detail, or misses available information. Even the generation failures often trace back to noisy or insufficient context.

As IBM's Dinesh Nirmal [put it](https://www.ibm.com/think/insights/rag-problems-five-ways-to-fix): "Pure RAG is not really giving the optimal results that were expected." The challenges are ingestion, retrieval optimization, metadata management, and data quality. If your [vector store is bloated with junk](https://www.cloudfactory.com/blog/rag-is-breaking), your retrieval will reflect that.

## The paradox

Here is what makes RAG counterintuitive: adding retrieval context can make hallucination worse.

Google researchers [found](https://research.google/blog/deeper-insights-into-retrieval-augmented-generation-the-role-of-sufficient-context/) that RAG increases model confidence while reducing its ability to abstain. When context is insufficient, the model should say "I don't know." Instead, it hallucinates more confidently. In their evaluation, Gemma's incorrect answer rate jumped from 10.2% with no context to 66.1% when given insufficient context.

Larger models excel when context is sufficient. But when context is insufficient, they fail to abstain. Smaller models hallucinate even with sufficient context. RAG does not fix this. It masks it.

## What breaks

RAG systems fail at specific, predictable points.

Chunking is the most common. You split a document into pieces. The split lands in the middle of a table, a contract clause, a clinical note. You retrieve half a table. Fixed-size chunking fragments narrative. Small chunks lose context. Large chunks introduce noise. There is no universal best strategy, and most teams never revisit their initial choice.

Even with good chunks, semantic mismatch degrades results. Top-K similarity search returns chunks that are thematically similar but semantically irrelevant. The embedding captures topic proximity, not answer relevance. You retrieve paragraphs that share keywords but do not actually answer the question.

And regardless of retrieval quality, LLMs have U-shaped attention. They process information at the beginning and end of context well. Information in the middle [degrades performance by 30% or more](https://www.getmaxim.ai/articles/solving-the-lost-in-the-middle-problem-advanced-rag-techniques-for-long-context-llms/). [Even million-token context windows](/blog/context-windows-are-not-free/) do not solve this.

## What works

Hybrid search (combining BM25 keyword retrieval with dense vector embeddings) [outperforms either approach alone](https://superlinked.com/vectorhub/articles/optimizing-rag-with-hybrid-search-reranking). IBM research found three-way retrieval (BM25 + dense vectors + sparse vectors) is optimal. Pure vector search misses exact keyword matches. Pure keyword search misses semantic relationships. Combining them catches both.

Reranking is the highest-leverage fix most teams skip. Standard embedding models compress each document into a single vector before you know the query: summarizing a book into one sentence. Cross-encoder rerankers evaluate the query and document together at query time, [reading the relevant pages with the question in mind](https://www.pinecone.io/learn/series/rag/rerankers/). The two-stage approach (fast embeddings to retrieve the top 100, then cross-encoder to pick the best 5-10) gets speed and precision.

But the unglamorous answer is data curation. [Simple RAG baselines often match complex pipelines](https://arxiv.org/abs/2506.03989) when the underlying data is clean. Teams over-engineer retrieval while ignoring data quality: multiple document versions, missing metadata, uncurated PDFs, outdated content mixed with current. The retrieval layer cannot fix what the data layer broke.

## The real question

Stanford researchers [tested](https://dho.stanford.edu/wp-content/uploads/Legal_RAG_Hallucinations.pdf) RAG-powered legal research tools from LexisNexis and Thomson Reuters, products built specifically to ground responses in real case law. They [hallucinated 17-33% of the time](https://law.stanford.edu/publications/hallucination-free-assessing-the-reliability-of-leading-ai-legal-research-tools/). These are not toy demos. These are products from the two largest legal research companies, with access to their own proprietary document collections. RAG did not eliminate hallucination. It redistributed it.

Gartner [predicts](https://www.gartner.com/en/newsroom/press-releases/2025-02-26-lack-of-ai-ready-data-puts-ai-projects-at-risk) that organizations will abandon 60% of AI projects unsupported by AI-ready data through 2026. RAG is not a solution. It is a tradeoff: you exchange the cost of fine-tuning or long context for the cost of maintaining a retrieval pipeline. That pipeline has all the problems of any data pipeline: [schema drift](/blog/introducing-tessera/), ownership gaps, quality degradation over time. Most RAG failures are not retrieval failures. They are data failures wearing a retrieval costume.

## What I am still figuring out

Whether the failure rate is a RAG problem or a data quality problem. If most failures trace back to ingestion rather than retrieval, the entire framing of "RAG improvement" is misdirected. The research points this way, but the industry keeps investing in better retrieval rather than better data curation. I do not know if this is because retrieval is easier to improve or because teams genuinely believe retrieval is the bottleneck.

The Stanford legal tools are particularly telling. These vendors have the data. They control the corpus. They still hallucinate 17-33% of the time. If RAG fails even when the data is good and the vendor controls the pipeline, the problem may be deeper than data quality alone.

---

Air Canada's chatbot told a grieving customer he could get a bereavement fare retroactively. He could not. The airline tried to disown its own chatbot. The tribunal said no.

Before you add another embedding model, another reranker, another retrieval strategy: is the correct, current answer even in your documents? And if it is, does your system know how to find it?
