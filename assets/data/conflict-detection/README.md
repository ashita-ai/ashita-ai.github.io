---
layout: page
title: "Conflict detection data"
permalink: /assets/data/conflict-detection/
description: "Blind labels, recoded decision pairs, and an authored teaching set for the conflict-detection post."
---

# Conflict detection: labels, pairs, and a teaching set

Companion data for [The Detector That Said Yes to Everything](https://ashita.ai/blog/the-detector-that-said-yes/).

The post argues that a hand-written evaluation suite can only check whether a
prompt matches the picture its author had in mind, and that the way out is to
label what the system actually did, after the fact, blind. It reports a set of
numbers from doing that. These files are here so you can check them, and so you
can try the labelling task yourself.

Three files, three different jobs. Read the caveats before you use any of them
as a benchmark.

---

## 1. `conflict-labels.csv`: every number in the post, no text

2,772 rows, one per scored decision pair. No decision text at all, which is why
this file covers the whole corpus rather than a scoped subset.

| column | meaning |
|---|---|
| `pair_id` | stable, non-reversible identifier |
| `gold_label` | blind four-way label: `contradiction`, `supersession`, `related_not_contradicting`, `unrelated` |
| `detector_relationship` | what the shipped detector said about this pair |
| `topic_similarity`, `significance`, `outcome_divergence`, `confidence_weight`, `temporal_decay` | the scorer's features |
| `decision_type_a`, `decision_type_b`, `agent_a`, `agent_b` | roles and decision categories |
| `same_project`, `same_agent`, `days_apart` | structural metadata |
| `severity`, `category`, `scoring_method` | detector metadata |
| `len_a`, `len_b` | decision text length in characters |
| `akashi_subset` | whether this pair is in the subset published as file 2 |

What you can reproduce from this file alone:

- The base rate. 93 contradictions in 2,772 pairs, 3.35%.
- The central finding. The detector said `contradiction` for 2,711 of 2,772
  pairs, 97.8%, of which 92 were right. Precision 3.39%, recall 98.9%.
- Both feature AUCs, and two the post added after the data was built:
  `outcome_divergence` is *inverted* at 0.434, and the strongest single feature
  is `temporal_decay` at 0.728, which was never designed as a signal.
- The precision arithmetic at a 3.35% base rate, and why F1 picks the wrong
  judge when the majority class is 96.65% of the data.

**Snapshot 2026-08-12.** The feature columns are mutable in the source system:
39 of these rows were rescored after the labelling run. That is why the post's
earlier AUC figures of 0.500 and 0.587 do not reproduce and were corrected. Any
AUC you compute here belongs to this snapshot.

## 2. `conflict-pairs-recoded.jsonl`: real pairs you can judge

192 pairs with their decision text, so you can run your own judge and compare.
Fields: `pair_id`, `gold_label`, `decision_type_a`, `decision_type_b`,
`decision_a`, `decision_b`.

**This is a scoped subset and its base rate is not the corpus base rate.** 14 of
192 pairs are contradictions, 7.3%, against 3.35% for the full corpus. A judge
evaluated here will look better than the same judge in production, because the
positives are more than twice as dense. If you quote a precision number from
this file, quote the 7.3% alongside it.

Label mix: 14 contradiction, 59 supersession, 119 related_not_contradicting.

**Every specific has been recoded.** Ticket ids, file paths, commit hashes, pull
request numbers, environment variables, branch names, service names, person
names and third-party names were replaced with stable placeholders
(`TICKET-X001`, `SHAX004`, `#PR012`, `pkg/xfile003.ext`, `Xname007`,
`xterm002`). Substitution is deterministic and the same source token always maps
to the same placeholder, which matters because a real contradiction here is
often two decisions binding the same named parameter to two different values.
Inconsistent substitution would destroy the very thing being labelled. The text
reads a little stiffly as a result. That is the trade.

## 3. `teaching-set.jsonl`: 60 authored pairs

Synthetic, hand-designed, no real data. Fields add `class` and `why`.

This one exists because the interesting thing about the task is not that it is
hard for models. It is that it is hard for people, and in a specific direction:
readers reliably call a supersession a contradiction. The set is deliberately
enriched, with 12 contradiction, 18 supersession, 26 related_not_contradicting
and 4 unrelated, and organised by the failure modes actually measured in production:

| class | what it tests |
|---|---|
| `binding_collision` | same named parameter, two values. A real contradiction |
| `genuine_reversal` | a live position actually reversed |
| `explicit_supersession` | the later decision says it replaces the earlier |
| `silent_supersession` | it replaces without saying so. Hard |
| `layer_confusion` | both say "access control"; one is route-level, one row-level |
| `diagnosis_then_repair` | one finds a defect, one fixes it |
| `measurement_vs_shipping` | one measures a rate, one ships a change |
| `surface_negation` | "no new vulnerabilities" vs "known vulnerabilities exist". Both true |
| `scope_disjoint` | same vocabulary, different subsystem |
| `unrelated_high_similarity` | dense shared jargon, no shared question |

Try `silent_supersession` and `surface_negation` before reading the labels.

---

## What is not here, and why

**The decision text for the full 2,772 pairs.** The corpus is an engineering
diary of real systems, most of it not mine to publish. File 1 carries the
statistics precisely because dropping the text is what made full coverage safe.

**The substitution map.** It is a decoder ring. Publishing it would reverse the
recoding in file 2.

**Anything you can use to identify the systems involved.** The scrub was built
around one rule that turned out to be wrong: *a token already present in my
public repository is safe to keep.* It is not. A token being in the repository
proves the leak already happened, which is exactly what it turned out to have
done. The rule was replaced, and three separate misses were caught afterwards by
an independent audit and a hard denylist check that fails the build rather than
warning. If you find something that should not be here, please open an issue on
[ashita-ai/akashi](https://github.com/ashita-ai/akashi).

## Reproducing the arithmetic

`examples/python/base_rate.py` and `examples/python/base_rate_charts.py` in the
[akashi repo](https://github.com/ashita-ai/akashi) reproduce the precision
arithmetic and generate the post's figures from label counts. Standard library
only.

## Provenance and license

Labels are LLM-generated, blind: each rater saw the two decision texts and
structural metadata, never the detector's verdict. An independent 200-pair
re-rate agrees at Cohen's kappa 0.766 for contradiction-versus-rest, with a 5.7%
false-flag rate on non-contradictions. **These labels are a noisy reference, not
ground truth.** Every precision figure derived from them inherits that noise.

Released under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
