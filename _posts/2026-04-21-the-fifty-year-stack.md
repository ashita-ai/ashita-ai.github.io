---
layout: post
title: "The Fifty-Year Stack"
date: 2026-04-21
---

On June 11, 2009, a developer named Johan Oskarsson organized a meetup in San Francisco to discuss open-source, distributed, non-relational databases. He needed a Twitter hashtag. Eric Evans at Rackspace [suggested](https://martinfowler.com/bliki/NosqlDefinition.html) "#NoSQL." The term, Evans later said, did not have a deep meaning. It was supposed to be used for one meeting.

Within three years, NoSQL was a movement. MongoDB raised [$150 million](https://techcrunch.com/2013/10/04/mongodb-raises-150m-for-nosql-database-technology-with-salesforce-joining-as-investor/) at a $1.2 billion valuation. Conferences proliferated. The relational model, declared dead by a [panel at ER 2012](https://sigmodrecord.org/publications/sigmodRecord/1306/pdfs/11.reports.atzeni.pdf), was a relic of the 1970s: too rigid, too slow, too limited for the data that defined the new era. MongoDB [IPO'd](https://techcrunch.com/2017/10/18/mongodb-prices-its-ipo-at-24-per-share/) at $24 per share in October 2017 and peaked at $585 in [November 2021](https://www.macrotrends.net/stocks/charts/MDB/mongodb/stock-price-history), a $39 billion market cap.

Fifteen years after the meetup, [55.6% of developers](https://survey.stackoverflow.co/2025/technology) use PostgreSQL. It is the most popular, most admired, and most desired database for the third consecutive year. The StackOverflow survey's migration chart tells the story: all roads lead to PostgreSQL. In 2025, Databricks paid [$1 billion](https://www.cnbc.com/2025/05/14/databricks-is-buying-database-startup-neon-for-about-1-billion.html) for Neon, a serverless PostgreSQL company. Snowflake paid [$250 million](https://www.saastr.com/snowflake-buys-crunchy-data-for-250m-databricks-buys-neon-for-1b-the-new-ai-database-battle/) for Crunchy Data. Both are betting their AI strategies on a database whose design dates to [1986](https://www.postgresql.org/docs/current/history.html).

The relational model is fifty-six years old. It did not survive NoSQL by ignoring it. It survived by eating it.

## The absorption pattern

The [four previous posts](/blog/the-properties-that-survive/) in this series examined ground truth, provenance, contracts, and reversibility as the structural properties that outlast paradigm shifts. This post asks a different question: not what properties survive, but how survival actually works.

The answer is not endurance. It is absorption.

Fifty-year systems do not win by resisting change. They win by incorporating what is useful from each challenger and discarding what is noise. The challenger's best ideas become features in the survivor. The challenger itself becomes unnecessary.

This pattern repeats across three stacks that underpin everything running today, including every AI system deployed in production.

## SQL absorbed NoSQL

The relational model has faced extinction-level challengers roughly once per decade. Hierarchical databases in the 1970s. Network databases in the 1980s. Object-oriented databases in the 1990s. NoSQL in the 2010s. Each time, the challenger identified a real limitation. Each time, the relational model absorbed the useful innovation and continued.

The NoSQL case is the most instructive because it happened recently enough to verify.

The legitimate criticism was real. Relational databases in 2009 were difficult to scale horizontally. Schema rigidity made rapid iteration painful. Document-shaped data did not map naturally to normalized tables. These were genuine problems, and NoSQL databases solved them.

But PostgreSQL did not stand still. In December 2006, before the NoSQL meetup even happened, PostgreSQL shipped [hstore](https://www.postgresql.org/docs/current/hstore.html): a key-value store inside a relational database. In 2012, PostgreSQL 9.2 added a native [JSON data type](https://www.postgresql.org/docs/9.2/release-9-2.html). In December 2014, PostgreSQL 9.4 shipped [JSONB](https://www.postgresql.org/docs/release/9.4.0/): binary JSON with GIN indexing, decomposed storage, and fast lookups. This was the critical release. PostgreSQL became a credible document store without ceasing to be a relational database.

The absorption continued. [UPSERT](https://www.postgresql.org/about/news/postgresql-95-released-1636/) in 2016 (ON CONFLICT clause). [SQL/JSON path language](https://www.postgresql.org/docs/12/release-12.html) in 2019. [SQL/JSON constructors](https://www.postgresql.org/docs/release/16.0/) in 2023. [SQL/JSON query functions and JSON_TABLE](https://www.postgresql.org/about/news/postgresql-17-released-2936/) in 2024, converting JSON into relational rows. Each release absorbed another reason people had reached for a document database.

Meanwhile, Google itself reversed course. In 2012 and 2013, Google published [Spanner](https://en.wikipedia.org/wiki/Spanner_(database)) and [F1](https://www.theregister.com/2013/08/30/google_f1_deepdive/), explicitly built because its engineers found frustration with NoSQL's lack of SQL. Engineer Stephan Ellner: "Very clean semantics we find is something you cannot live without." When asked whether you could have a truly scalable database without going NoSQL, Ellner answered: "[Our answer is yes](https://cloud.google.com/blog/products/gcp/from-nosql-to-new-sql-how-spanner-became-a-global-mission-critical-database)."

Carnegie Mellon's Andy Pavlo [wrote in his 2025 retrospective](https://www.cs.cmu.edu/~pavlo/blog/2026/01/2025-databases-retrospective.html): "Most of the database energy and activity is going into PostgreSQL companies, offerings, projects, and derivative systems." The extension ecosystem (TimescaleDB for time-series, pgvector for embeddings, PostGIS for geospatial, ParadeDB for full-text search) means that instead of picking a niche database and bolting PostgreSQL on the side, teams pick PostgreSQL and add one extension.

The relational model did not outlast NoSQL by being stubborn. It outlasted NoSQL by being absorbent.

## Linux absorbed containers

In 2013, Solomon Hykes released Docker, and within two years containers were the most discussed technology in infrastructure. Docker's narrative positioned containers as a new paradigm: a lightweight alternative to virtual machines, a way to package applications with their dependencies, a portable unit of deployment.

The narrative obscured a fact that Docker's own [documentation](https://docs.docker.com/engine/security/) made clear: containers are Linux kernel features.

In 2006, engineers at Google (Paul Menage and Rohit Seth) submitted a kernel patch called ["process containers"](https://lwn.net/Articles/236038/), later renamed control groups ([cgroups](https://en.wikipedia.org/wiki/Cgroups)). Cgroups were merged into the Linux kernel in version 2.6.24 (January 2008). They allow hierarchical grouping of processes with resource limits: CPU, memory, disk I/O, network.

Linux [namespaces](https://en.wikipedia.org/wiki/Linux_namespaces) started even earlier. Al Viro added the mount namespace to kernel 2.4.19 on August 3, 2002. Additional namespace types followed: UTS and IPC (2006), PID (2008), network (2009), user (2013, kernel 3.8). Full "container ready" isolation was complete by 2013.

Docker wrapped these kernel primitives with a developer-friendly interface. When you run `docker run`, Docker creates a set of namespaces and cgroups for the container. There is no hypervisor. Containers share the host's Linux kernel. This is why Docker on macOS and Windows runs a Linux VM underneath: containers are Linux kernel primitives that require a Linux kernel to exist.

Linux did not compete with containers. Linux absorbed the concept of containerization into its kernel over a decade of incremental additions, and Docker made those kernel features accessible. The "new paradigm" was eleven years of Linux kernel development plus a good user interface.

The pattern is older than containers. Linux absorbed virtualization by merging [KVM](https://en.wikipedia.org/wiki/Kernel-based_Virtual_Machine) (Kernel-based Virtual Machine) into the kernel in 2007, turning Linux into a hypervisor. It absorbed packet filtering and observability through [eBPF](https://en.wikipedia.org/wiki/EBPF). Each time, a capability that could have been a competing platform became a kernel feature instead.

The result: [100% of the Top500 supercomputers](https://www.top500.org/statistics/details/osfam/1/) run Linux (since November 2017). Approximately [70-76%](https://gs.statcounter.com/os-market-share/mobile/worldwide) of smartphones run Android (Linux kernel). Linux [surpassed Windows](https://linux.slashdot.org/story/19/07/01/1333252/linux-usage-on-azure-has-surpassed-windows-microsoft-developer-reveals) on Microsoft's own Azure cloud in 2019. Steve Ballmer [called Linux "a cancer"](https://www.theregister.com/2001/06/02/ballmer_linux_is_a_cancer/) in 2001. Fourteen years later, Satya Nadella declared "Microsoft loves Linux." Four years after that, Linux was running more than half of Microsoft's cloud.

## TCP/IP absorbed ATM

In the early 1990s, Asynchronous Transfer Mode ([ATM](https://en.wikipedia.org/wiki/Asynchronous_Transfer_Mode)) was supposed to replace TCP/IP for high-speed networking. ATM used fixed-size 53-byte cells (5-byte header, 48-byte payload) and offered quality-of-service guarantees that TCP/IP could not match. It promised a single converged network for voice, video, and data.

The [ATM Forum](https://en.wikipedia.org/wiki/ATM_Forum), founded in 1991, had over 325 member organizations. Telephone companies, equipment vendors, and computer companies backed it heavily. Fore Systems, an ATM-focused company, was [acquired for approximately $4.5 billion](https://en.wikipedia.org/wiki/FORE_Systems) in 1999. The industry produced over 200 interoperability specifications.

TCP/IP did not fight ATM. It absorbed it.

In January 1994, the IETF published [RFC 1577](https://www.rfc-editor.org/rfc/rfc1577.html): "Classical IP and ARP over ATM." The specification defined how to run IP datagrams over ATM networks. ATM became a link layer for IP, not a replacement for it. The very thing ATM was supposed to displace was now running on top of it.

Meanwhile, [Fast Ethernet](https://en.wikipedia.org/wiki/Fast_Ethernet) (100 Mbps, ratified 1995) and [Gigabit Ethernet](https://en.wikipedia.org/wiki/Gigabit_Ethernet) (1000 Mbps, ratified 1998) delivered comparable speeds at a fraction of the cost, with backward compatibility to existing infrastructure. Network administrators already knew Ethernet. ATM required new skills and expensive equipment. By the end of the decade, the ATM Forum was merging with other organizations. By 2009, its successor had been [absorbed into the Broadband Forum](https://en.wikipedia.org/wiki/Broadband_Forum). ATM's fourteen-year run as a TCP/IP challenger was over.

The absorption mechanism is structural. David Clark explained it in his [1988 paper](https://web.mit.edu/6.033/www/papers/darpa.pdf) on the design philosophy of the DARPA internet protocols: the fundamental goal was survivability, achieved by keeping intermediate nodes (routers) stateless. The [end-to-end principle](https://web.mit.edu/saltzer/www/publications/endtoend/endtoend.pdf) (Saltzer, Reed, and Clark, 1984) pushed complexity to the edges. IP sits at the [narrow waist](https://conferences.sigcomm.org/sigcomm/2011/papers/sigcomm/p206.pdf) of an hourglass: everything above depends on it, everything below carries it.

This architecture makes IP nearly impossible to replace and trivially easy to run over new link technologies. Any new network technology (ATM, Wi-Fi, cellular, satellite) becomes a way to carry IP. Any new application protocol becomes something that runs over IP. The narrow waist absorbs challengers in both directions.

Even when TCP itself is being superseded, the pattern holds. HTTP/3 ([RFC 9114](https://datatracker.ietf.org/doc/html/rfc9114), 2022) runs over QUIC, which reimplements TCP's reliability guarantees in user space on top of UDP. QUIC effectively bypasses TCP. But it still runs over IP. The narrow waist survives even the replacement of its own transport layer.

## What absorption requires

Absorption is not automatic. CORBA could not absorb REST's simplicity. Hadoop could not absorb the cloud. Flash could not absorb mobile. The systems that can absorb share structural properties that the casualties lack.

**Extensible contracts.** PostgreSQL could absorb JSON because SQL is a declarative contract: you state what you want, not how to get it. Adding JSONB did not break existing queries. IP could absorb ATM because IP is a contract about packet delivery, not about the medium. Adding a new link layer does not change the contract above it. CORBA's contracts [broke between revisions](/blog/the-properties-that-survive/). Extending them meant breaking everything built on them.

**Preserved ground truth.** PostgreSQL absorbed document storage without hiding the relational model. JSONB data is queryable with SQL. You can join JSON documents with relational tables. The ground truth (data means what it says) was never compromised. ORMs, by contrast, hid the relational model behind object graphs until the [abstraction leaked](https://en.wikipedia.org/wiki/Object%E2%80%93relational_impedance_mismatch) under production load. Hiding ground truth prevents absorption because you cannot integrate what you cannot see.

**Modular architecture.** Linux's kernel absorbed containers because the kernel is modular: namespaces and cgroups are independent subsystems that compose with existing process management. Docker could build on them without changing the kernel's core abstractions. Hadoop's architecture was monolithic: HDFS, MapReduce, and YARN were tightly coupled. Absorbing cloud object storage (S3) would have required rearchitecting the foundation.

**Reversibility.** PostgreSQL added JSONB as an option, not a mandate. Teams that do not need document storage ignore it. Teams that tried it and found it insufficient can migrate back to normalized tables. The absorption was reversible. Flash's plugin model was all-or-nothing. You either had Flash or you got nothing. When the paradigm shifted to mobile, there was no graceful path.

The four properties from the previous posts (ground truth, provenance, contracts, reversibility) are not just survival traits. They are the preconditions for absorption. Systems that have them can incorporate innovations from challengers. Systems that lack them can only resist or collapse.

## What I am still figuring out

Whether absorption is always better than replacement. TCP/IP absorbed ATM, but the IPv4-to-IPv6 transition has taken [almost thirty years](https://en.wikipedia.org/wiki/IPv6) and is still incomplete. NAT and CIDR extended IPv4's life far beyond what anyone expected, but they also created layers of complexity that the clean replacement (IPv6) was designed to eliminate. Sometimes the fifty-year system's ability to absorb workarounds delays a necessary replacement.

Whether today's AI infrastructure has anything with fifty-year potential. PostgreSQL will still be running in 2060. TCP/IP will be. Linux will be. The question for AI infrastructure is whether anything being built right now has the structural properties to absorb the paradigm shift that comes after transformers. Pgvector is interesting precisely because it embeds vector search inside a fifty-year system rather than building a standalone alternative. Over 80% of databases provisioned on Neon are now [created by AI agents](https://www.databricks.com/company/newsroom/press-releases/databricks-agrees-acquire-neon-help-developers-deliver-ai-systems), not humans. The agents are choosing the fifty-year stack.

Whether the Unix philosophy (small tools, pipes, text streams) applies to AI systems. The current trajectory is toward monolithic models that do everything. The Unix trajectory was toward composable tools that do one thing well. These are opposite philosophies. If the Unix philosophy is correct, the monolithic model era is a detour, and the infrastructure that survives will be the plumbing that connects specialized components. If the monolithic approach is correct, the Unix philosophy has met its first real exception in fifty-seven years.

---

On June 11, 2009, a hashtag was supposed to be used for one meeting. The databases discussed at that meeting are still running. Some of them are growing. But they are growing inside PostgreSQL's absorption radius, not outside it.

The relational model, the Unix kernel, and the IP protocol were not designed to be permanent. They were designed to be extensible, composable, and modular. Those properties turned out to be the same thing as permanent. The infrastructure that can absorb the next paradigm does not need to predict it. It just needs the structural properties that make absorption possible.

Four hundred and fifty billion dollars is flowing into AI infrastructure this year. Most of it is buying GPUs, training clusters, and model-specific tooling: infrastructure optimized for the current paradigm. The fifty-year stack is sitting underneath all of it, absorbing what is useful, waiting for the rest to pass.
