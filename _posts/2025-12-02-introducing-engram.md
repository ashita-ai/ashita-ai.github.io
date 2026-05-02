---
layout: post
title: "Building a Memory System That Does Not Lie to You"
date: 2025-12-02
category: "data-infrastructure"
---

I have been thinking about memory systems for AI applications. Not the kind that store everything forever, but the kind that actually work.

The problem is harder than it looks.

## The accuracy crisis

Recent benchmarks paint a grim picture. The [HaluMem study](https://arxiv.org/abs/2511.03506) tested leading memory systems and found answer accuracies below 56%. Hallucination rates were high. Omission rates (failing to recall information that was actually stored) exceeded 50%.

These are not edge cases. This is the baseline. If your memory system were a student, it would be failing the class and somehow also forgetting it enrolled.

Most systems follow a straightforward pattern: the user says something, the LLM extracts important facts, the facts go into a vector database. The extracted facts become the source of truth. The original conversation is summarized or discarded.

This compounds errors. Every extraction pass can introduce mistakes. Every summarization loses detail. After a few iterations, you are querying a game of telephone.

## Ground truth preservation

The fix is conceptually simple: do not throw away the original.

Store raw conversations verbatim, as immutable episodic memories. These are the ground truth. All derived knowledge (facts, preferences, semantic connections) traces back to specific episodes. If the system believes something incorrect, you can find where that belief came from and correct it.

This seems obvious in retrospect. It is how you would design any system where accuracy matters. But it is not how most AI memory systems work. They optimize for storage efficiency over correctness, which is a choice that compounds poorly over time.

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

Engram separates memory into regions with different decay rates and confidence properties: working (volatile, current conversation), episodic (immutable raw interactions), factual (deterministically extracted entities), semantic (LLM-inferred knowledge), procedural (behavioral patterns), and negation (what is explicitly NOT true). Most memory systems only store positive knowledge — they have no way to represent that a user does NOT use MongoDB, so they keep suggesting it. Negation as a first-class memory type solves that.

## Deferred processing

The expensive work happens in the background.

The critical path stores the episode and runs deterministic extraction (pattern matching for emails, dates, and so on) with no LLM calls. This keeps it fast and reliable.

Semantic inference runs as a background job. This has two benefits: it does not slow down the application, and errors can be caught before they propagate. A batch consolidation job compares new inferences against existing knowledge and flags contradictions.

## What comes next

The architecture is settled. The code is catching up.

The stack includes [Pydantic AI](https://ai.pydantic.dev/) for structured LLM interactions, [Qdrant](https://qdrant.tech/) for vector storage, and either [DBOS](https://www.dbos.dev/) or [Temporal](https://temporal.io/) for durable execution of background jobs.

I am building this because I need it. The AI applications I want to build require memory that works: memory that does not hallucinate, that can be verified, that degrades gracefully when something has to give.

If this problem interests you, [the repo is on GitHub](https://github.com/ashita-ai/engram). It is early, but the architecture docs explain the reasoning.

## What I am still figuring out

The optimal confidence thresholds for filtering queries. Too strict and the system is useless for exploratory questions. Too lenient and it returns inferences it should not trust. I do not have a principled way to set the boundary.

Whether negation memories are sufficient or whether the system needs an explicit "uncertain" state distinct from absence. A user who never mentioned MongoDB is different from a user who said "I don't use MongoDB." The first is silence; the second is a fact. Treating them the same loses information.

---

*This is the first in a series of posts about the tools I am building at Ashita AI.*
