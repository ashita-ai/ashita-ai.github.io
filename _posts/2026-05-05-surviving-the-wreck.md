---
layout: post
title: "Surviving the Wreck"
date: 2026-05-05
category: "architecture"
---

On August 1, 2012, Knight Capital deployed a routine software update to participate in the NYSE's new Retail Liquidity Program. The update accidentally reactivated dormant code on one of eight servers. In forty-five minutes: 4 million erroneous trades across 154 stocks, $460 million in losses, Knight's stock down roughly 75%. The company was acquired within months.

Knight Capital did not survive. But the interesting question is not why it died. It is what it would have needed to live.

Zillow exited the iBuying market. Unity spent months tracing an invisible data corruption. GetOnStack lost $47,000 to an undetected feedback loop. McDonald's shut down its AI drive-thru after 100 locations and three years. The postmortems are thorough. What they do not cover is what happened next — the recovery or the absence of one.

## The anatomy

Recovery has five phases. Most organizations stall at the first.

**Detection** is where Knight Capital died. The erroneous code ran for forty-five minutes before anyone understood what was happening. The SEC investigation found no automated controls to prevent the execution of the dormant code and no system to detect the anomaly in real time. [GetOnStack's agents](/blog/healthy-metrics-broken-agent/) burned money in conversation with themselves for eleven days before anyone noticed. Revenue per conversation, response latency, user satisfaction scores — all nominal. The system that was supposed to detect failure was measuring the wrong things.

Detection fails when monitoring measures operations instead of outcomes. The instruments were pointed at the engine, not the road.

**Containment** is where [Zillow died](/blog/the-ai-pilot-graveyard/). When the housing market turned, Opendoor's automated guardrails tightened offers without human intervention. Zillow's executives overrode their algorithm for growth targets until the company owned 7,000 homes it could not sell. The containment question was not technical — both systems could detect the market shift. It was political: the people with authority to contain were the same people whose incentives pointed toward expansion.

The kill switch that requires courage is not a kill switch.

**Diagnosis** is where [Unity spent months](/blog/contracts-as-infrastructure/). Corrupted data from a single client degraded ad-targeting silently, accumulating $110 million in losses before anyone traced the problem to a contract violation at the pipeline boundary. Without lineage, without [provenance](/blog/the-provenance-imperative/) on the inputs, diagnosis became archaeology. Every hour of forensic reconstruction is an hour the broken system continues running.

**Correction** is where Klarna found its footing. They deployed an AI assistant for customer service in early 2024. Within a month it handled [2.3 million conversations](/blog/against-agentic-everything/), two-thirds of all customer chats. Then they expanded scope, cut staff by 40%, and let AI handle increasingly complex queries. Quality dropped. Complaints rose. By 2025, CEO Sebastian Siemiatkowski acknowledged they had gone too far and began rehiring human agents.

What makes Klarna instructive is not the failure. It is that they corrected. They did not double down. They did not spin the pullback as a strategic pivot. They admitted the scope was wrong, narrowed it, and rebuilt with tighter constraints. The initial deployment worked because it was narrow: routine inquiries with clear escalation paths. The correction restored that narrowness.

Correction is the hardest phase because it requires a public admission that the previous decision was wrong. Detection is technical. Containment is operational. Correction is political. The CEO who expanded scope has to be the same CEO who contracts it. Most organizations cannot do this, which is why most corrections are disguised as "strategic pivots" or "phase two" rather than acknowledged as reversals.

**Institutional learning** is where McDonald's and Wendy's diverge. McDonald's partnered with IBM for AI drive-thru ordering. Wendy's partnered with Google Cloud. McDonald's [reached 100 locations](/blog/the-ai-pilot-graveyard/) in three years, then shut it down in June 2024. Wendy's started with one location in Columbus, Ohio. After a year of observation, they expanded to 36. Then planned 500. Same domain: AI drive-thru ordering. Different learning architecture. McDonald's scaled first and tried to learn in production at 100 locations. Wendy's learned in production at one location and scaled what worked.

The institutional lesson is not "go slow." It is: make the learning loop tight enough that failure at small scale produces knowledge rather than wreckage.

## The politics of recovery

The five phases describe what recovery requires. The reason most organizations fail at it is not technical. It is political.

**Who gets to pull the plug?** The people making decisions are optimized for different outcomes than the people bearing consequences. Recovery requires someone with both the authority and the incentive to act. When those two live in different people, recovery stalls.

**The blame allocation problem.** The SEC fined Knight Capital $12 million — a systemic penalty for a systemic failure. But inside organizations, blame allocation determines whether the response is structural (fix the release process, fix the monitoring) or personal (fire someone and call it solved). Personal blame is cheaper and faster. It also guarantees the next failure.

**The sunk cost trap.** McDonald's shut down their AI drive-thru after 100 locations. That decision required writing off years of investment and admitting publicly that the bet did not work. Wendy's could fail cheaply because they had not bet on any single location. The organizations that recover are the ones that structure their bets to be recoverable. The longer a pilot runs without producing measurable value, the harder it becomes to kill — sunk cost psychology takes over, and continuation becomes the default regardless of results.

## Recovery as practice

[Reversibility](/blog/reversibility-as-default/) is a technical property: the system can be rolled back. Recovery is a sociotechnical practice: the organization will roll it back. The gap between "can" and "will" is where most failures live. Knight Capital had no rollback mechanism. Zillow had one but the executives overrode it. The infrastructure without the permission is a kill switch behind glass that nobody is allowed to break.

Recovery as practice means three things. Authority to act without approval chains — the on-call engineer can revert without a VP signing off. Outcome metrics that detect failure before it compounds — measuring what the system produces, not just whether it is running. And budget structures that treat rollbacks as operational hygiene, not as waste to be justified.

The organizations that survive do not build systems that will not fail. They build systems that can fail and come back.

## What I am still figuring out

Whether recovery architecture and speed are fundamentally in tension. Opendoor's automated guardrails worked because the system could tighten offers without human approval. But automated recovery can itself be wrong — an overly aggressive circuit breaker kills a healthy system. The guardrail that fires without human intervention is also the guardrail that fires without human judgment. I do not have a clean framework for when automated recovery is better than human-mediated recovery. The answer is probably "for containment, always automate; for correction, sometimes involve humans." But the boundary between the two is not obvious.

Whether the five-phase model I described (detection, containment, diagnosis, correction, institutional learning) is actually sequential or whether the phases overlap and interfere with each other. In the Knight Capital case, the forty-five-minute timeline compressed all phases into minutes — there was no time for sequential anything. In the Klarna case, correction happened over months while diagnosis was still ongoing. The phases may be more useful as a checklist than as a sequence, and I am not sure the distinction matters in practice.

---

Knight Capital had forty-five minutes. The code ran. The trades executed. The money was gone. Opendoor had months. The market turned. The guardrails fired. The offers tightened. Same category of failure — an algorithm producing bad outputs at scale. Different recovery architecture. One company was acquired for scraps. The other is still operating.

The cost of recovery infrastructure is always less than the cost of the disaster it prevents. But recovery is only possible if the system was built to allow it.
