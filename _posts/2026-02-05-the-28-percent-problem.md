---
layout: post
title: "The 28% Problem"
date: 2026-02-05
---

A fintech startup I worked with shipped something new every quarter. They also left the previous quarter's work unfinished every quarter. Ten engineers, ten business and product people, and a roadmap that reset every twelve weeks. By my estimate, they wasted roughly 40% of their engineering capacity on projects that were abandoned before they could deliver value.

The problem was not execution. The engineers were good. The problem was that leadership kept placing bets on projects with vague definitions and no appetite constraints. "Build a recommendation engine" is not a strategy. It is a wish.

The fix was not a better roadmap tool or a new planning methodology. It was a one-page document that forced hard choices.

## The two failure modes

Technology strategy documents fall into two camps.

The first is the 40-page deck filled with vague language nobody understands. "Leverage AI to drive synergistic value across the platform ecosystem." These documents exist to look impressive in board meetings. Nobody uses them to make decisions. Nobody references them when choosing between two architectures. They are artifacts of a planning process, not tools for execution.

The second is the two-page document with massive sweeping claims borrowed from a bigger company. "We will be cloud-native and API-first." This is not a strategy. This is a LinkedIn post. Saying you will be API-first does not tell an engineer whether to build or buy a payments integration. It does not tell a PM whether the mobile app is more important than the web dashboard.

Both failure modes share the same root cause: they describe aspirations instead of constraints.

[MIT Sloan research](https://sloanreview.mit.edu/article/no-one-knows-your-strategy-not-even-your-top-leaders/) found that only 28% of executives and middle managers responsible for executing strategy could list their company's strategic priorities. Not employees. Managers. The people whose job is to execute the strategy cannot name it.

The documents exist. They are not working.

## Your strategy is what you shipped

Fred Nickols [wrote in 2016](https://www.nickols.us/strategy_is_execution.pdf) that strategy as contemplated and strategy as realized are often two very different matters. The document on your wiki is not your strategy. Your strategy is what you actually built, what you actually prioritized, what you actually said no to.

This is uncomfortable because it means your real strategy is visible to everyone. If you say "mobile-first" but your mobile app has not been updated in eighteen months, your strategy is not mobile-first. If you say "customer obsession" but your support queue takes four days, your strategy is not customer obsession.

The document does not create the strategy. The document reveals whether you have one.

## What betting teaches you

Two frameworks shaped how I think about this: [Shape Up](https://basecamp.com/shapeup) from Basecamp and Annie Duke's [Thinking in Bets](https://www.annieduke.com/books/).

They share an insight that most planning processes miss: good decisions are about managing appetite and capping downside, not predicting outcomes.

Shape Up uses a [betting table](https://basecamp.com/shapeup/2.2-chapter-08) where leadership commits to six-week cycles. The key constraint is that six weeks is the maximum. If a project is not done in six weeks, it does not automatically get an extension. This forces shaping work to fit an appetite, rather than estimating how long work will take and then padding.

Thinking in Bets argues that decision quality and outcome quality are different things. A good decision can have a bad outcome. A bad decision can get lucky. The goal is to make decisions you would be comfortable defending even if the outcome goes poorly.

Both frameworks force you to answer: what are we willing to spend on this? Not "how long will this take" (which invites negotiation and optimism). Not "what would be ideal" (which invites scope creep). What is our appetite? What is the most we are willing to lose if this does not work?

The fintech startup transformed when leadership started asking that question. They stopped placing bets on "recommendation engine" and started placing bets on "recommendation engine that improves conversion by 5%, built by two engineers in six weeks, using off-the-shelf embeddings." The constraint was the strategy.

## The litmus test

Sheryl Sandberg called Netflix's culture document ["maybe the most important document ever to come out of the Valley"](https://techcrunch.com/2013/01/31/read-what-facebooks-sandberg-calls-maybe-the-most-important-document-ever-to-come-out-of-the-valley/). What made it effective was not that it described Netflix's values. Every company has a values document. What made it effective was that it functioned as a litmus test.

The document told you what Netflix was and was not. If you wanted a family environment with job security, Netflix was not for you. If you wanted a professional sports team where performance determined tenure, you would thrive. The document did not try to be everything to everyone. It made a choice and accepted the consequences.

A technology strategy should work the same way. It should tell an engineer, on day one, how to make a decision when two reasonable paths exist. Build or buy? Speed or reliability? Features or infrastructure? If your strategy document cannot answer these questions, it is not a strategy. It is a mission statement.

The test is simple: can a new engineer read your strategy document and correctly predict how your team would decide a tradeoff they have never seen before? If not, the document is not doing its job.

## What fits on one page

After the fintech engagement, I started using a format that forces clarity. One page, five sections:

**What we are building this quarter.** Not a roadmap of features. A small number of bets (two to four) with specific outcomes and appetite constraints. "Reduce checkout abandonment by 15% with a re-engagement flow, two engineers, six weeks."

**What we are not building this quarter.** Explicit. If the sales team keeps asking for a feature and the answer is no, it goes here. This section is more important than the first one because it prevents scope creep and gives leadership air cover to say no.

**What we are buying.** Vendor decisions are strategic decisions. If you are using Stripe for payments, Snowflake for the warehouse, and Datadog for monitoring, say so. This tells engineers what is off the table for internal builds.

**What we will revisit if these bets fail.** A circuit breaker. If the re-engagement flow does not move checkout abandonment, what will you do? Kill it? Pivot? Double down? Deciding this in advance prevents sunk cost escalation.

**What would change this strategy.** The assumptions that would invalidate everything above. A new competitor, a shift in customer behavior, a technology discontinuity. This section acknowledges that strategy is not permanent.

That is it. If you cannot fit your technology strategy on one page, you do not have a strategy. You have a wish list.

## The counterargument

The obvious objection: some systems are genuinely complex. A one-page strategy for a bank's core infrastructure or a healthcare company's data platform might be dangerously reductive. Edge cases matter. Compliance matters. The 40-page document exists because someone, at some point, got burned by something the one-pager did not address.

This is fair. The one-page format works best when the goal is alignment and decision-making speed, not comprehensive documentation. It is a strategy document, not an architecture document or a compliance checklist. Those should exist separately.

The other objection is that the process of creating a long document forces rigor. Writing 40 pages requires thinking through scenarios you might otherwise ignore. Even if nobody reads the final document, the exercise had value.

Also fair. But the rigor should happen during shaping, not during documentation. Shape Up's insight is that you do the hard thinking before the betting table, not after. The one-pager is the output of rigorous thinking, not a substitute for it.

The format fails when leadership uses brevity as an excuse to avoid hard choices. A one-page document that says "we will be customer-focused and innovative" is worse than a 40-page document that actually specifies tradeoffs. The constraint is not the page count. The constraint is forcing decisions.

## What I am still figuring out

How to socialize a one-page strategy with leadership that expects 10-page decks. The format works for operators but can feel insufficiently "serious" to board members who equate length with rigor.

Whether this approach scales beyond small teams. At 10 engineers, everyone can read the one-pager and internalize it. At 500 engineers, the coordination problem is different.

How to version control strategy. When the document changes, how do you communicate what changed and why without the history becoming its own 40-page deck?

---

28% of managers can name their company's strategic priorities. That means 72% cannot. If your leadership team is average, three out of four of your managers are making daily decisions based on their best guess about what matters.

The fintech startup still ships quarterly. They also finish what they start now. The 40% waste disappeared. The difference was not process. It was a single page that forced them to decide what they actually believed.