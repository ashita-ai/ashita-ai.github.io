---
layout: post
title: "The Price of Doing It Right"
date: 2026-05-19
---

## Purpose

The blog quantifies the cost of failure extensively ($881M Zillow, $460M Knight Capital, $110M Unity, $20B+ Boeing). It never quantifies the cost of doing it right. This post answers the question the reader has after 30+ posts: "OK, I'm convinced. What does it actually cost to build with these properties, and does it pay back?"

## Opening (~300 words)

Start with a comparison the reader can feel. Pick two real systems that solved the same problem — one built with the properties, one without — and show the cost curves crossing.

Candidate: Stripe vs. early payment processors on fraud detection. Stripe invested heavily in Radar (ground truth on transaction patterns, provenance on fraud decisions, contracts on the API, reversibility via dispute handling). The upfront cost was significant. The payoff: 0.1% false positive rate, $6B fraud recovered, and a fraud system that's now a competitive moat. Compare to a processor that skimped on fraud infrastructure and ate the losses.

Or: Veeva vs. generic CRM in pharma. Veeva invested in FDA compliance infrastructure (audit trails, validation, e-signatures) from day one. Cost more to build. Result: 80% pharma CRM market share within 5 years, competitors structurally locked out. From "The Compliance Moat."

## Section 1: The investment profile (~400 words)

Break down what "building with properties" actually costs, using real numbers where available:

- **Ground truth:** Data quality infrastructure. Great Expectations, Monte Carlo, or custom validation. Industry benchmarks on what companies spend on data quality as % of data budget. IBM's old stat ($3.1T/year in US from poor data quality) vs. what prevention costs.
- **Provenance:** Lineage tooling (OpenLineage, Marquez, commercial options). Decision audit trails (Akashi). Logging and retention. Compare: cost of running lineage vs. cost of a single regulatory fine (Citibank $75M, Two Sigma $90M). Mimir's finding schema stores model_id, token counts, and metadata JSONB on every finding — the marginal cost of provenance is a few extra columns; the cost of not having it is "which model version produced the finding that caused the incident?"
- **Contracts:** Schema registries, contract testing, dependency tracking. The Tessera model. Mimir's six adapter interfaces (ProviderAdapter, ModelAdapter, etc.) are contracts that cost design time upfront but enable M1→M2 component swaps (tree-sitter→LSP) without pipeline changes. Compare: cost of running contract infrastructure vs. cost of a single breaking change incident (Unity $110M).
- **Reversibility:** Blue-green deployments, feature flags, canary infrastructure. LaunchDarkly pricing as a proxy. Compare: cost of maintaining two environments vs. cost of a single irreversible deployment failure.

The pattern should emerge: each property costs thousands to tens of thousands per year to maintain. Each property violation costs millions to billions when it fails.

## Section 2: The payback curve (~400 words)

The investment doesn't pay back linearly. It pays back through avoided catastrophes and compounding trust.

- **Avoided catastrophe math.** Expected value calculation: probability of failure * cost of failure vs. annual cost of prevention. Use the blog's own failure cases as the numerator. Even at low probability, the expected value of prevention dominates.
- **Compounding trust.** Stripe's API stability (15 years, 60 versions, all backward compatible) compounds: every year of stability makes the next integration easier, makes switching costs higher, makes the moat deeper. This is contracts paying compound interest.
- **Regulatory front-running.** AWS GovCloud built before having contracts. Veeva built FDA compliance before competitors. The compliance moat post showed this: early investment in properties creates barriers that late investors can't quickly replicate.

## Section 3: Why teams don't invest (~300 words)

The math is clear. The behavior doesn't follow. Why?

- **Discount rate mismatch.** Properties pay back over years. Teams are measured quarterly. The cost is visible now; the payoff is invisible (avoided disasters don't show up on dashboards).
- **Survivorship bias in failure.** Most property violations don't cause catastrophic failure. They cause slow degradation. Teams that skip data quality don't lose $881M — they lose 2% accuracy per quarter until the system is useless and nobody can point to the moment it broke.
- **The pilot trap.** From "The AI Pilot Graveyard" — pilots are optimized to skip infrastructure. Properties are infrastructure. The 95% failure rate of pilots is partly a properties deficit.

Close with: the price of doing it right is visible, bounded, and predictable. The price of doing it wrong is invisible, unbounded, and surprising. The blog has documented 30+ cases of the latter. This post is the invoice for the former.

## Sources to find and verify

- Stripe Radar economics (public blog posts, S-1 filing data on fraud rates)
- Veeva's early investment numbers and market share trajectory (SEC filings, earnings calls)
- Data quality tooling costs (Great Expectations, Monte Carlo, Soda pricing; industry surveys on data quality spending)
- Lineage tooling costs (OpenLineage is open source; commercial options like Atlan, Alation pricing)
- Feature flag / deployment infrastructure costs (LaunchDarkly pricing, blue-green infrastructure overhead estimates)
- IBM data quality cost stat — verify this is real and current, it's widely cited but may be outdated
- Any academic work on the economics of software quality investment (Capers Jones, etc.)

## Voice notes

- This is the most practical post in the blog. It should feel like a business case, not a manifesto.
- Use real dollar amounts wherever possible. Ranges are fine. Hand-waving is not.
- Target ~1,500 words.
- The reader who needs this post is the one trying to convince their VP to fund infrastructure instead of another feature.
