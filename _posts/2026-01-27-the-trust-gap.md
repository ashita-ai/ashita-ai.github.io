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

**Expensify** marketed "SmartScan" as AI that automatically processed expense receipts. From 2009 to 2012, [Mechanical Turk workers](https://theoutline.com/post/2520/strangers-are-looking-at-your-data-for-pennies) transcribed them manually for 2 cents each. One worker discovered strangers' Uber receipts with full names and home addresses. Boarding passes. Medical records. Bank account numbers. The practice resurfaced in 2017 when reporters caught them using crowdsourced labor again.

**Facebook M** was announced as an AI assistant in 2015. Reality: [no more than 30% of responses](https://en.wikipedia.org/wiki/M_(virtual_assistant)) were ever served by the AI. Human operators handled the rest, taking over conversations without users knowing. Quietly shut down in 2018.

**Presto Automation** claimed "Presto Voice" eliminated human drive-thru order-taking. In 2025, it became the [SEC's first "AI-washing" enforcement](https://www.sec.gov/files/litigation/admin/2025/33-11352.pdf) against a public company. Over 70% of orders required human agents in the Philippines. At the majority of locations, 100%.

Company raises money on AI claims. Uses humans to fake capabilities. Gets caught or quietly shuts down. Repeat.

## The rational response

[67% of CEOs](https://www.marketing-interactive.com/ceos-still-trust-intuition-over-data-driven-insights-says-kpmg-study) prioritize intuition over data-driven insights. [53% of consumers](https://consumergoods.com/53-consumers-distrust-ai-enabled-search-results-gartner) distrust AI-powered search results. [61% want an option](https://www.marketingdive.com/news/more-than-half-of-consumers-are-wary-of-ai-powered-search-gartner/759451/) to disable AI summaries entirely.

This is not technophobia. This is pattern recognition. When "AI-powered" meant "humans we are not telling you about" for a decade, skepticism is the rational response.

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

## The Copilot question

GitHub claims 90% of Fortune 100 companies use Copilot. Copilot does not publish model internals. It does not offer Stripe-style verification metrics. Yet adoption is massive.

This seems to contradict the Stripe thesis. If transparency converts trust from social to empirical, why did Copilot succeed without it?

The answer is structural. Copilot operates in a domain where verification is built into the workflow. Every suggestion goes through code review. Every output gets tested. The human-in-the-loop is not optional—it is the entire development process. Copilot does not need to publish accuracy metrics because your CI pipeline is the accuracy metric.

Radar and Copilot both work because they make verification cheap. Radar publishes the numbers. Copilot relies on your existing review process. Neither asks you to trust the AI. Both assume you will check.

## What verification looks like

The 30% who report low trust are not the problem. The problem is the gap between "I distrust this" and "I verify this."

Verification for AI code generation looks different than verification for fraud detection. You cannot publish a single accuracy number for Copilot because accuracy depends on context, language, and use case. But you can measure:

- **Review time delta.** How much longer do PRs with AI-generated code take to review? If the answer is "the same," your reviewers are not catching AI mistakes. If the answer is "50% longer," the trust gap is doing its job.
- **Post-merge defect rate.** Track bugs introduced by AI-assisted commits versus human-only commits. If AI commits have higher defect rates, you have a verification problem. If they are the same or lower, your review process is working.
- **Suggestion acceptance rate by author.** Senior engineers rejecting 60% of suggestions while juniors accept 90% is a signal. The juniors may be shipping code they do not understand.

The companies that survive the trust gap are not the ones who learned to trust AI. They are the ones who built verification into every deployment path.

## The real divide

The DORA data shows two populations that look identical in the numbers but are completely different in practice.

Population one: Teams shipping AI because the VP mandated it. They distrust the outputs, skip verification because it slows them down, and hope nothing breaks. When it breaks, they blame the tool.

Population two: Teams shipping AI because they verified it works. They distrust the outputs, verify anyway, and catch the failures before production. When something slips through, they improve the verification.

Both report low trust. Both show 90% adoption. One is a race to the bottom. The other is healthy engineering.

The trust gap is not going away. The question is whether your distrust makes you more careful or just more anxious.

---

The Turk toured Europe for 84 years before fire exposed the grandmaster inside. The Wizard of Oz decade ran from 2009 until the SEC started enforcing.

Stripe publishes fraud rates. Anthropic publishes red team results. GitHub trusts your code review process. The companies escaping the trust gap are not building more trustworthy AI. They are building AI that assumes you will verify.

The 30% who distrust AI-generated code are not behind. They are ahead—if their distrust drives verification instead of paralysis.
