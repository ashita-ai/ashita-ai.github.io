---
layout: post
title: "Data Contracts for the Age of Agentic Engineering"
date: 2026-01-07
---

I have been thinking about what happens when AI agents write data engineering code.

The short answer: things break faster.

## The coordination gap

Data teams have always struggled with schema changes. Someone upstream drops a column. Three teams downstream depend on it. Nobody knew. Pipelines fail at 3am. Incident review reveals the same root cause: we did not know who was using our data.

This problem gets worse with agents. A human engineer might ship one or two schema changes per week. An agent can ship dozens per day. The surface area for breaking changes expands accordingly.

Schema registries do not solve this. They validate that a schema is well-formed. They do not coordinate changes between producers and consumers. You can have a perfectly valid schema that breaks everyone downstream.

## Contracts as dependencies

The insight is that schema relationships are dependency relationships. If your pipeline reads `warehouse.analytics.dim_customers`, you depend on that table's schema the same way you depend on a library version.

Tessera makes these dependencies explicit. Consumers register what they use. Producers see who depends on them. When a breaking change is proposed, affected consumers are notified and must acknowledge before the change can proceed.

| Step | Actor | Action |
|------|-------|--------|
| 1 | Producer | Proposes changing `user_id` from integer to string |
| 2 | Tessera | Identifies 3 dependent teams, notifies them |
| 3 | Consumers | Update pipelines, acknowledge the change |
| 4 | Producer | Ships safely |

No surprises. No 3am pages.

## Breaking change detection

Tessera diffs schemas to detect incompatible changes. The compatibility model is configurable:

| Mode | Breaking if... |
|------|----------------|
| backward | Consumers of old schema cannot read new data |
| forward | Producers of old schema cannot write to new format |
| full | Any structural change |
| none | Just notify, do not block |

Most teams want backward compatibility: new data should work with existing consumers. Removing a field breaks backward compatibility. Adding an optional field does not.

The diffing works across schema formats. JSON Schema, Avro, OpenAPI, GraphQL. Import your existing schemas or define new ones.

## The agent future

This is where it gets interesting.

Data engineering is increasingly [agentic](https://medium.com/@sanjeebmeister/the-2026-data-engineering-roadmap-building-data-systems-for-the-agentic-ai-era-8e7064c2cf55). Agents write dbt models. Agents generate pipelines. Agents refactor schemas. The velocity is unprecedented.

As [dltHub's Adrian Brudaru observes](https://dlthub.com/), a data pipeline is a series of decisions. If one decision is wrong, your pipeline is broken. When agents make dozens of those decisions per day instead of humans making a few per week, the need for coordination infrastructure becomes acute.

But velocity without coordination is chaos. If an agent can propose schema changes, it needs to know who will be affected. If an agent consumes data, it needs to be notified when upstream schemas change. The same coordination that prevents human teams from breaking each other prevents agent teams from breaking each other.

Tessera is building toward this. The [Python SDK](https://pypi.org/project/tessera-sdk/) already supports programmatic contract management:

```python
from tessera_sdk import TesseraClient

client = TesseraClient()

# Check impact before making changes
impact = client.assets.check_impact(
    asset_id=asset.id,
    proposed_schema=new_schema
)

if not impact.safe_to_publish:
    print(f"Breaking changes: {impact.breaking_changes}")
    # Notify affected consumers, wait for acknowledgment
```

An agent that proposes schema changes can check impact first. An orchestration layer can gate deployments on consumer acknowledgment. The coordination happens programmatically, at agent speed.

## What comes next

Tessera is in active development. The core workflow is functional: publish contracts, register consumers, detect breaking changes, coordinate proposals.

The roadmap includes tighter integration with agent frameworks. If your agent writes dbt models, it should automatically check Tessera before deploying. If your agent consumes warehouse tables, it should register those dependencies. The goal is coordination as infrastructure, not coordination as afterthought.

If this problem interests you, [the repo is on GitHub](https://github.com/ashita-ai/tessera). There is also a [Python SDK](https://github.com/ashita-ai/tessera-python) for programmatic access.

## What I am still figuring out

Whether data contracts slow teams down more than they save, especially at small scale. The coordination overhead is real. For a five-person team with three data sources, Tessera might be overhead. For a fifty-person team with fifty sources, the overhead pays for itself. The breakeven point is not clear, and it likely depends on how frequently schemas change and how costly downstream breakage is.

---

*This is part of a series on the tools I am building at Ashita AI. Previously: [Engram](/blog/introducing-engram/), memory that does not lie.*
