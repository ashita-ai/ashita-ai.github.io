---
layout: post
title: "The Compliance Moat"
date: 2026-02-28
---

In 2011, Amazon Web Services built GovCloud before they had the government contracts to justify it. By 2013, they had the CIA. By 2021, the NSA. Competitors with comparable technology lost those bids. They had not built the infrastructure.

A startup [lost a $50 million deal](https://introl.com/blog/compliance-frameworks-ai-infrastructure-soc2-iso27001-gdpr) over SOC 2 failure. Another founder spent six months and $150,000 on ISO 27001 only to discover their prospects wanted SOC 2, and [still could not close US enterprise deals](https://pentesterworld.com/articles/iso-27001-vs-other-security-standards-detailed-comparison). The infrastructure they skipped was the gate their buyers needed them to pass through.

The conventional view is that compliance is overhead: a cost center that slows you down while competitors move fast. The opposite is true. Build the infrastructure compliance requires, and it becomes the moat.

## What the regulations require

FINRA, the FDA, NAIC, and the EU AI Act were written by different agencies, for different industries, across different years. Each arrived independently at the same list: audit logs documenting who changed what and when, lineage connecting model outputs to their inputs, model versioning with rollback paths, and access controls enforced before actions execute.

FINRA's model risk management framework under [SR 11-7](https://www.federalreserve.gov/supervisionreg/srletters/sr1107.htm) covers any quantitative method that processes input into estimates, which includes LLMs. The FDA's [December 2024 Predetermined Change Control Plan guidance](https://www.fda.gov/news-events/press-announcements/fda-issues-comprehensive-draft-guidance-developers-artificial-intelligence-enabled-medical-devices) requires documented verification for every model update; the agency has now authorized [over 1,250 AI-enabled medical devices](https://pmc.ncbi.nlm.nih.gov/articles/PMC12595527/) as of July 2025, up from just 33 between 1995 and 2015. The [NAIC Model Bulletin](https://content.naic.org/sites/default/files/inline-files/2023-12-4%20Model%20Bulletin_Adopted_0.pdf) requires written governance programs spanning business units, actuarial, data science, underwriting, claims, compliance, and legal, adopted in 23 states and Washington D.C., with Colorado's framework [taking effect this month](https://www.agentech.com/resources/articles/naic-ai-model-guidance). The EU AI Act mandates [10-year record retention](https://artificialintelligenceact.eu/assessment/eu-ai-act-compliance-checker/) and conformity assessments for high-risk systems, with fines reaching [€35 million or 7% of global annual turnover](https://www.europarl.europa.eu/topics/en/article/20230601STO93804/eu-ai-act-first-regulation-on-artificial-intelligence) and full enforcement beginning August 2026.

Banks engage in [months-long model risk reviews](https://bpi.com/the-overlooked-risk-in-bank-ai-adoption-regulatory-inaction/) before deploying any AI tool, while METR's research shows AI task completion capabilities [doubling roughly every seven months](https://arxiv.org/abs/2503.14499). The companies with this infrastructure in place skip the queue. The companies without it are locked out while they build it.

The regulators are not asking for extra work. They are asking you to build what you should have built first.

## The infrastructure that becomes a moat

The OCC [fined Citibank $75 million](https://www.occ.gov/news-issuances/news-releases/2024/nr-occ-2024-76.html) in 2024 for persistent failures in data governance and risk management controls. Banks that already have audit infrastructure can deploy AI in compliance-sensitive functions. Banks that do not are locked out until they build it.

The FDA's Predetermined Change Control Plan guidance requires knowing which model version produced which output and having a documented path to revert. Companies with model versioning can update AI medical devices through a streamlined process. Companies without it face full resubmission for every change.

The [NAIC Model Bulletin](https://www.mwe.com/insights/state-regulators-address-insurers-use-of-ai-11-states-adopt-naic-model-bulletin/) requires contract terms allowing audit and regulatory cooperation. Insurers with access controls and audit rights built into their vendor contracts can adopt AI tools immediately. Insurers without them must renegotiate first.

Each component is a gate. The companies that have the infrastructure pass through. The companies that do not are locked out of entire markets.

## The AWS example

In 2011, Amazon Web Services launched GovCloud — a dedicated cloud region built to meet U.S. government security and compliance requirements: FedRAMP High, DoD Impact Levels 4 and 5, ITAR, CJIS. There were no contracts yet that required it. They built it anyway.

Two years later, the CIA awarded AWS a contract worth [up to $600 million](https://www.theregister.com/2013/03/19/aws_allegedly_helps_cia_build_spy_cloud/). IBM protested the award. A federal court overturned the protest. The gap was not the technology. It was compliance infrastructure IBM had not built.

In 2021, the NSA awarded AWS a [$10 billion contract](https://www.nextgov.com/modernization/2021/08/nsa-awards-secret-10-billion-contract-amazon/184390/), codenamed "Wild and Stormy." Microsoft protested. The NSA evaluated the protest and re-awarded to AWS. A decade of intelligence community relationships and compliance infrastructure had compounded into an advantage Azure Government — which caught up on the technology — could not close.

The competitive advantage is not the cloud technology. It is the compliance infrastructure that determines who can bid.

ISVs building on GovCloud can [inherit AWS's FedRAMP security controls](https://aws.amazon.com/govcloud-us/), reducing their own authorization burden by months or years. AWS built the infrastructure first. Now they rent the advantage to partners.

## The economics

SOC 2 certification costs [$30,000 to $150,000](https://scytale.ai/center/soc-2/how-much-does-soc-2-compliance-cost/) for most small to mid-sized companies. ISO 27001 runs [$50,000 to $200,000](https://scytale.ai/resources/iso-27001-certification-costs/) and takes 3 to 18 months. [ISO 42001](/blog/i-read-iso-42001-so-you-dont-have-to/), the first certifiable standard specifically for AI management systems, is designed to integrate with existing ISO 27001 infrastructure, reducing implementation effort for organizations already certified. Fortune 500 companies average [$2.5 million](https://introl.com/blog/compliance-frameworks-ai-infrastructure-soc2-iso27001-gdpr) for AI infrastructure compliance.

The costs are front-loaded. The benefits compound.

Many venture capitalists [prefer investing in SOC 2-compliant startups](https://www.ispartnersllc.com/blog/soc-2-for-startups/). McKinsey [found](https://www.mckinsey.com/industries/financial-services/our-insights/the-case-for-compliance-as-a-competitive-advantage-for-banks) that 35% of financial services growth comes from adjacent industries, growth that requires regulatory approval competitors may not have. AWS rents its compliance moat to partners through GovCloud. Banks with audit infrastructure deploy AI where competitors are blocked by months-long model risk reviews. The pattern repeats in every regulated vertical.

The companies treating compliance as overhead are paying for infrastructure they will need anyway, getting no credit for it, and leaving market opportunity on the table. The companies treating compliance as strategy are building once and selling everywhere. [The incentive structure](/blog/the-incentive-problem/) rewards launching over maintaining, but compliance infrastructure is one of the few investments that pays off in both phases.

## What I am still figuring out

The minimum viable compliance infrastructure is not obvious. SOC 2 at $30K is a startup's entry ticket. A full regulatory framework at $2.5M is an enterprise investment. The right answer for a Series A company is somewhere between, and the threshold is invisible until you are past it — usually inside the incident or the lost deal that would have required it.

The AWS example is the clearest version of the moat thesis, which may also be its limitation. Government and intelligence community contracting is the most compliance-sensitive market that exists: buyers are sophisticated, requirements are explicit, and compliance is a genuine prerequisite. In commercial markets — where most companies actually compete — buyers are often less demanding. A mid-market software buyer asking "do you have SOC 2?" may not care about data lineage or model versioning at all. The moat is strongest in regulated verticals. Most startups are not in regulated verticals.

---

The startup that lost a $50 million deal did not lose it on technology. The founder who spent $150,000 on the wrong certification did not fail at engineering. They failed at understanding which gate their buyers needed them to pass through.

The regulators are not asking for busywork. They are asking for the same infrastructure that makes AI work in production: audit trails, lineage tracking, model versioning, access controls. The companies that build it first can deploy where competitors cannot. The governance is not overhead. The governance is the moat.
