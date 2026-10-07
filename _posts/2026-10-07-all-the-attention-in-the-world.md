---
layout: post
title: "All the Attention in the World"
date: 2026-10-07
category: "architecture"
description: "Attention Is All You Need solved the machine's attention problem and handed the bill to the person reviewing the output. The paper also contained the fix: when attending to everything costs too much, restrict attention by a rule. For people supervising agents, the rule is irreversibility."
---

In June 2017, a team at Google posted a paper about machine translation. A couple of nights before the deadline, it still had no title. Llion Jones suggested a riff on a Beatles song. "It literally took five seconds of thought," he [told Wired](https://www.wired.com/story/eight-google-employees-invented-modern-ai-transformers-paper/). "I didn't think they would use it."

They used it. *[Attention Is All You Need](https://arxiv.org/abs/1706.03762)* has been cited 274,113 times as of this morning. Nearly every large language model in use descends from it.

Attention, in the paper, is a mechanism. Each word looks at every other word and decides how much each one matters. The cost of all that looking grows with the square of the input, and the authors said so in a table. For very long inputs they offered a way out in one sentence: let each position look only at a neighborhood. "We plan to investigate this approach further in future work."

The title aged in a way nobody planned.

For the machine, attention got cheap. GPT-1 read [512 tokens](https://cdn.openai.com/research-covers/language-unsupervised/language_understanding_paper.pdf) at a time in 2018. Frontier models now take about a million, 2,048 times as many. At fixed capability, the price has fallen roughly [tenfold a year](https://a16z.com/llmflation-llm-inference-cost/). The machine's attention still dilutes, as I wrote [last December](/blog/context-windows-are-not-free/). Chroma tested 18 models in 2025 and found that performance ["grows increasingly unreliable as input length grows."](https://research.trychroma.com/context-rot) But it is abundant, and getting more so.

Mine is not.

I pulled thirty days of my own numbers before writing this. On a median workday I open 19 pull requests and change about 23,000 lines. Agents opened at least two-thirds of those pull requests. Review bots leave roughly 95 findings, comments, and status checks a day. Humans leave three reviews. My agents run about nine hours a day, and their subagents make close to 3,000 tool calls.

Count only the items that ask me for a look or a decision, and it comes to about 150 a day. An eight-hour day gives each one about three minutes. Nothing else gets done in those eight hours.

If I had all the attention in the world, I would read everything. I don't. Nobody running agents does. So the useful question is where to spend what there is.

## Full attention

The default answer in agent tooling is to spend it everywhere. Every action that might matter asks a person for approval. It is the transformer's design applied to a human being: every token attends to every token. In a person, the quadratic cost does not show up as compute. It shows up as a glazed eye.

Anthropic measured it. Claude Code users [approve 93 percent](https://www.anthropic.com/engineering/claude-code-auto-mode) of permission prompts, and the company's engineers name the result: "approval fatigue, where people stop paying close attention to what they're approving." Among newer users, about a fifth of sessions run fully auto-approved. [By 750 sessions](https://www.anthropic.com/research/measuring-agent-autonomy), it is over two-fifths.

The hand learns. A thousand harmless approvals teach it that the next one is harmless too. Mine has learned it. So has yours.

None of this is new. Lisanne Bainbridge wrote in [*Ironies of Automation*](https://ckrybus.com/static/papers/Bainbridge_1983_Automatica.pdf), in 1983, that "it is impossible for even a highly motivated human being to maintain effective visual attention towards a source of information on which very little happens, for more than about half an hour." Exhortation does not fix it. In Norman Mackworth's vigilance studies, begun in 1948, urging subjects to be especially attentive [had no effect](https://www.frontiersin.org/journals/cognition/articles/10.3389/fcogn.2025.1632885/full).

"Review carefully" is not a control. It is a wish with a checkbox.

## The footnote was the fix

The authors had already written the answer, in that sentence about long inputs. When attending to everything costs too much, restrict attention by a rule. Their rule was distance. Mine is irreversibility.

Anthropic's own data shows why the rule fits. In its February study of agents in the field, "only 0.8% of actions appear to be irreversible." A prompt for every action buries those few inside the many. The approval for a force push arrives in the same box as the approval for a lint fix.

Jeff Bezos drew this line in his [2015 shareholder letter](https://www.sec.gov/Archives/edgar/data/1018724/000119312516530910/d168744dex991.htm). One-way doors are "consequential and irreversible or nearly irreversible" and deserve slow deliberation. Two-way doors are reversible and should be fast. His warning was that large organizations drag the heavy process onto light decisions and become slow.

Agents run the failure in reverse. The light reflex, approve and move on, leaks onto the heavy decisions, because both look the same on the way in. Economists have priced what that costs. Robert Pindyck [wrote in 1990](https://www.nber.org/system/files/working_papers/w3307/w3307.pdf) that an irreversible investment "kills" the option to invest. It gives up "the possibility of waiting for new information," and "this lost option value must be included as part of the cost of the investment." An approved force push spends that option. A reversible change keeps it.

## Before, or after

So irreversibility does not decide whether a person looks. It decides when.

Reversible work gets attention afterward. The agent acts, the action lands in a trail, and I sample the trail, audit it, and roll back what is wrong. Irreversible work gets attention before. It stops at a gate, and nothing moves until a person says so.

The vendors have converged here. [Claude Code's auto mode](https://code.claude.com/docs/en/permission-modes) blocks force pushes, production deploys, and mass deletion. [OpenAI's agent guide](https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf) says irreversible actions "should trigger human oversight until confidence in the agent's reliability grows."

The gate is the easy part. Knowing which actions belong behind it is hard. Anthropic reports that its own classifier misses 17 percent of real overeager actions. An email to a customer looks small and cannot be unsent. That classification is where a person's attention belongs.

## Where my attention went

Over the past year, my attention has moved four times. Each move went upstream.

At first I read what the agent wrote. One agent, one prompt, one diff.

When the agents multiplied, I read summaries instead of output. Then I noticed the same mistakes recurring across dozens of pull requests, so I wrote them down as rules every agent reads before it starts. A rule costs attention once. Catching the same mistake in review costs it every time.

I also changed how the agents talk to me. Action first, five items at most, no recap. The cheapest attention is the attention a well-formed message never asks for.

Now I mostly approve designs. One decision about how a thing should work covers hundreds of actions that follow from it, and most of those actions are reversible.

The arc runs from instances to rules, and from after the fact to before it. Reading instances scales with the number of agents. Writing rules does not.

## What I am still figuring out

I suspect review should split into three lanes, sorted mostly by reversibility: items that run without a look, items that get a glance, and items that get a full read. I have not tested it. I do not know what share of my 150 daily items belongs in each lane, and I expect my first guess would be wrong.

I do not know how to make irreversibility legible at the moment of action. A force push announces itself. A message to the wrong channel, or a migration that is reversible in theory and not on a Friday, does not.

And Bainbridge left a warning I have not answered. "Perhaps the final irony," she wrote, "is that it is the most successful automated systems, with rare need for manual intervention, which may need the greatest investment in human operator training." If I read fewer instances, I may lose the judgment that lets me write good rules. Good rules come from having read a lot of bad diffs.

My own queue of open agent conflicts still holds 180 items.

---

Llion Jones spent five seconds on the title. It was a good use of five seconds, and it was right. It was just about the wrong reader.

Attention is all you need, and you will never have all of it. The machine got the abundance. People kept the scarcity. What is left is deciding where to point the little we have. The paper told us how in 2017. Pick a rule. Attend to the neighborhood. Stop looking at the rest, and be honest that you stopped.
