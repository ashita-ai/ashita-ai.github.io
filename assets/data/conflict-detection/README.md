---
layout: page
title: "Conflict detection data"
permalink: /assets/data/conflict-detection/
description: "Blind labels, recoded decision pairs, and an authored teaching set for the conflict-detection post."
---

Companion data for [The Detector That Said Yes to Everything](https://ashita.ai/blog/the-detector-that-said-yes/).

The post argues that a hand-written evaluation suite can only check whether a
prompt matches the picture its author had in mind, and that the way out is to
label what the system actually did, after the fact, blind. It reports a set of
numbers from doing that. These files are here so you can check them, and so you
can try the labelling task yourself.

Three files, three different jobs. Read the caveats before you use any of them
as a benchmark.

- [`conflict-labels.csv`](/assets/data/conflict-detection/conflict-labels.csv) — 2,772 blind labels, no text
- [`conflict-pairs-recoded.jsonl`](/assets/data/conflict-detection/conflict-pairs-recoded.jsonl) — 192 recoded pairs with text
- [`teaching-set.jsonl`](/assets/data/conflict-detection/teaching-set.jsonl) — 60 authored pairs across ten failure modes

---

## 1. `conflict-labels.csv`: every number in the post, no text

2,772 rows, one per scored decision pair. No decision text at all, which is why
this file covers the whole corpus rather than a scoped subset.

| column | meaning |
|---|---|
| `pair_id` | stable, non-reversible identifier shared with file 2 when `in_recoded_subset` is `t` |
| `gold_label` | blind four-way label: `contradiction`, `supersession`, `related_not_contradicting`, `unrelated` |
| `detector_relationship` | what the shipped detector said about this pair |
| `topic_similarity`, `significance`, `outcome_divergence`, `confidence_weight`, `temporal_decay` | the scorer's features |
| `decision_type_a`, `decision_type_b`, `agent_a`, `agent_b` | roles and decision categories |
| `same_project`, `same_agent`, `days_apart` | structural metadata |
| `severity`, `category`, `scoring_method` | detector metadata |
| `len_a`, `len_b` | decision text length in characters |
| `in_recoded_subset` | whether this pair is one of the 192 published with text in file 2 |

What you can reproduce from this file alone:

- The base rate. 93 contradictions in 2,772 pairs, 3.35%.
- The central finding. The detector said `contradiction` for 2,711 of 2,772
  pairs, 97.8%, of which 92 were right. Precision 3.39%, recall 98.9%.
- Every feature AUC. Rank AUC with midrank ties, Hanley–McNeil intervals:
  `temporal_decay` 0.728, `topic_similarity` 0.616, `significance` 0.601,
  `confidence_weight` 0.584, `outcome_divergence` 0.434. Two of those are worth
  a second look. `outcome_divergence` is *inverted*, with an interval that
  excludes 0.5, and the strongest feature in the scorer is a staleness weight.
- The precision arithmetic at a 3.35% base rate, and why F1 picks the wrong
  judge when the majority class is 96.65% of the data.

**Snapshot 2026-08-12.** Feature columns are mutable in the source system, and
39 of these rows were rescored after the labelling run. Treat any AUC you
compute here as a property of this snapshot, not of the pipeline in general.

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

**Identifying tokens are recoded.** Ticket ids, paths, commit hashes, pull
request numbers, environment variables, branch names, person names, and named
stack products use stable placeholders (`TICKET-X001`, `SHAX004`,
`pkg/xfile003.ext`, `Xname007`, `xterm002`, `xvendor001`). The same source token
maps to the same placeholder, which preserves parameter-binding contradictions
without releasing the original token.

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

**Anything identifying the systems involved.** Ticket ids, hashes, paths,
branch names, hostnames, resource ids, people, and named stack products are
recoded. Every release runs `scripts/check_conflict_detection_data.rb`, which
verifies the CSV/JSONL join and exits non-zero on raw identifier patterns or the
named product denylist. Agent identifiers are the exception: file 1's `agent_a`
and `agent_b` columns carry the real tool names, published deliberately, because
the post's argument is about which agents disagree. If you find something that
should not be here, open an issue on
[ashita-ai/akashi](https://github.com/ashita-ai/akashi).

## Provenance and license

Labels are LLM-generated, blind: each rater saw the two decision texts and
structural metadata, never the detector's verdict. An independent 200-pair
re-rate agrees at Cohen's kappa 0.766 for contradiction-versus-rest, with a 5.7%
false-flag rate on non-contradictions. **These labels are a noisy reference, not
ground truth.** Every precision figure derived from them inherits that noise.

Released under [CC BY 4.0](https://creativecommons.org/licenses/by/4.0/).
