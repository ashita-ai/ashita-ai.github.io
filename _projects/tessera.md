---
title: Tessera
layout: project
logo: /assets/images/tessera.png
github: https://github.com/ashita-ai/tessera
description: Tessera coordinates breaking changes between data producers and consumers. It prevents operational disruptions by requiring consumer acknowledgment before breaking schema changes can be deployed.
---

Tessera coordinates breaking changes between data producers and consumers.

Someone upstream wants to drop a column. Downstream, three teams are using it. Without coordination, someone discovers broken pipelines at 3am. Tessera prevents that.

## What it does

Tessera is a data contract coordination platform for data warehouses:

- **Breaking change detection** to identify incompatible schema modifications
- **Consumer dependency tracking** to map which teams rely on specific contracts
- **Proposal workflow system** enabling cross-team coordination on changes
- **Multi-source import** from dbt manifests, API specifications, and schema registries

## Schema support

Works with JSON Schema, Avro, OpenAPI, and GraphQL specifications. Import existing contracts or define new ones through the web interface.

## The workflow

When a producer proposes a breaking change, Tessera identifies all dependent consumers, notifies them, and blocks the modification until those teams confirm they've migrated. No surprises.

## Status

Tessera is in active development. Built with Python and PostgreSQL, deployable via Docker.
