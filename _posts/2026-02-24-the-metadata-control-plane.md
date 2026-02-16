---
layout: post
title: "The Metadata Layer as Your AI Control Plane"
date: 2026-02-24
---

In January 2025, the SEC [fined Two Sigma $90 million](https://www.sec.gov/files/litigation/admin/2025/34-102207.pdf) for failing to address security vulnerabilities in its algorithmic trading models. An employee modified live-trading models without approval for nearly two years. Some funds overperformed by $400 million. Others underperformed by $165 million.

The models worked. The governance did not.

Two Sigma's problem was not AI capability. It was metadata infrastructure: the ability to track who changed what, when, with what authorization. The vulnerability was identified in March 2019. It was not addressed until August 2023.

The root cause is always the same: the inability to track what a system did, why it did it, and who authorized it. Metadata infrastructure is not an optimization. It is the prerequisite for any AI system that makes decisions affecting money, health, or trust.

## What regulators already require

In August 2024, the SEC [fined 26 firms a combined $392.75 million](https://www.sec.gov/newsroom/press-releases/2024-98) for failing to preserve electronic communications. AI outputs are communications. If you cannot prove what your agent told a client, you have a recordkeeping violation.

[FINRA's 2026 report](https://www.finra.org/rules-guidance/guidance/reports/2026-finra-annual-regulatory-oversight-report/gen-ai) expects prompt and output logging, tracking which model version produced which output, and human-in-the-loop oversight. OCC's model risk management framework requires comprehensive model inventories with standardized metadata. Approval takes 9-12 months at most U.S. financial institutions.

ISO 42001 codifies these requirements into 38 auditable controls: data provenance, event logging, documentation by audience. Without that infrastructure, you cannot demonstrate compliance.

## What that translates to

Four infrastructure components map directly to these requirements.

**Data contracts** satisfy OCC's model inventory requirements. Before data flows into a model, the contract defines what it means: schema, ownership, quality expectations, update frequency. Without contracts, agents consume data they do not understand and produce outputs nobody can trace.

**Lineage tracking** satisfies FINRA's expectation that you can identify which model version produced which output. When data flows from source to transformation to model to output, the path is recorded. If a source system changes, you trace which models break before the incident ticket arrives.

**Classification tags** enforce access controls that regulators assume exist. PII, MNPI, production, test. A model requesting access to PII-tagged data must satisfy the attached policies. A query touching production tables triggers different guardrails than a query touching test tables.

**Audit logs** satisfy SEC recordkeeping requirements. Every query, every model inference, every agent action logged with timestamp, user, and context. When the regulator asks "what did your system tell this client on this date," you can answer.

## What happens without it

On August 1, 2012, Knight Capital [deployed a routine software update](https://www.sec.gov/newsroom/press-releases/2013-222) to participate in the NYSE's new Retail Liquidity Program. The update accidentally reactivated dormant code. Knight had no kill switch, no documented incident response procedures, no way to trace what the system was doing. In 45 minutes, the algorithm executed 4 million erroneous trades across 154 stocks. Loss: $460 million. Knight's stock dropped 70%. The company was acquired within months.

Knight's trading system had the raw data. It lacked the context to interpret it: no incident classification, no circuit breakers, no lineage to trace cascading failures. A metadata layer would have flagged the dormant code as unvalidated and blocked its deployment to production.

When Replit's AI assistant [wiped a production database](/blog/the-hollow-codebase/) after being asked to clean up test data, the root cause was metadata: the assistant could not distinguish production tables from test tables. No lineage tracking. No classification tags.

## The minimum viable layer

The obvious objection: this is expensive overhead that slows teams down. The answer depends on what your AI touches.

A seed-stage startup building internal tools needs a spreadsheet tracking its models and their training data, ownership documented somewhere findable, and a plan for when it scales into regulated verticals.

A company with 50 data sources and 10 AI applications needs more: lineage tracking for critical paths, classification tags on sensitive data, and audit logs for any AI output that reaches a customer.

A financial services firm deploying AI that touches client assets needs everything described above, with the rigor to withstand regulatory examination. There is no shortcut.

The question is not whether you need metadata infrastructure. It is how much. The companies that get this wrong in year one spend year three discovering their AI systems are ungovernable.

## What I am still figuring out

The economics of metadata infrastructure are clear for regulated industries. The ROI calculation for everyone else is murkier. The investment is front-loaded and the payoff is invisible. Nobody celebrates the production incident that did not happen.

The decisions you make about data quality in year one determine whether your AI works in year three. I am increasingly convinced the same is true for metadata.

---

Two Sigma's $90 million penalty was not about AI capability. It was about the inability to track who changed what, when, with what authorization.

The metadata layer is your AI control plane. The companies deploying AI without it are building systems they cannot audit, cannot debug, and cannot defend to regulators. The companies that survive will be the ones that built the infrastructure first.
