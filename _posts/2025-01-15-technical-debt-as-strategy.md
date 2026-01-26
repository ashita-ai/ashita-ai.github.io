---
layout: post
title: "Technical Debt as Strategy"
date: 2025-01-15
---

In 2017, Segment's engineering team found themselves ["falling from the microservices tree, hitting every branch on the way down."](https://segment.com/blog/goodbye-microservices/) What started as a sensible migration (one service per integration destination) had become a nightmare. Velocity plummeted. Defect rate exploded. They abandoned microservices and returned to a monolith. Three years later, Twilio acquired them for [$3.2 billion](https://techcrunch.com/2020/10/12/twilio-confirms-it-is-buying-segment-for-3-2b-in-an-all-stock-deal/).

The architecture they fled back to was the one they had labeled "technical debt." It turned out to be strategic advantage.

Most teams are too debt-averse. The debt-tolerant are winning. Clean code is a luxury you earn after you know what to build.

## The real killer

The [Startup Genome Report](https://startupgenome.com/article/premature-scaling-is-the-1-killer-of-startups) analyzed 3,200 startups: 74% of failures came from premature scaling. The pattern is always the same. A team imagines Google-scale traffic, builds Google-scale infrastructure, burns runway on systems that never see the load. Meanwhile, the simple Django app their competitor shipped is serving real users.

The startups that die are not the ones that picked the wrong database. They are the ones that spent six months picking while their competitors shipped.

## The AI wrinkle

OpenAI's token costs dropped [90% in one year](https://fortune.com/2025/04/04/ai-cost-collapse-tech-startups/). The code you are perfecting today might be irrelevant in six months. In a world where the best model changes every quarter, over-engineering is the real risk.

## The debt that matters

Not all shortcuts are equal.

Architecture debt is recoverable. You can refactor, migrate, rewrite. The code is messy but the outputs are correct.

[Data quality debt](/blog/the-data-platform-decisions-that-haunt-you/) is different. Bad data produces bad decisions. Bad decisions compound. Unity did not have architecture debt. They had data debt: incorrect inputs that [poisoned their ML model](https://www.montecarlodata.com/blog-bad-data-quality-examples/) and cost them $110 million.

Debt on *how* you build is acceptable. Debt on *what you produce* is dangerous. Ship messy code that works. Do not ship systems that produce wrong answers.

## Debt as default

Some teams treat debt as a temporary evil. Others treat it as the baseline.

Etsy has deployed to production [over 50 times a day](https://www.simform.com/blog/etsy-devops-case-study/). Their philosophy: "developers are happy when they're shipping product." Speed is not a phase they will grow out of. Speed is the product.

Basecamp runs a [9-year-old Rails monolith](https://dev.37signals.com/vanilla-rails-is-plenty/) with 400 controllers and 500 models, serving millions of users daily. DHH calls it the "majestic monolith." Their advice: stay in it as long as you can.

These are not companies that failed to modernize. They are companies that decided the modernization treadmill was the trap.

## When to pay it down

Technical debt carries interest. Unlike financial debt, that interest increases with scale.

In 2011, LinkedIn had eight years of accumulated shortcuts. Deployments had slowed to once every two weeks. Kevin Scott, their new head of engineering, found that ["the more engineers we added to the team, the slower things got."](https://www.linkedin.com/pulse/when-your-tech-debt-comes-due-kevin-scott)

Their response was Project InVersion: a two-month feature freeze where every engineer worked on infrastructure. Deployments went from biweekly to [three times daily](https://www.linkedin.com/pulse/case-study-linkedins-2011-operation-inversion-through-gene-kim-dht2c).

The difference between debt as asset and debt as powder keg comes down to where it lives. Interest payments are only triggered when you touch that code. Crufty but stable modules can sit forever. Debt in high-churn areas compounds with every commit.

But if you wait until adding engineers slows you down, you have already waited too long. That is LinkedIn in 2011, not Etsy in 2009.

## The leading indicators

Watch for these:

**Onboarding decay.** New engineers used to ship in their first week. Now it takes a month. The codebase has become oral tradition.

**Estimation drift.** Everything takes 2x the estimate. Not because engineers are bad at estimating, but because the invisible tax keeps growing.

**Avoidance patterns.** Engineers route around certain modules instead of through them. "Don't touch that" becomes tribal knowledge.

**Workaround accumulation.** You are building scaffolding around the codebase instead of extending it. Each workaround adds interest to the principal.

By the time velocity drops, you are already in crisis. The leading indicators show up months earlier, in how engineers *behave* around the code.

---

The best architecture is the one that ships. The leading indicator that you have waited too long: engineers route around the codebase instead of through it.
