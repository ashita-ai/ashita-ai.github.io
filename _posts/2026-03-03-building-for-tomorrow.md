---
layout: post
title: "Building for Tomorrow"
date: 2026-03-03
---

In 2019, Airbnb's data platform was considered state of the art. They had [invested heavily](https://medium.com/airbnb-engineering/data-quality-at-airbnb-870d03080469) in data quality tooling, built sophisticated feature stores, and published papers on their machine learning infrastructure. Since then, the ML paradigm has shifted multiple times: gradient-boosted trees gave way to neural networks, then to foundation models. The feature platform they built, [Chronon](https://www.infoq.com/news/2024/04/airbnb-chronon-open-sourced/), was open-sourced in 2024 and is still in active use. Stripe co-maintains it.

Their infrastructure survived because it was built on properties (data quality, consistency, lineage) rather than patterns (specific model types, specific frameworks). The paradigm shifted. The foundation did not.

Tomorrow is uncertain. The models will change. The regulatory landscape will shift. The organizational failures will persist in new forms. The question is not how to predict the future. The question is what to build that survives regardless.

## What dies

GPT-4 will be a footnote by 2030. LangChain and LlamaIndex will be replaced by whatever comes next. RAG pipelines may look as dated as MapReduce within five years. The models, frameworks, and architectures are furniture. They are supposed to be replaced.

The infrastructure that dies with them is the problem. MapReduce pipelines were state of the art in 2012. By 2018, cloud data warehouses had made most of them obsolete. The same coupling is happening now: vector databases tightly bound to current embedding models, agent frameworks coupled to today's LLM APIs, prompt engineering patterns optimized for how current models process text.

The question is what to build that does not die with the current paradigm. Not models, not frameworks, not architectures. Something more fundamental: infrastructure properties that were valuable before LLMs and will be valuable after whatever comes next.

## The two traps

Most organizations fall into one of two traps.

**Trap one: Building for today.** They adopt the current best practices (fine-tuning, RAG, prompt engineering) and build infrastructure optimized for exactly those patterns. When the paradigm shifts, the infrastructure becomes a constraint. MapReduce pipelines were perfectly designed for the batch processing workflows of 2012. They were not designed for the real-time analytics of 2018.

**Trap two: Building for never.** They recognize that the landscape is changing too fast, so they do not build infrastructure at all. They use off-the-shelf tools, avoid commitments, stay flexible. But flexibility without foundation is chaos. They cannot deploy AI at scale because they have no [governance infrastructure](/blog/the-metadata-control-plane/), no data quality guarantees, no way to trace what went wrong.

The path between these traps is building infrastructure that embodies properties rather than implements patterns. Fine-tuning pipelines and vector databases are patterns, coupled to a specific moment. The infrastructure that survived previous paradigm shifts had structural properties that were independent of any particular technology. Properties survive. Patterns become legacy.

## What survives

Four infrastructure properties have survived every previous paradigm shift. They will survive the next one.

**Data quality standards.** Airbnb's data quality tooling survived the transition from gradient-boosted trees to neural networks to LLMs because data quality is paradigm-independent. Models change. The requirement that your data be accurate, timely, and well-documented does not. [Data contracts](/blog/the-data-platform-decisions-that-haunt-you/) that define schema, ownership, and quality expectations transfer to any model architecture.

**Governance infrastructure.** The [metadata layer](/blog/the-metadata-control-plane/) (audit logs, lineage tracking, classification tags, access controls) is required by regulators and by production reality regardless of what models you run. Two Sigma's $90 million penalty was for governance failures in algorithmic trading. The same infrastructure would have prevented failures in LLM deployments. Governance becomes a [competitive moat](/blog/the-compliance-moat/) precisely because it is paradigm-independent.

**Institutional memory.** Organizations that document their decisions, maintain understanding of their systems, and invest in knowledge transfer survive paradigm shifts. Organizations that accumulate [comprehension debt](/blog/the-three-debts/) (code nobody understands) and [decision debt](/blog/the-three-debts/) (choices made for the wrong reasons) do not. The tools for preserving institutional memory will change. The requirement will not.

**Human judgment boundaries.** Every paradigm shift produces a wave of automation enthusiasm followed by a correction. The pattern with [agentic AI](/blog/against-agentic-everything/) is the same: narrow, supervised deployments work; broad, autonomous deployments fail. The boundary between human and machine will move. The need to define that boundary deliberately will not.

## What I am still figuring out

Whether paradigm-independence is even possible. Maybe every infrastructure investment is a bet on a particular future, and the best you can do is bet wisely. Maybe the companies that seem paradigm-independent just got lucky: their bets happened to align with where the industry went.

Whether the current infrastructure boom is building structure or furniture. Hundreds of billions flowing into GPU clusters, vector databases, and agent frameworks. Some of it will last. Most of it is coupled to a paradigm that has a shelf life. The question is which is which, and whether you can tell the difference before the paradigm shifts.

---

Airbnb's ML paradigm shifted three times. Their data quality infrastructure survived all three, not because anyone predicted the shifts, but because quality standards, governance, and lineage tracking are not coupled to any particular model architecture. The models were furniture. The data discipline was structure.

The question is not whether your infrastructure will become obsolete. Parts of it will. The question is whether you built anything underneath that survives when it does.
