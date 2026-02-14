---
layout: post
title: "When AI Actually Works"
date: 2026-02-02
---

Wendy's launched their AI drive-thru in a single Columbus, Ohio restaurant in June 2023. They spent a year in that one location before expanding to four stores. Another year to reach 36. They had people camped in the dining room for thousands of hours, talking to crews and customers. By 2025, they were [planning 500 locations](https://www.restaurantdive.com/news/wendys-deploy-digital-menu-boards-drive-thru-ai-500-restaurants-2025/746977/).

McDonald's took a different path. They deployed their IBM partnership to [over 100 restaurants](https://www.restaurantbusinessonline.com/technology/mcdonalds-ending-its-drive-thru-ai-test) in two years. Viral videos showed the system adding bacon to ice cream and ordering nine sweet teas instead of one. In June 2024, they shut it down entirely.

Same technology category. Same industry. Same use case. Opposite outcomes.

The pattern in every AI success is the same: narrow scope, human oversight, automatic rollback, and the patience to learn in production rather than the lab.

## Shadow deployment

Uber [runs shadow testing](https://www.uber.com/blog/raising-the-bar-on-ml-model-deployment-safety/) on 75% of critical online use cases, with plans to reach 100%. New models process real traffic alongside production models, but only the current model's predictions reach users. If error rates, latency, or CPU utilization breach thresholds, auto-rollback reverts to the last known good version. No human intervention required.

Netflix [compares 1,000+ metrics](https://netflixtechblog.com/deploying-the-netflix-api-79b6176cc3f0) between baseline and canary code, generating a confidence score that indicates how likely the canary is to succeed in production. Their deployment strategy: 1% of traffic, then 5%, then 25%, over 14 hours. Before they built this infrastructure, going from project start to deployment took four months. Now the [median is seven days](https://valohai.com/blog/building-machine-learning-infrastructure-at-netflix/).

Stripe's fraud detection [assesses over 1,000 characteristics](https://stripe.com/guides/primer-on-machine-learning-for-fraud-protection) per transaction and makes a decision in under 100 milliseconds. Out of billions of legitimate payments, Radar incorrectly blocks just 0.1%. Their feature freshness runs at [150ms p99](https://stripe.com/blog/shepherd-how-stripe-adapted-chronon-to-scale-ml-feature-development)—nearly real-time response to changing fraud patterns.

These companies did not build better models. They built better deployment infrastructure. The model is not the product. The system that validates, monitors, and rolls back the model is the product.

## Narrow scope

The AI implementations that work are not general-purpose. They are narrow, bounded, and boring.

H&M's customer support chatbot handles [order tracking, return policies, and sizing assistance](https://www.vktr.com/ai-disruption/5-ai-case-studies-in-customer-service-and-support/)—repetitive queries that overwhelmed their human team. Response time dropped from minutes to seconds. Operational costs fell by an estimated 30%. Available 24/7 in over 30 languages.

Amazon's predictive inventory system achieved a [35% reduction in stockouts](https://superagi.com/real-world-success-stories-how-top-companies-are-optimizing-inventory-with-ai-in-2025/). Walmart's FAST Unloader increased worker productivity by 25% and reduced inventory errors by up to 90%. Mavi, a Turkish retailer, [boosted revenue 9.6%](https://www.invent.ai/case-study/mavi-case-study-how-invent-ai-inventory-optimization-solutions-helped-increase-revenue-by-9.6) with AI-powered inventory optimization across 439 stores.

IT ticketing systems see [40–60% ticket deflection](https://www.moveworks.com/us/en/resources/blog/helpdesk-ticketing-system-ai-automation) within 90 days and 25–40% faster resolution for escalated cases. The key insight: 60–70% of inbound volume is repetitive, low-complexity work that does not require human judgment. Those are the ideal candidates for automation—not the complex cases, not the edge cases, just the boring repetitive volume.

The scope determines the outcome. Broad, autonomous, general-purpose deployments fail. Narrow, supervised, specific deployments work.

## Human in the loop

A Harvard and BCG [study on consultants](https://mitsloan.mit.edu/ideas-made-to-matter/how-generative-ai-can-boost-highly-skilled-workers-productivity) using AI found a 40% productivity increase when AI was used within its capability boundary. When used outside that boundary, performance dropped by 19 percentage points.

The researchers identified two working styles: "centaurs" who divided tasks between AI and themselves, and "cyborgs" who fully integrated their workflow with AI. Both patterns succeeded when the human understood where the AI's competence ended.

Medical diagnosis platforms using [human-in-the-loop approaches](https://parseur.com/blog/human-in-the-loop-ai) achieved 97% accuracy—compared to 85% AI-only and 89% human-only. The combination outperformed both. Diagnosis time dropped 60%.

The lesson is not that AI needs babysitting. The lesson is that humans and AI have complementary failure modes. AI fails on edge cases, novel situations, and context that was not in the training data. Humans fail on attention, consistency, and volume. The combination catches what either would miss alone.

## Automatic rollback

The companies that avoid disaster are the ones that built the kill switch before they built the model.

Uber's auto-rollback [fires on three signals](https://www.uber.com/blog/raising-the-bar-on-ml-model-deployment-safety/): error rates, latency, or resource utilization breaching thresholds. No human approval required. The system reverts to the last known good version automatically.

Industrial AI implementations now require [mapped failure modes, tabletop rollback tests within 90 days, and emergency stops independent of the AI](https://xmpro.com/the-top-10-challenges-preventing-industrial-ai-at-scale-and-exactly-how-to-beat-them/). The kill switch is not optional. It is the prerequisite.

This is what separated [Opendoor from Zillow](/blog/the-ai-pilot-graveyard/). Both used AI to value homes. Opendoor's system automatically tightened offers when predicted-vs-actual spreads exceeded thresholds. No human intervention needed. Zillow's executives overrode the algorithm to hit growth targets. By the time humans noticed the market had turned, Zillow owned 7,000 homes they could not sell.

A rollback is not a dashboard someone checks. It is a trigger that fires before the damage compounds.

## What the 5% do differently

McKinsey [found](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai) that 88% of organizations now use AI in at least one business function. Only 6% qualify as "high performers" achieving significant profit impact. The gap is not technology.

High performers are [three times more likely](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai) to redesign workflows rather than just adding AI to existing processes. 55% fundamentally redesigned individual workflows, compared to 20% of other companies.

The MIT NANDA research [found](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/) that purchasing AI tools from specialized vendors succeeds 67% of the time, while internal builds succeed only one-third as often. The successful companies treated vendors like business service providers rather than software suppliers—deep customization, outcome-based evaluation, co-evolutionary development.

A [Capital One survey](https://www.capitalone.com/tech/ai/ai-readiness-survey/) of nearly 4,000 business leaders found that 73% identified data quality and completeness as the primary barrier to AI success—ranking it above model accuracy, computing costs, and talent shortages.

BCG's [10-20-70 principle](https://www.bcg.com/publications/2025/closing-the-ai-impact-gap) summarizes it: 10% algorithms, 20% data and technology, 70% people, processes, and cultural transformation. A [RAND report](https://www.rand.org/pubs/research_reports/RRA2680-1.html) found that AI projects fail at twice the rate of other IT projects, with root causes spanning miscommunication, data issues, infrastructure problems, and unrealistic expectations.

## What I am still figuring out

The Wendy's-vs-McDonald's comparison is clean, but the sample size is small. Two companies is not a pattern. The rollout speed seems to matter—Wendy's spent a year in one location, McDonald's scaled to 100—but there could be confounding factors: different vendor partnerships, different menu complexity, different customer bases.

The 67% vendor success rate versus 33% internal build rate is striking, but the causation is unclear. Do vendors succeed because they have better technology, because they bring operational discipline, or because buying a product is a forcing function that prevents scope creep?

The narrow-scope pattern is consistent, but the boundary is not obvious. How narrow is narrow enough? Customer service chatbots succeed. General-purpose assistants fail. Somewhere between is a line, and I do not have a principled way to find it.

---

Wendy's spent a year with people camping in one restaurant's dining room. McDonald's deployed to 100 locations and got bacon on ice cream.

The [AI pilot graveyard](/blog/the-ai-pilot-graveyard/) is full of projects that scaled before they were ready. The companies that work—Netflix, Uber, Stripe, Wendy's—built the infrastructure first: shadow deployment, automatic rollback, narrow scope, human oversight.

The model is not the hard part. The system that keeps the model honest is the hard part.
