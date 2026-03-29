---
layout: post
title: "Building for Tomorrow"
date: 2026-03-10
category: "properties-series"
series: "the-properties-that-survive"
---

By 2019, Airbnb's ML infrastructure was among the most sophisticated in production use. They had built Bighead, an end-to-end machine learning platform presented at Strata in 2018 and Data Council in 2019. They had also built an internal feature platform called Zipline, designed to solve a specific problem: ensuring that the features used to train a model are identical to the features served in production. Since then, the ML paradigm has shifted multiple times: gradient-boosted trees gave way to neural networks, then to foundation models. The feature platform they built, renamed and [open-sourced in 2024 as Chronon](https://www.infoq.com/news/2024/04/airbnb-chronon-open-sourced/), is still in active use. Stripe co-maintains it.

Their infrastructure survived because it was built on properties (data quality, consistency, lineage) rather than patterns (specific model types, specific frameworks). The paradigm shifted. The foundation did not.

Tomorrow is uncertain. The models will change. The regulatory landscape will shift. The organizational failures will persist in new forms. The question is not how to predict the future. The question is what to build that survives regardless.

## What dies

The current flagship models will be replaced. That is not a prediction: it is the pattern. LangChain and LlamaIndex will be superseded by whatever comes next. RAG pipelines may look as dated as MapReduce within five years. The models, frameworks, and architectures are furniture. They are supposed to be replaced.

The infrastructure that dies with them is the problem. MapReduce pipelines were state of the art in 2012. In 2019, the two largest Hadoop vendors merged (a deal that signaled industry-wide distress) and cloud data warehouses made most on-premise pipelines obsolete. The same coupling is happening now: vector databases tightly bound to current embedding models, agent frameworks coupled to today's LLM APIs, prompt engineering patterns optimized for how current models process text.

The question is what to build that does not die with the current paradigm. Not models, not frameworks, not architectures. Something more fundamental: infrastructure properties that were valuable before LLMs and will be valuable after whatever comes next.

## The two traps

Most organizations fail the same way, in one of two directions.

The first: they adopt current best practices (fine-tuning, RAG, prompt engineering) and build infrastructure optimized for exactly those patterns. When the paradigm shifts, the infrastructure becomes a constraint. MapReduce was the right answer in 2012 for batch processing at scale. It was not the right answer in 2019. The companies that had invested most heavily in Hadoop infrastructure were the last to move.

The second: they recognize that the landscape is changing too fast and do not commit to infrastructure at all. They use off-the-shelf tools, avoid architectural decisions, stay flexible. Flexibility without foundation is chaos. At scale, you cannot trace what went wrong, cannot answer a regulator who asks what your system told a customer on a specific date, cannot onboard a new model without rebuilding the data pipeline from scratch.

Both traps have the same outcome: when the paradigm shifts, you are starting over. The path between them is building infrastructure that embodies properties rather than implements patterns. Properties survive. Patterns become legacy.

## What survives

Airbnb did not build Chronon for LLMs. They built it to solve a specific problem: ensuring that the features used to train a model are the same features served in production. That requirement has not changed across three paradigm shifts. The data quality standards, feature consistency guarantees, and lineage tracking that make Chronon useful survived gradient-boosted trees, survived neural networks, and will survive whatever comes next. What did not survive were the model architectures trained on those features, which were replaced each time the paradigm shifted.

The same pattern holds across infrastructure cycles. Stripe has [maintained compatibility with every version of its API](https://stripe.com/blog/api-versioning) since 2011. The underlying payment infrastructure has been rebuilt many times. Callers do not know or care, because the contract was designed not to change arbitrarily. Companies that exposed implementation details directly had to coordinate breaking changes with every consumer each time the internals changed. The implementation was replaced. The contract requirement was not.

What makes an infrastructure investment paradigm-independent is not its age. It is whether what it embodies holds regardless of which model architecture is reading the data, which framework is executing the workflow, or which vendor is providing the compute.

Four properties have held across every cycle examined here. Ground truth: data that means what it says, consistently, across every system that reads it (what Chronon enforces when it guarantees identical computation at training time and serving time). Provenance: the ability to trace any decision back to what model, what data, what version produced it (a requirement for debugging, auditing, and the regulator who asks what your system said on a specific date). Contracts: interfaces that absorb implementation changes without breaking callers (the difference between swapping an embedding model transparently and coordinating a breaking change across every downstream system). Reversibility: the ability to roll back when the world changes (to reprocess with corrected data, return to a known state, undo what should not have been done). These were requirements before LLMs and will be requirements after whatever replaces them.

I have worked at enough places to know this from the wreckage. At Netflix, the data infrastructure that outlasted my tenure was not the clever streaming pipelines — it was the boring data quality checks and schema contracts that nobody wanted to write. At a startup that no longer exists, I watched a team rebuild their entire analytics stack three times in two years because they had optimized for a specific framework each time and never invested in the properties underneath. The framework changed. The data contracts, had they existed, would not have. The next posts take each property in turn.

## What I am still figuring out

Whether paradigm-independence is even possible. Maybe every infrastructure investment is a bet on a particular future, and the best you can do is bet wisely. Maybe the companies that seem paradigm-independent just got lucky: their bets happened to align with where the industry went.

Whether the current infrastructure boom is building structure or furniture. In 2025, big tech spent over $400 billion on AI infrastructure. Some of it will last. Most of it is coupled to a paradigm that has a shelf life. The question is which is which, and whether you can tell the difference before the paradigm shifts.

---

The models were furniture. The data discipline was structure. Airbnb's ML paradigm shifted three times, and each time the feature platform survived. Not because anyone predicted the shifts. Because the property it enforced is not coupled to any particular model architecture. The same question applies to everything being built right now.
