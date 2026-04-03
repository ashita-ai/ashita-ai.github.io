---
layout: post
title: "Surviving the Wreck"
date: 2026-05-12
---

## Purpose

The blog has ~20 posts documenting AI failures. It has zero posts about what successful recovery looks like after a production AI failure. This post fills that gap. The arc needs a "what survival looks like" chapter — not prevention, not properties, but the actual mechanics of coming back from a disaster.

## Opening (~300 words)

Opendoor and Zillow both ran algorithmic homebuying. Zillow lost $881M and shut down iBuyer. Opendoor survived. The blog already covered this contrast in "The AI Pilot Graveyard" — but only as a bullet point about guardrails. This post goes deeper into Opendoor's recovery mechanics: what they did in the days and weeks after their model started mispricing, how they tightened the feedback loop, and why they're still operating.

Alternatively, use Klarna's arc: deployed AI customer service Jan 2024, 2.3M conversations in a month, expanded too far, quality dropped, rehired humans by 2025, then recalibrated. This is a full recovery cycle — over-deploy, recognize failure, pull back, rebuild with constraints.

## Section 1: The anatomy of recovery (~400 words)

Define what recovery actually requires, drawing from the blog's existing failure cases:

1. **Detection** — recognizing the failure is happening (GetOnStack didn't for 11 days; Knight Capital didn't for 45 minutes)
2. **Containment** — stopping the bleeding (Opendoor auto-tightened offers; Zillow's executives overrode the algorithm in the wrong direction)
3. **Diagnosis** — understanding root cause vs. symptoms (Unity spent months chasing metric anomalies before finding the data contract violation)
4. **Correction** — fixing the system, not just the output
5. **Institutional learning** — changing the organization so it doesn't happen again

Map each phase to a real company's experience.

## Section 2: The organizational dynamics of recovery (~400 words)

Recovery is not a technical problem. It's a political one.

- **Who gets to pull the plug?** At Zillow, executives overrode the algorithm for growth targets. At Opendoor, automated guardrails had authority independent of management. The difference: whether the kill switch requires human political will or fires automatically.
- **The blame allocation problem.** After Knight Capital, the question was whether the developer who deployed the dead code, the release process that allowed it, or the monitoring that missed it was at fault. Blame allocation determines whether the org fixes the system or fires a person.
- **The sunk cost trap.** McDonald's shut down AI drive-thru after 2 years and 100 locations. That's hard. Wendy's started with 1 location and could fail cheaply. Recovery is easier when you haven't bet the company.

Draw on "Incentives Eat Architecture" — the incentive structures that cause failures are the same ones that make recovery politically difficult.

## Section 3: Recovery as a property (~300 words)

Connect back to "Reversibility as Default." Recovery is reversibility exercised under pressure. The systems that recover are the ones that were built with reversibility as a property — not as an afterthought.

Mimir's pipeline design is an example of building for recovery at the micro level: `errgroup` task isolation (one failed LLM call doesn't cancel siblings), River's at-least-once delivery (crashed jobs restart), two-tier posting (suppress low-confidence findings rather than posting and retracting). These are recovery mechanisms for a system that expects to fail constantly — every LLM call might 429, every parse might hit an edge case. The design assumes failure and structures around it.

But add the organizational layer that "Reversibility as Default" didn't cover: reversibility is a technical property, but recovery is a sociotechnical practice. You need both the infrastructure (canary releases, kill switches, rollback mechanisms) and the organizational permission (authority to act, blame-free postmortems, budget for correction).

Close with: the blog has documented what breaks. This post documents what it takes to put it back together. The cost of recovery is always less than the cost of not recovering — but only if the system was built to allow it.

## Sources to find and verify

- Opendoor's actual guardrail mechanisms and recovery timeline (earnings calls, SEC filings, press coverage from 2021-2022)
- Klarna's AI deployment, pullback, and recalibration timeline (press coverage 2024-2025)
- Knight Capital postmortem details (SEC filing, technical analyses)
- McDonald's vs Wendy's drive-thru AI timeline and decisions
- Any academic literature on organizational recovery from technology failures
- Possibly: NTSB investigation methodology as a model for AI incident response

## Voice notes

- This is the most human post in the blog. The failures have been told through companies and systems. This one should feel like it's about the people making decisions under pressure.
- Target ~1,500 words.
- Resist the urge to make it a framework. It's a narrative with a thesis, not a taxonomy.
