---
layout: post
title: "Comprehension Debt"
date: 2026-01-25
category: "ai-failures"
---

A startup used AI to translate their codebase into a new language. The AI generated a hardcoded UUID that assigned every new user the identical identifier. The code worked perfectly for the first user. For everyone after that, the signup flow crashed on database uniqueness constraints.

The outage lasted [five days](https://allinconsulting.substack.com/p/how-ai-generated-code-caused-a-10000). At least $10,000 in lost revenue. Dozens of angry support messages before anyone figured out what was wrong.

The obvious lesson: add better monitoring. Set up alerts on signup failures. Watch the error logs.

That is the wrong lesson.

A basic alert would have caught the symptom faster. It would not have caught the disease. The disease is that nobody understood the code well enough to know a hardcoded UUID was there in the first place. The AI generated it. The developers shipped it. Nobody read it carefully enough to notice.

This is not an observability problem. Runtime monitoring would not have caught a hardcoded UUID. This is a comprehension problem: we do not understand what we are building.

## The crisis

Researchers at Carnegie Mellon [named this pattern](https://arxiv.org/abs/2512.08942) comprehension debt: what happens when teams build systems more sophisticated than they can independently understand. Traditional technical debt means someone understood the code when it was written. Comprehension debt means nobody ever did.

The consequences are materializing faster than the industry expected.

[One in five organizations](https://www.rg-cs.co.uk/ai-generated-code-blamed-for-1-in-5-breaches/) suffered a major security breach linked directly to AI-generated code in 2024-2025. Average cost: [$4.63 million per breach](https://www.kiteworks.com/cybersecurity-risk-management/ibm-2025-data-breach-report-ai-risks/). IBM found that 69% of breached organizations discovered vulnerabilities in AI-generated code they had already deployed. They did not know what they had shipped.

An indie game team [documented their experience](https://huggingface.co/blog/zeenaz/beyond-technical-debt): "The code worked. That was the problem. When bugs appeared or requirements changed, they couldn't fix it. They didn't understand the internal logic. They'd have to go back to AI and ask it to debug their own codebase."

[OX Security analyzed 300 open-source repositories](https://www.ox.security/resource-category/whitepapers-and-reports/army-of-juniors/) and found AI-generated code is "highly functional but systematically lacking in architectural judgment." Their VP of Research: "Functional applications can now be built faster than humans can properly evaluate them."

The [Cortex engineering benchmark](https://www.coderabbit.ai/blog/state-of-ai-vs-human-code-generation-report) found that while AI tools boosted PR output by 20%, incidents increased by 23.5%. The incidents are outpacing the velocity.

## Failure modes nobody anticipated

The UUID bug is a simple case. The failure modes getting worse are the ones current tools cannot see.

**Slopsquatting.** [A USENIX study](https://www.usenix.org/publications/loginonline/we-have-package-you-comprehensive-analysis-package-hallucinations-code) found that 19.6% of AI-suggested package dependencies do not exist. The packages are hallucinated. Gemini's hallucination rate reaches 64.5%, with 58% of hallucinated packages repeated consistently, making them predictable targets.

Attackers noticed. Security researcher Bar Lanyado [created a package](https://incidentdatabase.ai/cite/731) called `huggingface-cli` after seeing it hallucinated repeatedly. Alibaba incorporated it into their production documentation. The fake package was downloaded 30,000 times in three months.

Dependency scanners like Snyk check for known vulnerabilities in existing packages. They cannot detect when a package does not exist at generation time but gets maliciously registered later. The attack surface emerges after code generation but before deployment.

**Model drift.** The same AI produces different quality code over time. [Stanford and UC Berkeley researchers found](https://arxiv.org/abs/2307.09009) GPT-4's accuracy on prime number identification dropped from 84% to 51% in three months, a 33 percentage point drop. [Developers report](https://spectrum.ieee.org/ai-coding-degrades) tasks that took five hours with AI assistance in 2024 now take longer because quality has degraded.

Nobody maintains version-controlled baselines of generated code quality for identical prompts across model versions. The quality decay is invisible.

**Circular test validation.** AI generates both implementation and tests. The tests validate the AI's assumptions, not the requirements. As [one analysis](https://davidadamojr.com/ai-generated-tests-are-lying-to-you/) put it: "If your code is wrong, then tests derived from it will faithfully reflect that wrongness. It's like asking a student to grade their own essay with a rubric that they wrote themselves."

Code coverage tools report lines executed. They do not report whether the assertions are correct. A test suite with 95% coverage generated by the same AI that wrote buggy code will dutifully test the bugs.

**Architectural decay.** Individual AI suggestions make local sense but collectively fragment the architecture. [GitClear's 2025 research](https://www.gitclear.com/ai_assistant_code_quality_2025_research) found a 4x increase in code clones and a 60% decline in refactoring since the pre-AI baseline. Each suggestion solves its immediate problem while creating parallel implementations that individually work but [collectively become unmaintainable](/blog/your-agents-need-a-supervisor/).

These are comprehension problems. No amount of runtime monitoring catches them. They require different tools.

## What would have caught the UUID bug

The startup's five-day outage was not inevitable. A property-based test — "create 100 users, verify all IDs are unique" — would have caught it on the second user. [Meta's mutation testing research](https://engineering.fb.com/2025/09/30/security/llms-are-the-key-to-mutation-testing-and-better-compliance/) found that LLM-guided mutations catch exactly this failure mode: if your tests pass with a hardcoded UUID injected, the mutation "survives" and flags the gap. Static analysis tools like [SonarQube](https://rules.sonarsource.com/c/rspec-109/) flag hardcoded constants. And [research shows](https://arxiv.org/html/2405.16081) developers perform better when they simply know code is AI-generated: they search more, test more, catch bugs faster.

The tools exist. What does not exist is the discipline of treating AI-generated code as untrusted by default.

## The investment gap

Cursor AI is valued at [$29.3 billion](https://www.cnbc.com/2025/11/13/cursor-ai-startup-funding-round-valuation.html). Cognition (Devin) at [$10.2 billion](https://techcrunch.com/2025/09/08/cognition-ai-defies-turbulence-with-a-400m-raise-at-10-2b-valuation/). GitHub Copilot has 20 million users and is now a larger business than all of GitHub was when Microsoft acquired it. Enterprise spending on generative AI hit [$37 billion](https://menlovc.com/perspective/2025-the-state-of-generative-ai-in-the-enterprise/) in 2025.

[84% of developers](https://survey.stackoverflow.co/2025/ai) use or plan to use AI coding tools. Yet [74% of companies](https://www.bcg.com/press/24october2024-ai-adoption-in-2024-74-of-companies-struggle-to-achieve-and-scale-value) struggle to achieve and scale value from AI initiatives, according to BCG research. The industry invested massively in building and almost nothing in understanding what was built.

## What I am still figuring out

Traditional observability worked because software was deterministic. Same input, same output, reproducible failures. You could trace a request through the system and understand what happened.

AI-generated code breaks this model in two ways.

First, the code itself may be non-deterministic in origin. The same prompt to the same model produces different code. Model updates change output quality without warning. You cannot reproduce the conditions that generated the code you are debugging.

Second, comprehension debt compounds. Each AI-generated module you do not understand makes the next one harder to evaluate. The codebase becomes a black box assembled from black boxes.

I do not know what the right abstraction is. Maybe it is provenance tracking that logs which model version generated which code. Maybe it is mandatory property-based testing for any AI-generated module touching critical paths. Maybe it is Martin Kleppmann's prediction that [AI will make formal verification mainstream](https://martin.kleppmann.com/2025/12/08/ai-formal-verification.html): LLMs propose invariants, theorem provers guarantee correctness. What I do know is that comprehension debt compounds faster than technical debt, because at least someone understood the technical debt when it was written.

---

That startup's five-day outage cost at least $10,000. A basic alert would have caught the symptom faster. But the disease was that nobody understood what the AI had written. The alert would not have fixed that. The next bug would have been different, and the next one after that.
