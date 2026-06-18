---
layout: post
title: "Confidence Is Not a Signal"
date: 2026-06-18
category: "architecture"
description: "Jennifer Thompson was certain, and she was wrong, and a jury treated her certainty as evidence about someone else. We are now wiring machine certainty into the same role. I went looking for when a stated confidence actually means something — and found that my own agent fleet had been reporting itself 'calibrated' on a sample I never scored."
---

On the night of July 29, 1984, a man broke into Jennifer Thompson's apartment in Burlington, North Carolina, and raped her at knifepoint. She made a decision during the assault that the criminal justice system has always rewarded: she studied his face. She made herself memorize it. Afterward she picked Ronald Cotton out of a photo array, then picked him again out of a live lineup, and at trial she told the jury she was certain. She was certain at the second trial too. Ronald Cotton served [more than ten years](https://www.innocenceproject.org/cases/ronald-cotton/) before DNA matched a different man — Bobbie Poole, a convict who had reportedly bragged about the crime, and whom Thompson, when she finally saw him, did not recognize at all.

Her confidence was total. It was also wrong. And the thing the jury did with that confidence is the thing this essay is about: they treated it as evidence about Cotton, when it was only ever evidence about Thompson. It told them how her memory felt to her. It told them nothing reliable about who had been in the room.

