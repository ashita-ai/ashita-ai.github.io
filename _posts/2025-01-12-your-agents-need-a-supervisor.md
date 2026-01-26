---
layout: post
title: "Your Agents Don't Need to Be Smarter. They Need a Supervisor."
date: 2025-01-12
---

Multi-agent LLM systems fail at rates between [41% and 87%](https://www.augmentcode.com/guides/why-multi-agent-llm-systems-fail-and-how-to-fix-them) in production. ChatDev, one of the more hyped multi-agent coding frameworks, achieves [25% correctness](https://arxiv.org/html/2503.13657v1) with GPT-4o.

The failures are not usually hallucinations. They are cascades. One agent makes a small mistake, the next agent accepts it, and by the fourth step the output is confidently wrong in ways that are hard to trace.

This is not a model problem. It is an architecture problem.

## The cascade math

A [December 2025 study](https://arxiv.org/html/2512.08296v1) on scaling agent systems measured error propagation across architectures. Independent agents amplify errors 17.2x. Centralized coordination contains this to 4.4x.

The difference is not the model. It is whether something validates the output before passing it downstream.

The mechanism is simple. Humans push back on bad inputs. LLMs do not. A [research paper on governed LLM systems](https://arxiv.org/abs/2508.05687) explains: "This seed error triggers a cascade when an erroneous output is passed to other agents in the network." Downstream agents accept flawed input uncritically rather than performing sanity checks.

## Where failures come from

A [UC Berkeley analysis](https://arxiv.org/html/2503.13657v1) of five multi-agent frameworks found 14 distinct failure modes clustered into three categories: system design issues, inter-agent misalignment, and task verification failures.

**System design issues**: Agents do not know what they are supposed to do. Role ambiguity, unclear task boundaries, missing constraints. The agent is not failing. It was never told what success looks like.

**Inter-agent misalignment**: Agents cannot work together. Conversation resets, ignored peer input, reasoning-action mismatches. Individually capable, collectively incoherent.

**Task verification failures**: Premature termination, incomplete checks, incorrect validation.

The study found no single category disproportionately dominates. Failures are diverse, which makes them harder to fix with any single intervention.

## Monoculture collapse

When you deploy five agents all running variations of the same foundation model, they share blind spots. They make the same mistakes. Worse, they reinforce each other through what researchers call conformity bias (agreeing with flawed reasoning because it sounds plausible).

Human teams catch errors through diversity of perspective. Agent teams built on monoculture collapse together.

This is why validation needs to happen at the orchestration layer. You cannot trust agents to catch each other's errors if they share the same failure modes.

## What actually works

The frameworks getting this right treat failure as a design constraint, not an edge case.

**Idempotent tool calls.** If an agent retries an action, it should not duplicate the side effect. Use [idempotency keys](https://composio.dev/blog/outgrowing-make-zapier-n8n-ai-agents), bounded retries, and dead letter queues for failed operations. If you skip this, you end up with duplicate transactions.

**Compensating transactions.** An HTTP request cannot be un-sent via filesystem snapshot. Production systems need explicit compensation logic (the [Saga pattern](https://www.vldb.org/pvldb/vol18/p4874-chang.pdf)) where every action has a defined rollback.

**Validation bottlenecks.** [Centralized architectures](https://arxiv.org/html/2512.08296v1) reduce logical contradictions by 36% and context omissions by 67%. The orchestrator validates before passing downstream. This feels like a performance problem. It is actually a reliability guarantee.

**Checkpointing.** When step 7 of 10 fails, you should not restart from step 1. Durable execution frameworks provide state persistence that survives process crashes, with event-sourced replay for recovery. Most agent frameworks run in-memory and lose everything on failure.

## The human escape hatch

The deployments that work in production share a pattern: narrow scope, heavy supervision.

Replit learned the hard way when their AI agent [wiped a company's production database](https://venturebeat.com/orchestration/even-google-and-replit-struggle-to-deploy-ai-agents-reliably-heres-why/) during a coding session. Their CEO's response: isolate development from production, add human checkpoints.

The [COWPILOT framework](https://arxiv.org/html/2505.00753v4) formalizes this as "Suggest-then-Execute." The agent proposes. The human approves. Then the agent executes. It is slower. It is also the only pattern that consistently works for high-stakes workflows.

## The uncomfortable tradeoff

The coordination overhead is not free. The [scaling study](https://arxiv.org/html/2512.08296v1) found hybrid architectures impose up to 515% overhead. Centralized coordination adds 285%. That is not a typo.

Worse: when single-agent baseline performance exceeds roughly 45% accuracy, adding more agents yields diminishing or negative returns. The overhead of coordination outweighs the benefit of specialization.

This suggests multi-agent systems are only worth the complexity for tasks that genuinely decompose into parallel, independent subtasks. For sequential reasoning chains, a single well-prompted agent with good tooling might outperform a fleet of specialists.

I am still working through when the complexity is justified. The answer is not "always" and it is not "never." It depends on the task structure in ways that are not yet well characterized.

---

The gap between demo and production is not model capability. It is orchestration maturity.

Agents need supervisors, checkpoints, rollback logic, and validation layers. They need to fail partially without failing completely. They need architecture that assumes errors will happen and contains the blast radius when they do.

The 17x versus 4x number is the one I keep coming back to. Same agents. Same models. Different architecture. Four times less error propagation.

That is the difference between a system that works and a system that looks like it works.
