---
layout: post
title: "The Detector That Said Yes to Everything"
date: 2026-08-11
category: "architecture"
description: "For months I added suppressors to a conflict detector that said yes to everything. Then I blind-labelled every pair it had ever scored. The result was not a weak classifier but a constant function, and the labels graded my own judgment too."
---

For months, I improved Akashi's conflict detector one false positive at a time. A review found a pattern it should not flag. I added a suppression rule or another sentence to the prompt. The test passed. The next review found a different pattern.

This looked like iteration. It was a detector accumulating excuses.

So I stopped tuning it and blind-labelled the whole scored corpus: 2,772 pairs. The raters were language-model agents, dozens of them. Each saw the two decision texts and the structural metadata. None saw the detector's verdict. That is the blinding.

Models grading a model is a fair objection. The defense is that blinding, plus an independent 200-pair re-rate that agreed at a Cohen's kappa of 0.766. Blind agreement is not ground truth. But unlike the old test set, it was not written by the person being graded. It is the loop I argued for in [Your Evals Won't Save You](/blog/your-evals-wont-save-you/). It arrived seven months late.

## The detector was a constant function

[Akashi](/projects/akashi/) records agents' decisions. Conflict detection is meant to find two current decisions that cannot both be true. That is what makes the record more than a log.

The blind labels found 93 contradictions in the 2,772 pairs. Most pairs were merely related. More than a fifth were supersessions: a later decision replacing an earlier one. That is normal progress, not conflict.

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

The shipped detector said "contradiction" for 97.8 percent of the pairs it scored. Yes, 2,711 times. Ninety-two of those were right. It found supersession 61 times where the blind labels found 627.

This was not a weak or miscalibrated classifier. It was nearly a constant function.

The old evaluation suite had 122 handwritten pairs and reported 1.000 precision and 1.000 recall. I had written the prompt and chosen the examples from the same picture of a contradiction. [The kilogram had that problem for 130 years](/blog/ground-truth-as-foundation/): a reference that is correct by definition cannot be found wrong. The suite could check that the prompt followed the picture. It could not check whether the picture was wrong.

The blind corpus could. That is the difference between a test set and a measurement.

It graded me too. By July my triage was a routine that marked conflicts false positive in bulk. The detector said yes to everything, so I built a habit of saying no to everything. The blind labels sided with the bulk dismissals, 98.3 percent correct. The rotten ones were the conflicts I had adjudicated deliberately, read and resolved with a declared winner. Of those, 11 percent were real.

[A channel over its alarm budget](/blog/the-alarm-budget/) does not only train its receiver to stop reading. It degrades the judgments the receiver still makes. Mine were the only ground truth the system had. A detector that cries wolf poisons the record of which wolves were real, and that record is the one you need in order to fix it.

## The base rate changed the question

The failure was not only the prompt. It was what I had optimized for. At prevalence p, sensitivity s, and majority-class false-positive rate f:

```
precision = p·s / ( p·s + (1−p)·f )
```

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

False positives decide whether the queue is usable. Raise recall from 30 to 80 percent, which is fifty points of detector capability, and precision gains about 23 points. Halve the false-positive rate from 2 percent to 1, which is one point of movement, and precision gains 17.

The scorer has features of its own. `significance` weights a decision's consequence. `topic_similarity` is the embedding overlap that nominates pairs. Against the blind labels they score 0.60 and 0.62 AUC, on intervals six points wide. `outcome_divergence`, built to measure how far two outcomes differ, scores 0.43, which means it points the wrong way. The strongest predictor in the scorer is `temporal_decay`, at 0.73, and nobody designed it as one. These can be a recall funnel. They cannot be the decision.

F1 obscured the same fact more politely. `gpt-5-mini` posted the best sample F1 I measured, 0.704, and projected to 17.3 percent corpus precision. `gpt-5` scored worse on F1 and projected to 41.5. A stratified sample cannot see a fourfold gap in majority-class false positives, and at this base rate that gap decides the outcome. I report precision, recall, and queue size now.

## The work was an experiment, not a prompt rewrite

I ran the changes against a blind 200-pair gold set, then reweighted to corpus proportions. A stratified sample flatters a rare-event detector. The queue is what ships.

The first rewrite failed. I made chronology decisive: a later decision is supersession, never contradiction. Supersession then became the default sink for 54 to 65 percent of every class. Contradiction recall fell to 1.1 percent.

The version that survived is an ordered procedure. First, name the one question both decisions answer. If there is none, they are complementary. Then require explicit replacement language before anything counts as supersession. Only then ask whether two current answers are incompatible. A contradiction verdict must name its disputed question in a dedicated field, and the parser downgrades a verdict that cannot. A contract, not another request to be careful.

Judge capability mattered more than either rewrite. On the same procedure and the same corpus, the judge alone moved corpus-projected precision from 8.1 to 41.5 percent.

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
<figcaption style="font-size: 0.85rem; color: #666; max-width: 560px; margin: 0.4rem auto 0; text-align: left;">Corpus-projected precision on the same blind 200-pair gold set, same ordered-procedure prompt. Only the judge model changed. The <code>gpt-5</code> bar is the corrected 41.5%, after the 300-pair remeasure described below.</figcaption>
</figure>

