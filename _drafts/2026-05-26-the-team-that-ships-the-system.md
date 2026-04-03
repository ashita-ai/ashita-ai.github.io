---
layout: post
title: "The Team That Ships the System"
date: 2026-05-26
---

## Purpose

"Incentives Eat Architecture" diagnosed the organizational failure mode. "The Age of Anxiety" documented the human cost. Neither post described what a team that actually succeeds at shipping AI to production looks like. This post fills that gap: the org design, the incentive structure, the practices.

## Opening (~300 words)

Start with the handoff problem. The blog has documented it repeatedly: pilot team builds, operations team maintains, handoff kills the project. HBR's four handoff models, the "Owner's Manual" being least effective. PwC's finding that 80% of clients are stuck in pilot mode.

But some teams don't have this problem. They don't have it because they eliminated the handoff. Open with a concrete example of a team that owns the full lifecycle — build, deploy, operate, get paged.

Candidates:
- Nubank's AI-assisted migration team (Devin + engineers, 6M line monolith, same team built and operated)
- Netflix's experimentation platform team (builds the A/B testing infra and runs the experiments)
- Stripe's fraud team (builds Radar, operates Radar, measured on fraud rates not feature velocity)

## Section 1: The hive model (~400 words)

From "Incentives Eat Architecture": the hive model — multidisciplinary team owns the challenge, not the handoff. Expand this into a concrete description:

- **Composition.** What roles are on this team? Not "data scientist + engineer + PM" generically — what specific skills does a team need to ship an AI system to production and keep it there? Data engineer (pipeline reliability), ML engineer (model lifecycle), platform/infra (deployment, monitoring), domain expert (knows what "correct" means in this context).
- **Incentive alignment.** The team is measured on production outcomes, not pilot metrics. Revenue per decision, not model accuracy. Customer impact, not demo impressions. The pilot incentive (novelty, speed) is structurally eliminated because the same team lives with the consequences.
- **Ownership scope.** The team owns the data quality, the model, the deployment, the monitoring, and the incident response. No handoff points. When the 3am page fires, it goes to the people who built it.

## Section 2: The practices that matter (~400 words)

What do these teams actually do differently day-to-day?

- **Shadow deployment as default.** From "When AI Actually Works" — Uber shadows 75% of critical use cases. The team runs every model change in shadow before promoting. This is reversibility as daily practice.
- **Production learning over lab testing.** From "Your Evals Won't Save You" — the system is the eval. Netflix runs bandits. FDA approved adaptive trials. The team treats production as the test environment (with guardrails), not the lab.
- **Automated guardrails with authority.** From "The AI Pilot Graveyard" — Opendoor's guardrails auto-tightened without executive approval. The team builds kill switches that don't require political will to activate.
- **Decision audit trails.** From "The Metadata Control Plane" — every model output, every routing decision, every data transformation is traced. Mimir stores model_id, token counts, and metadata on every finding; Akashi traces every non-trivial agent decision with confidence scores and alternatives considered. When something breaks, the team can reconstruct what happened without forensic archaeology.
- **Postmortems that change systems, not blame people.** Blameless postmortems are table stakes. The practice that matters: every postmortem produces a system change (new guardrail, new contract, new test), not just a finding.

## Section 3: Why this is hard (~300 words)

Acknowledge the organizational barriers honestly:

- **Career incentives.** Engineers on lifecycle teams don't get to claim they "built" something shiny. They maintain. Maintenance is invisible. The blog's own "Attention Economy of Engineering" post diagnosed this: resume-driven development optimizes for the next job, not the current system.
- **Budget structure.** From "Incentives Eat Architecture" — 60% of AI spend comes from innovation budgets. Lifecycle teams need operational budgets. The funding model has to change before the team model can.
- **Scale.** This model works for teams of 4-8. It doesn't obviously scale to organizations of thousands. What's the coordination model between hive teams? How do properties (ground truth, contracts) serve as the interfaces between teams?

Close with: the properties survive because infrastructure survives. But infrastructure doesn't build itself. Someone has to ship it, run it, and stay accountable for it. That's not a technology problem. It's a team design problem.

## Sources to find and verify

- Nubank's Devin deployment details (blog posts, press coverage, engineering talks)
- Netflix experimentation platform team structure (Netflix tech blog posts)
- Stripe Radar team organization (if publicly available)
- HBR handoff models research (find the specific article cited in "Incentives Eat Architecture")
- PwC George Korizis quote on pilot purgatory (verify source)
- Google SRE model as precedent for "you build it, you run it" (SRE book, public talks)
- Amazon two-pizza team model as organizational precedent
- Any research on team structures that successfully ship ML to production (Google's ML reliability papers, Meta's production ML papers)

## Voice notes

- This should feel prescriptive without being preachy. The reader knows the problems; they need the shape of the solution.
- Draw heavily from existing blog posts — this is a synthesis post, connecting threads that are already there.
- Target ~1,500 words.
- Avoid making it sound like a consulting framework. Concrete examples over abstract models.
