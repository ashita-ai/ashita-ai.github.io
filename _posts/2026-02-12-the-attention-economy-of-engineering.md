---
layout: post
title: "The Attention Economy of Engineering"
date: 2026-02-12
---

The first startup I worked for built an intelligent scraper. The technology was genuinely impressive, and we engineered for Netflix-scale when we were a tiny fraction of it. We invested engineering attention in the scraper and the data infrastructure to support it, instead of the front-end product and user experience. The startup was acquired for less than a million dollars.

Years later, at Netflix, I worked on production status tracking for the studio. Hundreds of rows, maybe a dozen updates per day. It was not technically interesting. But executives used it to decide which shows to greenlight, which to cancel, and where to allocate hundreds of millions in content spend.

One of these showed up in the boardroom. The other showed up in an acqui-hire.

## Building for ourselves

[CB Insights analyzed 101 startup post-mortems](https://www.cbinsights.com/research/report/startup-failure-reasons-top/) and found that 42% failed because they built something nobody wanted. The founders of eCrowds put it bluntly: "We spent way too much time building it for ourselves and not getting feedback from prospects."

There is a name for this pattern when it happens in engineering: [resume-driven development](https://dev.to/hotfixhero/the-resume-driven-development-epidemic-building-for-your-next-job-not-the-business-4e1). Engineers choosing technologies based on what looks good on LinkedIn rather than what solves the problem. Kubernetes for five users. [Microservices maintained by two developers](/blog/technical-debt-as-strategy/). Machine learning where an if-statement would work.

This is not a character flaw. It is a principal-agent problem. Engineers are rationally optimizing for their next job, not their current one.

Carnegie Mellon's Software Engineering Institute has [studied failing software programs](https://insights.sei.cmu.edu/blog/reducing-project-failures-by-aligning-acquisition-strategy-and-software-architecture-with-stakeholder-needs-second-in-a-series/) and found a recurring pattern: misaligned incentives. The problems are rarely purely technical. They are about people optimizing for the wrong things.

Interesting problems attract engineering attention naturally. They are conference talks, blog posts, promotions. Important problems often do not. The Netflix pipeline was not going to get anyone a speaking slot. It just needed to be right.

Conference talks do not compound. Decisions do.

## AI makes this worse

When building was expensive, misallocated attention was self-limiting. You could only build so many wrong things per quarter. AI [removed that constraint](/blog/the-build-is-not-the-hard-part/). An engineer can now ship a Kubernetes deployment, a microservices migration, and a custom ML pipeline in the time it used to take to ship one. The principal-agent problem scales with velocity.

The result: teams build more of the wrong thing, faster. The [factory runs without a design department](/blog/the-factory-without-a-design-department/). The scraper gets more sophisticated. The Netflix pipeline still does not get built.

This is the attention economy of engineering in the AI era. The constraint is no longer how fast you can build. It is whether anyone is asking if you should.

## What actually helps

If you want engineers to allocate attention to important problems instead of interesting ones, you have to make important work rewarding.

**Align their upside with yours.** Engineers optimize for their resume when that is their only portable asset. Give them something better to optimize for. At startups, this means equity that is real, growth opportunities they could not get at a big company, and problems that matter. When engineers believe that winning for the company means winning for themselves, they stop building for LinkedIn and start building for the mission. [Research on job security](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2021.727363/full) confirms: insecure employees operate in survival mode, completing daily tasks instead of investing in projects that compound.

**Connect their work to business outcomes.** The Netflix pipeline shaped how I thought about engineering because I understood what it enabled. Studio executives made better decisions. Shows got greenlit or cancelled based on data we provided. That connection was not accidental. It was built into how the work was framed and reviewed.

**Make important work visible.** Resume-driven development thrives because interesting work gets recognized and important work does not. If promotions go to engineers who shipped Kubernetes, expect more Kubernetes. If promotions go to engineers whose work showed up in the boardroom, expect different choices. You get the behavior you reward.

## Counterargument

Sometimes the technically interesting problem is the important one. Scale can be a real constraint, not an imagined one. That startup I worked for needed a good scraper: the technology was the product.

The failure mode is not spending attention on hard problems. It is spending attention on hard problems that do not matter yet, for an audience that will not use the product.

## What I am still figuring out

The line between resume-driven development and legitimate technical investment is blurry. Sometimes you need Kubernetes. Sometimes microservices are the right architecture. The same choice can be correct technical judgment or cargo culting depending on context. I do not have a reliable test for distinguishing them in advance. The closest I have is asking whether the engineer can explain the decision without referencing what other companies do.

---

That startup's impressive infrastructure showed up in an acqui-hire. Less than a million dollars. The Netflix pipeline (hundreds of rows, technically boring) compounded into executive trust, better decisions, and shows that got made because the data was right.

42% of startups fail because they built something nobody wanted. Not because they could not build it. Because they built the wrong thing well.

Engineering attention is finite. Where you direct it determines what gets built well. What gets built well determines what decisions your company can make. And those decisions compound.
