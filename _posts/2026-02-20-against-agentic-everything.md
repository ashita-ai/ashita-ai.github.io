---
layout: post
title: "Against Agentic Everything"
date: 2026-02-20
---

In 2023, Air Canada deployed an AI chatbot to handle customer inquiries. When Jake Moffatt asked about bereavement fares after his grandmother died, the chatbot told him he could book at full price and apply for a retroactive discount within 90 days. The policy did not exist. Air Canada refused the refund and [argued the chatbot was a separate legal entity](https://www.cbsnews.com/news/aircanada-chatbot-discount-customer/) responsible for its own actions. A tribunal disagreed.

The chatbot did exactly what it was designed to do: answer questions autonomously, without human oversight, at scale. Nobody had designed for what happens when it answers confidently and wrong.

Andrej Karpathy [put it directly](https://www.dwarkesh.com/p/andrej-karpathy): "It will take about a decade to work through all of those issues." Not a quarter. Not a roadmap item. A founding member of OpenAI saying the technology his industry is selling does not work yet.

The problems are compounding. The reliability math does not work. The security architecture is fundamentally vulnerable. The data infrastructure does not exist. And much of what the industry is selling is fraud.

## The math

[Berkeley researchers](https://arxiv.org/abs/2503.13657) analyzed 1,600 execution traces across seven multi-agent frameworks. Failure rates ranged from 41% to 86.7%.

The compounding is what kills you. At a 20% error rate per action, a five-step workflow drops to 32% success. Even at 99% per-step reliability (which nobody has) you only get 82% success over 20 steps. [Error cascades](/blog/your-agents-need-a-supervisor/) are the mechanism: one agent makes a small mistake, the next accepts it, and by the fourth step the output is confidently wrong.

Multi-step production workflows need reliability that current agents cannot provide. The math does not work.

## The security problem

Simon Willison [identified](https://simonwillison.net/2025/Jun/16/the-lethal-trifecta/) "the lethal trifecta" for AI agents: access to private data, exposure to untrusted content, and the ability to communicate externally. Combine all three and an attacker can trick your agent into exfiltrating your data.

The core problem is that LLMs believe anything you tell them. They cannot distinguish instructions from content. Willison documented this vulnerability in ChatGPT, Amazon Q, GitHub Copilot, Microsoft Copilot, Slack, and Claude. Almost all were fixed by locking down exfiltration. The underlying vulnerability is architectural.

"Do I really trust a language model that believes the literal truth of anything that's presented to it to go out and do those things?"

## The data problem

The disconnect is between what agents promise and what data infrastructure supports. Joe Reis [observed](https://joereis.substack.com/p/ai-agents-and-the-pesky-problem-of) that very few people raise their hands when he asks audiences if they would put an LLM on top of their existing data.

Before you deploy an agent, you need to know what your data means. [Data contracts](/blog/the-data-platform-decisions-that-haunt-you/) are not optional infrastructure. They are the prerequisite for anything autonomous. Most corporate datasets are what Reis calls "utter hellscapes": poorly named columns, janky data models, timestamps without timezones because "everyone knows it's Eastern."

The data readiness problem has not been solved. It has been papered over with demos.

## The fraud problem

The SEC [charged Presto Automation](https://www.sec.gov/enforcement-litigation/administrative-proceedings/33-11352-s) with claiming its AI drive-thru "eliminated the need for human order taking." Reality: over 70% of orders required human agents in the Philippines and India.

The SEC and DOJ [charged Albert Saniger](https://www.justice.gov/usao-sdny/pr/tech-ceo-charged-artificial-intelligence-investment-fraud-scheme) of Nate Inc. with fraud. He raised $42 million claiming AI automation. Actual automation rate: zero percent. Hundreds of contractors in call centers in the Philippines and Romania manually completed purchases.

Gartner [estimates](https://www.gartner.com/en/newsroom/press-releases/2025-06-25-gartner-predicts-over-40-percent-of-agentic-ai-projects-will-be-canceled-by-end-of-2027) only 130 of thousands of vendors claiming "agentic AI" are real. The rest are agent-washing: rebranding chatbots without substantial capabilities. The same report predicts over 40% of agentic AI projects will be cancelled by end of 2027.

## What works

The pattern in every success is the same: narrow, internal, supervised.

Klarna deployed an AI assistant for customer service in early 2024. Within a month it handled [2.3 million conversations](https://www.klarna.com/international/press/klarna-ai-assistant-handles-two-thirds-of-customer-service-chats-in-its-first-month/), two-thirds of all customer chats, with resolution times dropping from 15 minutes to 2. Then they pushed further. They cut staff by 40% and let AI handle increasingly complex queries. Quality dropped. Complaints rose. By 2025, CEO Sebastian Siemiatkowski [acknowledged they had gone too far](https://fortune.com/2025/05/09/klarna-ai-humans-return-on-investment/) and began rehiring human agents.

The initial deployment worked because it was narrow: routine inquiries with clear escalation paths. The expansion failed because it crossed into territory requiring judgment, empathy, and context that LLMs cannot reliably provide. The line between the two is where every agentic deployment succeeds or fails.

The winning implementations are hybrid: LLM reasoning combined with deterministic guardrails and human-in-the-loop oversight. The failures are broad, external, and autonomous. Autonomy is a design choice, not a goal.

## What I am still figuring out

The decade timeline feels right but the path is unclear. Current agents fail on multi-step tasks, but the failure modes are not improving predictably. Some capabilities are advancing (coding, research). Others are stuck (reliable tool use, long-horizon planning).

The question I cannot answer: is this a capabilities problem that more compute will solve, or an architectural problem that requires a different approach? Karpathy thinks capabilities. Yann LeCun [thinks architecture](https://techcrunch.com/2025/01/23/metas-yann-lecun-predicts-a-new-ai-architectures-paradigm-within-5-years-and-decade-of-robotics/), predicting the current LLM paradigm has a shelf life of three to five years. If LeCun is right, the current wave of agent investments is building on the wrong foundation.

Either way, the companies deploying agents today are running the experiment with their own money. Some will learn. Most will join the [pilot graveyard](/blog/the-ai-pilot-graveyard/).

---

The problem is not AI. The problem is "agentic everything": the assumption that autonomy is progress, that removing humans is the objective, that governance can come later.

The governance cannot come later. The companies shipping agents without controls are building the next incident. The companies building data contracts, audit logs, and kill switches first are building something that might actually work.

Karpathy thinks it will take a decade. I think he is right.
