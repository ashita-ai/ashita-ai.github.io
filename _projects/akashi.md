---
title: Akashi
layout: project
logo: /assets/images/akashi.png
github: https://github.com/ashita-ai/akashi
description: Version control for AI decisions. Coordinate multi-agent systems before contradictions become incidents.
---

Multi-agent systems have a coordination problem.

Agents contradict each other. They re-litigate decisions that were already made. They have no shared memory of what was settled and why. The result is drift: two agents, running independently, converging on incompatible conclusions with no record of how either got there. Akashi is the coordination layer that prevents it.

## What it does

Agents check in before deciding and record their reasoning after. Over time, that builds a tamper-evident, semantically searchable record every agent in the system can learn from.

- **Check before deciding** — query for precedents, known conflicts, and prior reasoning before committing to an approach
- **Trace after deciding** — record what you chose, why, what alternatives you considered, and how confident you are
- **Conflict detection** — semantic similarity matching flags contradictions between agents before they cause incidents
- **Integrity guarantees** — SHA-256 content hashes and Merkle proofs mean the record can't be quietly altered
- **Assessment loop** — agents mark past decisions correct or incorrect, closing the feedback loop

## The conflict detection pipeline

When a new decision arrives, Akashi embeds it, runs approximate nearest-neighbor search against prior decisions, scores claim-level overlap, validates via LLM, classifies the relationship, and pushes a notification in real time. Contradictions surface immediately.

## Three ways to run it

- **Local-lite** — SQLite-backed, starts in under three seconds, no infrastructure required
- **Complete local stack** — Docker Compose with TimescaleDB, Qdrant, and Ollama
- **Self-hosted** — bring your own PostgreSQL and Qdrant

## The architecture

Written in Go with no web framework. Multi-tenant by default, with every query scoped to an org. Bi-temporal storage so you can query decisions as they existed at any point in time. SDKs for Go, Python, and TypeScript. Native MCP server so any agent using Claude, Cursor, or Windsurf can integrate without extra tooling.

## Status

Akashi is in active development. Run it locally with Docker Compose, or connect via the MCP server directly from your editor.
