---
layout: post
title: "What Becomes Infrastructure"
date: 2026-06-02
---

## Purpose

"The Fifty-Year Stack" and "The Cost of Absorption" are backward-looking: what survived and what broke. This post looks forward. Which of the four properties are becoming commodity infrastructure (table stakes, embedded in platforms), and which still require deliberate investment? This is the forward-looking capstone the blog currently lacks.

## Opening (~300 words)

Start with the absorption pattern from "The Fifty-Year Stack": PostgreSQL ate NoSQL, Linux ate containers, TCP/IP ate ATM. The pattern is that good properties get absorbed into infrastructure over time — they stop being differentiators and become assumptions.

The question: where are ground truth, provenance, contracts, and reversibility in this absorption cycle right now?

## Section 1: What's already commoditizing (~400 words)

**Reversibility is nearly infrastructure.** Blue-green deployments, feature flags, canary releases — these are platform features now, not architectural decisions. Vercel, AWS, GCP all offer them out of the box. LaunchDarkly is a billion-dollar company. Kubernetes has rolling updates built in. For deployment reversibility, the hard work is done. You just have to use it.

**Contracts are partially there.** Schema registries (Confluent), API versioning (Stripe's model widely copied), infrastructure-as-code (Terraform state). But data contracts specifically — the Tessera model where consumers register dependencies and producers see impact — are still early. Most teams still discover breaking changes from the 3am page, not from a contract system. The gap: deployment contracts are commoditized; data contracts are not.

## Section 2: What still requires deliberate investment (~400 words)

**Ground truth is not commoditized.** Data quality tooling exists (Great Expectations, Monte Carlo, Soda), but it's bolted on, not foundational. Most organizations still don't have immutable source-of-truth layers. The metrological chain from "Ground Truth as Foundation" — immutable sources, documented derivations, quantified uncertainty, continuous verification — is aspirational for nearly everyone. AI makes this worse: models trained on derived data with no traceability back to source.

**Provenance is the furthest from infrastructure.** Lineage tools exist (OpenLineage, Marquez) but adoption is low. Decision audit trails for AI systems barely exist outside of regulated industries — Akashi is one attempt, but it depends on agents voluntarily calling `akashi_trace`, which means gaps wherever an agent skips the step. Google's SLSA framework addresses software supply chain provenance but not data or decision provenance. Mimir's finding schema (model_id, token counts, metadata JSONB per finding) shows what per-output provenance looks like, but this is bespoke, not standardized. The regulatory push (EU AI Act logging requirements, SEC enforcement) is creating demand, but the tooling is immature. This is where the biggest gap — and the biggest opportunity — sits.

## Section 3: The absorption forecast (~300 words)

Make specific, falsifiable predictions about what happens in the next 3-5 years:

- **Reversibility:** Fully absorbed. Within 3 years, any deployment platform that doesn't offer automatic rollback will be considered negligent. This is the shipping container — standardized and invisible.
- **Contracts:** Data contracts become platform features within 3-5 years. Databricks, Snowflake, or a major cloud provider will ship native schema contract enforcement. The pressure from AI (agents making schema changes at machine speed) accelerates this.
- **Ground truth:** Partially absorbed. Data quality monitoring becomes standard in data platforms (already happening). But the metrological chain — immutable sources with documented derivations — remains a deliberate investment for organizations that care about AI reliability.
- **Provenance:** Regulation-driven absorption. The EU AI Act's logging requirements (6-month minimum, 10-year tech docs) force provenance infrastructure into existence for high-risk AI. It becomes compliance infrastructure first, then general infrastructure. Slowest to commoditize because it requires organizational discipline, not just tooling.

Close with: the properties that survive are the ones that become invisible. They stop being arguments and start being assumptions. The blog has argued for these properties for six months. The measure of success is whether, in five years, arguing for them feels as unnecessary as arguing for version control.

## Sources to find and verify

- LaunchDarkly valuation and market data (verify "billion-dollar company" claim)
- Vercel/AWS/GCP built-in deployment reversibility features (docs)
- Confluent Schema Registry adoption data
- Great Expectations / Monte Carlo / Soda adoption and funding data
- OpenLineage / Marquez adoption data
- SLSA framework current status and adoption
- EU AI Act implementation timeline (enforcement dates, logging requirements)
- Databricks / Snowflake recent product announcements re: data quality or contracts
- Any analyst reports on data infrastructure market evolution (a16z data infra map, MAD landscape, etc.)

## Voice notes

- This is the most forward-looking post in the blog. It should feel confident but not prophetic. Make predictions specific enough to be falsifiable.
- The tone should be: "here's where the trend line points, based on the patterns we've been studying."
- Target ~1,500 words.
- This is a natural ending point for this phase of the blog. It should feel like a conclusion without being conclusive — the work continues, but the argument is now complete enough to stand.
