---
layout: post
title: "LLM Evals Should Not Be a Black Box"
date: 2025-01-09
---

*Arbiter is available on PyPI. Install with `pip install arbiter-ai`.*

---

I ran an evaluation suite last month. 858 test cases, five evaluators, four models. The bill was $247.

I did not know this until the invoice arrived.

## The visibility problem

LLM evaluation is expensive. Every semantic similarity check, every factuality assessment, every pairwise comparison costs tokens. But most frameworks treat cost as an afterthought. You find out what you spent when you check your billing dashboard.

This matters because evaluation is iterative. You run a suite, tweak a prompt, run again. Without real-time cost visibility, you cannot make informed tradeoffs. Should you use GPT-4 or Haiku for this evaluator? How much does adding a factuality check cost per test case? These questions have answers, but most frameworks do not surface them.

## Cost as a first-class concept

Arbiter tracks every LLM interaction automatically. No manual instrumentation. No log parsing. The cost shows up as you run evaluations:

```python
from arbiter_ai import SemanticSimilarityEvaluator

evaluator = SemanticSimilarityEvaluator()
result = await evaluator.evaluate(
    output="Paris is the capital of France.",
    reference="The capital of France is Paris."
)

print(f"Score: {result.score}")
print(f"Cost: ${result.cost:.4f}")
```

Every `EvaluationResult` includes cost. Batch evaluations aggregate costs. You can filter and analyze by evaluator, by model, by test case. The data is there because ignoring it is not an option.

## What you can evaluate

Arbiter ships with evaluators for common needs:

| Evaluator | What it measures |
|-----------|------------------|
| Semantic Similarity | How close is the output to a reference? |
| Factuality | Are the claims supported by provided context? |
| Groundedness | Does the output stay within source material? |
| Relevance | Does the output address the query? |
| Custom Criteria | Whatever you define |
| Pairwise Comparison | Which of two outputs is better? |

The pairwise evaluator is useful for A/B testing prompts. The custom criteria evaluator handles domain-specific requirements. Need to check if a response maintains a formal tone? Define the criteria, pass it to the evaluator.

## Building your own

The framework uses a template method pattern. Extend `BasePydanticEvaluator`, implement four methods, and you have a custom evaluator with cost tracking built in:

```python
from arbiter_ai import BasePydanticEvaluator, Score
from pydantic import BaseModel, Field

class ToneResponse(BaseModel):
    score: float = Field(ge=0.0, le=1.0)
    detected_tone: str
    explanation: str

class ToneEvaluator(BasePydanticEvaluator):
    @property
    def name(self) -> str:
        return "tone"

    def _get_system_prompt(self) -> str:
        return "You evaluate whether text matches a specified tone..."

    def _get_user_prompt(self, output: str, **kwargs) -> str:
        tone = kwargs["tone"]
        return f"Evaluate if this text matches '{tone}' tone:\n{output}"

    def _get_response_type(self) -> type[ToneResponse]:
        return ToneResponse

    def _compute_score(self, response: ToneResponse) -> Score:
        return Score(
            value=response.score,
            metadata={"detected_tone": response.detected_tone}
        )
```

The base class handles LLM client management, structured outputs via PydanticAI, token counting, and cost calculation. You focus on the evaluation logic.

## No platform required

Arbiter is a library. Install it, configure API keys, run evaluations. There is no platform signup, no external server, no vendor lock-in.

Results persist to PostgreSQL or Redis if you want durability. Otherwise they live in memory. The choice is yours.

Provider support includes OpenAI, Anthropic, Google, Groq, Mistral, and Cohere. Switch models by changing a string.

## Alternatives

There are more mature options.

[DeepEval](https://github.com/confident-ai/deepeval) has 50+ metrics, pytest integration, and a cloud platform. If you need comprehensive coverage out of the box, it is probably the right choice. The tradeoff is weight. DeepEval does a lot, which means there is more to learn and more that can break. It also pushes you toward their Confident AI platform for team features.

[Promptfoo](https://github.com/promptfoo/promptfoo) is excellent for prompt iteration. YAML configs, CLI-first, fast feedback loops. If you are a prompt engineer testing variations, start there. It is less programmatic than Arbiter and does not emphasize cost tracking.

[RAGAS](https://github.com/explodinggradients/ragas) is purpose-built for RAG evaluation. Five core metrics, tight integration with LangChain and LlamaIndex. If you are evaluating retrieval pipelines specifically, RAGAS is more focused than a general framework.

Arbiter is smaller and newer. It has fewer built-in metrics than DeepEval. It does not have a cloud platform. What it does have: cost visibility on every evaluation, a clean extension pattern via PydanticAI, and no upsell. I built it because I wanted to know what my evaluations cost before the invoice arrived.

## When to use it

Arbiter makes sense if:

- You run LLM evaluations regularly
- You care about what those evaluations cost
- You want to build custom evaluators without reinventing infrastructure
- You prefer libraries over platforms.

It doesn't make sense if:

- You need a visual dashboard (use a platform instead)
- You run evaluations rarely enough that cost does not matter
- You want managed infrastructure

## Try it

```bash
pip install arbiter-ai
```

```python
import asyncio
from arbiter_ai import FactualityEvaluator

async def main():
    evaluator = FactualityEvaluator()

    result = await evaluator.evaluate(
        output="The Eiffel Tower is 330 meters tall.",
        context="The Eiffel Tower, located in Paris, stands at 330 meters."
    )

    print(f"Factual: {result.score:.0%}")
    print(f"Cost: ${result.cost:.4f}")

asyncio.run(main())
```

The [repo is on GitHub](https://github.com/ashita-ai/arbiter). Documentation includes 25+ examples covering basic usage through advanced patterns. The test suite has 96% coverage if you want to see how things work.

---

*This is part of a series on the tools I am building at Ashita AI. See also: [Engram](/blog/introducing-engram/), memory that does not lie. [Tessera](/blog/introducing-tessera/), data contracts for agentic engineering. [Conduit](/blog/introducing-conduit/), intelligent LLM routing.*
