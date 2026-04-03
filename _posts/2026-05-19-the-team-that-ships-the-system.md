---
layout: post
title: "The Team That Ships the System"
date: 2026-05-19
category: "economics"
---

[Eight out of ten clients](/blog/the-incentive-problem/) get stuck in pilot mode. [95% of enterprise AI pilots](/blog/the-ai-pilot-graveyard/) fail to deliver measurable ROI. Innovation teams are measured on novelty. Execution teams are measured on reliability. The handoff between them is where projects die. Engineers optimize for the next job, not the current system. The failure modes are well understood. What the team that actually ships looks like is not.

## The handoff that kills

The standard organizational model for AI projects has three phases: a research team builds the model, an engineering team builds the product, and an operations team runs it. Each handoff is a boundary where accountability evaporates.

The research team succeeds when the model works in a notebook. The engineering team succeeds when the product passes QA. The operations team succeeds when uptime stays above the SLA. Nobody succeeds when the system produces value for users, because that outcome spans all three boundaries and none of the three teams owns it.

[42% of companies](/blog/the-ai-pilot-graveyard/) abandoned most of their AI initiatives in 2025, up from 17% in 2024. The handoff model is working exactly as designed. It is just not designed for production.

HBR [studied four models](/blog/the-incentive-problem/) for transitioning innovation to operations. The least effective was the "Owner's Manual" — the innovation team writes documentation and throws it over the wall. The most effective was what they called the Hive: a multidisciplinary team that owns a challenge across its entire lifecycle. Same team builds it, same team runs it, same team gets paged when it breaks. The pilot incentive disappears when there is no handoff to hide behind.

## What the hive looks like

Amazon's two-pizza teams and Google's SRE model solved this for traditional software: the team that writes the code carries the pager. AI systems need the same ownership structure but different roles, because the failure modes are different. A web service fails when the code is wrong. An AI system fails when the data drifts, the model degrades, or the world changes — failures that are invisible to the people who did not build the system.

For AI, the hive needs four roles. A data engineer who owns pipeline reliability and data quality — the [ground truth](/blog/ground-truth-as-foundation/) layer. An ML engineer who owns model lifecycle: training, evaluation, deployment, monitoring. A platform engineer who owns the deployment infrastructure: canary releases, feature flags, rollback mechanisms — the [reversibility](/blog/reversibility-as-default/) layer. And a domain expert who knows what "correct" means in this context, because no amount of technical sophistication compensates for optimizing the wrong metric.

The team is measured on production outcomes, not intermediate artifacts. Not model accuracy — revenue per decision. Not demo impressions — customer impact. Not feature velocity — system reliability. When the 3am page fires, it goes to the people who built it.

Nubank demonstrated what this looks like at scale. They [migrated their core ETL](/blog/the-build-is-not-the-hard-part/), a 6-million-line monolith. The key detail is not the tooling. It is that the same team owned the migration and the resulting system. There was no handoff from "migration team" to "operations team." The people who made the architectural decisions lived with the consequences.

## The daily practices

The hive structure enables specific practices that handoff organizations cannot sustain. Shadow deployment requires someone who understands both the model and the production environment. Automated guardrails require someone with authority to let them fire. Decision audit trails require someone who will be held accountable for what they record. In a handoff model, each of these spans a boundary. In a hive, they are one team's job.

**Shadow deployment as default.** [Uber runs shadow testing](/blog/when-ai-actually-works/) on 75% of critical online use cases. New models process real traffic alongside production, but only the current model's predictions reach users. Auto-rollback reverts to the last known good version if error rates, latency, or CPU utilization breach thresholds. [Netflix compares over 1,000 metrics](/blog/when-ai-actually-works/) during canary analysis, promoting traffic from 1% to 5% to 25% over 14 hours. This is not testing. It is continuous deployment with structural reversibility.

**Production learning over lab evaluation.** The system is the eval. Netflix runs contextual bandits that learn which recommendations work by serving them. The FDA approved [adaptive clinical trials](/blog/your-evals-wont-save-you/) that modify treatment allocation based on accumulating evidence. The teams that ship treat production as the learning environment, with guardrails, not the lab as the proving ground.

