---
layout: post
title: "Building for Tomorrow"
date: 2026-03-03
---

In 2019, Airbnb's data platform team was considered state of the art. They had [invested heavily](https://medium.com/airbnb-engineering/data-quality-at-airbnb-870d03080469) in data quality tooling, built sophisticated feature stores, and published papers on their machine learning infrastructure. By 2023, the entire paradigm had shifted. The models they built infrastructure for—gradient boosted trees, logistic regression, carefully engineered features—were being replaced by foundation models that did not need any of it.

Their infrastructure was not wrong. It was right for its time. But its time passed.

Tomorrow is uncertain. The models will change. The regulatory landscape will shift. The organizational failures will persist in new forms. How do you build for a future you cannot predict?

This is the central paradox of infrastructure: it must be stable enough to rely on and flexible enough to evolve. The companies that built for yesterday's AI (rule-based systems, narrow ML) are now stuck. The companies building for today's AI (prompt engineering, RAG pipelines) will be stuck in three years.

What does it mean to build for tomorrow when tomorrow keeps moving?

## What dies

GPT-4 will be a footnote by 2030. LangChain and LlamaIndex will be replaced by whatever comes next. RAG pipelines may look as dated as MapReduce within five years. The models, frameworks, and architectures are furniture. They are supposed to be replaced.

The infrastructure that dies with them is the problem. Airbnb's feature stores were coupled to a specific ML paradigm. When that paradigm shifted, the infrastructure became a constraint rather than a foundation. The same coupling is happening right now: vector databases tightly bound to current embedding models, agent frameworks coupled to today's LLM APIs, prompt engineering patterns optimized for how current models process text.

The question is what to build that does not die with the current paradigm. Not models, not frameworks, not architectures. Something more fundamental: infrastructure properties that were valuable before LLMs and will be valuable after whatever comes next.

## The two traps

Most organizations fall into one of two traps.

**Trap one: Building for today.** They adopt the current best practices—fine-tuning, RAG, prompt engineering—and build infrastructure optimized for exactly those patterns. When the paradigm shifts, the infrastructure becomes a constraint. The feature stores that Airbnb built were perfectly designed for the ML workflows of 2019. They were not designed for the LLM workflows of 2024.

**Trap two: Building for never.** They recognize that the landscape is changing too fast, so they do not build infrastructure at all. They use off-the-shelf tools, avoid commitments, stay flexible. But flexibility without foundation is chaos. They cannot deploy AI at scale because they have no [governance infrastructure](/blog/the-metadata-control-plane/), no data quality guarantees, no way to trace what went wrong.

The path between these traps is building infrastructure that embodies properties rather than implements patterns. Fine-tuning pipelines and vector databases are patterns, coupled to a specific moment. The infrastructure that survived previous paradigm shifts had structural properties that were independent of any particular technology. Properties survive. Patterns become legacy.

## The questions ahead

The next question is harder than documenting what is broken: what survives?

I do not have complete answers. But I have four areas worth exploring:

**The uncertainty stack.** What infrastructure properties are truly paradigm-independent? What can we learn from infrastructure that survived previous technology transitions, from the [protocol wars](https://en.wikipedia.org/wiki/Protocol_Wars) to the Hadoop boom and bust? What makes systems future-proof rather than future-fragile?

**The institutional memory problem.** Organizations forget. The engineer who understood the system leaves. The documentation rots. AI accelerates this—[comprehension debt](/blog/the-three-debts/) compounds, codebases hollow out. What does institutional memory look like when both humans and machines are unreliable narrators? How do you preserve understanding across time?

**The governance precondition.** Governance is not overhead—it is a precondition for AI that works at scale. The companies that invested in "boring" infrastructure—data lineage, access controls, audit trails—have asymmetric advantage. But what is the minimum viable governance at different stages? How do you build governance that enables rather than constrains?

**The human-AI boundary.** Where does automation stop and judgment begin? The failures of full autonomy and the failures of no autonomy are both well documented. The answer is somewhere in between. What decisions require humans? How do you preserve human understanding as AI handles more? What interface patterns actually work?

## What I am still figuring out

Whether paradigm-independence is even possible. Maybe every infrastructure investment is a bet on a particular future, and the best you can do is bet wisely. Maybe the companies that seem paradigm-independent just got lucky: their bets happened to align with where the industry went.

Whether the current infrastructure boom is building structure or furniture. Hundreds of billions flowing into GPU clusters, vector databases, and agent frameworks. Some of it will last. Most of it is coupled to a paradigm that has a shelf life. The question is which is which, and whether you can tell the difference before the paradigm shifts.

---

Airbnb's feature stores were perfectly designed for gradient-boosted trees. They were furniture. But the data quality standards that powered them, the governance infrastructure underneath—those transfer to any paradigm. The furniture had to be replaced. The discipline underneath it did not.

The question is not whether your infrastructure will become obsolete. It will. The question is whether anything survives when it does.
