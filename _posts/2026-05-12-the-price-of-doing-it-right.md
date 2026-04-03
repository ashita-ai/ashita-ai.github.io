---
layout: post
title: "The Price of Doing It Right"
date: 2026-05-12
category: "economics"
---

Veeva launched in 2007 into a market Salesforce already owned. They did not compete on features. They built FDA [21 CFR Part 11](https://www.fda.gov/regulatory-information/search-fda-guidance-documents/part-11-electronic-records-electronic-signatures-scope-and-application) audit trails, GxP validation documentation, and e-signatures directly into the platform. By the time of their [2013 IPO](https://www.fiercepharma.com/marketing/veeva-systems-ipo-raises-261m-market-cap-tops-4-billion), they held an estimated 80% of pharmaceutical CRM. Today they serve [47 of the top 50 biopharma companies](https://www.veeva.com/about/).

That infrastructure was expensive to build. Compliance engineering is slow, unglamorous, and does not demo well. Salesforce could have built the same thing. They chose to compete on features instead. By the time they realized the compliance infrastructure was the product, Veeva's customers were locked in: switching requires revalidating the replacement system under FDA standards, a process that is slow, expensive, and risky for mission-critical workflows.

The cost of doing it wrong is well quantified. [$881 million](/blog/the-ai-pilot-graveyard/). [$460 million in forty-five minutes](/blog/the-metadata-control-plane/). [$110 million](/blog/contracts-as-infrastructure/) to a data contract violation. [$90 million](/blog/the-metadata-control-plane/) in SEC fines. [$75 million](/blog/the-compliance-moat/) in OCC penalties. The cost of failure is well documented.

The cost of doing it right is not. This is the invoice.

## The investment

[Ground truth](/blog/ground-truth-as-foundation/), [provenance](/blog/the-provenance-imperative/), [contracts](/blog/contracts-as-infrastructure/), and [reversibility](/blog/reversibility-as-default/) each has a cost. The cost is visible, bounded, and predictable. It is also substantially smaller than the failures it prevents.

**Ground truth** means data quality infrastructure: validation rules, freshness checks, distribution monitoring, anomaly detection. The tooling exists — Great Expectations, Soda, Monte Carlo. The engineering cost is not the tooling. It is defining what "correct" means for each critical data element: not "is this column non-null" but "does this derived metric trace back to an immutable source through documented transformations." That definition takes days per data element instead of hours. For a mid-size data platform, one to three engineers for a quarter. The difference: catching drift at the source versus chasing phantom anomalies for months. One design session prevents a category of operational pain.

**Provenance** means [lineage and audit trails](/blog/the-provenance-imperative/). OpenLineage is open-source and provides a standard for lineage metadata. Decision audit trails require storing what was decided, why, and by whom — a few extra columns per decision, a few extra API calls per workflow. Storing `model_id`, token counts, and response metadata on every AI output costs negligible storage. The engineering cost is in the discipline of writing to those fields consistently.

Compare that to the cost of not having provenance. [Two Sigma's $90 million fine](/blog/the-metadata-control-plane/) was for four years of invisible modification in a system managing billions of dollars. An employee modified live-trading models without approval for nearly two years. The question "who changed what, when, with what authorization" would have cost a metadata control plane to answer. The absence cost $90 million.

**Contracts** mean schema registries, interface definitions, and dependency tracking. Well-designed adapter interfaces — stable boundaries that let the implementation behind them change without breaking the pipeline — take days of design time. The payoff: when you swap implementations (a heuristic parser for a language server, one model provider for another), the pipeline code does not change. Every future migration touches zero integration code.

[Stripe's API](/blog/contracts-as-infrastructure/) has maintained backward compatibility through over 60 versions since 2011. That is fifteen years of versioning discipline — unglamorous, invisible, and the single largest reason developers stay. The cost of maintaining sixty versions is real. The cost of breaking one is larger than all sixty combined.

**Reversibility** means deployment infrastructure: blue-green deployments, canary releases, feature flags, automated rollback. These are platform features now. Kubernetes has rolling updates built in. Every major cloud provider offers canary deployment tooling. The cost is concrete: roughly double the compute for blue-green, a percentage of traffic for canary, a few milliseconds of latency for feature flag evaluation. Compare that to Knight Capital's $460 million in forty-five minutes. The infrastructure cost is a rounding error on the disaster it prevents.

## The payback

The investment does not pay back linearly. It pays back through three mechanisms that compound.

**Avoided catastrophe.** Expected value arithmetic is straightforward: probability of failure multiplied by cost of failure, versus annual cost of prevention. Unity's [$110 million loss](/blog/contracts-as-infrastructure/) could have been prevented by schema validation at the pipeline boundary — infrastructure that costs less to run annually than Unity lost in a week. Citibank's [$75 million fine](/blog/the-compliance-moat/) could have been prevented by standard audit infrastructure: model registries with ownership, classification tags on sensitive data, audit logs for customer-facing outputs. The prevention costs thousands per year. The failure costs millions per incident.

But the expected value framing understates the risk, because property violations compound silently. Unity did not lose $110 million in a day. The corrupted data degraded ad-targeting gradually, accumulating losses over weeks before anyone traced the problem to its source. The metrics looked fine while the system quietly destroyed value. By the time the failure was visible, the cost had already compounded.

**Compounding trust.** Stripe's API stability compounds. Every year of backward compatibility makes the next integration more likely, raises switching costs, and deepens the moat. That trust was purchased with fifteen years of contract discipline. It cannot be replicated quickly. A competitor would need to maintain flawless backward compatibility for years before anyone would believe them — and the first breaking change resets the clock.

Veeva's compliance infrastructure compounds the same way. Every year that competitors lack FDA-validated audit trails is another year of customer lock-in. AWS followed the same playbook for government: they built GovCloud before having the contracts to justify it, then won the CIA and a [$10 billion NSA contract](https://www.reuters.com/technology/amazon-web-services-wins-nsa-cloud-contract-2021-08-10/) while competitors with comparable technology lost bids. The moat is not the technology. It is the accumulated years of doing it right, and the years cannot be compressed.

**Regulatory front-running.** The [EU AI Act](/blog/the-compliance-moat/) mandates six-month minimum logging for high-risk AI systems and ten-year technical documentation retention. Penalties reach €35 million or 7% of global turnover for prohibited practices. Enforcement begins August 2026. Organizations that already have provenance infrastructure — lineage, audit trails, model registries — will meet these requirements with configuration changes. Organizations that do not will face months of engineering work under regulatory deadline pressure, which is the most expensive way to build anything.

## Why teams don't invest

The math is clear. The behavior does not follow. Three structural reasons.

**Discount rate mismatch.** Properties pay back over years. Teams are measured quarterly. The engineering manager who spends a quarter building data quality infrastructure ships zero features that quarter. The manager who skips it ships four features and gets promoted. The data quality failure arrives eighteen months later, under a different manager's watch. The incentive structure systematically undervalues prevention because the cost is visible now and the payoff is invisible — avoided disasters do not show up on dashboards.

**Survivorship bias in failure.** Most property violations do not cause catastrophic failure. They cause slow degradation. Teams that skip data quality do not lose $881 million. They lose 2% accuracy per quarter until the system is useless and nobody can point to the moment it broke. The catastrophic failures make the news. The slow degradation gets normalized. [S&P Global found](/blog/the-ai-pilot-graveyard/) that 42% of companies abandoned most of their AI initiatives in 2025, up from 17% in 2024. Most of those were not dramatic failures. They were slow deaths by property erosion.

**The pilot trap.** Pilots are optimized to skip infrastructure. They use synthetic data instead of building data quality. They use ad-hoc prompts instead of building contracts. They deploy without rollback because the pilot is "just a test." Then the pilot scales, the temporary decisions become permanent architecture, and the properties that were skipped in the pilot become the failures that kill the production system. The [95% pilot failure rate](/blog/the-ai-pilot-graveyard/) is partly a [properties](/blog/the-properties-that-survive/) deficit dressed up as a technology problem.

## What I am still figuring out

Whether the investment profile I described is honest about the organizational cost. The engineering cost of data quality, provenance, contracts, and reversibility is real but modest — a quarter, a few design sessions, some infrastructure overhead. The organizational cost is harder to measure. Convincing a team to spend a quarter on infrastructure instead of features requires a VP who values prevention over velocity. That VP exists at Stripe and Veeva. At most companies, the VP who ships four features gets promoted and the VP who prevents an invisible disaster gets nothing. The engineering cost is bounded. The political cost may not be.

Whether the expected value arithmetic actually persuades anyone. The math — probability of failure times cost of failure versus annual cost of prevention — is clean on paper. In practice, every organization believes it is the exception. Unity did not skip data contracts because the math was unclear. They skipped them because the math felt hypothetical until it was not. I do not know how to make the cost of invisible failures feel concrete before they happen. The case studies help. But case studies describe other people's failures, and other people's failures always feel distant.

---

Veeva launched in 2007 into a market Salesforce already owned. They did not compete on features. They built the compliance infrastructure first. By the time Salesforce realized the infrastructure was the product, Veeva held 80% of pharmaceutical CRM and the switching costs were insurmountable.

The price of doing it right is visible, bounded, and predictable. The price of doing it wrong is invisible, unbounded, and surprising. The numbers are not close.
