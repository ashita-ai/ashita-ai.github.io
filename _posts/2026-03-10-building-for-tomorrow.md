---
layout: post
title: "Building for Tomorrow"
date: 2026-03-10
---

In 2019, Airbnb's data platform was considered state of the art. They had [invested heavily](https://medium.com/airbnb-engineering/data-quality-at-airbnb-870d03080469) in data quality tooling, built sophisticated feature stores, and published papers on their machine learning infrastructure. Since then, the ML paradigm has shifted multiple times: gradient-boosted trees gave way to neural networks, then to foundation models. The feature platform they built, [Chronon](https://www.infoq.com/news/2024/04/airbnb-chronon-open-sourced/), was open-sourced in 2024 and is still in active use. Stripe co-maintains it.

Their infrastructure survived because it was built on properties (data quality, consistency, lineage) rather than patterns (specific model types, specific frameworks). The paradigm shifted. The foundation did not.

Tomorrow is uncertain. The models will change. The regulatory landscape will shift. The organizational failures will persist in new forms. The question is not how to predict the future. The question is what to build that survives regardless.

## What dies

GPT-4 will likely be a footnote by 2030. LangChain and LlamaIndex will be replaced by whatever comes next. RAG pipelines may look as dated as MapReduce within five years. The models, frameworks, and architectures are furniture. They are supposed to be replaced.

The infrastructure that dies with them is the problem. MapReduce pipelines were state of the art in 2012. By 2018, cloud data warehouses had made most of them obsolete. The same coupling is happening now: vector databases tightly bound to current embedding models, agent frameworks coupled to today's LLM APIs, prompt engineering patterns optimized for how current models process text.

The question is what to build that does not die with the current paradigm. Not models, not frameworks, not architectures. Something more fundamental: infrastructure properties that were valuable before LLMs and will be valuable after whatever comes next.

## The two traps

Most organizations fail the same way, in one of two directions.

The first: they adopt the current best practices (fine-tuning, RAG, prompt engineering) and build infrastructure optimized for exactly those patterns. When the paradigm shifts, the infrastructure becomes a constraint. MapReduce pipelines were the right answer in 2012 for batch processing at scale. They were not the right answer in 2018 when real-time analytics became the expectation. The companies that had invested most heavily in Hadoop infrastructure were the last to move.

The second: they recognize that the landscape is changing too fast and do not commit to infrastructure at all. They use off-the-shelf tools, avoid architectural decisions, stay flexible. Flexibility without foundation is chaos. At scale, you cannot trace what went wrong, cannot answer a regulator who asks what your system told a customer on a specific date, cannot onboard a new model without rebuilding the data pipeline from scratch.

Both traps have the same outcome: when the paradigm shifts, you are starting over. The path between them is building infrastructure that embodies properties rather than implements patterns. Properties survive. Patterns become legacy.

## What survives

Airbnb did not build Chronon for LLMs. They built it to solve a specific problem: ensuring that the features used to train a model are the same features served in production. That requirement has not changed across three paradigm shifts. The data quality standards, feature consistency guarantees, and lineage tracking that make Chronon useful survived gradient-boosted trees, survived neural networks, and will survive whatever comes next. What did not survive were the model architectures trained on those features, which were replaced each time the paradigm shifted.

The same pattern holds across infrastructure cycles. Companies that built APIs against versioned, documented contracts could swap implementations underneath without breaking callers. Companies that exposed implementation details directly had to coordinate breaking changes with every consumer each time the internals changed. The implementation was replaced. The contract requirement was not.

What makes an infrastructure investment paradigm-independent — if anything does — is not its age. It is whether what it embodies holds regardless of which model architecture is reading the data, which framework is executing the workflow, or which vendor is providing the compute.

Four properties have held across every cycle examined here. Ground truth: data that means what it says, consistently, across every system that reads it. Provenance: decisions that can be traced to their source — what model, what data, what version. Contracts: interfaces that do not change arbitrarily, so callers do not need to change with them. Reversibility: the ability to undo and roll back when the world changes. These were requirements before LLMs and will be requirements after whatever replaces them. The next posts take each in turn.

## What I am still figuring out

Whether paradigm-independence is even possible. Maybe every infrastructure investment is a bet on a particular future, and the best you can do is bet wisely. Maybe the companies that seem paradigm-independent just got lucky: their bets happened to align with where the industry went.

Whether the current infrastructure boom is building structure or furniture. Hundreds of billions flowing into GPU clusters, vector databases, and agent frameworks. Some of it will last. Most of it is coupled to a paradigm that has a shelf life. The question is which is which, and whether you can tell the difference before the paradigm shifts.

---

Airbnb's ML paradigm shifted three times. Their data quality infrastructure survived all three, not because anyone predicted the shifts, but because quality standards, governance, and lineage tracking are not coupled to any particular model architecture. The models were furniture. The data discipline was structure.
