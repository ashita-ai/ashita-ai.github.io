---
title: Conduit
layout: project
logo: /assets/images/conduit.jpg
github: https://github.com/ashita-ai/conduit
description: LLM routing that learns which model works best for each query. Stop overpaying for simple tasks.
---

Conduit learns which LLM works best for each type of query.

A simple "what time is it in Tokyo" does not need a frontier model. Neither does "summarize this paragraph." But the cognitive overhead of deciding per-query adds up fast, so most teams default to the expensive option. [Context windows are not free](/blog/context-windows-are-not-free/), and neither is routing everything to GPT-4.

## What it does

Conduit includes 11 routing algorithms, from simple baselines to Bayesian bandits:

- **Adaptive routing** that learns from feedback
- **Multi-objective optimization** balancing quality, cost, and latency
- **Multiple strategies** including Thompson Sampling, UCB, epsilon-greedy, and more
- **Provider agnostic** across OpenAI, Anthropic, Google, and more

## How it works

Each model maintains a probability distribution of expected performance. Conduit samples from these distributions and picks the winner. After a few hundred queries, it has learned your workload patterns and routes accordingly.

## Preliminary results

On MMLU (1000 queries), Dueling Bandit achieved 93.2% quality vs 82.0% for always routing to a fixed high-quality model. On GSM8K (1319 queries), Hybrid UCB1+LinUCB hit 95.3% vs 87.0% for static routing. Learning algorithms consistently beat static model selection because no single model dominates all query types. Convergence happens within 16-30 queries.

## Status

Conduit is alpha software. The API will change. Clone the repo and install with `uv sync`.
