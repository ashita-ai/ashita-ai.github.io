---
layout: post
title: "The Compliance Moat"
date: 2026-03-03
---

In 2011, Amazon Web Services [built GovCloud](https://aws.amazon.com/govcloud-us/) before they had the government contracts to justify it. By 2013, [they had the CIA](https://www.theregister.com/2013/03/19/aws_allegedly_helps_cia_build_spy_cloud/). By 2021, [the NSA](https://www.nextgov.com/modernization/2021/08/nsa-awards-secret-10-billion-contract-amazon/184390/). Competitors with comparable technology lost those bids. They had not built the infrastructure.

The same dollars spent on the wrong gate produce nothing. It is a common failure: six months and up to $150,000 on ISO 27001, only to discover that enterprise prospects required SOC 2 instead. The infrastructure is real. It opens the wrong door.

The conventional view is that compliance is overhead: a cost center that slows you down while competitors move fast. The opposite is true. Build the infrastructure compliance requires, and it becomes the moat.

## What the regulations require

Federal banking regulators, the FDA, NAIC, and the EU AI Act were written by different agencies, for different industries, across different years. Each arrived independently at the same four requirements: audit logs documenting who changed what and when. Lineage connecting model outputs to their inputs. Model versioning with rollback paths. Access controls enforced before actions execute.

The Federal Reserve and OCC's [SR 11-7](https://www.federalreserve.gov/supervisionreg/srletters/sr1107.htm) model risk management guidance covers any quantitative method that processes input into estimates, which includes LLMs. The EU AI Act mandates [10-year retention of technical documentation](https://artificialintelligenceact.eu/article/18/) and conformity assessments for high-risk systems, with automatically generated logs kept for [a minimum of six months](https://artificialintelligenceact.eu/article/19/), fines up to [€35 million or 7% of global turnover for prohibited AI and €15 million or 3% for high-risk violations](https://artificialintelligenceact.eu/article/99/), and full enforcement beginning August 2026.

The FDA and insurance regulators have arrived at the same place through different routes. The FDA's [December 2024 Predetermined Change Control Plan guidance](https://www.fda.gov/news-events/press-announcements/fda-issues-comprehensive-draft-guidance-developers-artificial-intelligence-enabled-medical-devices) requires documented verification for every model update, a requirement that grows more consequential as the agency has authorized [over 1,250 AI-enabled medical devices](https://pmc.ncbi.nlm.nih.gov/articles/PMC12595527/) as of July 2025, up from 33 between 1995 and 2015. The [NAIC Model Bulletin](https://content.naic.org/sites/default/files/inline-files/2023-12-4%20Model%20Bulletin_Adopted_0.pdf) requires written governance programs across business units, actuarial, data science, underwriting, claims, compliance, and legal, adopted in 24 jurisdictions as of early 2025.

Banks engage in [months-long model risk reviews](https://bpi.com/the-overlooked-risk-in-bank-ai-adoption-regulatory-inaction/) before deploying any AI tool. METR's research shows the length of tasks frontier AI can complete [doubling roughly every seven months](https://arxiv.org/abs/2503.14499) — meaning each month spent in regulatory review is a month falling further behind on capability. The companies with infrastructure already in place skip that queue. The companies without it are locked out while they build it.

The regulators are not asking for extra work. They are asking you to build what you should have built first.

## The infrastructure that becomes a moat

The OCC [fined Citibank $75 million](https://www.occ.gov/news-issuances/news-releases/2024/nr-occ-2024-76.html) in 2024 for persistent failures in data governance and risk management controls. Banks that already have audit infrastructure can deploy AI in compliance-sensitive functions. Banks that do not are locked out until they build it.

The FDA's Predetermined Change Control Plan guidance requires knowing which model version produced which output and having a documented path to revert. Companies with model versioning can update AI medical devices through a streamlined process. Companies without it face full resubmission for every change.

The [NAIC Model Bulletin](https://www.mwe.com/insights/state-regulators-address-insurers-use-of-ai-11-states-adopt-naic-model-bulletin/) requires contract terms allowing audit and regulatory cooperation. For insurers that built access controls and audit rights into their vendor contracts from the start, AI adoption is a procurement decision. For those that did not, it requires renegotiating every vendor relationship first — a process that often surfaces what was missing in the original contracts.

Each component is a gate. The companies that have the infrastructure pass through. The companies that do not are locked out of entire markets.

## The AWS example

IBM protested the [CIA award](https://www.theregister.com/2013/03/19/aws_allegedly_helps_cia_build_spy_cloud/). A federal court overturned the protest. The gap was not the technology. It was compliance infrastructure IBM had not built.

In 2021, the NSA awarded AWS a [$10 billion contract](https://www.nextgov.com/modernization/2021/08/nsa-awards-secret-10-billion-contract-amazon/184390/), codenamed "Wild and Stormy." Microsoft protested. The NSA evaluated the protest and re-awarded to AWS. A decade of intelligence community relationships and compliance infrastructure had compounded into an advantage Azure Government — which caught up on the technology — could not close.

The competitive advantage is not the cloud technology. It is the compliance infrastructure that determines who can bid.

ISVs building on GovCloud can [inherit AWS's FedRAMP security controls](https://aws.amazon.com/govcloud-us/), reducing their own authorization burden by months or years. AWS built the infrastructure first. Now they rent the advantage to partners.

## The economics

SOC 2 certification costs [$30,000 to $150,000](https://scytale.ai/center/soc-2/how-much-does-soc-2-compliance-cost/) for most small to mid-sized companies. ISO 27001 runs [$50,000 to $200,000](https://scytale.ai/resources/iso-27001-certification-costs/) and takes 3 to 18 months. [ISO 42001](/blog/i-read-iso-42001-so-you-dont-have-to/), the first certifiable standard specifically for AI management systems, is designed to integrate with existing ISO 27001 infrastructure, reducing implementation effort for organizations already certified.

The costs are front-loaded. The benefits compound.

McKinsey [found](https://www.mckinsey.com/industries/financial-services/our-insights/the-case-for-compliance-as-a-competitive-advantage-for-banks) that 35% of financial services growth comes from adjacent industries — growth that requires regulatory approval to pursue. Companies with compliance infrastructure already have it. Companies without it cannot bid while they build it. AWS rents its compliance moat to partners through GovCloud. Banks with audit infrastructure deploy AI where competitors are blocked by months-long model risk reviews. The pattern repeats in every regulated vertical.

The companies treating compliance as overhead are paying for infrastructure they will need anyway, getting no credit for it, and leaving market opportunity on the table. The companies treating compliance as strategy are building once and selling everywhere. [The incentive structure](/blog/the-incentive-problem/) rewards launching over maintaining, but compliance infrastructure is one of the few investments that pays off in both phases.

## What I am still figuring out

The minimum viable compliance infrastructure is not obvious. SOC 2 at $30K is a startup's entry ticket. A full regulatory framework runs into the millions for large enterprises. The right answer for a Series A company is somewhere between, and the threshold is invisible until you are past it — usually inside the incident or the lost deal that would have required it.

The AWS example is the clearest version of the moat thesis, which may also be its limitation. Government and intelligence community contracting is the most compliance-sensitive market that exists: buyers are sophisticated, requirements are explicit, and compliance is a genuine prerequisite. In commercial markets — where most companies actually compete — buyers are often less demanding. A mid-market software buyer asking "do you have SOC 2?" may not care about data lineage or model versioning at all. The moat is strongest in regulated verticals. Most startups are not in regulated verticals.

---

The founder who spent $150,000 on ISO 27001 and still could not close US enterprise deals did not fail at engineering. They failed at understanding which gate their buyers needed them to pass through.

The regulators are not asking for busywork. They are asking for the same infrastructure that makes AI work in production: audit trails, lineage tracking, model versioning, access controls. In regulated verticals, building it first determines who can bid. Everywhere else, it is still the foundation — just not the moat.
