---
layout: post
title: "The Data Platform Decisions That Haunt You in Year 3"
date: 2026-01-14
---

In 2022, Unity Technologies ingested bad data from a client into their ad-targeting ML model. They did not notice until revenue started dropping. By the time they found it, the damage was [$110 million](https://www.montecarlodata.com/blog-bad-data-quality-examples/), a nearly 40% stock crash, a class action lawsuit, and 4% of the workforce laid off.

The pipeline ran fine. The schema validated. The data was poison.

## The decisions that haunt you

The decisions that haunt you are rarely the ones you agonized over. Snowflake vs Databricks. Airflow vs Dagster. These feel important in year one. By year three, they are footnotes.

What haunts you are the implicit choices. The things you assumed would be fine. Chief among them: deciding that data quality is a problem for later.

## The pattern

Someone builds a pipeline. It works. They ship it. They move on.

Six months later, the pipeline still runs. Dashboards update. But the numbers do not match finance. Marketing does not trust the attribution. The ML model is drifting.

The pipeline was designed to be shipped, not maintained. [The metrics look fine](/blog/healthy-metrics-broken-agent/). No one is watching the data itself.

## The cost

Gartner estimates poor data quality costs [$12.9 million per year](https://www.gartner.com/smarterwithgartner/how-to-stop-data-quality-undermining-your-business) on average. That number has been stable for years. Companies are not getting better at this.

But the direct cost is not the problem. The problem is trust.

When stakeholders stop trusting the data, they stop using it. [KPMG found](https://www.marketing-interactive.com/ceos-still-trust-intuition-over-data-driven-insights-says-kpmg-study) 67% of CEOs have ignored data-driven insights in favor of their own intuition. They have been burned before.

You cannot measure the cost of decisions made on bad data or decisions not made because no one trusted the data enough to act.

## What compounds badly

**No data contracts.** Schema changes upstream break pipelines downstream. You discover this when a dashboard goes blank or when numbers silently change.

**No lineage.** When something breaks, you cannot trace the impact. Debugging becomes archaeology.

**No tests on the data itself.** Row counts. Null rates. Freshness. Without these, the pipeline succeeds while the data fails.

**No ownership.** The person who built it left. Maintenance becomes hot potato.

By year three, you have a system that technically works but that no one understands, trusts, or wants to touch.

## What matters less than you think

**Which warehouse you picked.** They all work. Migrations are painful but possible.

**Which orchestrator you chose.** Neither Airflow nor Dagster will save you from bad data quality practices.

**Whether you normalized your data model.** You will refactor this anyway.

These decisions feel important because they are visible. Architecture diagrams. Vendor conversations. The decisions that actually matter are invisible: how you handle quality, who owns what, whether you invest in maintenance.

## The meta-decision

The real question is whether you [treat data as a product](https://netflixtechblog.medium.com/data-as-a-product-applying-a-product-mindset-to-data-at-netflix-4a4d1287a31d) or a project.

Projects end. You ship, declare victory, move on. Products are maintained. You ship, then iterate. Monitor. Fix bugs. The success metric is ongoing value, not delivery.

Most data platforms are built like projects and expected to perform like products.

## Where to start

You cannot govern everything. You should not try.

The [Critical Data Elements](https://www.alation.com/blog/critical-data-elements-best-practices-data-governance/) framework says: identify the 50-100 data elements that would materially harm the business if wrong. Revenue numbers. Compliance fields. The inputs to your ML models. Start there.

Ask three questions: Would inaccuracy affect compliance? Does this drive a key dashboard? Would customers notice if it broke? If yes to any, it is critical. Everything else can wait.

For brownfield platforms, the [strangler fig pattern](https://martinfowler.com/bliki/StranglerFigApplication.html) applies. Do not try to retrofit quality everywhere at once. Pick one critical pipeline. Add contracts. Add tests. Validate in parallel with the old system. Once you trust it, move to the next. This is slower than a big bang rewrite and more likely to actually work.

The trap is perfectionism. "We will add data quality once we have time" means never. "We will add it to this one pipeline this sprint" means progress.

## What I am still figuring out

Whether the Critical Data Elements approach scales during fast growth. Identifying 50-100 critical elements works for a company with known data flows. Companies adding data sources faster than they can assess criticality face a moving target. The strangler fig pattern assumes you can identify which pipeline to fix next. When everything is partially broken, prioritization becomes the bottleneck, not execution.

---

No one gets haunted by their warehouse choice. They get haunted by the pipeline no one owned.
