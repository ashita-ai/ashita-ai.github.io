---
layout: post
title: "The Incentive Problem"
date: 2026-02-26
---

After Watson's 2011 Jeopardy victory, IBM's Watson team cautioned leadership that the system was designed to identify word patterns and predict answers to trivia questions. It was not, as David Ferrucci put it, "an all-purpose answer box ready to take on the commercial world." The warning [fell on deaf ears](https://www.advisory.com/daily-briefing/2021/07/21/ibm-watson). "It wasn't the marketing message," Ferrucci said. He left IBM in 2012.

IBM spent four billion dollars acquiring Watson Health companies. At Manipal Comprehensive Cancer Center, Watson achieved only 73% concordance on breast cancer treatment recommendations. At MD Anderson, the project was shelved after $62 million and four years. The technology showed promise in narrow applications and never matched the marketing.

This is not primarily a story about technology. It is a story about principal-agent problems: situations where the people making decisions are optimized for different outcomes than the people bearing consequences. Ferrucci bore the consequences. The executives who ignored him were playing a different game entirely.

That structure repeats at every layer of AI deployment.

## The team problem

PwC's George Korizis [put it bluntly](https://trullion.com/blog/why-95-of-ai-projects-fail-and-why-the-5-that-survive-matter/): "Eight out of ten clients that I see get stuck in pilot mode. They usually have no issue creating small, isolated wins. But most of them can't stitch those wins together to make a bigger impact."

S&P Global [found](https://www.spglobal.com/market-intelligence/en/news-insights/research/ai-experiences-rapid-adoption-but-with-mixed-outcomes-highlights-from-vote-ai-machine-learning) that 42% of companies abandoned most AI initiatives in 2025, up from 17% in 2024. On average, 46% of pilots are scrapped before they ever reach production. The incentive structure is working exactly as designed. It is just not designed for production.

Pilot teams are rewarded for novelty and speed. A fast prototype that generates executive excitement is a career win. Whether it survives the handoff to operations is someone else's problem — literally. AI-skilled workers command a [56% wage premium](https://www.pwc.com/gx/en/news-room/press-releases/2025/ai-linked-to-a-fourfold-increase-in-productivity-growth.html) over peers in similar roles, according to PwC's analysis of a billion job postings. The fastest path up is launching initiatives, not maintaining them. People launch, collect the credit, and move on before production reveals the cracks.

The handoff is where it dies. Harvard Business Review [documented five models](https://hbr.org/2018/08/how-to-hand-off-an-innovation-project-from-one-team-to-another) for transferring innovation projects to execution teams. The most common — the "Owner's Manual," where the innovation team documents their work and hands it over — is also the least effective. The execution team, measured on reliability and efficiency, has no incentive to adopt something that disrupts their metrics. [Research on misaligned incentives](https://agility-at-scale.com/implementing/scaling-ai-projects/) in AI projects confirms it directly: "If the pilot team is rewarded for fast prototype delivery, not long-term adoption, they may neglect production considerations." The innovation dies between teams, not in the lab.

The only handoff model that reliably works is what HBR calls the "Hive": multidisciplinary teams that own a challenge across its entire lifecycle, eliminating the transfer entirely. Same team builds it, same team runs it, same team gets paged when it breaks. The pilot incentive disappears when there is no handoff to hide behind.

## The budget problem

[60% of enterprise AI investment](https://menlovc.com/2024-the-state-of-generative-ai-in-the-enterprise/) comes from innovation budgets: temporary funds earmarked for new projects. Only 40% comes from permanent operational budgets. Innovation budgets are designed to launch things. They are not designed to keep things running.

The result is predictable. A project ships on innovation dollars. It then competes for maintenance budget against everything else. The team that launched has moved on. The team inheriting it has no incentive to keep it alive — doing so drains resources from their own projects.

RAND [found](https://www.rand.org/pubs/research_reports/RRA2680-1.html) that more than 80% of AI projects fail to deliver expected value, twice the failure rate of non-AI technology projects. The Big Tech capex numbers obscure this: Amazon at $100B, Microsoft at $80B, Alphabet at $91B. The money exists to build. The budget structures do not exist to sustain.

## The vendor problem

The vendors selling AI tools carry the sharpest misalignment of all, and it is structural.

Seat-based pricing, the dominant SaaS model, [creates a trap](https://www.starthawk.io/blog/post/the-death-of-the-seat-based-license-pricing-for-outcomes-in-an-automated-world): if you make your product more automated, you get paid less. A CRM with AI that does what twenty salespeople did now requires two. Charge per seat, and your revenue drops 90% even as your product becomes ten times more powerful.

Sierra's pricing analysis [makes the conflict explicit](https://sierra.ai/blog/outcome-based-pricing-for-ai-agents): "Legacy customer experience providers face a dilemma. Their revenue models depend on seat-based pricing. While these vendors may promote AI agents that autonomously resolve cases, they're trapped in a conflict: the more effective their AI becomes, the fewer contact center seats their clients need, undermining the provider's own revenue model."

This is not vendor bad faith. It is a rational response to incentives. A vendor on seat-based contracts who builds AI that genuinely works is destroying their own revenue. The rational move is to build AI that looks effective in demos and requires humans to keep it running in production. That is what the incentive structure produces.

The market is beginning to correct. Seat-based pricing [dropped from 21% to 15%](https://www.growthunhinged.com/p/2025-state-of-b2b-monetization) of companies in twelve months, with hybrid and outcome-based models picking up the difference. But most enterprise contracts have not caught up. Until they do, your vendor's incentives are not your incentives.

## What works

The companies that scale AI share one structural trait: the same team that builds owns production.

This eliminates the pilot incentive. If the team that ships the demo also gets paged when it breaks at 3am, they build differently from the start. McKinsey's [State of AI data](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai) shows high performers consistently pushing AI ownership to line managers rather than centralizing it in corporate AI labs, and tying employee incentives to business outcomes rather than launch metrics.

Budget follows the same logic. Projects that survive are the ones with operational budget commitments before the pilot ships, not after. If the funding structure requires competing for maintenance dollars after launch, the project is already in trouble.

On the vendor side: outcome-based contracts align interests. If the vendor gets paid per resolved case rather than per seat, they have a direct reason to build AI that actually resolves cases.

## What I am still figuring out

The career incentive data is weaker than expected. There is plenty of anecdotal evidence that pilot launchers advance faster than production deliverers, but no rigorous longitudinal studies tracking promotion rates by delivery type. The pattern is visible in behavior — people consistently leave before production — but the causal mechanism is inferred, not measured.

The structural problem may run deeper than incentives alone. O'Reilly and Tushman's research on [organizational ambidexterity](https://journals.aom.org/doi/10.5465/amp.2013.0025) argues that exploration and exploitation require fundamentally different organizational capabilities: flexibility versus control, autonomy versus efficiency, tolerance for failure versus zero tolerance for downtime. Aligning incentives may not be sufficient if the same team structurally cannot do both. A team optimized for production reliability may be incapable of running the kind of exploratory experiments that produce useful pilots, regardless of how you measure them.

The vendor transition is also unresolved. Outcome-based pricing works for vendors who can make the shift without collapsing existing revenue. Most incumbents cannot. Their sales motions, their customer success teams, their engineering roadmaps — all built around seat counts. Moving to outcome-based is not a contract change. It is a business model change. The vendors who get there first will be structurally different companies from the ones that dominated the last decade of SaaS.

---

David Ferrucci saw it clearly in 2012. He said the system was not what the marketing claimed. He was ignored because the people with the power to act were optimized for a different outcome: the acquisition narrative, the stock movement, the press release. Four billion dollars later, the Watson Health division was sold for parts.

The technology was not the failure. The incentive structure was.
