---
layout: post
title: "What I Learned Building Four Tools With AI Agents"
date: 2026-01-28
---

Over the past year, I built four open-source tools almost entirely with AI coding agents: [Engram](https://github.com/ashita-ai/engram) (a memory system for AI applications that preserves ground truth and tracks confidence), [Tessera](https://github.com/ashita-ai/tessera) (data contract coordination for warehouses), [Conduit](https://github.com/ashita-ai/conduit) (ML-powered LLM routing using contextual bandits), and [Arbiter](https://github.com/ashita-ai/arbiter) (a provider-agnostic LLM evaluation framework). Combined: 1,016 commits, tens of thousands of lines of code.

This is what I learned about designing systems that agents can actually build.

## The Workflow

Every project started the same way.

**Step 1: Write the CLAUDE.md file.** Before any code, I wrote an agent constitution. What the project is. What the agent's role is. What it should always do, what it should ask about first, and what it should never do. This file became the project's source of truth.

**Step 2: Create GitHub Issues for coordination.** I used issues as durable state. Each issue had clear acceptance criteria with checkboxes. Labels routed work: `focus:core-functionality`, `phase-1-foundation`, `priority:high`. The agent could not close an issue until every checkbox was checked.

**Step 3: Let the agent build.** I would point the agent at an issue, it would work, open a PR, and I would review. Repeat.

The workflow sounds simple. Getting it to work required learning some lessons the hard way.

## The Eight Lessons

### 1. Design for Deletion

Across the four projects, 20-30% of agent-written code was eventually removed. Not because it was wrong—because it was unnecessary. The agent builds what you ask for, including scaffolding you did not need, abstractions that never got reused, and edge case handling for cases that never happened.

**Implication:** Small, deletable modules beat monoliths. When you delete agent code, you want to delete a file, not untangle a dependency graph.

### 2. Security Cannot Be Retrofitted

In all four projects, security improvements came late. Path traversal protection, input validation, authentication hardening—these arrived in the final 20% of commits. The pattern was consistent: build functionality first, realize it is exposed, add protection.

This was my fault, not the agent's. I did not specify security requirements upfront. The agent built exactly what I asked for.

**Implication:** Security constraints belong in the CLAUDE.md file and the first issues, not the last ones.

### 3. Documentation Describes Intent, Not Reality

Agent-written documentation is aspirational. It describes what the code should do, not what it actually does. I found README sections for features that were half-implemented, API docs for endpoints that had drifted, architecture diagrams that no longer matched the code.

**Implication:** Treat agent documentation as a first draft. Verify claims against the implementation before publishing.

### 4. Validation Comes Last (It Should Come First)

The same pattern in every repo: core logic first, then features, then validation and error handling at the end. This meant the happy path worked for weeks before edge cases got attention.

**Implication:** Write issues that require validation as part of acceptance criteria, not as follow-up work.

### 5. Modules Do Not Emerge Naturally

Agents do not refactor toward better abstractions on their own. They add code where you point them. If you do not explicitly create module boundaries, you get files that grow until they are unmaintainable. One Conduit file hit 800 lines before I noticed.

**Implication:** Create the module structure yourself. Tell the agent where new code belongs.

### 6. Decomposition Is the Specification

The quality of agent output is directly proportional to how well you decompose the work. Vague issues produce vague code. "Implement authentication" gets you something. "Implement JWT token generation with refresh tokens, 15-minute access token expiry, 7-day refresh token expiry, and token rotation on refresh" gets you what you want.

**Implication:** Spend more time writing issues than you think you need to. The issue *is* the spec. This is [the design department problem](/blog/the-factory-without-a-design-department/) at the individual practitioner level.

### 7. Labels Route the Agent

I started with three labels. By the end, I had a taxonomy: `focus:` for domain, `phase-` for project stage, `priority:` for urgency. The labels were not just for organization. They gave the agent context about what kind of work this was.

**Implication:** Design your label system deliberately. Labels are hints to the agent about how to approach the work.

### 8. State Lives in GitHub, Not Agent Memory

Agents forget. Context windows fill up. Sessions end. GitHub Issues persist. Every decision, every requirement, every acceptance criterion went into an issue. When I resumed work after a break, the agent could read the issues and pick up where we left off.

**Implication:** Write issues as if explaining to a new team member. Because the agent is always a new team member.

## What I Would Do Differently

**Enforce PR size limits.** Some PRs bundled multiple issues for convenience. The convenience of bundling made review more difficult. Smaller PRs are easier to understand, review, and revert.

**Require security review earlier.** Not as a final check, but as a gate on the first PR that touches user input, file systems, or network boundaries.

**Add explicit validation checkboxes.** Every issue should include "validates inputs" and "handles error cases" as acceptance criteria, not implied expectations.

**Define module structure upfront.** Before writing any code, sketch the folder structure and tell the agent where each type of code belongs.

## The CLAUDE.md Template

Every project started from the same skeleton: a one-line description, a role statement, a design philosophy, and three tiers of boundaries (Always Do, Ask First, Never Do). The [early versions](https://github.com/ashita-ai/engram/blob/main/CLAUDE.md) were compact:

```markdown
# [Project] Agent Guide

**What is [Project]**: [One sentence]
**Your Role**: [One sentence]
**Design Philosophy**: [3-5 words]

## Boundaries

### Always Do (No Permission Needed)
- Write complete, production-grade code
- Add tests for all new features
- Use type hints (mypy strict mode)
- Follow existing patterns in the codebase

### Ask First
- Modifying database models
- Changing API contracts
- Adding new dependencies
- Refactoring across multiple modules

### Never Do

**GitHub Issues**:
- NEVER close an issue unless ALL acceptance criteria are met
- If an issue has checkboxes, ALL boxes must be checked
- NEVER mark an issue complete if tests are failing

**Git**:
- NEVER commit directly to main
- NEVER force push
- NEVER commit secrets or credentials

**Security**:
- NEVER disable security features
- NEVER bypass authentication
- NEVER log sensitive data
```

The later projects grew more elaborate as I learned what agents actually needed. [Conduit's file](https://github.com/ashita-ai/conduit/blob/main/CLAUDE.md) added model configuration warnings (never modify `conduit.yaml` priors without explicit request), anti-pattern lists, and pre-commit detection commands. [Arbiter's](https://github.com/ashita-ai/arbiter/blob/main/CLAUDE.md) added a common mistakes section, a testing decision matrix, and a self-improvement protocol where the agent updates its own rules after failures. The skeleton held. The guardrails got more specific with each project.

## The Issue Decomposition Checklist

Before creating an issue, I ask:

- [ ] Can this be completed in a single PR under 400 lines?
- [ ] Are acceptance criteria specific and testable?
- [ ] Is validation included in the acceptance criteria, not assumed?
- [ ] Are security requirements explicit if this touches user input, files, or network?
- [ ] Does this issue depend on other issues? Are they linked?
- [ ] Is the scope small enough that I can review the PR in 15 minutes?

If any answer is no, decompose further.

## What I am still figuring out

Whether this workflow scales beyond solo development. One person reviewing AI-generated PRs works because the reviewer holds the full mental model. Two people reviewing introduces coordination: who owns which modules, what conventions matter, how to resolve disagreements about the CLAUDE.md. The document becomes a shared governance artifact rather than a personal operating guide. I have not tested this with a team and do not know where it breaks.

---

Building with agents is not pair programming. It is more like managing a very fast, very literal contractor who has no institutional memory. The systems that work are the ones designed for that constraint: explicit specifications, durable state, clear boundaries, and the assumption that everything will need to be reviewed.

The agents did most of the typing. The architecture was still my job.

---

*Thanks to the contributors who helped with these projects: [SoulSniper-V2](https://github.com/SoulSniper-V2), [ChanfeiLi](https://github.com/ChanfeiLi), [MukeshK17](https://github.com/MukeshK17), [JithinBathula](https://github.com/JithinBathula), [nicoleman0](https://github.com/nicoleman0), [Aditya-Singh-008](https://github.com/Aditya-Singh-008), [Nikhita-14](https://github.com/Nikhita-14), [harshit-69](https://github.com/harshit-69), [hhayan](https://github.com/hhayan), [DAShaikh10](https://github.com/DAShaikh10), [MeghanBao](https://github.com/MeghanBao), and [jskrable](https://github.com/jskrable).*
