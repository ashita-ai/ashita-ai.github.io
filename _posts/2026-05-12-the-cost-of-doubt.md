---
layout: post
title: "The Cost of Doubt"
date: 2026-05-12
category: "architecture"
---

On March 6, 1665, Henry Oldenburg published the first issue of *Philosophical Transactions of the Royal Society*. He was the Society's first Secretary; the journal was the second of its kind in the world and is the longest-running scientific journal still publishing today. Oldenburg did not write the papers that appeared in it. His job was to read them, decide which were worth publishing, and steward the process by which the Society's Council vetted the work before it went to print.

Acceptance was the author's job. Doubt was Oldenburg's, and the Council's, and the Members' who read each manuscript before it was licensed for publication. The Society's rules at the time required that every tract be approved by the Council and reviewed first by some of its Members. This was internal review — insiders judging insiders. There was no external peer-review apparatus, and there did not need to be: the Society was small, the volume was small, the cost of doubt was modest, and it was paid by the people who already had a reason to pay it.

The volume grew. By the 1830s, the Royal Society had established Sectional Committees with named referees, and peer review — a third party, asked to read each manuscript with the assumption that something was wrong — became formal procedure. The cost of doubt had outgrown what the Council could absorb in-house. The Society had to externalize it.

Every age since has spent a little more on doubt as the volume of acceptance grew.

## When the volume grew

Code review came late to the principle. Michael Fagan published *Design and Code Inspections to Reduce Errors in Program Development* in IBM Systems Journal in 1976, and showed that structured pre-deployment inspection caught defects at a tenth to a hundredth of the cost of catching them after release. His inspections were heavyweight — multiple participants, formal roles, hours per session — and like the Royal Society's 1665 council vetting, they were affordable as long as the volume was modest. They lightened. By the 2000s, peer review at scale meant patch emails on Linux Kernel Mailing List threads. By the 2010s, it meant pull requests on GitHub. Each step compressed the format because the rate of work was rising and the doubt-budget could not keep up.

The lightening was not because the principle had been challenged. It was because human reviewers had stayed expensive while the rate of work outgrew them. By the 2020s, "code review" in most teams meant a glance from a colleague, a green-checkmark from CI, and a merge button. The form had become so light that "did this PR actually get reviewed" was a question one could ask without sarcasm.

Then generation stopped being a human activity.

