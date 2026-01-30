---
layout: post
title: "The Metadata Layer as Your AI Control Plane"
date: 2026-02-24
---

In January 2025, the SEC [fined Two Sigma $90 million](https://www.sec.gov/files/litigation/admin/2025/34-102207.pdf) for failing to address security vulnerabilities in its algorithmic trading models. An employee modified live-trading models without approval for nearly two years. Some funds overperformed by $400 million. Others underperformed by $165 million.

The models worked. The governance did not.

Two Sigma's problem was not AI capability. It was metadata infrastructure—the ability to track who changed what, when, with what authorization. The vulnerability was identified in March 2019. It was not addressed until August 2023.

[Against agentic everything](/blog/against-agentic-everything/), I argued the current wave of AI deployments is failing because governance infrastructure should have come first. This post is about what that infrastructure looks like.

## The failures that metadata would have caught

A marketing team automated their ad bidding with an AI agent. The agent had access to campaign data. It did not have access to the holiday calendar. Over a three-day weekend, it bid aggressively on inventory that would not convert. By Monday, they had burned a quarter million dollars on ads nobody would see.

A data contracts layer would have flagged the missing dependency. The agent was consuming campaign performance data without understanding that conversion rates depend on calendar context. The metadata was incomplete. The agent did not know what it did not know.

Replit's AI assistant [wiped Jason Lemkin's production database](https://fortune.com/2025/07/23/ai-coding-tool-replit-wiped-database-called-it-a-catastrophic-failure/)—1,206 executive records representing months of curation—when he asked it to clean up test data. The assistant could not distinguish production tables from test tables. No lineage tracking. No classification tags.

The pattern is consistent: agents consume data they do not understand, make decisions without context, and fail in ways that proper metadata infrastructure would have prevented.

## What the infrastructure looks like

**Data contracts.** Before data flows downstream, the contract defines what it means—schema, ownership, quality expectations. This is why I built [Tessera](/blog/introducing-tessera/). Without contracts, agents consume data they do not understand. The marketing agent needed a contract that specified: "campaign performance data requires calendar context for valid interpretation."

**Lineage tracking.** When data flows from source to transformation to model to output, the path is recorded. If a source system changes, you trace which models and dashboards break before the incident ticket arrives. If Replit had lineage, the AI assistant would have known which tables were production dependencies.

**Classification tags.** PII, MNPI, production, test—tags that trigger access controls automatically. A model requesting access to PII-tagged data must satisfy the attached policies. A query touching production tables triggers different guardrails than a query touching test tables.

**Audit logs.** Every query, every model inference, every agent action logged with timestamp, user, and context. When the regulator asks "what did your system tell this client on this date," you can answer.

## What regulators already require

In August 2024, the SEC [fined 26 firms a combined $392.75 million](https://www.sec.gov/newsroom/press-releases/2024-98) for failing to preserve electronic communications. AI outputs are communications. If you cannot prove what your agent told a client, you have a recordkeeping violation.

[FINRA's 2026 report](https://www.finra.org/rules-guidance/guidance/reports/2026-finra-annual-regulatory-oversight-report/gen-ai) expects prompt and output logging, tracking which model version produced which output, and human-in-the-loop oversight. OCC's model risk management framework requires comprehensive model inventories with standardized metadata—approval takes 9-12 months at most U.S. financial institutions.

The pattern: you need to know what data you have, where it came from, who can access it, what AI systems consume it, and what those systems output. Without that, you cannot demonstrate compliance.

## The counterargument

The obvious objection: expensive overhead that slows teams down.

For startups without regulatory requirements, the calculus is different. You do not need enterprise tooling. You need a spreadsheet tracking your models and their training data, ownership documented somewhere findable, and a plan for when you scale into regulated verticals.

But if AI decisions affect people's money, health, or rights—the infrastructure is not optional. The regulators will ask. The auditors will ask. You will either have answers or you will have penalties.

## What I am still figuring out

The economics of metadata infrastructure are clear for regulated industries. The ROI calculation for everyone else is murkier.

The companies that invested in data contracts early report significant error reduction. But the investment is front-loaded and the payoff is invisible. Nobody celebrates the production incident that did not happen.

The question I keep returning to: what is the minimum viable metadata layer? A full data catalog is overkill for a seed-stage startup. A spreadsheet is insufficient for a company with 50 data sources and 10 AI applications. Somewhere in between is the right answer, and it probably looks different for every organization.

[The decisions you make about data quality](/blog/the-data-platform-decisions-that-haunt-you/) in year one determine whether your AI works in year three. I am increasingly convinced the same is true for metadata.

---

Two Sigma's $90 million penalty was not about AI capability. It was about the inability to track who changed what, when, with what authorization.

The metadata layer is your AI control plane. [40% of agentic AI projects will be cancelled](/blog/against-agentic-everything/) by 2027 due to unclear business value and inadequate risk controls. The companies that survive will be the ones that built the infrastructure first.

The governance cannot come later.
