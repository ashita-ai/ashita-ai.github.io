---
layout: post
title: "The Properties That Survive"
date: 2026-03-05
---

In August 1988, the United States government published [FIPS 146](https://en.wikipedia.org/wiki/Government_Open_Systems_Interconnection_Profile), mandating that all federal agencies purchase networking equipment compliant with OSI protocols. Australia, Canada, Japan, the United Kingdom, and West Germany coordinated similar requirements. The International Organization for Standardization had spent over a decade designing a comprehensive seven-layer networking model that was more rigorous, more formally specified, and more theoretically complete than anything TCP/IP offered.

TCP/IP—the protocol that DARPA researchers had built over the preceding decade, the one already running the actual internet—had none of these advantages. It was messy, underspecified, and built by people who [prioritized working code](https://web.mit.edu/saltzer/www/publications/endtoend/endtoend.pdf) over comprehensive standards.

TCP/IP [won anyway](https://en.wikipedia.org/wiki/Protocol_Wars). By 1995, GOSIP was officially described as "a flop." The mandate was withdrawn. OSI became a classroom diagram. The wrong protocol won—by every criteria except the one that mattered.

OSI was better specified. TCP/IP was better at surviving.

## The AI infrastructure bubble

[Hundreds of billions of dollars](/blog/the-incentive-problem/) are flowing into AI infrastructure right now—GPU clusters, model training pipelines, vector databases, agent frameworks. Most of it is optimized for the current paradigm: transformer architectures, embedding-based retrieval, prompt engineering patterns.

The paradigm always shifts. And most of what gets built for a specific paradigm dies with it.

This has happened before. CORBA promised language-independent distributed objects and died when REST offered something simpler. SOAP and the WS-\* stack offered comprehensive specifications for everything; REST offered six constraints and HTTP verbs. Hadoop dominated big data by 2012. Cloudera [IPO'd at $15 per share](https://techcrunch.com/2017/04/28/cloudera-finishes-up-20-in-stock-market-debut/) in 2017 and was [taken private at $16](https://techcrunch.com/2021/06/01/cloudera-to-go-private-as-kkr-cdr-grab-it-for-5-3b/) four years later. MapR [collapsed in 2019](https://siliconangle.com/2019/05/30/mapr-may-shut-investor-pulls-following-extremely-poor-results/) after raising $280 million. Spark proved that MapReduce was a paradigm-specific pattern, not a lasting property. The data processing need survived. The framework did not.

The [RAG pipelines](/blog/the-rag-trap/) companies are building today look like the Hadoop clusters of 2012: infrastructure for a specific moment, mistaken for infrastructure for the future. Vector databases are tightly coupled to the current embedding paradigm. Agent frameworks are coupled to today's LLM APIs and prompting patterns. Prompt engineering itself is a pattern, not a property—optimized for how current models process text, likely obsolete when the architecture changes.

Gartner [predicts](https://www.gartner.com/en/newsroom/press-releases/2025-06-25-gartner-predicts-over-40-percent-of-agentic-ai-projects-will-be-canceled-by-end-of-2027) over 40% of agentic AI projects will be scrapped by 2027. These are the companies building GOSIP.

The question is what to build instead.

## What survives

Five pieces of infrastructure built between 1969 and 1991 still run the internet—including every AI system deployed today. DNS (1983). SQL (1970). Unix (1969). HTTP (1989). TCP/IP (1974). Every LLM API call travels over HTTP, resolves through DNS, executes on Linux, and stores its metadata in SQL.

These survived the mainframe era, the client-server era, the web era, the cloud era, and the mobile era. They will survive the AI era. Not because they are old. Because they have four structural properties that paradigm-specific infrastructure does not.

They are not better engineered than the casualties. CORBA's type system was more rigorous than REST's. OSI's specification was more complete than TCP/IP's. Hadoop's ecosystem was more comprehensive than Spark's. What the survivors share is not engineering quality. It is structure.

## The four properties

**Ground truth.** RAG pipelines retrieve garbage when nobody verified the source documents. Models hallucinate because [the ground truth was never established](/blog/the-cost-of-being-wrong/). The embedding model is new. The problem—data that does not mean what you think it means—is the oldest problem in computing.

The survivors preserve the meaning of data without hiding it behind abstractions. SQL's ACID guarantees ensure that data means what it says—transactions complete or they do not, no partial states, no ambiguity. DNS maps names to addresses through a hierarchy where every record has an authoritative source you can trace. Codd [stated the design goal](https://dl.acm.org/doi/10.1145/362384.362685) in 1970: "Future users of large data banks must be protected from having to know how the data is organized in the machine." Protect users from implementation details, not from truth. CORBA abstracted away where things ran until nobody knew. ORMs hid the relational model behind object graphs until the [abstraction leaked](https://en.wikipedia.org/wiki/Object%E2%80%93relational_impedance_mismatch) under production load.

The AI systems that will survive the next paradigm shift are the ones where the data means what it says—regardless of which model is reading it.

**Provenance.** When a model hallucinates, which training data contributed? When an agent makes a bad decision, what was the reasoning chain? The companies deploying AI without [audit trails and lineage tracking](/blog/the-metadata-control-plane/) are building SOAP—stateful, opaque, and untraceable.

The survivors make it possible to trace how you got here. HTTP's stateless model means every request carries its own context. TCP/IP's layered architecture lets you trace a packet from application to wire. DNS's hierarchical delegation traces authority from root to leaf. The casualties buried provenance in stateful sessions, opaque middleware, and batch job chains where tracing a failure meant reconstructing invisible state across a distributed cluster.

AI infrastructure that cannot trace a decision back to its source will not survive regulation, will not survive debugging, and will not survive the next architecture.

**Contracts.** LLM APIs are the opposite of stable contracts. Model behaviors change between versions without notice. Prompts that worked last month fail after an update. [Agent systems that chain multiple calls](/blog/against-agentic-everything/) compound the instability—every link in the chain is a contract that might break silently.

The survivors define stable interfaces that implementations can change behind. SQL is a contract: you declare what you want, not how to get it. The query optimizer can improve across decades without changing your application. POSIX is a contract: applications write to the standard, not to the kernel. The S3 API became so stable that competitors implement it—Cloudflare R2, Backblaze B2, MinIO—because the [contract is more valuable](https://www.architecting.it/blog/object-storage-standardising-on-the-s3-api/) than any implementation behind it. CORBA's contracts broke between revisions. Hadoop's Java API coupled applications to a specific framework version. Without stable contracts, every upgrade is a migration.

The AI infrastructure that survives will have contracts that mean the same thing regardless of which model sits behind them.

**Reversibility.** The companies shipping AI without a path back are betting that their first deployment will be their best. It will not be. The AI deployments that [actually work](/blog/when-ai-actually-works/)—Wendy's, Netflix, Uber, Stripe—all built rollback first. Shadow deployment, automatic pullback, circuit breakers.

The survivors can evolve without destroying what came before. HTTP/3 replaced TCP with QUIC while maintaining backward compatibility through [protocol negotiation](https://developer.mozilla.org/en-US/docs/Web/HTTP/Guides/Evolution_of_HTTP). DNS added [extension mechanisms](https://en.wikipedia.org/wiki/Extension_Mechanisms_for_DNS) that older resolvers simply ignore. Flash had no fallback. When Steve Jobs published ["Thoughts on Flash"](https://en.wikipedia.org/wiki/Thoughts_on_Flash) in 2010, Flash could not degrade gracefully—you either had the plugin or you got nothing. HTML5 rendered everywhere. The survivors gave you a path back. The casualties burned the bridge.

AI infrastructure that cannot roll back, degrade gracefully, or run two versions simultaneously will not survive its first production failure—let alone a paradigm shift.

## Shearing layers

In 1994, Stewart Brand published [*How Buildings Learn*](https://en.wikipedia.org/wiki/How_Buildings_Learn), describing how buildings are not single things but layers that change at different rates. The site is eternal. The structure lasts generations. The skin changes every twenty years. The furniture moves daily.

His key insight: "An adaptive building has to allow slippage between the differently-paced systems. Otherwise the slow systems block the flow of the quick ones, and the quick ones tear up the slow ones with their constant change."

GPT-4 is furniture. It will be replaced, probably soon. RAG pipelines are furniture. Prompt engineering is furniture. The data quality infrastructure that feeds these systems, the audit trails that trace their decisions, the contracts that define what the data means, the rollback mechanisms that recover from failures—those are structure.

The forty percent of agentic AI projects that Gartner predicts will be scrapped by 2027 are mostly projects that invested in AI furniture while ignoring the structure underneath. This is the distinction from [Building for Tomorrow](/blog/building-for-tomorrow/). Patterns are furniture—implementation choices that should change as technology evolves. Properties are structure—the load-bearing decisions everything else depends on. Confusing the two is how you build infrastructure that works for three years and [constrains you for ten](/blog/the-data-platform-decisions-that-haunt-you/).

The companies that separate structure from furniture now will swap models, architectures, and paradigms without starting over. The companies that do not will be starting over every time the furniture changes.

## What I am still figuring out

Whether four properties are enough. Ground truth, provenance, contracts, reversibility feel right as a taxonomy. But they are extracted from historical analysis, not derived from first principles. Composability—Unix's philosophy of small tools connected by pipes—is hard to classify under any of the four. Simplicity might be a fifth property or it might be a prerequisite for the other four.

Whether the Lindy Effect is descriptive or prescriptive. Nassim Taleb [argues](https://en.wikipedia.org/wiki/Lindy_effect) that the longer a non-perishable thing has survived, the longer it will survive. SQL has fifty-six years. TCP/IP has over forty. The Lindy Effect tells you what to bet on. It does not tell you what to build. Something has to be new before it can be old.

Whether any AI infrastructure being built today will be running in 2060. SQL will be. TCP/IP will be. Linux will be. The question for anyone building AI infrastructure right now is not whether GPT-4 will still be around. It will not. The question is whether anything you are building will outlast the model it was designed for.

---

The OSI model was technically superior, formally specified, and backed by government mandates across seven countries. TCP/IP was messy, pragmatic, and built by researchers who shipped working code before they finished the specification.

OSI implemented a pattern: a comprehensive model designed for a particular vision of how networking should work. TCP/IP embodied properties: layered abstraction, explicit contracts at each boundary, backward compatibility across every version.

The pattern lost. The properties survived. The same bet is being placed right now, at much larger scale, across AI infrastructure. Most of it is pattern. The next four posts test what it means to build for properties instead—starting with ground truth.
