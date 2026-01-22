---
layout: post
title: "The AI Pilot Graveyard"
date: 2026-01-22
---

Zillow had the model. They had the data. They had years of Zestimate predictions behind them. In 2018, they launched their AI-powered iBuyer program and expanded it to 25 metropolitan areas. By the time they [shut it down](https://www.geekwire.com/2021/zillow-shutter-home-buying-business-lay-off-2k-employees-big-real-estate-bet-falters/) in November 2021, the division had [lost $881 million](https://therealdeal.com/new-york/2022/02/13/zillow-reports-880m-loss-on-failed-home-flipping-business/) for the year, they had cut 2,000 jobs (25% of their workforce), and watched their stock drop 25% in a single day.

Meanwhile, their competitors Opendoor and Offerpad used similar AI and survived. The difference was not the algorithm. It was the guardrails.

McDonald's made the same mistake with different technology. Their AI drive-thru pilot with IBM [reached 100 locations](https://www.cnbc.com/2024/06/17/mcdonalds-to-end-ibm-ai-drive-thru-test.html) in three years. It processed real orders. It scaled. And in June 2024, they shut it down. Order accuracy hovered around [85%](https://www.restaurantdive.com/news/mcdonalds-ai-drive-thru-voice-ordering-accuracy/625923/) (they needed 95% for broader rollout). The viral videos (bacon on ice cream, nine sweet teas when a customer ordered none) were symptoms, not the disease. The pilot validated that the technology could take orders. It did not validate that customers would tolerate the experience.

Meanwhile, [Wendy's used the same underlying technology](https://fortune.com/2024/10/15/wendy-google-ai-drive-thru-expansion/) (Google Cloud AI) and is still expanding. The difference: Wendy's started with one location in Columbus, Ohio. After a year, they had 36 restaurants. They are planning 500 by end of 2025. Same technology. Different execution philosophy. The pattern repeats.

This is not a story about pilots failing to reach production. It is a story about what happens when they scale too fast.

## The 95% stat

[MIT research](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/) found that 95% of enterprise AI pilots fail to deliver measurable ROI. The instinct is to read this as a failure rate. It is not. It is a design outcome.

Pilots are optimized to not reach production.

A pilot with synthetic data and friendly internal users tells you nothing about how your AI will behave when customers use it in ways you did not anticipate. A pilot that runs for six months generates board decks and justifies headcount. A pilot that "succeeds" on narrow metrics gives everyone permission to declare victory without shipping anything.

The [S&P Global data](https://www.ciodive.com/news/AI-project-fail-data-SPGlobal/742590/) confirms it: 42% of companies abandoned most of their AI initiatives in 2025, up from 17% in 2024. These are not technical failures. The models work. What fails is the organizational willingness to put AI in front of real users with real stakes.

## Innovation theater

Steve Blank [coined the term](https://steveblank.com/2019/10/15/between-a-rock-and-a-hard-place-organizational-and-innovation-theater/) "innovation theater" for activities that shape culture but rarely ship: hackathons, design thinking workshops, AI labs that generate press releases but not production systems.

AI pilots are innovation theater's most expensive production. They justify Chief AI Officer hires. They look like progress in quarterly updates. They give executives air cover for not making decisions. And they almost never ship.

The reason is structural. Innovation teams are measured on novelty: new capabilities, impressive demos, press coverage. Execution teams are measured on reliability: uptime, cost control, operational stability. When an innovation team succeeds and hands off to execution, the execution team has zero incentive to adopt it. It disrupts their metrics. The innovation dies in the handoff, not in the lab.

This is not laziness. It is rational behavior under misaligned incentives. Meta's Reality Labs has [lost $71 billion since 2021](https://venturebeat.com/ai/metas-reality-labs-is-losing-billions-still-worth-watching/) building VR technology that the rest of Meta has no incentive to integrate. That is innovation theater at enterprise scale.

The tell is the documentation. If your pilot has a "success criteria" document longer than one page, it is theater. Real AI strategy fits on one page: the problem (20 words), the smallest solution (25 words), the 30-day proof with a specific date, and the one metric everyone watches. Anything more elaborate exists to delay the moment of truth.

## What the 5% do differently

The companies that scale AI are not running better pilots. They are skipping pilots entirely.

They deploy to limited production immediately. They accept that some deployments will fail visibly. They build systems with guardrails that detect when conditions change and pull back automatically.

Netflix, Stripe, and Uber all deploy new ML models constantly. Not after six-month pilots. Constantly. Their pattern is called [shadow deployment](https://www.qwak.com/post/shadow-deployment-vs-canary-release-of-machine-learning-models): the new model runs alongside production, processes the same requests, but only the current model's predictions reach users. You get real production data before real exposure. Organizations using shadow deployment report [40% fewer production incidents](https://aws.amazon.com/blogs/machine-learning/deploy-shadow-ml-models-in-amazon-sagemaker/). That is not a pilot. That is continuous deployment with training wheels.

This is what separated Opendoor from Zillow. Both used AI to value homes. Both deployed to production. But Opendoor built systems that detected when the housing market shifted and adjusted offers accordingly. Zillow's executives [overrode the algorithm](https://jise.org/Volume35/n1/JISE2024v35n1pp67-72.pdf) through a practice called "offer calibration," raising bids by thousands above model prices to hit growth targets. When the market turned, Opendoor's guardrails caught it. Zillow's did not exist.

The lesson is not "deploy faster." The lesson is "deploy with kill switches."

## When pilots are legitimate

Regulated industries have legitimate compliance gates. Healthcare AI needs FDA clearance. Financial models need regulatory approval. These are not pilots. A compliance gate has external accountability, a clear definition of "done," and a regulatory body that will shut you down if you skip it. A pilot has none of these.

The difference matters. MD Anderson's [IBM Watson oncology project](https://spectrum.ieee.org/how-ibm-watson-overpromised-and-underdelivered-on-ai-health-care) spent four years and over $62 million before being quietly shelved. That was not regulatory compliance. That was a pilot with no kill switch and no external accountability, dressed up as medical research.

The tell is simple: if your pilot has external deadlines enforced by someone who can shut you down, it is compliance. If your pilot has been "waiting for legal review" for six months, the bottleneck is not legal.

## Build versus buy

One of the cleaner findings from the MIT research: purchased AI tools [succeed 67% of the time](https://fortune.com/2025/08/18/mit-report-95-percent-generative-ai-pilots-at-companies-failing-cfo/), while internal builds succeed only one-third as often.

Why does buying work better? Three reasons.

First, vendors absorb the integration burden. Research shows [60% of AI development time](https://beam.ai/agentic-insights/the-great-ai-flip-why-76-of-enterprises-stopped-building-ai-in-house) goes to connecting systems, managing APIs, and ensuring data flow. Vendor platforms handle this. Internal teams rebuild it from scratch.

Second, vendor contracts create external accountability. When a vendor is paid $500K per year, deployment delays have financial consequences. SLAs are enforceable. Internal builds have no such ratchet. The deadline slips and nothing happens.

Third, internal builds hide their maintenance costs. Successful internal deployments require [15-30% of original build cost annually](https://dust.tt/blog/build-vs-buy-ai-agents) in ongoing maintenance. Doctolib launched an internal AI assistant that hit 800 users within days. The infrastructure demands (access management, security, audit logs, compliance) would have required tripling the team. They switched to a vendor.

Internal builds stall because they can. Vendors ship because they have to.

## The real problem

Pilots fail because they test the wrong things. This is different from the [eval problem](/blog/your-evals-wont-save-you/). Evals test whether the model works. Pilots test whether the organization will use it. Both fail for the same reason: they validate capability when they should validate adoption.

A pilot that validates whether GPT-4 can summarize documents is worthless. Of course it can. A pilot that validates whether your legal team will actually use AI summaries instead of reading the originals is the only question that matters.

Most pilots are technical solutions to organizational problems. They let engineering teams prove the technology works while avoiding the harder question of whether the organization will change how it operates.

The companies that scale AI do not ask "does this model perform well?" They ask "will this change how decisions get made?" Those are different questions. The first one can be answered in a sandbox. The second one requires production.

## What to do instead

Kill pilots that have run longer than 90 days. The MIT data is clear: [successful pilots transition to production in about 90 days](https://loris.ai/blog/mit-study-95-of-ai-projects-fail/). Failed ones take nine months or longer. The 90-day mark is the boundary between "scaling" and "pilot purgatory." After that, sunk cost psychology takes over and the pilot becomes harder to kill than to keep funding.

Deploy to limited production with real users. Not friendly internal users. Real customers who will use your AI in ways you did not anticipate and complain when it breaks.

Build automated guardrails before you build the model. [The decisions you make about monitoring and rollback](/blog/the-data-platform-decisions-that-haunt-you/) matter more than the decisions you make about model architecture. This is what separates [healthy metrics from broken agents](/blog/healthy-metrics-broken-agent/).

Buy when you can. The 2x success rate gap is not a suggestion. [Taking on that technical debt](/blog/technical-debt-as-strategy/) is only worth it if you have a genuine competitive advantage to protect.

## What I am still figuring out

The 90-day boundary is clearer than I expected, but the causation is not. Pilots may run long because they are already struggling, not vice versa. The extended timeline could be a symptom rather than a cause. The best proxy I have for distinguishing "legitimate extended validation" from "pilot purgatory" is external accountability: if someone outside your company can force a deadline, it is probably real. If your only deadlines are internal, it is probably theater.

---

Zillow lost $881 million. MD Anderson spent $62 million. McDonald's spent years on a pilot that worked but did not matter. The graveyard is not full of failed technology. It is full of successful pilots that validated the wrong things.
