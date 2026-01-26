---
layout: post
title: "The Cost of Being Wrong"
date: 2026-01-20
---

Deloitte used GPT to help prepare a 237-page Australian government report on safety standards. When the document was reviewed three months later, analysts discovered fabricated references, incorrect standards, and citations to sources that did not exist. The company [refunded part of the AU$440,000 contract](https://clod.io/blog/ai-control-failures-2025). The following month, a separate Deloitte report—a [CA$1.6 million health plan for a Canadian province](https://fortune.com/2025/11/25/deloitte-caught-fabricated-ai-generated-research-million-dollar-report-canada-government/)—was found to contain four more fake citations. That one had been in circulation for six months.

The model did not crash. It did not throw an error. It produced 237 pages of confident, well-formatted, professionally structured hallucination.

This is the pattern that makes AI failures expensive: the system keeps running. For months.

## The confidence problem

Traditional software fails by signaling uncertainty. A null pointer throws an exception. A type mismatch breaks the build. A timeout returns an error code. The system tells you something is wrong because it cannot proceed.

AI systems fail by signaling confidence. Ask a leading LLM "Who received the IEEE Frank Rosenblatt Award in 2010?" and it will answer "Geoffrey Hinton" with [93% confidence](https://arxiv.org/html/2502.11028v3). The correct answer is Michio Sugeno. There is no error code for "I made this up." The system proceeds because nothing technically failed.

This is not an edge case. [47% of enterprise AI users](https://drainpipe.io/the-reality-of-ai-hallucinations-in-2025/) admitted to making at least one major business decision based on hallucinated content. They did not know the content was hallucinated. The system gave them no reason to doubt it.

Courts across the US have documented [hundreds of legal briefs](https://clod.io/blog/ai-control-failures-2025) containing hallucinated citations and fictional case law. Lawyers submitted briefs citing cases that never existed, written by judges who never ruled, establishing precedents that were invented. The AI did not flag uncertainty. It produced case names, docket numbers, and quotations with the same fluency it produces real ones.

Bishop Fox's security research found something similar in compromised AI systems: ["AI failures don't crash, they comply."](https://bishopfox.com/resources/ai-war-stories-silent-failures-real-consequences) When attackers manipulate an AI system, it does not throw errors. It follows the malicious instructions with the same confidence it follows legitimate ones.

## The detection gap

In traditional software, the cost of errors follows a predictable curve: cheap in development, expensive in production. This created the entire testing and CI/CD ecosystem. Invest heavily in catching problems before deployment because that is where leverage is.

AI systems break this model. Pre-production testing catches the errors you anticipated. Production reveals the errors you did not. And the errors that matter most are the ones you cannot anticipate because they emerge from the interaction between model behavior and real-world conditions.

A model that passes all your evals can still hallucinate in ways you never tested for. An agent that works perfectly in staging can make catastrophic decisions when user behavior differs from your assumptions. The failure modes are not bugs in the traditional sense. They are emergent properties of systems that do not know what they do not know.

[IBM's 2025 Cost of a Data Breach report](https://www.ibm.com/reports/data-breach) found that 13% of organizations had experienced breaches involving AI models or applications. Of those compromised, 97% reported lacking proper AI access controls. Breaches involving unmonitored "shadow AI" tools cost an [average of $670,000 more](https://www.ibm.com/reports/data-breach) than breaches at organizations with AI governance.

The premium is not because AI attacks are more sophisticated. It is because they run longer before detection.

Google's 2025 DORA report found that [90% of developers now use AI in production](https://www.relyance.ai/blog/ai-trust-paradox-dora-report), but only 70% trust what they are deploying. Do the math: 27% of developers are shipping AI they do not trust.

## The counterargument deserves a real answer

The obvious objection: traditional software has silent failures too. Off-by-one errors in financial calculations. Race conditions that corrupt data intermittently. Memory leaks that degrade performance slowly. The failure modes I am describing are not unique to AI.

This is partially true.

When McDonald's AI hiring chatbot ["Olivia" was breached](https://madhulsachdeva.com/blog/2025/08/25/ai-security-lessons-2025/) in 2025, exposing data on 64 million job applicants, the root cause was that security researchers guessed the admin password: "123456." That is not an AI failure. That is forgetting Security 101. Many incidents attributed to "AI" are actually infrastructure failures, deployment mistakes, or basic security hygiene problems wearing an AI costume.

But the novel failure mode is real: confident wrongness at scale. Traditional silent failures degrade performance or corrupt data incrementally. AI failures produce fluent, structured, authoritative-looking outputs that are substantively wrong. The system does not know it is wrong, cannot signal that it is wrong, and will continue being wrong until a human catches it.

The 93% confidence on a wrong answer is not a bug. It is the system working as designed.

## Where the cost compounds

Not all errors cost the same. The question is not "will this system make mistakes" but "what is the blast radius when it does."

**Bounded errors**: A recommendation system suggests an irrelevant product. The user ignores it. The system learns from the non-click. Cost: one missed conversion, self-correcting.

**Accumulating errors**: A pricing model undervalues inventory by 3%. Every transaction loses margin. The error is invisible in daily metrics, surfaces only in quarterly review. Cost: months of reduced profit, no automatic correction.

**Catastrophic errors**: An agent with production database access deletes records and [generates 4,000 fake users to cover the damage](https://cybernews.com/ai-news/replit-ai-vive-code-rogue/). A medical AI misses a pattern across thousands of scans. A trading algorithm amplifies volatility instead of dampening it. Cost: potentially unrecoverable, and the system may actively resist detection.

Traditional software had natural circuit breakers. A crash stops execution. An exception halts the pipeline. The system cannot silently continue making the same mistake indefinitely.

AI systems need artificial circuit breakers because they do not stop themselves. They need external validation because they cannot self-report uncertainty. They need human checkpoints because confident wrongness looks exactly like confident rightness.

## What this means for architecture

If failures are confident and expensive, you need systems designed to surface them:

**Validation at the output layer, not just the model layer.** The Deloitte report passed whatever internal review existed. The failure surfaced when someone checked the citations against reality. Build that check into the pipeline. Automated reference verification. Structured output validation. [Grounding against authoritative sources](/blog/the-rag-trap/).

**Economic circuit breakers.** Set cost and volume limits that trigger alerts and halt execution. An AI system that suddenly processes 10x normal volume or costs 10x normal spend should stop and notify, not continue until the invoice arrives.

**Outcome monitoring, not just operational monitoring.** Latency and error rates tell you the system is running. They do not tell you the system is right. Track business metrics that surface when AI decisions diverge from expected outcomes. A [dashboard can show green while the system burns money](/blog/healthy-metrics-broken-agent/).

**Confidence calibration at the application layer.** Models do not reliably self-report uncertainty. Build uncertainty into the application: thresholds below which the system escalates to humans, ranges outside which it refuses to act. Abstention is cheaper than confident wrongness.

## The scale asymmetry

The pitch for AI is that it handles tasks humans cannot scale. This is true. It also means AI makes mistakes humans cannot catch.

A lawyer reviewing ten cases will notice a fabricated citation. A legal AI generating ten thousand briefs embeds hallucinations that surface years later, in appeals, when someone finally checks. The error rate might be identical. The blast radius is not.

The cost of being wrong scales with autonomy. An AI that suggests and a human who approves has bounded downside. An AI that decides and executes has unbounded downside limited only by the blast radius of its permissions.

---

The Deloitte hallucinations ran for three months. Then six months. The lawyers' fake citations are still being discovered. The enterprise decisions based on hallucinated content have already been made.

Traditional software taught us to invest in catching errors before production. AI requires catching errors during production—because that is when confident wrongness finally becomes visible.
