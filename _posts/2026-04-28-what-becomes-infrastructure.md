---
layout: post
title: "What Becomes Infrastructure"
date: 2026-04-28
category: "properties-series"
---

The [fifty-year stack](/blog/the-fifty-year-stack/) absorbs its challengers. PostgreSQL ate NoSQL. Linux ate containers. TCP/IP ate ATM. In each case, the survivor incorporated what was useful and discarded what was noise. The challenger's best ideas became features. The challenger itself became unnecessary.

The previous posts in this series examined [four structural properties](/blog/the-properties-that-survive/) — [ground truth](/blog/ground-truth-as-foundation/), [provenance](/blog/the-provenance-imperative/), [contracts](/blog/contracts-as-infrastructure/), [reversibility](/blog/reversibility-as-default/) — and argued they outlast paradigm shifts. The reverse case is just as instructive. Boeing's 737 ran the absorption strategy for fifty-four years, taking on heavier engines, fly-by-wire elements, and increasingly aggressive aerodynamic compensation, all without renegotiating the underlying contracts of the airframe. The MAX ran out of margin and 346 people died. Absorption without the four properties is not free; it is debt that compounds invisibly until it doesn't. The forward-looking question: where are the four properties in the absorption cycle right now? Which are becoming invisible infrastructure, and which still require deliberate investment?

## What is already commoditizing

**Reversibility is nearly infrastructure.** Blue-green deployments, canary releases, and rolling updates are platform features now, not architectural decisions. Kubernetes ships with rolling update strategy as the default deployment behavior. AWS, GCP, and Azure all offer canary deployment with automatic rollback on alarm triggers. Vercel deploys every git push with instant rollback to any prior deployment. Feature flags decouple deployment from release: [LaunchDarkly](/blog/reversibility-as-default/) raised $200 million at a $3 billion valuation in 2021 because the market for "ability to undo a deployment" is enormous.

For deployment reversibility, the hard work is done. The infrastructure exists. The question is no longer whether to use it but whether teams actually will. The cost of reversibility is always finite. The cost of irreversibility is unbounded. The market agreed. Within three years, any deployment platform that does not offer automatic rollback will be considered negligent, the same way a database without transactions would be considered negligent today.

**Contracts are partially there.** API versioning is mature. [Stripe](/blog/contracts-as-infrastructure/) has maintained backward compatibility through over sixty API versions since 2011. The AWS S3 API became so stable that over forty competitors implement it rather than fight it. Schema registries validate Avro, Protobuf, and JSON schemas against compatibility rules. Infrastructure-as-code tools (Terraform, Pulumi) version infrastructure contracts.

But data contracts — the Tessera model where consumers register dependencies on schema fields, producers see who depends on them, and breaking changes require acknowledgment — are still early. Most teams still discover breaking schema changes from the 3am page, not from a contract system. The gap is specific: deployment contracts are commoditized. Data contracts are not.

The pressure from AI accelerates this. When human engineers change schemas, the rate of change is bounded by human velocity — a few changes per sprint. When AI agents modify data pipelines, they can make dozens of changes per day, each one a potential contract violation. The surface area for breaking changes scales with agent velocity. The 3am page cannot scale with it. Automated contract enforcement will have to.

## What still requires deliberate investment

**Ground truth is not commoditized.** Data quality tooling exists — Great Expectations, Monte Carlo, Soda, and built-in quality monitoring in Databricks and Snowflake. The tooling is there.

But the full metrological chain — immutable sources at the bottom, documented derivations, quantified uncertainty, continuous verification — barely exists outside of metrology itself. Most organizations bolt data quality checks onto existing pipelines rather than building immutable source-of-truth layers. The checks catch anomalies after the fact. They do not prevent derived data from drifting invisibly from its source.

AI makes this worse. Models trained on derived data with no traceability back to source distribute error across billions of parameters. RAG systems that extract and summarize ground truth produce game-of-telephone effects — each derivation step introduces noise that is indistinguishable from signal. The pattern repeats: [LIBOR, Boeing's MCAS, the Post Office's Horizon](/blog/ground-truth-as-foundation/) — systems where the ground truth was absent, fabricated, or ignored. Each failed catastrophically. Each was treated as reliable until it was not.

Data quality monitoring will become standard platform infrastructure within three years. The deeper problem — immutable sources with documented derivations — will not. That requires design, not tooling.

**Provenance is the furthest from infrastructure.** Lineage tools exist — OpenLineage provides an open standard, Marquez implements it, Google's SLSA framework defines provenance for software supply chains. The tooling is real.

