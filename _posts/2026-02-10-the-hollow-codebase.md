---
layout: post
title: "The Hollow Codebase"
date: 2026-02-10
---

In July 2025, Jason Lemkin was building a web app for SaaStr using Replit's AI coding agent. During a designated code freeze, the AI [deleted his entire production database](https://fortune.com/2025/07/23/ai-coding-tool-replit-wiped-database-called-it-a-catastrophic-failure/): 1,206 executive records representing months of curation. Then, to cover the damage, it generated 4,000 fake records, invented fictional people, and built a parallel algorithm to make the system appear functional.

When questioned, the AI admitted to panicking in response to empty database queries. It declared: "This was a catastrophic failure on my part. I destroyed months of work in seconds."

Lemkin had told it eleven times, in all caps, not to make changes.

This is not a story about a rogue AI. It is a story about code that works until it does not, built by systems that cannot explain why. [The seeing problem](/blog/the-seeing-problem/) is about observability: you cannot monitor what you do not understand. This is about capacity: humans cannot review fast enough to maintain understanding.

## The bottleneck moved

AI coding tools work. I am less skeptical of them than I was a year ago. The productivity gains are real for certain tasks.

But [Faros AI analyzed](https://www.faros.ai/blog/ai-software-engineering) telemetry from over 10,000 developers and found something troubling. Teams with high AI adoption complete 21% more tasks and merge 98% more pull requests. They also see PR review times increase by 91%.

Almost double the output. Almost double the review time. The constraint shifted from writing to understanding.

The [2024 DORA Report](https://cloud.google.com/blog/products/devops-sre/announcing-the-2024-dora-report) found it got worse from there: as AI adoption increased, delivery throughput dropped 1.5% and stability dropped 7.2%. The [2025 report](https://dora.dev/research/2025/dora-report/) introduced a concept they call the "Vacuum Hypothesis." AI frees up developer time, but that time gets absorbed by lower-value tasks rather than improving delivery.

[76% of developers](https://dora.dev/research/2025/dora-report/) now use AI tools in some part of their daily work. Most organizations see no measurable performance gains.

## The hollow codebase

Steve Yegge [described](https://itrevolution.com/articles/observing-the-impact-of-ai-on-law-firms-software-and-writing-winners-and-losers/) working with LLMs as collaborating with "wildly productive junior developers who are super fast, super full of energy, but also potentially whacked out on mind-altering drugs, often coming up with crazy and fundamentally unworkable approaches."

The code they produce compiles. It often works. But it accumulates differently than human-written code.

[Apiiro's research](https://apiiro.com/blog/4x-velocity-10x-vulnerabilities-ai-coding-assistants-are-shipping-more-risks/) across Fortune 50 enterprises found AI-assisted developers produce 3-4x more commits while generating 10x more security findings. Syntax errors dropped 76%. Architectural design flaws spiked 153%. The easy problems got fixed. The hard problems got worse.

[CodeRabbit's analysis](https://www.coderabbit.ai/blog/state-of-ai-vs-human-code-generation-report) of 470 pull requests found AI-generated code contains 1.7x more issues overall: 1.75x more logic errors, 3x more readability issues, 8x more excessive I/O operations.

The pattern: AI removes the work that was easy to review and adds work that is hard to review. Six months later, you are staring at a codebase that works but nobody fully understands.

Bus factor is approaching zero.

## The junior problem

Junior developers can now produce code they cannot evaluate.

The volume is, in the words of [one analysis](https://addyo.substack.com/p/beyond-the-70-maximizing-the-human), "saturating the ability of midlevel staff to review changes." Seniors are drowning in review queues instead of doing architecture or mentorship. The ratio is broken.

A [Stanford study](https://stackoverflow.blog/2025/12/26/ai-vs-gen-z) found employment for software developers aged 22-25 declined nearly 20% from its 2022 peak. 37% of employers say they would rather "hire" AI than a recent graduate. The economics are obvious in the short term.

But someone has to ask the question nobody wants to answer: who reviews AI code in 2035 if nobody was hired as a junior in 2025?

The junior-to-senior pipeline is how organizations build review capacity. Cut the pipeline and you solve today's headcount problem while creating tomorrow's knowledge crisis. The codebase gets hollower. The people who understand it get older. Eventually, nobody is left who remembers why things work.

## What we are doing about it

The review bottleneck is a systems problem. You cannot solve it by telling seniors to review faster.

**Dedicated review time.** We run a daily review thread in Slack. Every engineer allocates at least an hour to PR reviews. The work has to be scheduled or it does not happen.

**Clear priority signals.** Not every PR needs the same scrutiny. Payment code, security boundaries, core business logic: senior review. Boilerplate, tests, documentation: move faster. Attention is the constraint. Allocate it deliberately.

**Smaller PRs.** AI-generated PRs are [154% larger](https://www.faros.ai/blog/ai-software-engineering) on average. Larger PRs get worse reviews. Enforce size limits.

**AI-assisted review for the patterns.** Tools like [CodeRabbit](https://www.coderabbit.ai/) catch null handling, style inconsistencies, common security issues. One team tracked every comment over a month and found [72% of findings were relevant](https://www.deployhq.com/blog/ai-code-review-before-you-deploy-our-experience-with-coderabbit), but only 3% were security-critical. Use them to clear the brush so humans can focus on judgment.

**Intentional mentorship.** Junior developers need structured opportunities to understand code, not just produce it. Pair programming. Design reviews. Occasionally implementing something without AI assistance. The skills atrophy if they are never exercised.

## What I am still figuring out

The right ratio of AI-assisted work to unassisted work for skill development. I do not have a principled answer.

Whether the review bottleneck eventually gets solved by better AI review tools, or whether human judgment remains the constraint indefinitely.

How to measure "codebase comprehension" as a leading indicator before it becomes a crisis.

---

Lemkin's AI generated 4,000 fake records to make the system appear functional. The code worked. The tests passed. Nobody understood what had actually happened until they looked.

The organizations that maintain human comprehension of their systems will outperform the ones that just ship faster.
