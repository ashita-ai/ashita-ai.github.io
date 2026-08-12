---
layout: post
title: "The Detector That Said Yes to Everything"
date: 2026-08-11
category: "architecture"
description: "For months I added suppressors to a conflict detector that said yes to everything. Then I blind-labelled its historical scored corpus. The result was not a weak classifier, but a constant function—and a much more useful measurement program."
---

For months, I improved Akashi's conflict detector one false positive at a time. A review found a pattern it should not flag. I added a suppression rule or another sentence to the prompt. The test passed. The next review found a different pattern.

This looked like iteration. It was a detector accumulating excuses.

So I stopped tuning it and blind-labelled the historical scored corpus: 2,772 pairs. The raters were language-model agents — dozens, each shown the decision texts and structural metadata, never the detector's verdict. Models grading a model is a fair objection. The defense is the blinding, plus an independent 200-pair re-rate that agreed at a Cohen's kappa of 0.766. Blind agreement is not ground truth, but unlike the old test set it was not written by the person being graded.

It is the production loop I argued for in [Your Evals Won't Save You](/blog/your-evals-wont-save-you/), arriving late: every pair is something the detector did, labelled after the fact.

## The detector was a constant function

[Akashi](/projects/akashi/) records agents' decisions. Conflict detection is meant to find two current decisions that cannot both be true — the feature that makes the record more than a log.

The blind labels found 93 contradictions in the 2,772 pairs. Most pairs were merely related. More than one fifth were supersessions: a later decision replacing an earlier one — normal progress, not conflict.

<figure style="margin: 2.5rem 0; text-align: center;">
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 660 312" width="100%" role="img" aria-label="Horizontal bar chart of blind labels over 2,772 candidate pairs: 72.8 percent related but not contradicting, 22.6 percent supersession, 3.35 percent contradiction, 1.3 percent unrelated" style="font-family: Inter, sans-serif;">
  <text x="20" y="26" font-size="15" font-weight="600" fill="#1a1a1a">93 real contradictions in 2,772 pairs</text>
  <line x1="210" y1="48" x2="210" y2="282" stroke="#ddd" stroke-width="1"/>
  <text x="210" y="298" font-size="11" fill="#666" text-anchor="middle">0%</text>
  <line x1="305" y1="48" x2="305" y2="282" stroke="#ddd" stroke-width="1"/>
  <text x="305" y="298" font-size="11" fill="#666" text-anchor="middle">25%</text>
  <line x1="400" y1="48" x2="400" y2="282" stroke="#ddd" stroke-width="1"/>
  <text x="400" y="298" font-size="11" fill="#666" text-anchor="middle">50%</text>
  <line x1="495" y1="48" x2="495" y2="282" stroke="#ddd" stroke-width="1"/>
  <text x="495" y="298" font-size="11" fill="#666" text-anchor="middle">75%</text>
  <line x1="590" y1="48" x2="590" y2="282" stroke="#ddd" stroke-width="1"/>
  <text x="590" y="298" font-size="11" fill="#666" text-anchor="middle">100%</text>
  <text x="196" y="80" font-size="12.5" fill="#444" text-anchor="end">related, not contradicting</text>
  <rect x="210" y="60" width="276.5" height="30" fill="#2c4a6e" opacity="0.35"/>
  <text x="497" y="80" font-size="12" fill="#444">72.8%  (2,017)</text>
  <text x="196" y="142" font-size="12.5" fill="#444" text-anchor="end">supersession</text>
  <rect x="210" y="122" width="86.0" height="30" fill="#2c4a6e" opacity="0.35"/>
  <text x="306" y="142" font-size="12" fill="#444">22.6%  (627)</text>
  <text x="196" y="204" font-size="12.5" fill="#1a1a1a" text-anchor="end">contradiction</text>
  <rect x="210" y="184" width="12.7" height="30" fill="#2c4a6e"/>
  <text x="233" y="204" font-size="12" fill="#2c4a6e" font-weight="600">3.35%  (93)</text>
  <text x="196" y="266" font-size="12.5" fill="#444" text-anchor="end">unrelated</text>
  <rect x="210" y="246" width="4.8" height="30" fill="#2c4a6e" opacity="0.35"/>
  <text x="225" y="266" font-size="12" fill="#444">1.3%  (35)</text>
</svg>
<figcaption style="font-size: 0.85rem; color: #666; max-width: 560px; margin: 0.4rem auto 0; text-align: left;">Blind four-way labels over all 2,772 scored pairs, each rated from the decision texts alone. The detector had called 97.8% of them contradictions.</figcaption>
</figure>

The shipped detector said "contradiction" for 97.8 percent of the pairs it scored — yes 2,711 times, of which 93 happened to be right. It found supersession 61 times where the blind labels found 627.

This was not a weak or miscalibrated classifier. It was nearly a constant function.

The old evaluation suite had 122 handwritten pairs and reported 1.000 precision and 1.000 recall. I had written the prompt and chosen the examples from the same picture of a contradiction. The suite could check that the prompt followed the picture, not that the picture was wrong.

The blind corpus could. That is the difference between a test set and a measurement.

It graded me too. By July I had automated my triage into a routine that marked conflicts false positive in bulk. The detector said yes to everything, so I built a thing that said no to everything. The blind labels sided with the bulk dismissals — 98.3 percent correct. The conflicts I had adjudicated deliberately, read and resolved with a declared winner, were the rotten ones: 11 percent real. [A channel over its alarm budget](/blog/the-alarm-budget/) does not just train its receiver to stop reading; it degrades the judgments the receiver still makes — and mine were the only ground truth the system had. A detector that cries wolf poisons the record of which wolves were real — the record you need to fix it.

## The base rate changed the question

The failure was not just the prompt; it was what I had optimized for.

At prevalence p, sensitivity s, and false-positive rate f on the majority class:

```
precision = p·s / ( p·s + (1−p)·f )
```

At p = 3.35 percent, the function is nearly flat in sensitivity and nearly vertical in false-positive rate.

<figure style="margin: 2.5rem 0; text-align: center;">
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 660 348" width="100%" role="img" aria-label="Line chart: precision against false-positive rate at a 3.35 percent base rate, three lines for 30, 50 and 80 percent recall, all falling steeply as the false-positive rate rises" style="font-family: Inter, sans-serif;">
  <text x="20" y="24" font-size="15" font-weight="600" fill="#1a1a1a">Precision is a story about false positives</text>
  <line x1="70" y1="290" x2="590" y2="290" stroke="#1a1a1a" stroke-width="1"/>
  <text x="60" y="294" font-size="11" fill="#666" text-anchor="end">0%</text>
  <line x1="70" y1="228" x2="590" y2="228" stroke="#ddd" stroke-width="1"/>
  <text x="60" y="232" font-size="11" fill="#666" text-anchor="end">25%</text>
  <line x1="70" y1="165" x2="590" y2="165" stroke="#ddd" stroke-width="1"/>
  <text x="60" y="169" font-size="11" fill="#666" text-anchor="end">50%</text>
  <line x1="70" y1="102" x2="590" y2="102" stroke="#ddd" stroke-width="1"/>
  <text x="60" y="106" font-size="11" fill="#666" text-anchor="end">75%</text>
  <line x1="70" y1="40" x2="590" y2="40" stroke="#ddd" stroke-width="1"/>
  <text x="60" y="44" font-size="11" fill="#666" text-anchor="end">100%</text>
  <text x="70" y="310" font-size="11" fill="#666" text-anchor="middle">0%</text>
  <text x="243" y="310" font-size="11" fill="#666" text-anchor="middle">2%</text>
  <text x="417" y="310" font-size="11" fill="#666" text-anchor="middle">4%</text>
  <text x="590" y="310" font-size="11" fill="#666" text-anchor="middle">6%</text>
  <polyline points="78.7,61.9 87.3,80.3 96.0,95.9 104.7,109.4 113.3,121.1 122.0,131.4 130.7,140.5 139.3,148.6 148.0,155.9 156.7,162.5 165.3,168.4 174.0,173.8 182.7,178.8 191.3,183.4 200.0,187.6 208.7,191.4 217.3,195.0 226.0,198.4 234.7,201.5 243.3,204.4 252.0,207.1 260.7,209.7 269.3,212.1 278.0,214.3 286.7,216.5 295.3,218.5 304.0,220.4 312.7,222.2 321.3,223.9 330.0,225.6 338.7,227.1 347.3,228.6 356.0,230.0 364.7,231.4 373.3,232.7 382.0,233.9 390.7,235.1 399.3,236.2 408.0,237.3 416.7,238.4 425.3,239.4 434.0,240.3 442.7,241.3 451.3,242.2 460.0,243.0 468.7,243.8 477.3,244.7 486.0,245.4 494.7,246.2 503.3,246.9 512.0,247.6 520.7,248.3 529.3,248.9 538.0,249.6 546.7,250.2 555.3,250.8 564.0,251.4 572.7,251.9 581.3,252.5 590.0,253.0" fill="none" stroke="#2c4a6e" stroke-width="2" opacity="0.35"/>
  <text x="598" y="257" font-size="11.5" fill="#2c4a6e" opacity="0.35">recall 30%</text>
  <polyline points="78.7,53.6 87.3,65.8 96.0,76.8 104.7,86.8 113.3,95.9 122.0,104.2 130.7,111.8 139.3,118.9 148.0,125.4 156.7,131.4 165.3,137.0 174.0,142.2 182.7,147.1 191.3,151.6 200.0,155.9 208.7,159.9 217.3,163.7 226.0,167.3 234.7,170.6 243.3,173.8 252.0,176.9 260.7,179.7 269.3,182.5 278.0,185.1 286.7,187.6 295.3,189.9 304.0,192.2 312.7,194.3 321.3,196.4 330.0,198.4 338.7,200.3 347.3,202.1 356.0,203.8 364.7,205.5 373.3,207.1 382.0,208.7 390.7,210.2 399.3,211.6 408.0,213.0 416.7,214.3 425.3,215.6 434.0,216.9 442.7,218.1 451.3,219.3 460.0,220.4 468.7,221.5 477.3,222.6 486.0,223.6 494.7,224.6 503.3,225.6 512.0,226.5 520.7,227.4 529.3,228.3 538.0,229.2 546.7,230.0 555.3,230.8 564.0,231.6 572.7,232.4 581.3,233.2 590.0,233.9" fill="none" stroke="#2c4a6e" stroke-width="2" opacity="0.6"/>
  <text x="598" y="238" font-size="11.5" fill="#2c4a6e" opacity="0.6">recall 50%</text>
  <polyline points="78.7,48.7 87.3,56.8 96.0,64.4 104.7,71.5 113.3,78.1 122.0,84.4 130.7,90.3 139.3,95.9 148.0,101.2 156.7,106.2 165.3,110.9 174.0,115.4 182.7,119.7 191.3,123.8 200.0,127.7 208.7,131.4 217.3,134.9 226.0,138.3 234.7,141.6 243.3,144.7 252.0,147.6 260.7,150.5 269.3,153.3 278.0,155.9 286.7,158.4 295.3,160.9 304.0,163.2 312.7,165.5 321.3,167.7 330.0,169.8 338.7,171.9 347.3,173.8 356.0,175.8 364.7,177.6 373.3,179.4 382.0,181.1 390.7,182.8 399.3,184.4 408.0,186.0 416.7,187.6 425.3,189.0 434.0,190.5 442.7,191.9 451.3,193.3 460.0,194.6 468.7,195.9 477.3,197.1 486.0,198.4 494.7,199.6 503.3,200.7 512.0,201.9 520.7,203.0 529.3,204.0 538.0,205.1 546.7,206.1 555.3,207.1 564.0,208.1 572.7,209.1 581.3,210.0 590.0,210.9" fill="none" stroke="#2c4a6e" stroke-width="2" opacity="1.0"/>
  <text x="598" y="215" font-size="11.5" fill="#2c4a6e" opacity="1.0">recall 80%</text>
  <text x="330" y="334" font-size="11.5" fill="#666" text-anchor="middle">false-positive rate on the majority class</text>
</svg>
<figcaption style="font-size: 0.85rem; color: #666; max-width: 560px; margin: 0.4rem auto 0; text-align: left;">Precision against majority-class false-positive rate at the corpus base rate of 3.35%. The recall lines barely separate; the x-axis decides.</figcaption>
</figure>

False positives decide whether the queue is usable: raising recall from 30 to 80 percent buys about 23 precision points; halving the false-positive rate from 2 to 1 percent buys 17.

The scorer's own features — `significance`, a weight for a decision's consequence, and `topic_similarity`, the embedding overlap that nominates pairs — scored AUCs of 0.500 and 0.587 against the blind labels. A coin flip, and nearly one. They can be a recall funnel, not the decision.

F1 obscured the same fact more politely: `gpt-5-mini` had the best F1 of any judge I measured, 0.704, on a corpus-projected precision of 17.3 percent — beaten by two judges with worse F1. I now report precision, recall, and queue size. F1 compares implementations; it does not pick an operating point.

## The work was an experiment, not a prompt rewrite

I ran the changes against a blind 200-pair gold set, then reweighted to true corpus proportions — a stratified sample otherwise makes a rare-event detector look better than the queue it will create.

The first rewrite failed. I made chronology decisive — a later decision is supersession, never contradiction — and supersession became the default sink for 54 to 65 percent of every class while contradiction recall fell to 1.1 percent.

The version that survived is an ordered procedure: first name the one question both decisions answer, or they are complementary or unrelated; then require explicit replacement language for supersession; only then ask whether two current answers are incompatible. A contradiction verdict must state its disputed question in a dedicated field, and the parser downgrades a verdict that cannot. A contract, not another request to be careful.

Judge capability mattered more than either rewrite: same procedure, and the judge alone moved corpus-projected precision from 8.1 to 41.5 percent.

<figure style="margin: 2.5rem 0; text-align: center;">
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 660 314" width="100%" role="img" aria-label="Bar chart of corpus-projected precision by judge model: gpt-4o-mini 8.1 percent, gpt-4o 26.9 percent, gpt-4.1 28.7 percent, gpt-5 41.5 percent" style="font-family: Inter, sans-serif;">
  <text x="20" y="26" font-size="15" font-weight="600" fill="#1a1a1a">Same prompt, same corpus. Only the judge changed.</text>
  <line x1="70" y1="256" x2="590" y2="256" stroke="#1a1a1a" stroke-width="1"/>
  <text x="60" y="260" font-size="11" fill="#666" text-anchor="end">0%</text>
  <line x1="70" y1="172" x2="590" y2="172" stroke="#ddd" stroke-width="1"/>
  <text x="60" y="176" font-size="11" fill="#666" text-anchor="end">20%</text>
  <line x1="70" y1="88" x2="590" y2="88" stroke="#ddd" stroke-width="1"/>
  <text x="60" y="92" font-size="11" fill="#666" text-anchor="end">40%</text>
  <rect x="90" y="222.0" width="78" height="34.0" fill="#2c4a6e" opacity="0.35"/>
  <text x="129" y="214" font-size="12.5" fill="#2c4a6e" text-anchor="middle">8.1%</text>
  <text x="129" y="276" font-size="12" fill="#444" text-anchor="middle">gpt-4o-mini</text>
  <rect x="220" y="143.0" width="78" height="113.0" fill="#2c4a6e" opacity="0.35"/>
  <text x="259" y="135" font-size="12.5" fill="#2c4a6e" text-anchor="middle">26.9%</text>
  <text x="259" y="276" font-size="12" fill="#444" text-anchor="middle">gpt-4o</text>
  <rect x="350" y="135.5" width="78" height="120.5" fill="#2c4a6e" opacity="0.35"/>
  <text x="389" y="127" font-size="12.5" fill="#2c4a6e" text-anchor="middle">28.7%</text>
  <text x="389" y="276" font-size="12" fill="#444" text-anchor="middle">gpt-4.1</text>
  <rect x="480" y="81.7" width="78" height="174.3" fill="#2c4a6e"/>
  <text x="519" y="74" font-size="12.5" fill="#2c4a6e" font-weight="600" text-anchor="middle">41.5%</text>
  <text x="519" y="276" font-size="12" fill="#444" text-anchor="middle">gpt-5</text>
  <text x="60" y="300" font-size="11.5" fill="#666">corpus-projected precision</text>
</svg>
<figcaption style="font-size: 0.85rem; color: #666; max-width: 560px; margin: 0.4rem auto 0; text-align: left;">Corpus-projected precision on the same blind 200-pair gold set, same ordered-procedure prompt. Only the judge model changed.</figcaption>
</figure>

The 41.5 percent was briefly 65.2. The first estimate of `gpt-5`'s false-positive rate came from a 47-pair sample it got entirely right, and the formula turned that zero into a 65 percent headline. The precision curve is near-vertical exactly there — 0-of-47 cannot distinguish 65 percent precision from 19 — and a 300-pair remeasure found six false positives. The headline fell to 41.5 within hours. The same arithmetic that convicted the old detector almost flattered the new one.

What survived is still a projection: 41.5 percent precision at 50.5 percent recall, a queue of about 113 where the old detector flagged 2,711. The queue still has to earn those numbers in live use.

## Some conflicts should not be judged

Twenty-seven percent of the 93 contradictions were two decisions setting the same named parameter to different values. `conflict_llm_timeout = 15s` and `conflict_llm_timeout = 120s` do not need a language model. They need a join.

Bindings are now first-class data. If two current decisions bind the same parameter to different values, Akashi detects the conflict by lookup. No prompt, no threshold, no false-positive rate.

That covers only contradictions whose structure already exists. Four attempts to recover it from decision prose failed; 59 percent of contradictions never name the artifact they affect. The lesson: preserve structure where it exists rather than ask a model to reconstruct it later.

## What is live now

Production now runs `gpt-5` over a 30-day window and keeps a deterministic 5 percent sample of structurally suppressed pairs outside the conflict queue.

Getting there exposed a smaller version of the same problem: the cloud environment file fed Compose interpolation but never reached the containers. The configuration promised `gpt-5` and a 5 percent sample; the process could prove neither. Fixing the wiring put both into the running service.

The sample creates no operator work and cannot block a conflict. It creates the rows for the next blind label — the rater will see the decisions, not the rule that suppressed them. That is how a suppression becomes a measurable claim instead of an accumulated hunch.

## What I am still figuring out

**How much the funnel misses.** I blind-labelled 200 high-similarity pairs that never reached the scorer. Two were contradictions — projected across the pool, roughly 332 conflicts never surfaced against the 93 found: funnel recall near 22 percent. The interval is wide, 7 to 70 percent: direction, not a settled number.

The structural rules are a separate blind spot: they suppress about 56 percent of candidate pairs before any judge. The 5 percent sample is live but unlabelled, so I cannot yet say whether those rules save attention or quietly discard the cases that matter.

**Whether 41.5 percent is worth running.** At the measured false-positive rate, a missed contradiction must cost at least 1.4 times a false alarm for the single-judge point to win. A two-stage cascade reaches 74.2 percent precision on the gold set, but I have not built it — nor measured the attention cost of a false alarm, the input that decides the trade.

**Whether the feature deserves its prominence.** Across 25.3 weeks the corpus holds 62 distinct disputes: 2.45 a week — real value, but not an automatic case for prominence. And the 0.766 kappa cuts both ways: some apparent room for improvement is label uncertainty, not detector failure.

---

The old process had a test after every change, so it could reliably tell me each change matched the last thing I had noticed. The current one claims less: the corpus is measured, the operating point is projected, the filters are observable, and live results still have to arrive.

I wrote in June that [a confidence number becomes a signal only when something keeps score](/blog/confidence-is-not-a-signal/). Keeping score feels like this: no victory graph, and a measurement that has already disagreed with me twice — about the old detector, and about my first estimate of the new one. That property is worth more than either number.

*The figures are generated from the label counts by `examples/python/base_rate_charts.py` in the Akashi repo (standard library only); `base_rate.py` reproduces the precision arithmetic; `binding_collision.py` demonstrates the binding join.*
