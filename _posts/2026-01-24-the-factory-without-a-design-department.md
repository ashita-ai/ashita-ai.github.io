---
layout: post
title: "The Factory Without a Design Department"
date: 2026-01-24
---

<img src="/assets/images/the_blueprint.jpg" alt="The Blueprint Spec-Press vs the Orchestration Engine" style="width: 120%; max-width: none; margin-left: -10%; height: auto; margin-bottom: 2rem;">

Cursor ran [production experiments](https://cursor.com/blog/scaling-agents) with hundreds of concurrent agents over weeks. Their initial architecture used flat coordination: equal-status agents with shared-file locking. Twenty agents produced the effective throughput of two or three.

Meanwhile, a developer using Geoffrey Huntley's "Ralph" technique [shipped a $50K contract for $297 in compute costs](https://ghuntley.com/ralph/). The architecture is a bash loop. One agent. One task per iteration. State persisted to a markdown file between iterations. (The $297 reflects API spend only—specification work, debugging, and review are not included.)

Same underlying models. Radically different results. Cursor built a complex factory floor and it failed. Huntley built a simple one and invested in blueprints instead.

## The missing department

The industry is building factories. Cursor, Devin, Claude Code, CrewAI, LangGraph, AutoGen—all orchestration engines. [Gartner reported](https://www.gartner.com/en/articles/multiagent-systems) a 1,445% surge in multi-agent system inquiries from Q1 2024 to Q2 2025. Two-thirds of enterprise AI implementations now use multi-agent architectures.

The same industry reports a [41-86.7% failure rate](https://arxiv.org/html/2503.13657v1) for production multi-agent systems. [Seventy-nine percent](https://arxiv.org/html/2503.13657v1) of failures originate from specification and coordination issues rather than technical implementation.

We built the factory. We forgot the design department.

[Huntley's pattern](https://github.com/ghuntley/how-to-ralph-wiggum) makes this explicit. His workflow has three phases: requirements (`specs/*.md`), planning (`IMPLEMENTATION_PLAN.md`), and building (the loop). The blueprints are where the work happens. "LLMs are mirrors of operator skill," [he writes](https://ghuntley.com/ralph/). The results come from investing in specifications, not from sophisticated orchestration.

## The blueprint printing press

[Scott Logic observed](https://blog.scottlogic.com/2025/12/15/the-specification-renaissance-skills-and-mindset-for-spec-driven-development.html) that AI coding assistants have exposed an uncomfortable truth: "many people struggle to articulate what they actually want to build." We spent decades optimizing for implementation speed while specification skills atrophied. Now implementation is cheap, and specification is the constraint.

The obvious response would be to build tools that help write blueprints. But look at the landscape:

- **Cursor**: factory
- **Devin**: factory
- **Claude Code**: factory
- **CrewAI**: factory framework
- **LangGraph**: factory framework

Where is the design department? The blueprint printing press?

The [Agentic Handbook](https://www.nibzard.com/agentic-handbook) documents why agents fail: ambiguous instructions, improper task decomposition, missing termination cues. These are blueprint failures, not factory failures. The handbook's solution is better human discipline: "Can you describe the topic in one sentence without 'and'?" But discipline does not scale. Tooling does.

## Why this is hard to build

Blueprints are harder than factories because specs require understanding intent, not just code. The codebase contains what was built. It does not contain why, or what was considered and rejected, or what "good" means in this context.

There is also an infinite regress problem. To build a blueprint-writing agent, you need a blueprint for the blueprint-writer. Turtles all the way down.

But maybe it bottoms out. The AI does not write the blueprint. It interrogates until the human has drawn a good one.

**The Socratic design department:**

1. Human provides raw intent: "I want users to track usage metrics"
2. AI decomposes: "What counts as a metric? What's the retention policy? Who can see what?"
3. AI applies the scope test: "Can you describe this in one sentence without 'and'?"
4. AI challenges edge cases: "What happens when the service is down? What's explicitly out of scope?"
5. AI validates: "Here's what I understood. Here are the ambiguities I still see."

This is not the AI drawing blueprints. It is the AI refusing to let vague blueprints reach the factory floor.

## The constraint moved upstream

Steve Yegge's [Gas Town](https://maggieappleton.com/gastown) orchestrates dozens of agents simultaneously. His observation: when the factory runs fast, humans must invest substantially more effort in architectural decisions, feature prioritization, and specification clarity. The constraint moved upstream. The tooling did not follow.

Anthropic's [official guidance](https://www.anthropic.com/research/building-effective-agents) is to find "the simplest solution possible, and only increase complexity when needed." For most applications, a single agent is enough. The bottleneck is not the factory. The bottleneck is [knowing what to build](/blog/the-data-platform-decisions-that-haunt-you/).

Multi-agent systems use [approximately 15x more tokens](https://www.anthropic.com/engineering/multi-agent-research-system) than single-agent interactions. Each additional agent multiplies the opportunities for blueprint errors to propagate. If your specifications are ambiguous, one agent might misinterpret them. Twenty agents will misinterpret them in twenty different ways.

This is the same dynamic that [kills AI pilots](/blog/the-ai-pilot-graveyard/). The factory works. The design department does not keep pace.

## What I am still figuring out

The Socratic design department is conceptually clean but I have not seen it built. The closest examples are design docs reviewed by senior engineers—but that is expensive human time, not tooling. There may be a reason nobody has built this. Blueprints are contextual in ways that resist automation.

The 66% multi-agent adoption stat comes from enterprise surveys. I suspect it is inflated. If routing between specialized prompts counts as "multi-agent," the number is meaningless. If it means genuine autonomous coordination, 66% seems implausibly high.

Huntley's results are striking but specific to his context. He has years of experience tuning these loops. The technique may not transfer to teams without that foundation—which brings us back to the tooling gap. If the skill is rare and hard to teach, the tool matters even more.

---

Cursor's fix was not a better factory. It was less factory. The integrator role they added "created more bottlenecks than it solved."

The lesson is not about factory architecture. It is about where to invest. The industry has invested in orchestration. The constraint is specification. [Evals alone will not save you](/blog/your-evals-wont-save-you/)—you cannot evaluate your way out of building the wrong thing.

Build the design department. The blueprints matter more than the factory.
