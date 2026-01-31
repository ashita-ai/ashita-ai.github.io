---
layout: post
title: "How I Learned to Stop Worrying and Write the Spec"
date: 2026-01-31
---

I answered questions for an hour. Then I said "implement this" and walked away. I came back to a working library: Python SDK, TypeScript SDK, FastAPI collector, TimescaleDB migrations, 63 passing tests.

The spec was extracted, not authored. The architecture emerged from answers, not from upfront design.

## The experiment

I wanted to build [Hikari](https://github.com/evanvolgas/hikari), an LLM pipeline cost tracking tool. Instead of writing a spec, I built a tool that would interrogate me until the spec was obvious.

[Elenchus](https://github.com/evanvolgas/elenchus) is an MCP server with one constraint: it will not generate a specification while unresolved contradictions exist. Claude performs the interrogation—asking questions, extracting premises from my answers, detecting contradictions. Elenchus stores that data and blocks progress until I resolve the conflicts. The intelligence is Claude's. The constraint is Elenchus's.

Eleven questions. Forty-nine premises extracted. Four potential contradictions flagged. One was real:

> "Zero-config (one import) vs. needing user to provide pipeline_id and stage attributes."

I had said I wanted zero-config instrumentation. I had also said I wanted users to set pipeline IDs. Both cannot be true by default. Resolution: pipeline_id defaults to trace_id, stage auto-derives from the span name. Zero-config works. Overrides are optional.

That design decision was hiding in my head. The interrogation surfaced it.

The other three flags—SDK buffer size vs collector buffer size, batch sizes that looked mismatched—turned out to be non-issues. But explaining *why* they were non-issues made the reasoning explicit in the spec. An implementer reading "SDK buffer: 10,000, Collector buffer: 50,000" might wonder if that is a mistake. Now the spec explains: the SDK buffers per-process; the collector receives from many instances.

Once contradictions were resolved, Claude generated a 1,061-line [engineering specification](https://github.com/evanvolgas/hikari/blob/main/docs/engineering-spec.md). Not prose. Function signatures, DDL statements, API schemas, Pydantic models, test expectations. I said "implement this" and left.

The code matches the spec. The buffer sizes I specified (10,000 SDK, 50,000 collector), the retry logic (3 retries, exponential backoff), the SQL injection prevention pattern, the version checking on provider SDKs—these specific decisions from my answers appear in the implementation.

My contribution after the spec: nine lines changed. Two minor fixes that Claude's self-review suggested.

## Why it worked

Writing specs is hard because you must anticipate questions nobody has asked yet. You guess what an implementer will need to know. You guess wrong. The implementer fills gaps with assumptions. The assumptions are wrong.

Interrogation inverts this. You do not anticipate. You answer. The cognitive load shifts from "what might someone need to know" to "what is the answer to this specific question."

But interrogation alone is not enough. Without a gate, you can answer questions inconsistently and never notice. The gate forces reckoning. You cannot proceed by ignoring the conflict. You must resolve it.

Contradictions surface during interrogation, when fixing them is cheap—not during implementation, when fixing them is expensive.

## The caveats

The conditions were favorable. Greenfield project. Single author. Well-bounded scope—an observability SDK is a known pattern. No legacy code, no team conventions, no existing architecture. The hard parts of most software projects were absent.

And I am a domain expert. My answers were detailed because I have thought about this domain. When Claude asked about token extraction paths, I knew the answer. A non-expert giving vague answers would get a vague spec, and vague specs produce wrong code.

Elenchus catches contradictions between explicit statements. It cannot catch contradictions between stated requirements and unstated assumptions. If I never mentioned authentication, the spec would not include it. The tool surfaces conflicts in what you say. It cannot surface conflicts with what you forgot to say.

This is one data point. I do not know if it generalizes.

---

[Augment Code found](https://www.augmentcode.com/guides/why-multi-agent-llm-systems-fail-and-how-to-fix-them) that 41.77% of agent failures are specification problems. Another 36.94% are coordination failures. The industry builds better orchestration engines—Cursor, Devin, CrewAI, LangGraph. This addresses the 36.94%. It ignores the 41.77%. We are building [factories without design departments](/blog/the-factory-without-a-design-department/).

The response should not be "get better at writing specs." It should be "build tools that extract specs from people who know what they want but cannot write it down."

The [code](https://github.com/evanvolgas/hikari) and [extracted premises](https://github.com/evanvolgas/hikari/blob/main/docs/elenchus-spec.json) are public.
