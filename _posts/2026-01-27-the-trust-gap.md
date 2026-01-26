---
layout: post
title: "The Trust Gap"
date: 2026-01-27
---

Google's [2025 DORA report](https://dora.dev/research/2025/dora-report/) found that 90% of developers now use AI at work. It also found that [30% report little or no trust](https://www.infoq.com/news/2025/09/dora-state-of-ai-in-dev-2025/) in the AI-generated code they are shipping.

Read that again. Nearly a third of production AI systems are deployed by teams who do not trust them.

This is not a bug. It is the predictable outcome of an industry that spent fifteen years faking it.

## The Wizard of Oz decade

In 1770, Wolfgang von Kempelen unveiled "The Turk," a chess-playing automaton that defeated Napoleon Bonaparte and Benjamin Franklin. It toured Europe for 84 years as a marvel of artificial intelligence. It was a fraud. A chess grandmaster hid inside, moving the pieces.

The tech industry ran the same con.

**Expensify** marketed "SmartScan" as AI that automatically processed expense receipts. From 2009 to 2012, [Mechanical Turk workers](https://qz.com/1141695/startup-expensifys-smart-scanning-technology-used-humans-hired-on-amazon-mechanical-turk) transcribed them manually for pennies each. One worker discovered strangers' Uber receipts with full names and home addresses. Boarding passes. Medical records. Bank account numbers. When caught in 2017, CEO David Barrett [admitted](https://blog.expensify.com/2017/11/10/our-commitment-to-your-privacy/) they had used MTurk since 2009.

**Facebook M** was announced as an AI assistant in 2015. Reality: [no more than 30% of responses](https://en.wikipedia.org/wiki/M_(virtual_assistant)) were ever served by the AI. Human operators handled the rest, taking over conversations without users knowing. Quietly shut down in 2018.

**Presto Automation** claimed "Presto Voice" eliminated human drive-thru order-taking. In 2025, it became the [SEC's first "AI-washing" enforcement](https://www.sec.gov/enforcement-litigation/administrative-proceedings/33-11352-s) against a public company. Over 70% of orders required human agents in the Philippines. At the majority of locations, 100%.

**Builder.ai**, a UK unicorn valued at hundreds of millions, claimed to "automate software development through cutting-edge AI." In June 2025, [an investigation revealed](https://vaultinum.com/blog/ai-washing-lessons-from-the-builder-ai-collapse) no real AI existed—just 700 human developers doing manual coding. The company collapsed with $37 million in frozen assets. Microsoft had integrated it into Azure.

**DoNotPay** marketed itself as the "world's first robot lawyer." The FTC [found](https://www.ftc.gov/news-events/news/press-releases/2025/02/ftc-finalizes-order-donotpay-prohibits-deceptive-ai-lawyer-claims-imposes-monetary-relief-requires) the company never tested if AI output matched human lawyer expertise, hired no attorneys, and produced documents that were "often incomplete, inaccurate or otherwise flawed." They settled for $193,000 in February 2025.

Company raises money on AI claims. Uses humans to fake capabilities. Gets caught or quietly shuts down. Repeat.

## The rational response

[53% of consumers](https://www.gartner.com/en/newsroom/press-releases/2025-09-03-gartner-survey-finds-53-percent-of-consumers-distrust-ai-powered-search-results0) distrust AI-powered search results. [61% want an option](https://www.marketingdive.com/news/more-than-half-of-consumers-are-wary-of-ai-powered-search-gartner/759451/) to disable AI summaries entirely. [77% of Americans](https://kpmg.com/us/en/media/news/trust-in-ai-2025.html) do not trust businesses to use AI responsibly.

This is not technophobia. This is pattern recognition. When "AI-powered" meant "humans we are not telling you about" for a decade, skepticism is the rational response.

The trust gap is not a communication problem. It is an earned reputation.

## The strange part

So consumers are right to be skeptical. Developers themselves are skeptical.

And yet the code ships anyway.

The [Stack Overflow 2025 Developer Survey](https://survey.stackoverflow.co/2025/ai) reveals the paradox in sharper detail. 84% of developers now use AI tools—up from 76% in 2024. But trust in AI accuracy has collapsed from 43% to 33%. Only 3% of developers "highly trust" AI output.

Usage went up. Trust went down. That is not adoption. That is coercion.

When asked what would still make them consult humans in an AI-dominated future, [75% said](https://stackoverflow.blog/2025/12/29/developers-remain-willing-but-reluctant-to-use-ai-the-2025-developer-survey-results-are-here) "when I don't trust AI's answers." Developers position themselves as the ultimate arbiters while shipping AI-generated code at scale because their employers require it.

The [pilot graveyard](/blog/the-ai-pilot-graveyard/) is full of companies that never deployed because they could not get past their rational skepticism. They are stuck validating technology while competitors ship.

But the teams deploying despite distrust are not in better shape. They are shipping systems they expect to fail, hoping production feedback will eventually justify the bet. [That post](/blog/the-cost-of-being-wrong/) describes what happens when those systems fail silently with confident wrongness.

Neither path is good. One group is paralyzed by earned distrust. The other is ignoring their own judgment.

## The Boeing parallel

This has happened before.

In 2018 and 2019, two Boeing 737 MAX aircraft crashed, killing 346 people. Investigations revealed that Boeing had rushed to match Airbus's A320, and engineers who raised safety concerns were told to ["not rock the boat"](https://pmc.ncbi.nlm.nih.gov/articles/PMC7351545/). A manager told one engineer: "You don't want to be upsetting executives."

Instead of redesigning hardware, Boeing relied on software—the MCAS system—to compensate for aerodynamic problems. Engineers [bragged](https://spectrum.ieee.org/how-the-boeing-737-max-disaster-looks-to-a-software-developer) they had "tricked" FAA regulators. After the crashes, a former senior manager said: "I would absolutely not fly a Max airplane. I've worked in the factory where they were built, and I saw the pressure employees were under to rush the planes out the door."

The pattern is identical to what DORA describes. Engineers knew the system was not ready. Competitive pressure overrode safety concerns. The code shipped anyway.

Boeing's lesson applies directly to AI: "Even the best companies can fall prey to competitive pressures as they seek to stay financially viable, grow faster, or profit by shipping products more quickly and cheaply."

The aviation industry relies on public trust. So does AI. And every high-profile failure—every UnitedHealthcare algorithm denying care with a [90% error rate on appeals](https://www.cbsnews.com/news/unitedhealth-lawsuit-ai-deny-claims-medicare-advantage-health-insurance-denials/), every Cruise robotaxi [dragging a pedestrian over 20 feet](https://www.justice.gov/usao-ndca/pr/cruise-admits-submitting-false-report-influence-federal-investigation-and-agrees-pay), every chatbot confidently hallucinating legal citations—erodes the foundation.

## The exception

Stripe does not ask merchants to trust Radar. They publish [exactly how it works](https://stripe.com/radar): which signals it monitors, how it weighs transaction patterns, what happens when it flags a payment.

Then they publish results against industry baselines. Radar users saw a [17% decrease in dispute rates](https://stripe.com/blog/using-ai-optimize-payments-performance-payments-intelligence-suite). They recovered over $6 billion in legitimate transactions that would have been incorrectly declined—a 60% year-over-year increase.

Merchants do not trust Radar because Stripe asked nicely. They trust it because they can see inside it and verify the numbers independently.

Contrast this with Presto. The problem was not that humans assisted with orders. Plenty of AI systems use human fallbacks. The problem was claiming humans were not involved while workers in the Philippines took the calls.

IBM takes a [similar approach](https://aif360.res.ibm.com/) with their AI Fairness 360 toolkit—open-sourcing 70+ fairness metrics and 10 bias mitigation algorithms so anyone can verify claims. They scored [95/100](https://www.lumenova.ai/blog/how-transparent-are-ai-companies/) on the Foundation Model Transparency Index, the highest in history.

The difference is not transparency as a virtue. It is transparency as a mechanism. These companies convert trust from a social question ("do I believe them?") into an empirical one ("can I verify their claims?").

## Trust but verify

During the 1987 INF Treaty negotiations, Ronald Reagan popularized the Russian proverb "Doveryai, no proveryai"—trust, but verify. The context was nuclear weapons, where a single error could destroy civilization.

NIST has [adopted this framework](https://tsapps.nist.gov/publication/get_pdf.cfm?pub_id=935075) for AI assurance: "Even after robust verification and validation for all key assurance properties, the system must never be regarded as always safe, and must be continuously evaluated and challenged."

This reframes the trust gap. The 30% who distrust AI are not paranoid. They are practicing what [researchers call](https://arxiv.org/html/2505.09747v1) "healthy distrust"—skepticism that establishes "preconditions for meaningful trust" rather than opposing it.

The problem is not that 30% of developers distrust their AI. The problem is that the industry has not built verification infrastructure to match deployment velocity. Developers are asked to ship systems they cannot verify, then blamed for lacking trust.

[72% of executives](https://www.ey.com/en_ro/newsroom/2025/08/ey-survey-ai-adoption-outpaces-governance-as-risk-awareness) claim their organizations have "integrated and scaled AI." Only one-third have proper protocols for responsible AI governance. The executives trust. The developers doubt. The verification does not exist.

## What I am still figuring out

The DORA data does not distinguish between "I deployed despite distrust because my VP made me" and "I deployed despite distrust because I have good monitoring in place."

If it is the first, we are watching Boeing 737 MAX happen again in slow motion across the entire software industry. Competitive pressure forcing premature deployment. Engineers overruled. The collapse comes when enough systems fail at once.

If it is the second, the trust gap might be exactly what healthy AI adoption looks like. Healthy distrust drives careful work. It demands verification infrastructure. It treats AI as a tool that requires continuous challenge rather than a system that requires faith.

I suspect the answer varies by team. Some are being coerced. Some are being careful. The aggregate statistics cannot tell us which is which.

But I know this: the companies escaping the trust gap are not asking for trust. They are making it unnecessary. Stripe publishes how Radar works. IBM open-sources their fairness metrics. Anthropic submits Claude to external red teams.

---

The Turk toured Europe for 84 years before a fire revealed the chess master hiding inside. The Wizard of Oz decade lasted from 2009 to 2025.

The industry earned this distrust. It cannot communicate its way out. It has to build verification infrastructure that makes trust unnecessary—or watch the 30% who doubt become the 100% who leave.
