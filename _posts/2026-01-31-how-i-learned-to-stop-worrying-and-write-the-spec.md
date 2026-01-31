---
layout: post
title: "How I Learned to Stop Worrying and Write the Spec"
date: 2026-01-31
---

Augment Code analyzed why multi-agent LLM systems fail. The [breakdown](https://www.augmentcode.com/guides/why-multi-agent-llm-systems-fail-and-how-to-fix-them): 41.77% specification problems, 36.94% coordination failures, 21.29% execution errors. Nearly 80% of failures happen before code execution begins.

The industry response has been to build better factories. Cursor, Devin, CrewAI, LangGraph—orchestration engines that coordinate agents more effectively. This addresses the 36.94%. It ignores the 41.77%. We are building [factories without design departments](/blog/the-factory-without-a-design-department/).

## The specification problem

Specification failures come in two forms: missing information and contradictory information. Missing information is obvious in hindsight—nobody specified what happens when the database is unavailable. Contradictory information is harder. It hides in plain sight.

A product manager says "all users can export data" in one meeting and "PII requires access controls" in another. Both statements feel true. Both get written down. The spec contains a contradiction that surfaces only during implementation, when an engineer asks: "Wait, can users export their own PII or not?"

This is expensive with human engineers. It is catastrophic with AI agents. The engineer asks a clarifying question. The agent picks one interpretation arbitrarily and builds confidently in the wrong direction.

The usual solution is better human discipline—more careful spec writing, more thorough reviews. But discipline does not scale. Tooling does.

## The gate

I built [Elenchus](https://github.com/evanvolgas/elenchus), an MCP server that implements one key constraint: it will not generate a specification while unresolved contradictions exist.

To be clear about what Elenchus does and does not do: Claude performs the interrogation. Claude asks the questions, extracts premises from your answers, and detects contradictions. Elenchus provides the scaffolding—it stores the premises, tracks the contradictions, and blocks spec generation until they are resolved. The intelligence is Claude's. The constraint is Elenchus's.

This is a gate, not a guide. Elenchus does not tell you what to build. It does not suggest requirements. It just refuses to proceed until your stated requirements are internally consistent. The pressure to resolve contradictions comes from wanting to get past the gate.

I tested it on [Hikari](https://github.com/evanvolgas/hikari), an LLM pipeline cost tracking tool. I fed a product spec into Elenchus and told Claude to interrogate it until the result was precise enough for single-pass implementation.

The session produced 11 questions. Here is the kind of specificity Claude demanded:

> **Q**: "What error handling and retry logic should be implemented when span ingestion fails or the database is unavailable?"
>
> **A**: "SDK-side: spans are enqueued to an in-memory bounded queue (max 10,000 spans). If the queue is full, oldest spans are dropped. The exporter sends batches with a 5-second timeout. On failure, retry up to 3 times with exponential backoff (1s, 2s, 4s). After 3 failures, drop the batch and log a warning. The SDK never raises exceptions to user code. Collector-side: if Postgres is unavailable, buffer holds spans in memory (bounded to 50,000) and retries writes every 10 seconds. Health endpoint reports degraded status when DB is unreachable."

That answer contains seven implementation decisions. Elenchus extracted each as a premise—a concrete commitment. Across 11 questions, it extracted 49 premises. Then Claude checked them for contradictions.

**Contradiction 1**: "Zero-config (one import) vs. needing user to provide pipeline_id and stage attributes."

I had said I wanted zero-config instrumentation. I had also said I wanted users to set pipeline IDs and stages. Both cannot be true by default.

Resolution: pipeline_id defaults to trace_id, stage auto-derives from the span name. Zero-config works. Overrides are optional. This was the only real contradiction—it forced a design decision I had not consciously made.

Claude flagged three other potential contradictions: SDK batch size (100) vs collector capacity (1000), SDK buffer (10,000) vs collector buffer (50,000), and an apparent redundancy between two premises about null costs. All three turned out to be non-issues once I explained the reasoning. The SDK batches per-process; the collector receives from many instances. Different contexts, different numbers.

But the process still helped. Forcing me to articulate *why* the numbers differed made that reasoning explicit in the spec. An implementer reading "SDK buffer: 10,000, Collector buffer: 50,000" might wonder if that is a mistake. The spec now explains the architectural reason.

Four flags total, one real contradiction, three clarifications. Only after I resolved them would Elenchus allow spec generation.

## The output

Once contradictions were resolved, Elenchus produced a [product specification](https://github.com/evanvolgas/hikari/blob/main/docs/spec.md). I said "go implement." Claude asked a few more clarifying questions—file structure, test patterns—then generated a 1,061-line [engineering specification](https://github.com/evanvolgas/hikari/blob/main/docs/engineering-spec.md). Not prose. Function signatures, DDL statements, API schemas, Pydantic models, test expectations. Detailed enough that "implement this" is an unambiguous instruction.

I said "implement this" and walked away. Came back hours later. Python SDK, TypeScript SDK, FastAPI collector, TimescaleDB migrations, 63 passing tests. It worked.

The impressive part is not that Claude wrote code. That is table stakes. The impressive part is that the code matches the spec. The buffer sizes I specified (10,000 SDK, 50,000 collector), the retry logic (3 retries, exponential backoff), the SQL injection prevention pattern, the version checking on provider SDKs—these specific decisions from my answers appear in the implementation. The code is not exceptional—there is some duplication in the sync/async wrappers, some boilerplate in the spec synthesizer—but it does what I said it should do.

My contribution after the spec: reviewing two minor fixes that Claude's self-review suggested. Nine lines changed. The [code](https://github.com/evanvolgas/hikari) and [extracted premises](https://github.com/evanvolgas/hikari/blob/main/docs/elenchus-spec.json) are public.

## Why the gate matters

Writing specs is hard because you must anticipate questions nobody has asked yet. You guess what an implementer will need to know. You guess wrong. The spec has gaps. The implementer fills them with assumptions. The assumptions are wrong.

Interrogation inverts this. You do not anticipate questions. You answer them. The cognitive load shifts from "what might someone need to know" to "what is the answer to this specific question." The second task is easier.

But interrogation alone is not enough. Without a gate, you can answer questions inconsistently and never notice. The gate forces reckoning. When Elenchus refuses to generate a spec because premises P1 and P2 conflict, you cannot proceed by ignoring the conflict. You must resolve it.

This is different from [my previous workflow](/blog/what-i-learned-building-four-tools-with-ai-agents/). Before, I wrote decomposed GitHub issues with explicit acceptance criteria. The agent implemented. I reviewed. Repeat. Contradictions surfaced during implementation, when fixing them was expensive.

With Elenchus, contradictions surface during interrogation, when fixing them is cheap. The spec was extracted, not authored. The architecture emerged from answers, not from upfront design.

## What I am still figuring out

The conditions were favorable. Greenfield project. Single author. Well-bounded scope—an observability SDK is a known pattern. No legacy code to integrate with, no team conventions to follow, no existing architecture to preserve. The hard parts of most software projects were absent.

And I am a domain expert. My answers to the interrogation questions were detailed because I have thought about this domain. When Claude asked about token extraction paths, I knew the answer. A non-expert giving vague answers would get a vague spec, and vague specs produce wrong code.

The interrogation took about an hour. The implementation took several hours of unattended compute. For a project this size, the economics are favorable. For a bug fix, the overhead would be absurd.

The hardest limitation: Elenchus catches contradictions between explicit statements. It cannot catch contradictions between stated requirements and unstated assumptions. If I never mentioned authentication, the spec would not include it. The tool surfaces conflicts in what you say. It cannot surface conflicts with what you forgot to say.

This is one data point. Favorable conditions, domain expertise, greenfield scope. I do not know if it generalizes.

---

Scott Logic [observed](https://blog.scottlogic.com/2025/12/15/the-specification-renaissance-skills-and-mindset-for-spec-driven-development.html) that AI coding assistants have exposed an uncomfortable truth: "many people struggle to articulate what they actually want to build." We spent decades optimizing for implementation speed while specification skills atrophied. Now implementation is cheap, and specification is the constraint.

The response should not be "get better at writing specs." It should be "build tools that extract specs from people who know what they want but cannot write it down."
