---
layout: post
title: "The AI Pilot Graveyard"
date: 2026-01-22
---

Zillow had the model. They had the data. They had years of Zestimate predictions behind them. In 2021, they deployed their AI-powered iBuyer program to production across 25 metropolitan areas. Within months, they had [lost $881 million](https://www.gsb.stanford.edu/insights/flip-flop-why-zillows-algorithmic-home-buying-venture-imploded), written off $304 million in inventory, cut 2,000 jobs, and watched $7.8 billion in market value evaporate.

Meanwhile, their competitors Opendoor and Offerpad used similar AI and survived. The difference was not the algorithm. It was the guardrails.

This is not a story about pilots failing to reach production. It is a story about what happens when they do.

## The 95% stat

[MIT research](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/) found that 95% of enterprise AI pilots fail to deliver measurable ROI. The instinct is to read this as a failure rate. It is not. It is a design outcome.

Pilots are optimized to not reach production.

A pilot with synthetic data and friendly internal users tells you nothing about how your AI will behave when customers use it in ways you did not anticipate. A pilot that runs for six months generates board decks and justifies headcount. A pilot that "succeeds" on narrow metrics gives everyone permission to declare victory without shipping anything.

The [S&P Global data](https://www.ciodive.com/news/AI-project-fail-data-SPGlobal/742590/) confirms it: 42% of companies abandoned most of their AI initiatives in 2025, up from 17% in 2024. These are not technical failures. The models work. What fails is the organizational willingness to put AI in front of real users with real stakes.

## Innovation theater

Steve Blank [coined the term](https://steveblank.com/2019/10/15/between-a-rock-and-a-hard-place-organizational-and-innovation-theater/) "innovation theater" for activities that shape culture but rarely ship: hackathons, design thinking workshops, AI labs that generate press releases but not production systems.

AI pilots are innovation theater's most expensive production. They justify Chief AI Officer hires. They look like progress in quarterly updates. They give executives air cover for not making decisions. And they almost never ship.

The tell is the documentation. If your pilot has a "success criteria" document longer than one page, it is theater. Real AI strategy fits on one page: the problem (20 words), the smallest solution (25 words), the 30-day proof with a specific date, and the one metric everyone watches. Anything more elaborate exists to delay the moment of truth.

## What the 5% do differently

The companies that scale AI are not running better pilots. They are skipping pilots entirely.

They deploy to limited production immediately. They accept that some deployments will fail visibly. They build systems with guardrails that detect when conditions change and pull back automatically.

This is what separated Opendoor from Zillow. Both used AI to value homes. Both deployed to production. But Opendoor built systems that detected when the housing market shifted and adjusted offers accordingly. Zillow's executives [overrode the algorithm](https://jise.org/Volume35/n1/JISE2024v35n1pp67-72.pdf) through a practice called "offer calibration," raising bids by thousands above model prices to hit growth targets. When the market turned, Opendoor's guardrails caught it. Zillow's did not exist.

The lesson is not "deploy faster." The lesson is "deploy with kill switches."

Regulated industries have legitimate compliance gates. These are not pilots. A compliance gate has external accountability, a clear definition of "done," and a regulatory body that will shut you down if you skip it. A pilot has none of these. The problem is when companies use "compliance" as cover for what is actually innovation theater. If your pilot has been "waiting for legal review" for six months, the bottleneck is not legal.

## Build versus buy

One of the cleaner findings from the MIT research: purchased AI tools succeed [67% of the time](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/) compared to 33% for internal builds.

Why does buying work better? Vendors force production deployment. When you buy software, it ships. There is no six-month pilot phase. There is a contract, an implementation timeline, and users. Internal builds stall because they can. There is always another stakeholder to consult, another edge case to handle, another quarter to refine the model.

## The real problem

Pilots fail because they test the wrong things.

A pilot that validates whether GPT-4 can summarize documents is worthless. Of course it can. A pilot that validates whether your legal team will actually use AI summaries instead of reading the originals is the only question that matters.

Most pilots are [technical solutions to organizational problems](/blog/the-rag-trap/). They let engineering teams prove the technology works while avoiding the harder question of whether the organization will change how it operates.

The companies that scale AI do not ask "does this model perform well?" They ask "will this change how decisions get made?" Those are different questions. The first one can be answered in a sandbox. The second one requires production.

## What to do instead

Kill pilots that have run longer than 90 days. If you have not deployed by then, you are not going to.

Deploy to limited production with real users. Not friendly internal users. Real customers who will use your AI in ways you did not anticipate and complain when it breaks.

Build automated guardrails before you build the model. [The decisions you make about monitoring and rollback](/blog/the-data-platform-decisions-that-haunt-you/) matter more than the decisions you make about model architecture. This is what separates [healthy metrics from broken agents](/blog/healthy-metrics-broken-agent/).

Buy when you can. The 67% versus 33% success rate is not a suggestion. [Taking on that technical debt](/blog/technical-debt-as-strategy/) is only worth it if you have a genuine competitive advantage to protect.

---

The graveyard is full of pilots that succeeded on every metric except the one that mattered: shipping.
