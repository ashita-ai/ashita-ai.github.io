---
layout: post
title: "Your Evals Won't Save You"
date: 2026-01-16
---

In 2024, [42% of companies](https://www.spglobal.com/market-intelligence/en/news-insights/research/ai-experiences-rapid-adoption-but-with-mixed-outcomes-highlights-from-vote-ai-machine-learning) abandoned most of their AI initiatives before reaching production. Up from 17% the year before. Gartner [predicts](https://www.gartner.com/en/newsroom/press-releases/2024-07-29-gartner-predicts-30-percent-of-generative-ai-projects-will-be-abandoned-after-proof-of-concept-by-end-of-2025) 30% of GenAI projects will be abandoned after proof of concept by the end of 2025.

These projects did not fail because their evals were wrong. They failed because evals are not the problem.

## The eval-industrial complex

The industry is over-invested in pre-production evaluation. Evals are demo-able (you can show a chart going up), fundable (VCs understand "we improved accuracy by 15%"), and feel like engineering. They are a proxy for progress when you do not know if the product works yet.

But Gartner says projects fail from "poor data quality, inadequate risk controls, escalating costs, unclear business value." Not "our benchmark scores were too low."

The eval-industrial complex exists because evals are easy to build and hard to question. The actual hard problems are messy and cross-functional. Evals are contained and measurable. So we measure what is easy to measure and hope it correlates with what matters.

## The journey most teams take

It starts with benchmarks. An LLM scores [87% on HumanEval](https://www.codeant.ai/blogs/test-llm-performance-real-code). The team ships. In production, accuracy drops to 30% on real codebases with cross-file dependencies. Worse: benchmark contamination is [rampant](https://arxiv.org/html/2406.04244v1). Models have seen the test data. You were measuring memorization, not capability.

So the team builds custom evals. Reference-based metrics like ROUGE and BERTScore. But Eugene Yan [found](https://eugeneyan.com/writing/evals/) these do not discriminate well enough to set production thresholds. The similarity distributions of positive and negative instances are too close. Generated outputs often surpass reference quality anyway.

So the team builds an eval framework. Infrastructure, pipelines, dashboards. But Hamel Husain [advises](https://hamel.dev/blog/posts/evals/) starting simpler: "Spend 30 minutes manually reviewing 20-50 LLM outputs." If you are building infrastructure before you have looked at your data, you are optimizing for the wrong thing.

The pattern: teams keep investing in better pre-production measurement. The gap is not measurement. The gap is what happens after you ship.

## What actually matters

**Structured outputs.** OpenAI's [schema enforcement](https://openai.com/index/introducing-structured-outputs-in-the-api/) went from 40% compliance with prompting alone to 100% with strict mode. This is not glamorous, but it is where production systems actually break.

**Synthetic data for bootstrapping.** Synthetic data solves the cold start problem: no production traffic yet, no labeled dataset. You can [generate thousands of test cases](https://www.confident-ai.com/blog/the-definitive-guide-to-synthetic-data-generation-using-llms) in minutes. Once you understand your domain, curated test cases beat synthetic volume.

**Binary labels.** [Both](https://eugeneyan.com/writing/llm-evaluators/) [practitioners](https://hamel.dev/blog/posts/llm-judge/) recommend pass/fail over Likert scales. The difference between a "3" and a "4" is subjective. Pass/fail forces clearer thinking.

**Production feedback loops.** This is where the real gap is. Not better evals. Better learning.

## The system is the eval

Adaptive clinical trials do not test all treatments upfront, pick a winner, then ship. They use [multi-armed bandits](https://www.fda.gov/drugs/development-resources/adaptive-design-clinical-trials-drugs-and-biologics-guidance-industry) to allocate more patients to treatments that are working. You learn as you treat. The FDA approved this approach because it is more ethical and more effective than static trial design.

The same principle applies to LLM systems. The question is not "did this pass our evals?" The question is "can this system learn from production?"

Netflix does not pre-eval all possible recommendations. The system learns from what you watch. The eval is the production behavior.

| Pre-production evals | Production learning |
|---------------------|---------------------|
| Static measurement | Dynamic adaptation |
| Certainty before shipping | Learning from traffic |
| Investment: better evals | Investment: better feedback loops |

The teams that win will not be the ones with the best pre-production evals. They will be the ones whose systems learn fastest from real users.

---

Invest more in evaluatable systems than in evaluations. A system that learns from feedback will outperform a system that passed all your evals but cannot adapt.
