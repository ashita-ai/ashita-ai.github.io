---
layout: post
title: "The Trust Gap"
date: 2026-01-27
---

Google's [2025 DORA report](https://dora.dev/research/2025/dora-report/) found that 90% of developers now use AI at work. It also found that [30% report little or no trust](https://cloud.google.com/blog/products/devops-sre/announcing-the-2025-dora-report) in the AI-generated code they are shipping.

Read that again. Nearly a third of production AI systems are deployed by teams who do not trust them.

This is not a bug. It is the predictable outcome of an industry that spent fifteen years faking it.

## The Wizard of Oz decade

In 1770, Wolfgang von Kempelen unveiled "The Turk," a chess-playing automaton that defeated Napoleon Bonaparte and Benjamin Franklin. It toured Europe for 84 years as a marvel of artificial intelligence. It was a fraud. A chess grandmaster hid inside, moving the pieces.

The tech industry ran the same con.

**Expensify** marketed "SmartScan" as AI that automatically processed expense receipts. For eight years, from 2009 to 2017, [Mechanical Turk workers](https://theoutline.com/post/2520/strangers-are-looking-at-your-data-for-pennies) transcribed them manually for 2 cents each. One worker discovered strangers' Uber receipts with full names and home addresses. Boarding passes. Medical records. Bank account numbers.

**Facebook M** was announced as an AI assistant in 2015. Reality: [no more than 30% of responses](https://en.wikipedia.org/wiki/M_(virtual_assistant)) were ever served by the AI. Human operators handled the rest, taking over conversations without users knowing. Quietly shut down in 2018.

**Presto Automation** claimed "Presto Voice" eliminated human drive-thru order-taking. In 2025, it became the [SEC's first "AI-washing" enforcement](https://www.sec.gov/files/litigation/admin/2025/33-11352.pdf) against a public company. Over 70% of orders required human agents in the Philippines. At the majority of locations, 100%.

Company raises money on AI claims. Uses humans to fake capabilities. Gets caught or quietly shuts down. Repeat.

## The rational response

[67% of CEOs](https://www.marketing-interactive.com/ceos-still-trust-intuition-over-data-driven-insights-says-kpmg-study) prioritize intuition over data-driven insights. [53% of consumers](https://consumergoods.com/53-consumers-distrust-ai-enabled-search-results-gartner) distrust AI-powered search results. [61% want an option](https://www.marketingdive.com/news/more-than-half-of-consumers-are-wary-of-ai-powered-search-gartner/759451/) to disable AI summaries entirely.

This is not technophobia. This is Bayesian updating. When "AI-powered" meant "humans we're not telling you about" for a decade, skepticism is the correct prior.

The trust gap is not a communication problem. It is an earned reputation.

## The strange part

So executives are right to be skeptical. Consumers are right to be skeptical. Developers themselves are skeptical.

And yet the code ships anyway.

The DORA data shows 90% adoption despite 30% distrust. That is not a contradiction. It is a confession. Teams are deploying AI they do not believe in because they feel they have no choice. Competitive pressure. Executive mandates. Fear of falling behind.

This creates two failure modes running simultaneously.

The [pilot graveyard](/blog/the-ai-pilot-graveyard/) is full of companies that never deployed because they could not get past their rational skepticism. They are stuck validating technology while competitors ship.

But the teams deploying despite distrust are not in better shape. They are shipping systems they expect to fail, hoping production feedback will eventually justify the bet. [That post](/blog/the-cost-of-being-wrong/) describes what happens when those systems fail silently with confident wrongness.

Neither path is good. One group is paralyzed by earned distrust. The other is ignoring their own judgment.

## The exception

Stripe does not ask merchants to trust Radar. They publish [exactly how it works](https://stripe.com/radar): which signals it monitors, how it weighs transaction patterns, what happens when it flags a payment.

Then they publish results against industry baselines. Radar users saw a [17% decrease in dispute rates](https://stripe.com/lp/2025-state-of-ai-and-fraud) while global ecommerce fraud rose 15%. They recovered $6 billion in legitimate transactions that would have been incorrectly declined.

Merchants do not trust Radar because Stripe asked nicely. They trust it because they can see inside it and verify the numbers independently.

Contrast this with Presto. The problem was not that humans assisted with orders. Plenty of AI systems use human fallbacks. The problem was claiming humans were not involved while workers in the Philippines took the calls.

The difference is not transparency as a virtue. It is transparency as a mechanism. Stripe's approach works because it converts trust from a social question ("do I believe this company?") into an empirical one ("can I verify these claims?").

## The race

Here is what I cannot figure out.

If 30% of teams are shipping AI they do not trust, one of two things is happening.

**Possibility one:** Competitive pressure is forcing premature deployment. Teams know their AI is not ready but ship anyway because everyone else is shipping. This is a race to the bottom. The industry is building on foundations it does not believe in, and the collapse will come when enough systems fail at once.

**Possibility two:** Distrust is the wrong frame. Teams are not "trusting" or "distrusting" their AI. They are treating it as a tool that requires verification rather than a system that requires faith. The 30% who report low trust may actually have the healthiest relationship with their AI: they deploy it, but they watch it.

I do not know which is true. The DORA data does not distinguish between "I deployed despite distrust because my VP made me" and "I deployed despite distrust because I have good monitoring in place."

If it is the first, we are in trouble. If it is the second, the trust gap might be exactly what healthy AI adoption looks like.

---

The Turk toured Europe for 84 years before a fire revealed the chess master hiding inside. The Wizard of Oz decade lasted from 2009 to 2025.

Stripe publishes how Radar works. Anthropic submits Claude to external red teams. The companies escaping the trust gap are not asking for trust. They are making it unnecessary.
