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

## What survives

Some things survive paradigm shifts. Not the models—GPT-4 will be a footnote by 2030. Not the frameworks—LangChain and LlamaIndex will be replaced by whatever comes next. Not even the architectures—RAG pipelines may look as dated as MapReduce within five years.

What survives is more fundamental:

**Ground truth.** Data that means what it says it means. Data contracts that make semantics explicit. When the models change, the data they consume still needs to be trustworthy. The companies that invested in data quality—not as a compliance checkbox but as infrastructure—can adopt new paradigms without rebuilding from scratch.

**Provenance.** Knowing where things came from. Memory systems that track lineage, not just content. When a model hallucinates, you need to know which sources contributed. When a decision is challenged, you need an audit trail. Provenance is the foundation of trust, and trust is what lets you move fast later.

**Contracts.** Explicit agreements about interfaces. Not just API schemas, but semantic contracts—what this field means, what values are valid, what downstream systems depend on it. When you change one thing, contracts tell you what else breaks. Without them, every change is a gamble.

**Reversibility.** The ability to undo. Circuit breakers that cut off failing systems before they cascade. Model versioning with rollback. Feature flags that let you retreat. The companies that [deploy with automatic pullback](/blog/the-ai-pilot-graveyard/) can experiment aggressively because failure is recoverable.

These are not AI capabilities. They are infrastructure properties. They were valuable before LLMs, and they will be valuable after whatever comes next.

## The two traps

Most organizations fall into one of two traps.

**Trap one: Building for today.** They adopt the current best practices—fine-tuning, RAG, prompt engineering—and build infrastructure optimized for exactly those patterns. When the paradigm shifts, the infrastructure becomes a constraint. The feature stores that Airbnb built were perfectly designed for the ML workflows of 2019. They were not designed for the LLM workflows of 2024.

**Trap two: Building for never.** They recognize that the landscape is changing too fast, so they do not build infrastructure at all. They use off-the-shelf tools, avoid commitments, stay flexible. But flexibility without foundation is chaos. They cannot deploy AI at scale because they have no [governance infrastructure](/blog/the-metadata-control-plane/), no data quality guarantees, no way to trace what went wrong.

The path between these traps is building infrastructure that embodies properties rather than implements patterns. Ground truth, provenance, contracts, reversibility—these are properties. Fine-tuning pipelines and vector databases are patterns. Properties survive. Patterns become legacy.

## The questions ahead

The next question is harder than documenting what is broken: what survives?

I do not have complete answers. But I have four areas worth exploring:

**The uncertainty stack.** What infrastructure properties are truly paradigm-independent? I have named four—ground truth, provenance, contracts, reversibility—but there may be more, and I may be wrong about some. What can we learn from infrastructure that survived previous technology transitions? What makes systems future-proof rather than future-fragile?

**The institutional memory problem.** Organizations forget. The engineer who understood the system leaves. The documentation rots. AI accelerates this—[comprehension debt](/blog/the-three-debts/) compounds, codebases hollow out. What does institutional memory look like when both humans and machines are unreliable narrators? How do you preserve understanding across time?

**The governance precondition.** Governance is not overhead—it is a precondition for AI that works at scale. The companies that invested in "boring" infrastructure—data lineage, access controls, audit trails—have asymmetric advantage. But what is the minimum viable governance at different stages? How do you build governance that enables rather than constrains?

**The human-AI boundary.** Where does automation stop and judgment begin? The failures of full autonomy and the failures of no autonomy are both well documented. The answer is somewhere in between. What decisions require humans? How do you preserve human understanding as AI handles more? What interface patterns actually work?

## What I am still figuring out

Whether properties are enough. Ground truth, provenance, contracts, reversibility—these feel right. But I do not know if they are complete. There may be infrastructure properties I have not identified that will turn out to be critical. There may be properties I have named that turn out to be less fundamental than I think.

Whether paradigm-independence is even possible. Maybe every infrastructure investment is a bet on a particular future, and the best you can do is bet wisely. Maybe the companies that seem paradigm-independent just got lucky—their bets happened to align with where the industry went.

---

The models will change. The frameworks will change. The architectures will change.

Ground truth, provenance, contracts, reversibility—these will still matter.

Build for properties, not patterns. That is how you build for tomorrow.