AI agents now produce code at rates that bear no relationship to what humans can read. [Faros AI's telemetry from over 10,000 developers](/blog/the-hollow-codebase/) showed teams with high AI adoption merging 98% more pull requests and seeing PR review times rise 91%. The reviewer pool is the same size. The reviewer's reading rate is the same. The math is what it has been since 1665, just compressed: when the rate of acceptance outruns the doubt-budget, the budget either grows or quality drops.

## What gets paid

What is different about this moment is that the budget cannot grow at the rate the work does. A reviewer cannot read fifty times as many pull requests in a week as they used to. A bot can be added at low marginal cost — that is what the AI-review tools are — but a bot whose findings the reviewer cannot trust is a tax, not a budget. The cost of doubt is paid in calibrated trust, not in the bot's outputs. And calibration is human work.

This is the bottleneck under the bottleneck. Even where AI review tools are good — and the better ones are pretty good — the reading of their findings, the marking of false positives, the maintenance of the loop that lets a team trust the bot, is human time spent on doubt. It scales linearly. The cost grows with the volume of generation, and a team that does not pay it absorbs the cost a different way: as bugs that ship, as audit gaps that surface in incidents, as quiet deterioration in the code's reliability that no one can pinpoint to a specific PR.

A reviewer's incentives have always been a problem. Peer reviewers in science are paid in citations and reputation, badly. Code reviewers are paid in seniority signaling and architectural influence, also badly. The reviewer's interests do not align with the producer's interests; that is the point. But the misalignment has to be funded by the institution. Without institutional funding for doubt, the producer's interests dominate, and the producer accepts.

This is true at the granular level — the reviewer who is too busy to engage will rubber-stamp; the reviewer whose feedback was ignored on the last three PRs will not bother on the fourth — and at the strategic level. A team that ships AI-generated code without a corresponding investment in doubt is in the same regime as a journal that publishes manuscripts without referees. It works for a while. The cost compounds.

## Where the cost is paid

Three things follow.

The first is that [reviewer attention has to be allocated, not assumed](/blog/the-attention-economy-of-engineering/). The reviewer who is also a senior engineer cannot be the residual catch for everything that ships, because their time is finite and their other obligations are not optional. Some organizations have started rotating senior engineers through dedicated review weeks; others have created reviewer roles that exist as their own job, the way scientific journals have professional editors. The shape will vary, but the underlying move is the same: doubt is a paid position now, not a tax on whoever happens to be CC'd.

The second is that bot review needs continuous calibration to be worth running at all. A bot reviewer that is not calibrated drifts into noise, which trains reviewers to ignore findings, including the next real one. A bot reviewer that is calibrated produces the kind of findings the human reviewer can use to extend their attention. Calibration costs human time, in the form of reading the bot's output critically, marking false positives, escalating false negatives, and feeding the result back into the configuration that drives the next pass. A bot review system shipped without this loop is the cheap half of the system, and most teams will deploy it. The expensive half is what makes the cheap half useful.

The third is that some kinds of doubt cannot be delegated. Architectural doubt — does this fit the system we are building? — cannot be done by a bot reading a diff, because the diff is too narrow a context. Cultural doubt — does this match how we work? — cannot be done by a bot at all. These continue to be human work, they continue to be linear in human time, and the temptation to skip them when the queue is long is the most expensive temptation in software production.

[Mimir](https://github.com/Mimir-Review/mimir), an open-source bot reviewer [Dan Getz](https://www.linkedin.com/in/dangetzjr/) is designing, applies this discipline to its own pipeline. Findings persist to the database before they are posted, so an API failure does not erase them. Every lifecycle transition becomes an append-only event row. Confidence adjustments and suppressions carry their reasons in the same log. The semantic index reports `IsApproximate()`, and that signal propagates to confidence ceilings, to prompt annotations the model itself reads, and to coverage disclosure on the summary comment. Reactions on inline comments become labeled events that feed the system's evaluation of itself. The design is largely his; we have been thinking through it together. If the design problem is interesting, reach out to him, or me.

## What I am still figuring out

Whether the cultural commitment to doubt scales the way I am arguing it does. The history of peer review in science is also a history of underinvestment — reviewers underpaid, their work unattributed, the system held together by a small number of people who care more than the system rewards. Software has the same shape. I do not know whether the AI generation rate will force organizational reinvestment in doubt, or whether the cost will compound invisibly until something breaks badly enough that someone reinvests after the fact. The latter is how most institutions discover that doubt was load-bearing.

Whether bot review changes the answer. At a hypothetical limit, a bot reviewer that is calibrated to a team's standards and continuously learning could absorb most of the verification work that compiles cleanly. The limit is far away, and the path to it requires the human investment in calibration that is the bottleneck in the first place. The cheap version of bot review is what most teams will ship; the cheap version produces the noise floor that trains reviewers to ignore findings; the expensive version produces the calibration that justifies the noise floor. Few teams will pay for the expensive version. I am not sure what happens when most teams ship the cheap version, except that the post-mortems will have a familiar shape.

---

In 1665, the Royal Society's Council vetted manuscripts before publication because someone had to. The Society was small, the work was small, the people doing the doubting were the same people who had something at stake in the canon. By the 1830s that arrangement could no longer hold; the volume had outgrown what the Council could absorb, and named referees formally took on the job for the first time. Software is at a structurally similar moment, on a much faster clock. Generation got cheap. Verification did not. The cost of doubt is now visible.

Acceptance and doubt are different in kind. A producer cannot doubt their own work the way a reviewer can. The institution that wants both has to pay both. The institutions that have lasted — journals, standards bodies, peer-reviewed software ecosystems — have all paid this cost, sometimes badly, sometimes well, but always. The institutions that have not paid it have produced canons that contained things they should not have. The price of acceptance is doubt, paid out of someone's time, and there is no era in which it has been free. Ours is the era when it stopped being hidden.