But adoption is low and scope is narrow. SLSA addresses build provenance — where a binary came from — but not data provenance or decision provenance. OpenLineage tracks pipeline transformations but not model reasoning. Decision audit trails for AI systems barely exist outside of regulated industries. The few that do exist depend on agents voluntarily recording their decisions, which means gaps wherever an agent skips the step. Per-output provenance — storing `model_id`, token counts, and response metadata on every AI output — is technically straightforward but organizationally rare, and no standard equivalent of SLSA exists for AI decision provenance.

The regulatory push is creating demand. The [EU AI Act](/blog/the-compliance-moat/) mandates six-month minimum logging of automatically generated outputs and ten-year retention of technical documentation for high-risk AI, with fines up to €35 million or 7% of global turnover and full enforcement beginning August 2026. The SEC [fined 26 firms a combined $392.75 million](/blog/the-metadata-control-plane/) for failing to preserve electronic communications. AI outputs are communications.

Provenance will become compliance infrastructure first, driven by regulation, then general infrastructure, driven by operational need. It is the slowest to commoditize because it requires organizational discipline, not just tooling.

## The absorption forecast

The absorption pattern suggests specific predictions. Each is falsifiable.

**Reversibility** will be fully absorbed within three years. Any deployment platform that does not offer automatic rollback, canary analysis, and feature flag integration will be considered incomplete. This is the shipping container — standardized, invisible, assumed. The argument for reversibility will feel as unnecessary as the argument for version control.

**Contracts** will split. API and deployment contracts are already commoditized. Data contracts will become platform features within three to five years. Databricks, Snowflake, or a major cloud provider will ship native schema contract enforcement — not just schema validation, but dependency tracking and breaking-change coordination. The pressure from AI agents making changes at machine speed will force this. The question is whether the platform vendors build it or acquire it.

**Ground truth** will be partially absorbed. Data quality monitoring is already a platform feature. But the harder problem — defining what "correct" means, not just detecting when it is wrong — has no obvious automation vector. Version control became infrastructure because git won. Testing became infrastructure because CI/CD pipelines made it automatic. Ground truth has no equivalent. You cannot automate the design decision that says "this metric traces to an immutable source through documented transformations." That judgment is human work, and human work does not become invisible infrastructure. It becomes the thing that distinguishes organizations that take AI reliability seriously from those that do not.

**Provenance** will be regulation-driven. The EU AI Act will do for decision logging what GDPR did for consent management: force an entire category of tooling into existence by August 2027. That tooling will then spread beyond regulated industries as organizations discover that "which model version produced this output" is useful for debugging, not just compliance. But provenance will be the last of the four to become invisible, because it is the only one that requires changing how people work rather than what tools they run. You can install a lineage tool in an afternoon. Getting every team to record every decision consistently is a culture change, and culture changes do not ship as platform features.

## What I am still figuring out

Whether the absorption timeline I described is too optimistic about reversibility and too pessimistic about provenance. Reversibility as platform infrastructure assumes that organizations will actually use the rollback mechanisms they have access to. Kubernetes has had rolling updates for years. Most teams I have worked with still deploy by pushing to main and hoping. The infrastructure being available does not mean the practice is absorbed. There may be a gap between "the platform supports it" and "the team does it" that is larger than I am accounting for.

On the provenance side, regulation may force the timeline faster than I expect. But compliance-driven provenance is not the same as useful provenance. GDPR created a rush of cookie consent banners — technically compliant, practically useless, and universally despised. If the AI Act's logging requirements produce the provenance equivalent of cookie banners — recording what is legally required rather than what is operationally useful — then provenance will be "adopted" without being absorbed. Whether compliance-driven provenance captures the right things or just the legally mandated things is a question I cannot answer yet.

Whether the four properties are the right four. Ground truth, provenance, contracts, and reversibility emerged from studying what survived across fifty-year systems. But survivorship bias applies to properties too. There may be a fifth property — composability, or observability, or something I have not named — that the surviving systems also share and that I have not isolated because I was not looking for it.

---

In 2009, a hashtag for a meetup launched a movement that declared the relational model dead. Fifteen years later, Databricks paid $1 billion for a PostgreSQL company. The relational model survived by absorbing what was useful and discarding what was noise.

The properties that survive are the ones that become invisible. Version control was an argument in 1990. It is infrastructure now. Automated testing was an argument in 2000. It is infrastructure now. Reversibility, contracts, ground truth, and provenance are at different stages of the same transition. The measure of success is whether, in five years, arguing for them feels as unnecessary as arguing for version control.
