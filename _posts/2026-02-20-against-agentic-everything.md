---
layout: post
title: "Against Agentic Everything"
date: 2026-02-20
---

In February 2024, an employee at Arup's Hong Kong office joined a video call with the company's CFO and other senior executives. The CFO instructed them to transfer funds. They complied. The deepfake agents on the call were AI-generated. The [loss was $25 million](https://fortune.com/europe/2024/05/17/arup-deepfake-fraud-scam-victim-hong-kong-25-million-cfo/).

The attackers did not need a sophisticated multi-agent framework. They needed one agent good enough to impersonate a CFO for fifteen minutes.

Andrej Karpathy called the current state of AI agents ["slop."](https://www.dwarkesh.com/p/andrej-karpathy) "The reason you don't do it today is because they just don't work. They don't have enough intelligence, they're not multimodal enough, they can't do computer use... It will take about a decade to work through all of those issues."

A decade. Not a quarter. Not a roadmap item. A founding member of OpenAI saying the technology his industry is selling does not work yet.

## The math

[Berkeley researchers](https://arxiv.org/abs/2503.13657) analyzed 1,600 execution traces across seven multi-agent frameworks. Failure rates ranged from 41% to 86.7%.

The compounding is what kills you. At a 20% error rate per action, a five-step workflow drops to 32% success. Even at 99% per-step reliability—which nobody has—you only get 82% success over 20 steps. [Error cascades](/blog/your-agents-need-a-supervisor/) are the mechanism: one agent makes a small mistake, the next accepts it, and by the fourth step the output is confidently wrong.

Production systems need 99.9%+. The math does not work.

## The gullibility problem

Simon Willison [identified](https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/) "the lethal trifecta" for AI agents: access to private data, exposure to untrusted content, and the ability to communicate externally. Combine all three and an attacker can trick your agent into exfiltrating your data.

The core problem is that LLMs believe anything you tell them. They cannot distinguish instructions from content. Willison documented this vulnerability in ChatGPT, Amazon Q, GitHub Copilot, Microsoft Copilot, Slack, and Claude. Almost all were fixed by locking down exfiltration. The underlying vulnerability is architectural.

"Do I really trust a language model that believes the literal truth of anything that's presented to it to go out and do those things?"

The Arup attack exploited exactly this. The agent was a human employee. The prompt injection was a deepfake video call. The exfiltration was a wire transfer. The pattern is the same whether the agent runs on silicon or carbon.

## The data problem

Marina Danilevsky, a senior research scientist at IBM Research, [put it bluntly](https://www.bloomberg.com/news/articles/2025-04-08/ai-agents-could-reshape-how-we-work-but-don-t-believe-the-hype): "I'm still struggling to truly believe that this is all that different from just orchestration."

The disconnect is between what agents promise and what data infrastructure exists. Joe Reis [asked the right question](https://joereis.substack.com/p/ai-agents-and-the-pesky-problem-of): "Would you stick an LLM on top of your corporate data set today? Would you bet your job on it?"

Nobody raises their hand.

This is why I built [Tessera](/blog/introducing-tessera/). Before you deploy an agent, you need to know what your data means. [Data contracts](/blog/the-data-platform-decisions-that-haunt-you/) are not optional infrastructure—they are the prerequisite for anything autonomous. Most corporate datasets are what Reis calls "utter hellscapes"—poorly named columns, janky data models, timestamps without timezones because "everyone knows it's Eastern."

The data readiness problem has not been solved. It has been papered over with demos.

## The fraud problem

The SEC [charged Presto Automation](https://www.sec.gov/enforcement-litigation/administrative-proceedings/33-11352-s) with claiming its AI drive-thru "eliminated the need for human order taking." Reality: over 70% of orders required human agents in the Philippines and India.

The SEC and DOJ [charged Albert Saniger](https://www.justice.gov/usao-sdny/pr/tech-ceo-charged-artificial-intelligence-investment-fraud-scheme) of Nate Inc. with fraud. He raised $42 million claiming AI automation. Actual automation rate: zero percent. Hundreds of contractors in call centers in the Philippines and Romania manually completed purchases.

Gartner [estimates](https://www.gartner.com/en/newsroom/press-releases/2025-06-25-gartner-predicts-over-40-percent-of-agentic-ai-projects-will-be-canceled-by-end-of-2027) only 130 of thousands of vendors claiming "agentic AI" are real. The rest are agent-washing: rebranding chatbots without substantial capabilities. The same report predicts over 40% of agentic AI projects will be cancelled by end of 2027.

## What works

The pattern in every success is the same: narrow, internal, supervised.

Customer service with escalation paths. Inventory optimization with human approval. IT ticket routing with fallback queues. The winning implementations are hybrid: LLM reasoning combined with deterministic guardrails and human-in-the-loop oversight.

The failures are broad, external, and autonomous. General-purpose agents making decisions without oversight. Autonomy is a design choice, not a goal.

## What I am still figuring out

The decade timeline feels right but the path is unclear. Current agents fail on multi-step tasks, but the failure modes are not improving predictably. Some capabilities are advancing (coding, research). Others are stuck (reliable tool use, long-horizon planning).

The question I cannot answer: is this a capabilities problem that more compute will solve, or an architectural problem that requires a different approach? Karpathy thinks capabilities. Yann LeCun thinks architecture. If LeCun is right, the current wave of agent investments is building on the wrong foundation.

Either way, the companies deploying agents today are running the experiment with their own money. Some will learn. Most will join the [pilot graveyard](/blog/the-ai-pilot-graveyard/).

---

The problem is not AI. The problem is "agentic everything"—the assumption that autonomy is progress, that removing humans is the objective, that governance can come later.

The governance cannot come later. The companies shipping agents without controls are building the next incident. The companies building [data contracts](/blog/introducing-tessera/), audit logs, and kill switches first are building something that might actually work.

Karpathy thinks it will take a decade. I think he is right.