Thompson is not an outlier. Of the first 375 people exonerated by DNA in the United States, [69% had been convicted at least in part on a mistaken eyewitness identification](https://innocenceproject.org/dna-exonerations-in-the-united-states/) — more than any other single cause. For most of the twentieth century the law ran on a folk theorem that a confident witness is an accurate witness, and that theorem put hundreds of innocent people in prison. Confidence and accuracy are different quantities. One is a feeling the speaker has about a claim; the other is a property of the world. They can move together, and under the right conditions they do — I'll come back to that, because it is the most important part. But they are not the same measurement, and a system that reads one as a proxy for the other will be wrong in exactly the cases where it most needs to be right.

I am writing this because I have spent the last few months building the machine version of that mistake, and I did not notice until the tool told on itself.

Most days I run a fleet of agents — coders, reviewers, investigators — and [a tool I keep](/projects/akashi/) records every consequential decision they make, along with the agent's own stated confidence in it. As I write this, in mid-June 2026, that trail holds 2,804 decisions from 51 distinct agents. The first thing you notice in the aggregate is that the confidence numbers barely move. The median is 0.80. More than three-quarters of every decision my fleet has ever made lands between 0.70 and 0.90 — regardless of the agent, regardless of the task, and regardless of whether the decision later turned out to be right.

<figure style="margin: 2.5rem 0; text-align: center;">
<svg viewBox="0 0 660 340" width="100%" role="img" aria-label="Histogram of stated confidence across 2,804 agent decisions, clustered between 0.7 and 0.9" style="font-family: Inter, sans-serif;">
  <text x="80" y="24" font-size="15" font-weight="600" fill="#1a1a1a">2,804 decisions. One feeling.</text>
  <!-- y gridlines + labels -->
  <line x1="80" y1="300" x2="620" y2="300" stroke="#1a1a1a" stroke-width="1"/>
  <line x1="80" y1="180" x2="620" y2="180" stroke="#ddd" stroke-width="1"/>
  <line x1="80" y1="60"  x2="620" y2="60"  stroke="#ddd" stroke-width="1"/>
  <text x="72" y="304" font-size="11" fill="#666" text-anchor="end">0</text>
  <text x="72" y="184" font-size="11" fill="#666" text-anchor="end">600</text>
  <text x="72" y="64"  font-size="11" fill="#666" text-anchor="end">1,200</text>
  <!-- bars -->
  <rect x="97"  y="263" width="56" height="37"  fill="#2c4a6e" opacity="0.85"/>
  <rect x="187" y="299" width="56" height="1"   fill="#2c4a6e" opacity="0.85"/>
  <rect x="277" y="254" width="56" height="46"  fill="#2c4a6e" opacity="0.85"/>
  <rect x="367" y="114" width="56" height="186" fill="#2c4a6e" opacity="0.85"/>
  <rect x="457" y="61"  width="56" height="239" fill="#2c4a6e"/>
  <rect x="547" y="248" width="56" height="52"  fill="#2c4a6e" opacity="0.85"/>
  <!-- bar count labels -->
  <text x="125" y="257" font-size="12" fill="#444" text-anchor="middle">184</text>
  <text x="215" y="293" font-size="12" fill="#444" text-anchor="middle">5</text>
  <text x="305" y="248" font-size="12" fill="#444" text-anchor="middle">232</text>
  <text x="395" y="108" font-size="12" fill="#444" text-anchor="middle">929</text>
  <text x="485" y="55"  font-size="13" font-weight="600" fill="#2c4a6e" text-anchor="middle">1,196</text>
  <text x="575" y="242" font-size="12" fill="#444" text-anchor="middle">258</text>
  <!-- median line -->
  <line x1="440" y1="40" x2="440" y2="300" stroke="#a23" stroke-width="1" stroke-dasharray="4 3"/>
  <text x="446" y="48" font-size="11" fill="#a23">median 0.80</text>
  <!-- x labels -->
  <text x="80"  y="318" font-size="11" fill="#666" text-anchor="middle">0.4</text>
  <text x="170" y="318" font-size="11" fill="#666" text-anchor="middle">0.5</text>
  <text x="260" y="318" font-size="11" fill="#666" text-anchor="middle">0.6</text>
  <text x="350" y="318" font-size="11" fill="#666" text-anchor="middle">0.7</text>
  <text x="440" y="318" font-size="11" fill="#666" text-anchor="middle">0.8</text>
  <text x="530" y="318" font-size="11" fill="#666" text-anchor="middle">0.9</text>
  <text x="620" y="318" font-size="11" fill="#666" text-anchor="middle">1.0</text>
  <text x="350" y="336" font-size="12" fill="#666" text-anchor="middle">stated confidence</text>
</svg>
<figcaption style="font-size: 0.85rem; color: #666; max-width: 560px; margin: 0.4rem auto 0; text-align: left;">Stated confidence across 2,804 agent decisions in my own fleet. The distribution is a spike, not a spread — and for almost none of these decisions do I actually know the outcome.</figcaption>
</figure>

That chart is the distribution of a feeling. It is *not* evidence the feeling is wrong — because, and here is the part I am least proud of, for almost none of those decisions do I actually know what happened. The tool has a field for the outcome. The field is mostly empty: barely five percent of those 2,804 decisions — 141 of them — ever get a result recorded against them. And yet the tool, totaling up that thin five percent, had been cheerfully reporting a single summary flag: `calibrated: true`. I had glanced at that flag for weeks and felt reassured by it.

It was Jennifer Thompson's jury in a config file. A confident-sounding summary, resting on a sample far too small to support it, and I was treating the confidence of the summary as evidence about the fleet. It was only evidence about the summary.

## The meter was built to read full

The reason this is worth more than a personal embarrassment is that the number my agents emit — the 0.8 they nearly always emit — is structurally untrustworthy, and the research on this has gotten sharper and more alarming in the last year.

Start with the size of the gap. A [2025 study](https://arxiv.org/abs/2505.02151) of five models found they "overestimate the probability that their answer is correct between 20% and 60%." That alone would be survivable if the error were uniform — you could subtract it off. But the same study found the bias is not uniform: it "increases sharply" exactly as the model becomes less sure it is right. The overconfidence is largest in precisely the region where you were hoping the number would help — the hard cases, the ones near the boundary, the ones you wanted the model to flag.

And this is not a bug someone forgot to fix. It is installed by the training. OpenAI's own [GPT-4 technical report](https://arxiv.org/abs/2303.08774) noted that "the pre-trained model is highly calibrated (its predicted confidence in an answer generally matches the probability of being correct)" — and that "after the post-training process, the calibration is reduced." The figure caption is blunter: "The post-training hurts calibration significantly." The very step that makes a model pleasant to talk to — alignment to human preference — teaches it to sound sure, because sure is what humans reward. We trained the meter to read full.

Nor does it improve when the model "thinks." A [June 2025 paper](https://arxiv.org/abs/2506.18183) on reasoning models — the ones that deliberate at length before answering — found them "typically overconfident, with self-verbalized confidence estimates often greater than 85% particularly for incorrect responses." Read that clause again: the highest confidence was pinned to the wrong answers. The deliberation did not surface doubt; it manufactured conviction. And the picture is not unanimous — a [NeurIPS 2025 paper](https://arxiv.org/abs/2505.14489) found nearly the opposite, that reasoning models express confidence *better* than their non-reasoning counterparts in 33 of 36 settings, because slow deliberation gives them room to revise a number downward. Both can be true, and that is the point. "The model said 0.9" is not a fact you can build on, because whether that 0.9 means anything depends on the model, the task, and the way you asked — in ways the number itself does not disclose. A measurement you cannot interpret without reading a research literature is not a signal. It is a number that feels like one.

## What it costs to read it as a signal

The cost is now showing up on invoices, and I have [totted some of them up before](/blog/the-cost-of-being-wrong/): Deloitte [refunding](https://www.cfodive.com/news/deloitte-refunds-60k-report-ai-errors-australian-government-accounting/803321/) the Australian government part of a A$440,000 contract over a report that cited academic papers which did not exist and quoted a federal judge who never said it; courts through 2025 [sanctioning lawyers](https://coloradosun.com/2025/07/07/mike-lindell-attorneys-fined-artificial-intelligence/) for the identical failure, two of them fined $3,000 each in a Colorado case that July over a brief riddled with citations to cases that were never decided. The point here is narrower than that ledger, and its sharpest illustration is also the newest. In April 2025, the AI support bot for the code editor Cursor [told users](https://fortune.com/article/customer-support-ai-cursor-went-rogue/) that the product "is designed to work with one device per subscription as a core security feature." There was no such policy. The bot had invented it and stated it with the flat assurance of a published rule, and customers — reading the assurance as a signal — cancelled subscriptions over it before a human caught the mistake.

In every one of these, the fabrications were not hedged. Nothing in their presentation marked them as lower-confidence than the true sentences around them. That is the failure, exactly: the model's confidence carried no information about its correctness, so the reader had nothing to go on but the prose — and the prose was immaculate. Confident and wrong does not announce itself — and that is what makes it expensive.

## The exception that tells you the rule

So is confidence simply noise? No — and the exception is the most useful thing in this essay, because it tells you what would have to be true for a confidence number to mean something.

Go look at a weather forecast. When an American meteorologist says there is a 30% chance of rain, it rains about 30% of the time. This is not a figure of speech; it is measured. In a [1977 study](https://academic.oup.com/jrsssc/article/26/1/41/6953771) of every precipitation forecast issued by National Weather Service forecasters in Chicago over four years — 17,514 of them — the days assigned a 30% probability saw rain on 28.5% of occasions. Across the whole range the forecasts tracked the diagonal so closely that their reliability error came to 2.8 percentage points. Weather forecasters are among the best-calibrated human beings ever measured.

<figure style="margin: 2.5rem 0; text-align: center;">
<svg viewBox="0 0 660 380" width="100%" role="img" aria-label="Reliability diagram: NWS precipitation forecast probability versus observed frequency of rain, points falling on the diagonal" style="font-family: Inter, sans-serif;">
  <text x="60" y="24" font-size="15" font-weight="600" fill="#1a1a1a">What a checked confidence number looks like</text>
  <!-- plot square -->
  <rect x="110" y="30" width="300" height="300" fill="none" stroke="#ccc" stroke-width="1"/>
  <!-- perfect-calibration diagonal -->
  <line x1="110" y1="330" x2="410" y2="30" stroke="#999" stroke-width="1.2" stroke-dasharray="5 4"/>
  <text x="312" y="120" font-size="11" fill="#999" transform="rotate(-45 312 120)">perfect calibration</text>
  <!-- illustrative points hugging the line -->
  <circle cx="125" cy="319" r="2.6" fill="#888"/>
  <circle cx="140" cy="306" r="2.6" fill="#888"/>
  <circle cx="170" cy="276" r="2.6" fill="#888"/>
  <circle cx="230" cy="216" r="2.6" fill="#888"/>
  <circle cx="260" cy="189" r="2.6" fill="#888"/>
  <circle cx="290" cy="162" r="2.6" fill="#888"/>
  <circle cx="320" cy="132" r="2.6" fill="#888"/>
  <circle cx="350" cy="105" r="2.6" fill="#888"/>
  <circle cx="380" cy="75"  r="2.6" fill="#888"/>
  <!-- verified point: forecast 30 -> observed 28.5 -->
  <circle cx="200" cy="245" r="5" fill="#2c4a6e"/>
  <line x1="205" y1="243" x2="432" y2="212" stroke="#2c4a6e" stroke-width="0.8"/>
  <text x="436" y="206" font-size="12" fill="#2c4a6e" font-weight="600">Forecasters said 30%.</text>
  <text x="436" y="222" font-size="12" fill="#2c4a6e">It rained 28.5% of the time</text>
  <text x="436" y="238" font-size="11" fill="#666">— 449 rainy days out of 1,574.</text>
  <!-- axes ticks -->
  <text x="110" y="348" font-size="11" fill="#666" text-anchor="middle">0</text>
  <text x="260" y="348" font-size="11" fill="#666" text-anchor="middle">50</text>
  <text x="410" y="348" font-size="11" fill="#666" text-anchor="middle">100</text>
  <text x="260" y="366" font-size="12" fill="#666" text-anchor="middle">forecast probability of rain (%)</text>
  <text x="102" y="334" font-size="11" fill="#666" text-anchor="end">0</text>
  <text x="102" y="184" font-size="11" fill="#666" text-anchor="end">50</text>
  <text x="102" y="34"  font-size="11" fill="#666" text-anchor="end">100</text>
  <text x="40" y="180" font-size="12" fill="#666" text-anchor="middle" transform="rotate(-90 40 180)">it actually rained (%)</text>
</svg>
<figcaption style="font-size: 0.85rem; color: #666; max-width: 560px; margin: 0.4rem auto 0; text-align: left;">U.S. National Weather Service precipitation forecasts, Chicago, 1972–76 — 17,514 of them. The dots fall on the diagonal: stated probability matched reality to within 2.8 points. This is what a confidence number looks like after decades of being scored against outcomes. Murphy &amp; Winkler (1977).</figcaption>
</figure>

They are not well-calibrated because they are humbler, or smarter, or because rain is easier to call than a code review. They are well-calibrated because of one structural fact: every forecast is scored against what actually happened, the next day, every day, for decades. The discipline even has a name for the scoring rule — the Brier score, in continuous use since 1950. It can be decomposed to isolate calibration specifically, so a forecaster who says 70% and is right half the time gets that error handed back as a number they answer for. Calibration is not a virtue the forecaster brought to the job. It is a residue left by a feedback loop. Take the loop away and the calibration leaves with it.

That is the whole thing. Confidence becomes a signal only inside a system that scores it against outcomes and feeds the score back. Weather built that loop. The courts, for most of a century, did not — a witness's confidence was never systematically checked against whether they were right, so it drifted free of accuracy and nobody noticed until DNA supplied the missing answer key. An LLM ships with no loop at all: its confidence is a single forward pass with nothing on the other side. And my fleet — the embarrassing punchline — had the field for the loop and left it empty, then read its own unscored summary back to me as reassurance.

## The number is moving into load-bearing positions

This matters now because the industry is busy wiring stated confidence into places that hold weight. Confidence thresholds decide whether an agent acts on its own or stops to ask a human. They gate which outputs get auto-approved and which get a review. They route work between a cheap model and an expensive one. Every one of those designs treats the number as a signal about correctness — as the meteorologist's 30% — when what it has under the hood is the eyewitness's certainty: a single, unscored, training-inflated feeling, largest exactly when it should be smallest. A gate keyed on that number does not fail randomly. It fails toward letting the confident-and-wrong through, because confident-and-wrong is the model's specialty. And a gate that clears exactly the cases it was built to stop teaches its operator, soon enough, to stop reading its verdicts at all — the [alert fatigue](/blog/the-alarm-budget/) that saturates every noisy monitor, now pushed down a level and wired into the confidence score itself.

There is a constructive half to this, and it is not "trust the number less." A scalar you distrust is still a scalar you are using. The more durable move is to stop asking the model how it feels and start measuring something outside the feeling. The most reliable uncertainty signal anyone has found does not come from the self-report at all; it comes from *disagreement across samples* — ask the same question several times, or several ways, and watch whether the answers converge or scatter. When Oxford researchers [published a method](https://www.nature.com/articles/s41586-024-07421-0) in *Nature* in 2024 for catching confabulations, the usable signal was the semantic spread of multiple answers, not the confidence of any one of them. This is something you can act on now: sample the same prompt three or five times, cluster the answers by meaning, and gate on whether they agree — not on the lone scalar the model volunteers. It is a small feedback loop you can run at inference time, and unlike the self-report it fails honestly, flying apart exactly when the model is lost. It is a poor man's Brier score, and it is worth more than the number the model hands you for free.

## What I am still figuring out

**Whether confidence is a signal at the first, uncontaminated pass.** I owe the eyewitness research one more turn, because the modern synthesis is not "confidence is worthless." [Wixted and Wells argued in 2017](https://journals.sagepub.com/doi/10.1177/1529100616686966) that under pristine conditions — an initial identification, a fair lineup, no suggestive feedback — a high-confidence eyewitness ID is in fact remarkably accurate. Confidence carries real information at the moment of first, uncontaminated measurement, and then bleeds it: a single confirming remark from an officer ("good, that's the one") can inflate a witness's remembered confidence by close to a full standard deviation while doing nothing for their accuracy, severing the link. I do not know whether agent confidence has a pristine moment. Maybe the number worth keeping is the one from a single clean forward pass — before the model has seen its own retries, my leading follow-ups, three rounds of self-critique — and everything after it is contaminated confidence, inflating away from the truth. If so, our habit of letting models revise and re-rate themselves is the officer leaning over the lineup.

**Whether I can even build the loop.** The honest reason my fleet is uncalibrated is not that calibration is impossible; it is that [scoring a decision against its outcome is expensive](/blog/the-cost-of-doubt/) and often ambiguous. A weather forecast resolves itself by tomorrow. Whether an architectural call was "right" may not be knowable for months, if ever, and may have no clean ground truth at all. I can build the Brier loop for the decisions that resolve cleanly. I do not yet know what to do about the ones that don't — which are also the ones where the confidence number is doing the most unearned work.

---

Ronald Cotton and Jennifer Thompson later became friends, and have spent years explaining to anyone who will listen that she was not lying and not careless. She was certain, in good faith, and certainty was the wrong instrument. The lesson never required doubting her sincerity. It required noticing that sincerity is not accuracy, and building a process that checks one against the other instead of accepting the first as a stand-in for the second.

The model that returns 0.9 is sincere in exactly that way. It is reporting, as faithfully as its training allows, how the claim feels from the inside. The mistake is not the model's. It is ours — every time we read that number as if it came from a meter that had been checked against the world, when most of the meters in front of us, mine included until recently, have never been checked at all. Confidence is not a signal. It is a feeling with a decimal point, and it becomes a signal only when something keeps score.