The simplest version of this is a feedback footer on every AI-generated output: "Was this helpful? React with :+1: or :-1:." Those reactions become labeled data. Thumbs-down flags a false positive. The absence of thumbs-down is not confirmation, but it is signal — a weak label, but free and continuous. This is cheap to build, requires no new infrastructure, and produces the dataset needed to validate whether confidence thresholds are calibrated correctly. The system learns from production, not from benchmarks.

**Automated guardrails with authority.** When the housing market turned in 2021, [Opendoor's guardrails auto-tightened offers](/blog/the-ai-pilot-graveyard/) without executive approval. Zillow's executives overrode their algorithm for growth targets and lost $881 million. The difference: whether the kill switch requires political will to activate. The teams that ship build guardrails that fire automatically. A guardrail is not a dashboard someone checks. It is a trigger that fires without human intervention.

**Decision audit trails.** Two Sigma paid [$90 million](/blog/the-metadata-control-plane/) because four years of model modifications happened without an audit trail. The teams that ship record every model output, every routing decision, every data transformation — `model_id`, token counts, response metadata on every AI output. When something breaks, the team reconstructs what happened from structured records, not from Slack archaeology.

**Postmortems that change systems.** Blameless postmortems are table stakes. The practice that matters: every postmortem produces a system change. A new guardrail. A new contract. A new test. Not a finding. Not an action item assigned to someone who was not in the room. A deployed change that prevents the specific failure from recurring. If the postmortem does not produce a commit, it did not work.

## Why this is hard

The hive model has organizational barriers that cannot be wished away.

**Career incentives point sideways.** Engineers on lifecycle teams do not get to claim they "built" something visible. They maintain. Maintenance is invisible. The engineer who ships a Kubernetes migration gets a conference talk. The engineer who keeps a data pipeline reliable for three years gets nothing. Resume-driven development optimizes for the next job, not the current system. Until organizations make production reliability as visible as new feature launches, lifecycle teams will be staffed with people who could not get onto the feature teams.

**Budget structures resist the model.** [60% of enterprise AI investment](/blog/the-incentive-problem/) comes from innovation budgets, which are temporary. Only 40% comes from operational budgets, which are permanent. Lifecycle teams need operational budgets. A team that builds, deploys, and maintains a system cannot be funded with innovation dollars that expire at the end of the fiscal year. The funding model has to change before the team model can.

**Scale is uncertain.** The hive model works for teams of four to eight. It does not obviously scale to organizations of thousands. What is the coordination model between hive teams?

This is where the four properties become organizational infrastructure, not just technical infrastructure. [Ground truth](/blog/ground-truth-as-foundation/) provides a shared source of facts that teams do not need to negotiate — if both teams read from the same immutable source, they do not need a meeting to agree on what the data says. [Contracts](/blog/contracts-as-infrastructure/) provide stable interfaces that teams can build against independently — if the contract holds, the upstream team can change its implementation without coordinating with every downstream consumer. [Provenance](/blog/the-provenance-imperative/) provides the audit trail that makes cross-team debugging possible — when a downstream team's model degrades, provenance tells them which upstream change caused it without filing a ticket and waiting three days.

Without these properties, scaling autonomous teams requires coordination meetings, architecture review boards, and shared standards bodies. With them, the properties do the coordinating. The teams stay autonomous.

## What I am still figuring out

Whether the hive model survives contact with enterprise reality. Amazon's two-pizza teams work because Amazon built an entire organizational culture around service ownership. Google's SRE model works because Google pays enough to attract engineers who will carry pagers voluntarily. Most organizations have neither the culture nor the compensation to make lifecycle ownership attractive. The hive model may be correct in theory and impossible to staff in practice. I have seen it work at Netflix, where the culture explicitly values operational ownership. I have not seen it work at organizations where the culture implicitly values feature launches.

Whether the properties I have described — ground truth, contracts, provenance, reversibility — actually function as coordination mechanisms between autonomous teams, or whether they just reduce the surface area of coordination failures. The difference matters. If properties are coordination mechanisms, then getting them right makes inter-team collaboration possible. If they just reduce failure surface area, then you still need something else — architecture reviews, platform teams, shared standards bodies — to make collaboration work. I suspect the answer is "both, depending on the organization," which is not a satisfying framework.

---

Eight out of ten clients stuck in pilot mode. 42% of companies abandoning most of their AI initiatives. The technology works. The handoff does not.

The teams that ship do not hand off. They own the lifecycle. They build guardrails that fire without permission and learn from production instead of benchmarks. The missing piece was never the model. It was always the org chart.