For a few hours I believed that number was 65.2. The first estimate came from a 47-pair sample the judge got entirely right. A clean sample puts the false-positive rate near zero, which is where the precision curve stands almost vertical. Zero of 47 cannot tell 65 percent precision from 19. A 300-pair remeasure found six false positives, a rate of 2.00 percent, and the estimate fell to 41.5. The same arithmetic that convicted the old detector almost flattered the new one.

What survived is still a projection: 41.5 percent precision at 50.5 percent recall, a queue of about 113 where the old detector flagged 2,711. The new queue is twenty-four times smaller, and it drops half the real contradictions. The old detector caught 92 of the 93, which is what saying yes to almost everything buys you.

## Some conflicts should not be judged

Twenty-seven percent of the 93 contradictions were two decisions setting the same named parameter to different values. `conflict_llm_timeout = 15s` and `conflict_llm_timeout = 120s` do not need a language model. They need a join.

Bindings are first-class data now. Two current decisions that bind the same parameter to different values make a conflict by lookup. No prompt, no threshold, no false-positive rate.

That covers only contradictions whose structure already exists. Four attempts to recover it from prose all failed. Fifty-nine percent of contradictions never name the artifact they affect. Preserve structure where you have it. A model will not reconstruct it later.

## What is live now

Production now runs `gpt-5` over a 30-day window and keeps a deterministic 5 percent sample of structurally suppressed pairs outside the conflict queue.

The cutover produced the clearest case of a measurement that flatters you. Reasoning models think a long time before the first token. The judge's timeout was still at its 15-second default, so 159 of 200 `gpt-5` calls timed out. A skipped candidate is fail-safe: not flagged, not alerted, not queued. Detections fell silently. That is exactly what a more precise model looks like from outside. `conflict_llm_timeout = 15s` against `120s`, from the section above, is this bug.

The sample creates no operator work and cannot block a conflict. It creates rows for the next blind label. The rater will see the decisions, not the rule that suppressed them. That is how a suppression becomes a measurable claim instead of an accumulated hunch.

## What I am still figuring out

**How much the funnel misses.** Retrieval stops at the top twenty neighbours, which leaves 33,151 pairs above the similarity floor that were never scored. I blind-labelled 200 of them and two were contradictions. Projected across the pool, roughly 332 conflicts never surfaced against the 93 found. That puts funnel recall near 22 percent, on an interval of 7 to 70. It is a direction, not a settled number.

The structural rules are a separate blind spot. They suppress about 56 percent of candidate pairs before any judge sees them. The first 116-pair batch of the 5 percent sample, blind-labelled as this went up, found zero contradictions. That puts the ceiling near 2.6 percent, not at zero. One batch narrows the range. It does not clear the rules.

**Whether 41.5 percent is worth running.** At the measured false-positive rate, a missed contradiction must cost at least 1.4 times a false alarm for the single-judge point to win. A two-stage cascade reaches 74.2 percent precision at 38.7 percent recall. I have not built it, and I have not measured the attention cost of a false alarm, which is the input that decides the trade-off.

**Whether the pair is the right unit.** Everything above scores two decisions against each other. [Work on consistency checking with noisy LLM oracles](https://arxiv.org/abs/2601.13600) shows pairwise checks cannot certify a whole set: three decisions can be compatible in every pair and impossible together. The paper offers a way out, an adaptive search for the smallest inconsistent subset at polynomial cost. Nothing I run today would see the problem, let alone do that.

**Whether the feature deserves its prominence.** Across 25.3 weeks the corpus holds 62 distinct disputes, or 2.45 a week. That is real value, but not an automatic case for prominence. The 0.766 kappa also works against my own figures: some of the apparent room for improvement is label uncertainty rather than detector failure.

## You can check this yourself

A post arguing for measurement over assertion should hand over the measurements. [The data is published](/assets/data/conflict-detection/) under CC BY 4.0, in three files.

`conflict-labels.csv` is all 2,772 pairs with their blind label, the detector's verdict and every scorer feature, and no decision text, which is what makes full coverage safe to release. It reproduces the base rate, the 97.8 percent, and the AUCs above.

`conflict-pairs-recoded.jsonl` is 192 of those pairs with their text, so you can run your own judge. Every ticket, path, hash and name became a stable placeholder. One caveat matters: 14 of the 192 are contradictions, a 7.3 percent base rate against the corpus 3.35, so a judge measured there will flatter itself.

`teaching-set.jsonl` is 60 pairs I wrote by hand, sorted into the ten failure modes the real corpus taught me. Try `silent_supersession` and `surface_negation` before you look at the answers. Most people call both of them contradictions.

---

The old process had a test after every change. It could reliably tell me that each change matched the last thing I had noticed. The current one claims less: the corpus is measured, the operating point is projected, the filters are observable, and the live results are not in yet.

I wrote in June that [a confidence number becomes a signal only when something keeps score](/blog/confidence-is-not-a-signal/). This is what keeping score looks like. No victory graph. A measurement that has now contradicted me four times: about the old detector, about my first estimate of the new one, and twice more about numbers I had already written down here. That property is worth more than any of them.
