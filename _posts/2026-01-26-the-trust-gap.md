---
layout: post
title: "The Trust Gap"
date: 2026-01-26
---

In 1770, Wolfgang von Kempelen unveiled "The Turk," a chess-playing automaton that defeated Napoleon Bonaparte and Benjamin Franklin. It toured Europe for decades as a marvel of artificial intelligence. It was a fraud. A chess grandmaster hid inside, moving the pieces.

250 years later, we're still doing this.

## The Wizard of Oz decade

**2009-2017: Expensify** marketed "SmartScan" as AI that automatically processed expense receipts. Reality: [Mechanical Turk workers](https://theoutline.com/post/2520/strangers-are-looking-at-your-data-for-pennies) paid 2 cents per receipt to transcribe them manually. One worker discovered strangers' Uber receipts with full names and home addresses. Boarding passes. Medical receipts. Bank account numbers. The CEO admitted they had used human labor since 2009.

**2015-2018: Facebook M** was announced as an AI assistant that could make purchases, order food, and book appointments. Reality: [no more than 30% of answers](https://en.wikipedia.org/wiki/M_(virtual_assistant)) were ever served by the AI system. Over 70% required human operators who took over conversations without users knowing. Quietly shut down in January 2018.

**2024-2025: Presto Automation** became the [SEC's first "AI-washing" enforcement](https://www.sec.gov/files/litigation/admin/2025/33-11352.pdf) against a public company. The company claimed "Presto Voice" eliminated human drive-thru order-taking. Reality: over 70% of orders required human agents in the Philippines. At the majority of locations, 100%.

The pattern is consistent: company raises money on AI claims, uses humans to fake capabilities, gets caught or quietly shuts down. Repeat.

## Why executives are right to distrust AI

[67% of CEOs](https://www.marketing-interactive.com/ceos-still-trust-intuition-over-data-driven-insights-says-kpmg-study) have prioritized intuition over data-driven insights, according to KPMG. The instinct is to read this as irrational. It is not. It is the appropriate response to an industry that has repeatedly lied to them.

When Presto Automation tells you their AI handles drive-thru orders, but workers in Manila are actually taking the calls, you learn to discount AI claims. When Expensify tells you SmartScan uses machine learning, but strangers on Mechanical Turk are reading your receipts, you learn that "AI-powered" often means "humans we're not telling you about."

The trust gap is not a communication problem. It is an earned reputation.

## Consumer distrust follows

The skepticism has spread. [53% of consumers](https://consumergoods.com/53-consumers-distrust-ai-enabled-search-results-gartner) now distrust AI-powered search results and summaries. 41% say AI overviews make search more frustrating than traditional methods. [61% want an option](https://www.marketingdive.com/news/more-than-half-of-consumers-are-wary-of-ai-powered-search-gartner/759451/) to disable AI summaries entirely.

This is not technophobia. This is pattern recognition. Consumers have watched AI search confidently cite sources that do not exist, summarize articles it clearly did not read, and present hallucinations as facts. They have adjusted their priors accordingly.

## The trust paradox

Here is the counterpoint that makes this interesting: Google's [2025 DORA report](https://dora.dev/research/2025/dora-report/) found that 90% of developers now use AI in production. But only 70% trust what they are deploying.

Run the math: [27% of production AI systems are running on hope](/blog/the-cost-of-being-wrong/). That post is about the technical reasons: AI fails silently with confident wrongness. This post is about the historical reasons: the industry spent a decade faking it.

This creates a strange dynamic. Organizations that deploy AI learn its actual capabilities and limitations. Organizations that do not deploy remain skeptical based on the Wizard of Oz decade. The [pilot graveyard](/blog/the-ai-pilot-graveyard/) is full of initiatives that never reached the point where trust could be established through experience.

The companies stuck in pilot purgatory are not being irrational. They are responding rationally to incomplete information and an industry that has given them every reason to be skeptical. But the 27% who are using AI they do not trust are not being rational either. They have deployed anyway and are hoping for the best.

## What actually earns trust

The solution is not better AI marketing. It is not "building trust" through communication strategies. It is shipping things that actually work and being honest when they do not.

Three patterns separate companies that earn trust from those that do not:

**Ship what works on day one.** Not AI that "will improve with more data." Not AI that works in demos but fails in production. If your AI cannot deliver value immediately, you are asking users to extend credit you have not earned.

**Disclose limitations before users discover them.** Every AI system has failure modes. The question is whether users find them or you tell them first. Presto's problem was not that humans assisted with orders. It was that they claimed humans were not involved. Transparency about limitations builds more trust than silence about capabilities.

**Measure outcomes, not accuracy.** A model with 95% accuracy that nobody uses has earned nothing. A model with 80% accuracy that changes how your team operates has demonstrated value. [Metrics that show the model is healthy](/blog/healthy-metrics-broken-agent/) mean nothing if the business outcome is not there.

## The inheritance problem

If you are building AI today, you are paying for the industry's sins. The default assumption from executives and consumers is that your AI claims are inflated. That your demo is not representative of production. That somewhere behind the curtain, there are humans you are not mentioning.

This is unfair if your AI actually works. It is also the reality.

The only way out is through. Ship to production. Be transparent about what works and what does not. Let users discover through experience that your system does what you claim. Trust is rebuilt one honest interaction at a time.

## What I am still figuring out

The 27% number troubles me. Those teams know they do not trust their AI and deployed it anyway. I have not found good research explaining this behavior. Possible explanations: competitive pressure to ship, inability to measure trust concretely, or the belief that production feedback will eventually justify the deployment. Each has different implications. If the industry is deploying despite distrust because of competitive pressure, that is a race to the bottom. If teams cannot measure trust, that is a tooling problem we could solve. I do not know which it is.

---

Expensify used Mechanical Turk workers from 2009 to 2017. Facebook M used human operators for over 70% of responses. Presto used Filipino workers to take drive-thru orders while claiming AI did it. The pattern lasted a decade.

The Turk was exposed in 1857 when a fire revealed the chess master hiding inside. We should not need another 250 years to learn the same lesson again.
