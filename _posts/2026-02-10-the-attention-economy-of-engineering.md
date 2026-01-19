---
layout: post
title: "The Attention Economy of Engineering"
date: 2026-02-10
---

The first startup I worked for built an intelligent scraper. The technology was genuinely impressive, and we engineered for Netflix-scale when we were a tiny fraction of it. We invested engineering attention in the scraper and the data infrastructure to support it, instead of the front-end product and user experience. The startup was acquired for less than a million dollars.

Years later, at Netflix, I worked on production status tracking for the studio. Hundreds of rows, maybe a dozen updates per day. It was not technically interesting. But executives used it to decide which shows to greenlight, which to cancel, and where to allocate hundreds of millions in content spend.

One of these showed up in the boardroom. The other showed up in an acqui-hire.

## Building for ourselves

[CB Insights analyzed 101 startup post-mortems](https://www.cbinsights.com/research/report/startup-failure-reasons-top/) and found that 42% failed because they built something nobody wanted. The founders of eCrowds put it bluntly: "We spent way too much time building it for ourselves and not getting feedback from prospects."

There's a name for this pattern when it happens in engineering: [resume-driven development](https://dev.to/hotfixhero/the-resume-driven-development-epidemic-building-for-your-next-job-not-the-business-4e1). Engineers choosing technologies based on what looks good on LinkedIn rather than what solves the problem. Kubernetes for five users. Microservices maintained by two developers. Machine learning where an if-statement would work.

This isn't a character flaw. It's a principal-agent problem. Engineers are rationally optimizing for their next job, not their current one.

Carnegie Mellon's Software Engineering Institute [studied failing software programs](https://resources.sei.cmu.edu/asset_files/Podcast/2012_016_100_296206.pdf) and found a recurring pattern: misaligned incentives. The researchers were surprised because "we typically view the world from a technical perspective." But the problems weren't technical. They were about people optimizing for the wrong things.

Interesting problems attract engineering attention naturally. They're conference talks, blog posts, promotions. Important problems often don't. The Netflix pipeline wasn't going to get anyone a speaking slot. It just needed to be right.

Conference talks don't compound. Decisions do.

## What actually helps

If you want engineers to allocate attention to important problems instead of interesting ones, you have to make important work rewarding.

**Align their upside with yours.** Engineers optimize for their resume when that's their only portable asset. Give them something better to optimize for.

At startups, this means equity that's real, not a lottery ticket buried in legalese. It means growth opportunities they couldn't get at a big company. It means working on problems that matter, with mentorship that accelerates their careers whether the startup succeeds or fails. When engineers believe that winning for the company means winning for themselves, they stop building for LinkedIn and start building for the mission.

At larger companies, the math is different but the principle holds. Sun Microsystems [tracked this directly](https://www.mentorcliq.com/blog/mentoring-stats): mentored employees had 72% retention vs 49% for the general population, with ROI exceeding 1000%. But the real return wasn't retention - it was what those engineers built while they stayed. [Research on job security](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.727363/full) shows that insecure employees operate in survival mode, completing daily tasks instead of investing in projects that compound. When people believe they'll be around to see the consequences of their decisions, they make different decisions.

**Connect their work to business outcomes.** The Netflix pipeline shaped how I thought about engineering because I understood what it enabled. Studio executives made better decisions. Shows got greenlit or cancelled based on data we provided. That connection wasn't accidental - it was built into how the work was framed and reviewed. When engineers see the business impact of their work, they start optimizing for impact.

**Make important work visible.** Resume-driven development thrives because interesting work gets recognized and important work doesn't. If promotions go to engineers who shipped Kubernetes, expect more Kubernetes. If promotions go to engineers whose work showed up in the boardroom, expect different choices.

You get the behavior you reward.

## Counterargument

Sometimes the technically interesting problem is the important one. Scale can be a real constraint, not an imagined one. That startup I worked for needed a good scraper - the technology was the product.

The failure mode isn't spending attention on hard problems. It's spending attention on hard problems that don't matter yet, for an audience that won't use the product. Build for the audience that pays you, not the audience that hires you next.

## What I am still figuring out

The line between resume-driven development and legitimate technical investment is blurry. Sometimes you need Kubernetes. Sometimes microservices are the right architecture. The same choice can be correct technical judgment or cargo culting depending on context. I do not have a reliable test for distinguishing them in advance. The closest I have is asking whether the engineer can explain the decision without referencing what other companies do.

## The compounding effect

The difference is not the technology. It is the decisions made in the first year that compound for the next five.

That startup's impressive infrastructure showed up in an acqui-hire. Less than a million dollars. The Netflix pipeline (hundreds of rows, technically boring) compounded into executive trust, better decisions, and shows that got made because the data was right.

42% of startups fail because they built something nobody wanted. Not because they could not build it. Because they built the wrong thing well.

Engineering attention is finite. Where you direct it determines what gets built well. What gets built well determines what decisions your company can make. And those decisions compound.
