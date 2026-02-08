---
layout: post
title: "The Intelligence Is in the Document, Not the Model"
date: 2026-02-08
---

Three CI failures in one afternoon. Same project. Same root cause every time.

I was building Akashi, a decision trace layer for multi-agent systems — Go, Postgres, Atlas migrations. The agent was fast. The agent was confident. The agent pushed code that failed CI three times in a row.

**First failure:** dependency drift. The agent imported `godotenv` directly but `go.mod` still listed it as indirect. CI runs `go mod tidy && git diff --exit-code go.mod go.sum`. Failed.

**Second failure:** migration checksum mismatch. A previous session added a migration file without running `atlas migrate hash`. CI runs `atlas migrate validate`. Failed.

**Third failure:** linter catch. `golangci-lint` found an ineffectual variable assignment — incrementing a counter after its last use. The linter was not installed locally, let alone listed in the pre-commit checklist.

Every one of these checks existed somewhere. CI had them. The Makefile had them. The agent had read the Makefile. The agent still did not run the checks.

## The gap

Knowing something exists in a reference file is not the same as having it as a directive in operating instructions. The agent had the information. It did not have the instruction.

CI is the safety net, but by the time it catches something you have already pushed, waited for the runner, read the logs, fixed, pushed again. [Research from Atlassian](https://arxiv.org/html/2402.09651v2) found that 43% of developers experienced CI failures in 50-75% of their pull requests, with failed builds costing an average of 120 hours of wasted build time per project per year. Three round trips when zero should have been necessary.

The fix was not a better model. The fix was better instructions. Each failure became a new line in the CLAUDE.md:

```
agent fails → human encodes the lesson → agent improves next session
```

This is supervised learning happening at the prompt level, not the weight level.

## Agents do not have muscle memory

An experienced engineer would internalize "always run the linter" after one CI failure. They would never need it written down again. Agents do not work that way. Each session starts fresh. The CLAUDE.md is their muscle memory. If the lesson is not encoded there, they do not have it.

You would not give a new engineer the codebase and say "figure it out." You would give them a setup guide, explain the CI pipeline, walk them through the pre-commit hooks, point out the gotchas. The CLAUDE.md is the onboarding doc for an engineer who gets re-onboarded every session.

The difference: human engineers graduate from the onboarding doc. They build intuition, learn the codebase's rhythms, anticipate problems before they surface. Agents never graduate. The document is not temporary scaffolding. It is the permanent operating system.

## The checklist problem

In 2009, a [study in the New England Journal of Medicine](https://www.nejm.org/doi/full/10.1056/NEJMsa0810119) found that a 19-item surgical safety checklist reduced major complications from 11% to 7% and inpatient deaths from 1.5% to 0.8%. Eight hospitals. Nearly 8,000 patients. The checklist took two minutes to complete.

The surgeons already knew to check for allergies. They already knew to confirm the surgical site. The checklist did not teach them anything new. It enforced consistent execution of what they already knew.

A CLAUDE.md works the same way. Not "run the linter" as a suggestion buried in a Makefile the agent might reference. `golangci-lint run ./...` as a directive the agent will execute before every commit.

Larry Smith called this [shift-left testing](https://dl.acm.org/doi/10.5555/500399.500404) in 2001: move quality checks earlier in the process, where defects are cheap to fix. A CLAUDE.md shifts left past the developer entirely, into the agent's operating instructions. The checks happen before the code is committed, not after it fails in CI.

## The reframe

The quality of autonomous code generation is directly proportional to the quality of the context you build around the repo. Not the quality of the model. The quality of the context.

A perfect CLAUDE.md does not mean the agent is smart. It means the human did great curation. Agent quality scales with document quality, not model quality. This reframes "AI replacing developers" into something more precise: AI executing developer-curated instructions at scale. The human's job shifts from writing code to curating the context that makes agents write good code.

That shift is still a lot of work. But it compounds. Today's failures are tomorrow's guardrails. The context improves with each session — not because the model improved, but because the document improved.

[I wrote previously](/blog/what-i-learned-building-four-tools-with-ai-agents/) about the CLAUDE.md evolving across four open-source projects. The pattern held: early versions were skeletal. Later versions had anti-pattern lists, pre-commit detection commands, common mistakes sections, self-improvement protocols. The skeleton survived. The guardrails got more specific with each failure.

A good CLAUDE.md is operational, not aspirational. Not "we use TDD" but `go test -race ./...` before every commit. Not "run the linter" but the exact command with the exact flags. [Anthropic's own guidance](https://code.claude.com/docs/en/best-practices) recommends including only what the agent "can't infer from code alone" — and keeping it concise enough that the agent actually follows it. Bloat defeats the purpose. An agents.md that reads like a novel gets ignored the same way a 40-page onboarding doc gets ignored.

## What I am still figuring out

Can agents update their own CLAUDE.md proactively? In Akashi, the agent updated the file when told to after a failure. It did not update it on its own. The curation loop is still human-driven — human frustration is the training signal. Closing that loop is the obvious next step. I do not know if current models can do it reliably without drifting the document toward noise. An agent that appends every lesson it encounters will produce a CLAUDE.md that is too long to follow within two weeks. The curation itself requires judgment about what matters.

Is there a convergent CLAUDE.md for a given stack? Every Go project with Atlas migrations probably needs the same five pre-commit checks. But the footguns are repo-specific. Maybe 60% is boilerplate and 40% is hard-won project knowledge. I do not have enough data points to know the ratio.

How does this scale to teams? One person curating the CLAUDE.md works. Ten people with different conventions is a governance problem. The document needs an owner, or it rots into a junk drawer of contradictory instructions.

---

We are not there yet. The curation loop is manual. Every lesson still passes through a human who failed, got frustrated, and encoded the fix. But the trajectory is clear. Every session, the context gets better. Every failure, the guardrails tighten.

The agent is not learning. The document is.
