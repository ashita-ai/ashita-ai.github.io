---
layout: post
title: "The Seeing Problem"
date: 2026-01-25
---

A startup used AI to translate their codebase into a new language. The AI generated a hardcoded UUID that assigned every new user the identical identifier. The code worked perfectly for the first user. For everyone after that, the signup flow crashed on database uniqueness constraints.

The outage lasted [five days](https://allinconsulting.substack.com/p/how-ai-generated-code-caused-a-10000). At least $10,000 in lost revenue. Dozens of angry support messages before anyone figured out what was wrong.

The obvious lesson: add better monitoring. Set up alerts on signup failures. Watch the error logs.

That is the wrong lesson.

A basic alert would have caught the symptom faster. It would not have caught the disease. The disease is that nobody understood the code well enough to know a hardcoded UUID was there in the first place. The AI generated it. The developers shipped it. Nobody read it carefully enough to notice.

This is the seeing problem. Not "we lack observability tools." We lack comprehension of what we are building.

## Two problems wearing the same name

The industry is conflating two different visibility gaps.

**Problem one: LLM application observability.** When you deploy a chatbot or an agent, you need to trace what the LLM does at runtime. What prompts fired. What tokens cost. Why the model hallucinated. Tools like [Langfuse](https://langfuse.com/), [Arize](https://arize.com/), and [Datadog LLM Observability](https://www.datadoghq.com/product/llm-observability/) solve this. The category is maturing rapidly.

**Problem two: AI-generated code comprehension.** When an AI writes your code during development, you need to understand what it wrote before it reaches production. This is not a runtime problem. It is a development-time problem. And the tooling barely exists.

The UUID bug was problem two. Langfuse would not have caught it. Datadog would not have caught it. Those tools monitor LLM behavior at runtime. The UUID was hardcoded at development time by an AI that was never monitored at all.

When people say "the observability tools exist," they are usually pointing at problem one while experiencing problem two.

## The comprehension debt crisis

Researchers at Carnegie Mellon [named this pattern](https://arxiv.org/abs/2512.08942) comprehension debt: what happens when teams build systems more sophisticated than they can independently understand. [Traditional technical debt](/blog/the-three-debts/) means someone understood the code when it was written. Comprehension debt means nobody ever did.

The consequences are materializing faster than the industry expected.

[One in five organizations](https://www.rg-cs.co.uk/ai-generated-code-blamed-for-1-in-5-breaches/) suffered a major security breach linked directly to AI-generated code in 2024-2025. Average cost: [$4.63 million per breach](https://www.kiteworks.com/cybersecurity-risk-management/ibm-2025-data-breach-report-ai-risks/). IBM found that 69% of breached organizations discovered vulnerabilities in AI-generated code they had already deployed. They did not know what they had shipped.

An indie game team [documented their experience](https://huggingface.co/blog/zeenaz/beyond-technical-debt): "The code worked. That was the problem. When bugs appeared or requirements changed, they couldn't fix it. They didn't understand the internal logic. They'd have to go back to AI and ask it to debug their own codebase."

[OX Security analyzed 300 open-source repositories](https://www.ox.security/resource-category/whitepapers-and-reports/army-of-juniors/) and found AI-generated code is "highly functional but systematically lacking in architectural judgment." Their VP of Research: "Functional applications can now be built faster than humans can properly evaluate them."

The [Cortex engineering benchmark](https://www.coderabbit.ai/blog/state-of-ai-vs-human-code-generation-report) found that while AI tools boosted PR output by 20%, incidents increased by 23.5%. Change failure rates rose 30%. The incidents are outpacing the velocity.

## Failure modes nobody anticipated

The UUID bug is a simple case. The failure modes getting worse are the ones current tools cannot see.

**Slopsquatting.** [A USENIX study](https://www.usenix.org/publications/loginonline/we-have-package-you-comprehensive-analysis-package-hallucinations-code) found that 19.6% of AI-suggested package dependencies do not exist. The packages are hallucinated. Gemini's hallucination rate reaches 64.5%, with 58% of hallucinated packages repeated consistently—making them predictable targets.

Attackers noticed. Security researcher Bar Lanyado [created a package](https://incidentdatabase.ai/cite/731) called `huggingface-cli` after seeing it hallucinated repeatedly. Alibaba incorporated it into their production documentation. The fake package was downloaded 30,000 times in three months.

Dependency scanners like Snyk check for known vulnerabilities in existing packages. They cannot detect when a package does not exist at generation time but gets maliciously registered later. The attack surface emerges after code generation but before deployment.

**Model drift.** The same AI produces different quality code over time. [Stanford and UC Berkeley researchers found](https://arxiv.org/abs/2307.09009) GPT-4's accuracy on prime number identification dropped from 84% to 51% in three months—a 40% degradation. [Developers report](https://spectrum.ieee.org/ai-coding-degrades) tasks that took five hours with AI assistance in 2024 now take longer because quality has degraded.

LLM observability tools track individual API calls. They do not maintain version-controlled baselines of generated code quality for identical prompts across model versions. They see API success but not subtle quality decay.

**Circular test validation.** AI generates both implementation and tests. The tests validate the AI's assumptions, not the requirements. As [one analysis](https://davidadamojr.com/ai-generated-tests-are-lying-to-you/) put it: "If your code is wrong, then tests derived from it will faithfully reflect that wrongness. It's like asking a student to grade their own essay with a rubric that they wrote themselves."

Code coverage tools report lines executed. They do not report whether the assertions are correct. A test suite with 95% coverage generated by the same AI that wrote buggy code will dutifully test the bugs.

**Architectural decay.** Individual AI suggestions make local sense but collectively fragment the architecture. [GitClear's 2025 research](https://www.gitclear.com/ai_assistant_code_quality_2025_research) found a 4x increase in code clones and a doubling of code churn since the pre-AI baseline. Each suggestion solves its immediate problem while creating parallel implementations that individually work but collectively become unmaintainable.

These are not runtime observability problems. Langfuse will not catch them. They are comprehension problems that require different tools.

## What would have caught the UUID bug

The startup's five-day outage was not inevitable. Several approaches would have caught the hardcoded UUID before production.

**Property-based testing.** Instead of testing "create one user, verify ID exists," test the invariant: "create 100 users, verify all IDs are unique." The hardcoded UUID fails on the second user. Traditional example-based tests often create one or two users and miss the collision.

**Mutation testing.** [Meta's mutation testing research](https://engineering.fb.com/2025/09/30/security/llms-are-the-key-to-mutation-testing-and-better-compliance/) found that combining LLM-guided mutations with test verification catches exactly this failure mode. If your tests pass with a hardcoded UUID injected, the mutation "survives" and flags a gap.

**Static analysis for duplicated literals.** Tools like [SonarQube](https://rules.sonarsource.com/c/rspec-109/) flag hardcoded constants that appear multiple times. If the UUID appeared in multiple signup flows or test files, the duplication would have triggered review.

**AI code provenance tracking.** Emerging tools like [git-ai](https://www.blog.brightcoding.dev/2025/12/14/the-ai-code-tracking-revolution-how-to-automatically-identify-ai-generated-code-in-your-git-repositories/) fingerprint AI-generated code and prioritize it for human review. [Research shows](https://arxiv.org/html/2405.16081) developers perform better when they know code is AI-generated—they search more, test more, and catch bugs faster.

None of these are LLM observability tools. They are development-time verification tools. The category that needs to exist for AI-generated code is not runtime monitoring. It is pre-production comprehension.

## The investment gap

The mismatch is staggering.

Cursor AI is valued at [$29.3 billion](https://www.cnbc.com/2025/11/13/cursor-ai-startup-funding-round-valuation.html). Cognition (Devin) at [$10.2 billion](https://techcrunch.com/2025/09/08/cognition-ai-defies-turbulence-with-a-400m-raise-at-10-2b-valuation/). GitHub Copilot has 20 million users and is now a larger business than all of GitHub was when Microsoft acquired it.

Arize, the largest AI observability company, raised [$70 million Series C](https://arize.com/blog/arize-ai-raises-70m-series-c-to-build-the-gold-standard-for-ai-evaluation-observability/). Langfuse raised $4 million seed.

That is a 150x to 400x valuation gap between building and seeing.

Enterprise spending tells the same story. [$37 billion](https://menlovc.com/perspective/2025-the-state-of-generative-ai-in-the-enterprise/) went to generative AI in 2025. The entire LLM observability market is [$2 billion](https://market.us/report/llm-observability-platform-market/). An 18x difference.

The result is predictable. [84% of developers](https://survey.stackoverflow.co/2025/ai) use or plan to use AI coding tools. Yet [74% of companies](https://www.bcg.com/press/24october2024-ai-adoption-in-2024-74-of-companies-struggle-to-achieve-and-scale-value) struggle to achieve and scale value from AI initiatives, according to BCG research.

The industry is building at an 18x building-to-seeing ratio, then wondering why 74% struggle to extract value.

## What I am still figuring out

Traditional observability worked because software was deterministic. Same input, same output, reproducible failures. You could trace a request through the system and understand what happened.

AI-generated code breaks this model in two ways.

First, the code itself may be non-deterministic in origin. The same prompt to the same model produces different code. Model updates change output quality without warning. You cannot reproduce the conditions that generated the code you are debugging.

Second, [comprehension debt compounds](/blog/the-hollow-codebase/). Each AI-generated module you do not understand makes the next one harder to evaluate. The codebase becomes a black box assembled from black boxes.

I do not know what the right abstraction is. Maybe it is provenance tracking that logs which model version generated which code. Maybe it is mandatory property-based testing for any AI-generated module touching critical paths. Maybe it is Martin Kleppmann's prediction that [AI will make formal verification mainstream](https://martin.kleppmann.com/2025/12/08/ai-formal-verification.html)—LLMs propose invariants, theorem provers guarantee correctness.

What I do know: the answer is not "add Datadog LLM Observability." That solves a different problem. The seeing problem for AI-generated code is a development-time comprehension problem, not a runtime monitoring problem. The tools that solve it do not exist yet, or exist in fragments that nobody has assembled into a coherent practice.

---

That startup's five-day outage cost at least $10,000. A basic alert would have caught the symptom faster.

But the disease was that nobody understood what the AI had written. The alert would not have fixed that. The next bug would have been different, and the next one after that.

AI solved the building problem. It created the comprehension problem. The industry is spending 18x more on building than on seeing, then blaming the tools that exist for the tools that do not.
