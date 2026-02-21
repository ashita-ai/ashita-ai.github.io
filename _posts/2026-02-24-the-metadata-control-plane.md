---
layout: post
title: "The Metadata Control Plane"
date: 2026-02-24
---

In January 2025, the SEC [fined Two Sigma $90 million](https://www.sec.gov/files/litigation/admin/2025/34-102207.pdf) for failing to address security vulnerabilities in its algorithmic trading models. An employee modified live-trading models without approval for nearly two years. Some funds overperformed by $400 million. Others underperformed by $165 million.

The models worked. The governance did not.

Two Sigma's problem was not AI capability. It was the absence of a control plane: the infrastructure to track who changed what, when, with what authorization. The vulnerability was identified in March 2019. It was not addressed until August 2023. Four years of invisible modification in a system managing billions of dollars.

Every complex system that operates at scale has a control plane. TCP/IP has BGP and routing tables: the control plane decides where packets go, the data plane moves them. Kubernetes has etcd and the scheduler: the control plane decides where pods run, the data plane runs them. Power grids have SCADA: the control plane monitors load and adjusts dispatch, the data plane delivers electricity.

The control plane is what makes the data plane governable. Without it, you can operate. You cannot observe, correct, or defend what you are operating.

AI systems are being deployed without one.

## What regulators have already decided

Regulators are not waiting for the industry to sort this out. The SEC [fined 26 firms a combined $392.75 million](https://www.sec.gov/newsroom/press-releases/2024-98) in 2024 for failing to preserve electronic communications. AI outputs are communications. If you cannot prove what your agent told a client, you have a recordkeeping violation.

[FINRA's 2026 oversight report](https://www.finra.org/rules-guidance/guidance/reports/2026-finra-annual-regulatory-oversight-report/gen-ai) expects prompt and output logging, model version tracking, and human-in-the-loop oversight. OCC's model risk management framework requires comprehensive model inventories with standardized metadata. ISO 42001 codifies 38 auditable controls covering data provenance, event logging, and documentation by audience.

The question is not whether regulators will ask. It is whether you can answer.

## What a control plane actually does

A metadata control plane gives you three capabilities that governance requires: the ability to see, the ability to stop, and the ability to prove.

**See.** Lineage tracking shows where data came from, which transformations touched it, and which models consumed it. When a source system changes, you know which downstream models are affected before the incident ticket arrives. When an output looks wrong, you trace it back to the input that caused it. Without lineage, you are operating blind.

**Stop.** Classification tags enforce the boundaries your regulators assume exist. A model requesting access to PII-tagged data must satisfy the attached policies before the query executes. A query touching production tables triggers different guardrails than a query touching test tables. An AI assistant asked to clean up test data cannot touch production tables because the metadata makes the distinction visible before the action executes, not after.

**Prove.** Audit logs answer the question regulators actually ask: what did your system tell this client, on this date, using which model version, acting on whose authorization? Data contracts document what data means before it enters a model: schema, ownership, quality expectations, update frequency. Without contracts, agents consume data they do not understand and produce outputs nobody can trace.

## What happens without it

On August 1, 2012, Knight Capital [deployed a routine software update](https://www.sec.gov/newsroom/press-releases/2013-222) to participate in the NYSE's new Retail Liquidity Program. The update accidentally reactivated dormant code. In 45 minutes: 4 million erroneous trades across 154 stocks, $460 million in losses, Knight's stock down roughly 75%. The company was acquired within months.

Knight's trading system had the raw data. It had no control plane. There was no kill switch, no incident classification, no lineage to trace what the dormant code was doing. A control plane would have flagged the unvalidated code before deployment. It would have detected anomalous order volume within seconds and triggered a circuit breaker. Instead, 45 minutes of invisible operation destroyed a 17-year-old firm.

The mechanism is always the same: the system acts, the damage accumulates, and nobody knows what happened until it is too late to stop it.

## How much you actually need

The obvious objection is that this is expensive overhead. The answer depends on blast radius, not company size: what happens when your AI acts without governance?

Start there. If a classification tag fails to fire and a model queries data it should not, what is the consequence? If an audit log is missing and a regulator asks what the system told a client on a specific date, can you answer? If you cannot answer those questions, you do not know what level of control plane you need.

For most teams, the minimum is a model registry with documented ownership, classification tags on sensitive data, and audit logs for any output that reaches a customer. That is achievable in days and sufficient until the blast radius grows.

For regulated deployments, every component above needs to survive examination: lineage that a regulator can follow, access controls that a lawyer can audit, logs that answer the precise questions examiners ask. The rigor is not optional when the blast radius includes fines, liability, or patient outcomes.

The question is not whether you need metadata infrastructure. It is whether you understand your blast radius before or after your first ungovernable incident.

## What I am still figuring out

The ROI calculation for regulated industries is straightforward. For everyone else it is genuinely hard. The investment is real and front-loaded. The payoff is counterfactual: nobody knows what incidents did not happen, and nobody celebrates the production problem that a classification tag blocked at 2am on a Tuesday.

The harder question is when you cross the threshold. A startup with two engineers and one model does not need SCADA. A company with a dozen models running in production serving real customers probably does, but the transition point is invisible until you are past it. By the time you feel the need for a control plane, you are usually inside the incident that would have required one.

The companies that get this right seem to share one trait: they treat metadata infrastructure as foundational rather than retroactive. They build it before they need it, which means they build it before they can prove they need it. That is a hard organizational sell. I do not have a clean answer for how to make the case before the incident makes it for you.

---

Two Sigma's $90 million penalty was not about AI capability. It was about four years of invisible modification in a system managing billions of dollars.

The metadata layer is your AI control plane. Build it before the incident that proves you needed it.
