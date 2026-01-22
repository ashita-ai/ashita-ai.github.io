---
layout: post
title: "The Trust Gap"
date: 2026-01-27
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

Here is the counterpoint that makes this interesting: Google's [2025 DORA report](https://dora.dev/research/2025/dora-report/) found that 90% of developers now use AI at work. But only 24% trust it "a lot" or "a great deal." Another 49% trust it "somewhat." The remaining [30% report little or no trust](https://cloud.google.com/blog/products/devops-sre/announcing-the-2025-dora-report) in the AI-generated code they are shipping.

That means roughly one in four production AI systems are deployed by teams who do not trust them. [That post](/blog/the-cost-of-being-wrong/) is about the technical reasons: AI fails silently with confident wrongness. This post is about the historical reasons: the industry spent a decade faking it.

This creates a strange dynamic. Organizations that deploy AI learn its actual capabilities and limitations. Organizations that do not deploy remain skeptical based on the Wizard of Oz decade. The [pilot graveyard](/blog/the-ai-pilot-graveyard/) is full of initiatives that never reached the point where trust could be established through experience.

The companies stuck in pilot purgatory are not being irrational. They are responding rationally to incomplete information and an industry that has given them every reason to be skeptical. But the teams shipping AI they do not trust are not being rational either. They have deployed anyway and are hoping for the best.

## What actually earns trust

The solution is not better AI marketing. It is not "building trust" through communication strategies. It is being specific about what your AI does and does not do, then proving it.

Stripe built trust in their fraud detection AI by publishing exactly how it works. Not "we use machine learning." They document [which signals the system monitors](https://stripe.com/radar), how it weighs transaction patterns, what happens when it flags a payment. Result: Stripe Radar users saw a [17% decrease in dispute rates](https://stripe.com/lp/2025-state-of-ai-and-fraud) while global ecommerce fraud rose 15%. They recovered $6 billion in legitimate transactions that would have been incorrectly declined. Merchants trust Radar because they can see inside it.

Contrast this with Presto. The problem was not that humans assisted with orders. Plenty of AI systems use human fallbacks. The problem was claiming humans were not involved. Stripe says "here is how our AI works and here are its limitations." Presto said "our AI handles everything" while workers in the Philippines took the calls.

Three patterns separate companies that earn trust from those that do not:

**Be specific about what data goes where.** Not "we take privacy seriously." Stripe publishes which signals they monitor. DuckDuckGo explains that their AI proxy anonymizes requests so third-party models never see user data. Anthropic provides 100% audit logs for enterprise clients. Specificity is credibility.

**Publish third-party verification.** Internal metrics mean nothing. Stripe publishes fraud reduction percentages measured against industry baselines. Anthropic submits Claude to external red teams and publishes the results. If you cannot point to independent validation, you are asking users to trust your word. After the Wizard of Oz decade, your word is not enough.

**Acknowledge limitations before users discover them.** Every AI system has failure modes. [Metrics that show the model is healthy](/blog/healthy-metrics-broken-agent/) mean nothing if users find the edge cases first. The companies that build trust tell you what their AI cannot do. The companies that lose trust wait for users to find out.

## The inheritance problem

If you are building AI today, you are paying for the industry's sins. The default assumption from executives and consumers is that your AI claims are inflated. That your demo is not representative of production. That somewhere behind the curtain, there are humans you are not mentioning.

This is unfair if your AI actually works. It is also the reality.

Stripe did not earn trust by asking for it. They earned it by publishing how Radar works, submitting to third-party measurement, and letting the fraud reduction numbers speak. The path out of the trust gap is not communication. It is evidence.

## What I am still figuring out

The DORA finding troubles me. Teams that report low trust in AI are deploying it anyway. I have not found good research explaining this behavior. Possible explanations: competitive pressure to ship, inability to measure trust concretely, or the belief that production feedback will eventually justify the deployment. Each has different implications. If the industry is deploying despite distrust because of competitive pressure, that is a race to the bottom. If teams cannot measure trust, that is a tooling problem we could solve. I do not know which it is.

---

Expensify. Facebook M. Presto. The Wizard of Oz decade lasted from 2009 to 2025. The Turk toured Europe for 84 years before a fire revealed the chess master hiding inside.

Stripe publishes how Radar works. Anthropic submits Claude to external red teams. DuckDuckGo explains exactly what data their AI proxy does and does not see. The companies building trust are not asking for it. They are proving it.
