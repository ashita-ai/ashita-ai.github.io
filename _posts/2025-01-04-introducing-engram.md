---
layout: post
title: "Building a Memory System That Doesn't Lie to You"
date: 2025-01-04
---

I have been thinking about memory systems for AI applications. Not the kind that store everything forever, but the kind that actually work.

The problem is harder than it looks.

## The accuracy crisis

Recent benchmarks paint a grim picture. The [HaluMem study](https://arxiv.org/abs/2511.03506) tested leading memory systems and found answer accuracies below 56%. Hallucination rates were high. Omission rates (failing to recall information that was actually stored) exceeded 50%.

These are not edge cases. This is the baseline. If your memory system were a student, it would be failing the class and somehow also forgetting it enrolled.

Most systems follow a straightforward pattern: the user says something, the LLM extracts important facts, the facts go into a vector database. Rinse. Repeat. The extracted facts become the source of truth. The original conversation is summarized or discarded.

This compounds errors. Every extraction pass can introduce mistakes. Every summarization loses detail. After a few iterations, you are querying a game of telephone.

## Ground truth preservation

The fix is conceptually simple: do not throw away the original.

Store raw conversations verbatim, as immutable episodic memories. These are the ground truth. All derived knowledge (facts, preferences, semantic connections) traces back to specific episodes. If the system believes something incorrect, you can find where that belief came from and correct it.

This seems obvious in retrospect. It's how you would design any system where accuracy matters. But it is not how most AI memory systems work. They optimize for storage efficiency over correctness, which is a choice that compounds poorly over time.

## Confidence as a first-class concept

Not all memories are equally reliable.

A direct quote from a user is more trustworthy than an LLM's interpretation of that quote. A pattern-matched email address is more trustworthy than an inferred preference. Track this explicitly:

| Source | Confidence | Method |
|--------|------------|--------|
| Verbatim | Highest | Direct storage, immutable |
| Extracted | High | Pattern matching, deterministic |
| Inferred | Variable | LLM-derived |

Applications can then filter by confidence. A high-stakes query uses only verified facts. An exploratory query includes inferences. The system exposes uncertainty rather than hiding it behind a friendly interface that says it remembers everything perfectly.

## Memory as layout, not storage

Sebastian Lund [makes a compelling argument](https://fastpaca.com/blog/failure-case-memory-layout/) that context management is a design problem, not a capacity problem. The question is not how much can you store but what happens when something has to go.

Different types of information have different failure modes. Losing a user's stated preference is annoying. Losing the context that prevents a dangerous recommendation is catastrophic. A flat buffer where everything competes equally cannot express these distinctions.

This leads to a layout with distinct regions:

**Working** memory holds the current conversation context, volatile and in-memory only, serving as the entry point for everything else.

**Episodic** memories are the immutable ground truth: raw interactions stored verbatim with fast decay, serving as the source for all derived knowledge.

**Factual** memories are pattern-extracted facts like emails, phone numbers, dates, and names, with high confidence because extraction is deterministic and slow decay.

**Semantic** memories are LLM-inferred knowledge (preferences, context, relationships between concepts) with variable confidence and slow decay.

**Procedural** memories capture behavioral patterns, such as when a user prefers concise responses, detected through repetition with very slow decay.

**Negation** memories represent what is explicitly NOT true. When a user corrects a misunderstanding, that negation gets stored to prevent false matches

This is an engineering construct. Most memory systems only store positive knowledge. They have no way to represent that the user does NOT use MongoDB. So they keep suggesting it. Negation facts solve this practical problem.

The neuroscience here is instructive. Memories strengthen through repeated retrieval (the [testing effect](https://pmc.ncbi.nlm.nih.gov/articles/PMC5912918/)) so Engram tracks `consolidation_strength` that increases when memories are linked, refined, or undergo consolidation. [Retrieval-induced forgetting](https://pubmed.ncbi.nlm.nih.gov/7931095/) shows that retrieving some memories actively suppresses related non-retrieved items; Engram implements this via opt-in RIF to naturally prune redundant memories.

The linking between memories is inspired by [A-MEM research](https://arxiv.org/abs/2502.12110) showing significant improvement on multi-hop reasoning benchmarks. And the buffer promotion system draws from [Cognitive Workspace](https://arxiv.org/abs/2508.13171) research demonstrating 58.6% memory reuse compared to 0% for naive RAG approaches.

## Deferred processing

The expensive work happens in the background.

The critical path stores the episode and runs deterministic extraction (pattern matching for emails, dates, and so on) with no LLM calls. This keeps it fast and reliable.

Semantic inference runs as a background job. This has two benefits: it does not slow down the application, and errors can be caught before they propagate. A batch consolidation job compares new inferences against existing knowledge and flags contradictions.

This mirrors how biological memory consolidation works. Encoding is fast; consolidation is slow and happens offline. In the biological case, this happens during sleep. In the engineering case, this happens in a job queue. The [research on systems consolidation](https://pubmed.ncbi.nlm.nih.gov/7624455/) is extensive and the analogy is more useful than it might first appear.

## What comes next

The architecture is settled. The code is catching up.

The stack includes [Pydantic AI](https://ai.pydantic.dev/) for structured LLM interactions, [Qdrant](https://qdrant.tech/) for vector storage, and either [DBOS](https://www.dbos.dev/) or [Temporal](https://temporal.io/) for durable execution of background jobs.

I am building this because I need it. The AI applications I want to build require memory that works: memory that does not hallucinate, that can be verified, that degrades gracefully when something has to give.

If this problem interests you, [the repo is on GitHub](https://github.com/ashita-ai/engram). It is early, but the architecture docs explain the reasoning. I will be writing more as the implementation progresses.

---

*This is the first in a series of posts about the tools I am building at Ashita AI. Next: Tessera, data contract coordination for warehouses.*
