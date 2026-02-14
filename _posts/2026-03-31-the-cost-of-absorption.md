---
layout: post
title: "The Cost of Absorption"
date: 2026-03-31
---

In December 2010, Airbus launched the A320neo with new fuel-efficient engines. Boeing faced a choice: design a new narrow-body aircraft from scratch or fit larger engines onto the 737, an airframe that first flew on [April 9, 1967](https://www.historylink.org/file/3569). A clean-sheet design would cost upward of $10 billion and take a decade. [Re-engining](https://en.wikipedia.org/wiki/Boeing_737_MAX) the 737 would cost $2-3 billion and take four years.

Boeing chose absorption. The larger LEAP-1B engines did not fit under the 737's low-slung wings in their natural position. Engineers [mounted them farther forward and higher](https://en.wikipedia.org/wiki/Maneuvering_Characteristics_Augmentation_System), changing the aircraft's aerodynamics and creating a pitch-up tendency at high angles of attack. Rather than redesign the airframe, Boeing wrote software: the Maneuvering Characteristics Augmentation System, which automatically pushed the nose down when sensors detected a high angle of attack. MCAS relied on a [single angle-of-attack sensor](https://www.seattletimes.com/business/boeing-aerospace/failed-certification-faa-missed-safety-issues-in-the-737-max-system-implicated-in-the-lion-air-crash/), though the aircraft had two.

On October 29, 2018, a faulty sensor on [Lion Air Flight 610](https://en.wikipedia.org/wiki/Lion_Air_Flight_610) fed MCAS incorrect data. The system pushed the nose down. The pilots fought it. MCAS pushed again. One hundred eighty-nine people died in the Java Sea. Five months later, the same failure sequence killed [157 people](https://en.wikipedia.org/wiki/Ethiopian_Airlines_Flight_302) on Ethiopian Airlines Flight 302. Three hundred and forty-six dead.

Boeing estimated it would save billions by absorbing new engines into an old airframe instead of starting fresh. The grounding cost the company over [$20 billion](https://en.wikipedia.org/wiki/Financial_impact_of_the_Boeing_737_MAX_groundings) in direct losses, with indirect costs exceeding $60 billion. The [criminal settlement](https://www.belfercenter.org/publication/boeing-737-max-crashes) was $2.5 billion. For fifty-four years, each generation of 737 modifications had validated the next. The Classic absorbed high-bypass turbofan engines. The NG absorbed redesigned wings and a glass cockpit. Each round of absorption worked, until the airframe's margin ran out and the software hiding the problem killed people.

The [previous post](/blog/the-fifty-year-stack/) argued that the infrastructure which survives paradigm shifts does so by absorbing useful innovation from challengers. PostgreSQL absorbed document storage. Linux absorbed containerization. TCP/IP absorbed ATM. But absorption has a shadow. When the system being extended has drifted too far from its original design envelope, absorption stops being survival and becomes accumulation.

## The fifty-year workaround

In May 1994, [RFC 1631](https://www.rfc-editor.org/rfc/rfc1631.html) introduced Network Address Translation. The authors' conclusion was explicit: "NAT has several negative characteristics that make it inappropriate as a long term solution, and may make it inappropriate even as a short term solution."

That was thirty-two years ago.

The problem NAT solved was real. IPv4 addresses are 32-bit, providing approximately 4.3 billion unique addresses. By the early 1990s, the address space was being consumed faster than anyone planned for. [CIDR](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) (1993) slowed the bleeding by allowing more flexible allocation. NAT stopped it by allowing multiple devices to share a single public address.

But NAT broke the internet's foundational design. The [end-to-end principle](https://web.mit.edu/saltzer/www/publications/endtoend/endtoend.pdf) (Saltzer, Reed, and Clark, 1984) established that the network should be simple and complexity should live at the edges. Any device could reach any other device directly. NAT destroyed this. Devices behind NAT cannot be reached from the outside without assistance. Vint Cerf has called NAT "sort of an abomination" because it "really does mess about with the basic protocol architecture of the Internet."

The workarounds compounded. [STUN](https://datatracker.ietf.org/doc/html/rfc5389) (2008) to discover NAT-translated addresses. [TURN](https://datatracker.ietf.org/doc/html/rfc5766) (2010) to relay traffic when direct connection fails. [ICE](https://datatracker.ietf.org/doc/html/rfc8445) (2018) to negotiate the best available path. Carrier-grade NAT to apply address translation at the ISP level. Each layer addressed a problem that NAT created, spawning complexity that the clean replacement was designed to eliminate.

IPv6 was specified in [December 1998](https://datatracker.ietf.org/doc/html/rfc2460). It provides 340 undecillion addresses and restores end-to-end connectivity. Twenty-eight years later, global adoption is approximately [45-49%](https://www.google.com/intl/en/ipv6/statistics.html). Geoff Huston at APNIC [projects](https://blog.apnic.net/2024/10/22/the-ipv6-transition/) universal adoption around 2045. If that holds, the full transition will have taken roughly fifty years from specification to completion.

The cost of the workaround compounds annually. IANA [exhausted](https://en.wikipedia.org/wiki/IPv4_address_exhaustion) its last IPv4 address blocks in January 2011. IPv4 addresses peaked at approximately [$60 per address](https://www.ipxo.com/blog/ipv4-price-history/) in late 2021 on the trading market. AWS, which holds approximately [132 million](https://www.tomshardware.com/networking/amazons-aws-new-charge-for-using-ipv4-is-expected-to-rake-in-up-to-dollar1b-per-year-change-should-speed-ipv6-adoption) IPv4 addresses, began [charging $0.005 per hour per address](https://aws.amazon.com/blogs/aws/new-aws-public-ipv4-address-charge-public-ip-insights/) in February 2024: an estimated [$400 million to $1 billion](https://www.tomshardware.com/networking/amazons-aws-new-charge-for-using-ipv4-is-expected-to-rake-in-up-to-dollar1b-per-year-change-should-speed-ipv6-adoption) in annual revenue from a resource that was supposed to have been replaced two decades ago.

NAT's authors told us it was a short-term fix. The internet is still running on it thirty-two years later, patched with layers of workarounds that each generation of engineers inherits, extends, and passes on. The clean replacement exists. The migration is half done. The workaround persists because in any individual year, the cost of maintaining it is lower than the cost of completing the replacement. The costs compound invisibly until they are structural.

## The system nobody can replace

In April 2020, New Jersey Governor Phil Murphy held a [press conference](https://www.cnbc.com/2020/04/06/new-jersey-seeks-cobol-programmers-to-fix-unemployment-system.html) about the state's overwhelmed unemployment system. "We have systems that are 40 years-plus old," he said. Then: "How did we get here where we literally needed COBOL programmers?"

New Jersey was not alone. Connecticut received over 220,000 unemployment claims since mid-March on a COBOL mainframe. By mid-April, 180,000 applications were still pending. A Brookings Institution [study](https://www.brookings.edu/articles/coboling-together-ui-benefits/) found that states running COBOL-based unemployment systems saw $105 billion less GDP during 2020 than states with modern systems. Claims delayed over 70 days rose 2.1 percentage points more in COBOL states. Consumption declined 2.8 percentage points more. The systems were running. They were running at a speed calibrated for 1980s claim volumes, not for [22 million initial claims](https://www.cnbc.com/2020/04/16/us-weekly-jobless-claims.html) filed in four weeks.

COBOL was designed in 1959 by a committee that included Grace Hopper. It is sixty-seven years old. A 2022 Micro Focus survey found 775-850 billion lines of COBOL in daily production use. The IRS [Individual Master File](https://www.gao.gov/products/gao-25-107795), which processes every federal income tax return, dates to 1962. The modernization program to replace it started in 1999. The government has spent approximately [$5.9 billion](https://www.congress.gov/crs_external_products/IF/HTML/IF12525.web.html). The GAO warned in 2024 of continued risk of "cost overruns, schedule delays, and overall project failure." The original system is still running.

Replacing COBOL is not just expensive. It is dangerous. In April 2018, TSB Bank migrated 5.4 million customer records from a legacy platform. The migration [failed](https://www.computerweekly.com/news/252528519/TSB-hit-with-huge-fine-after-IT-migration-disaster): £330 million in total costs, [£48.65 million](https://www.bankofengland.co.uk/news/2022/december/tsb-fined-for-operational-resilience-failings) in regulatory fines, 80,000 lost customers. The CEO resigned. Three years of planning and 85 subcontractors were not enough.

The average COBOL programmer is 55-58 years old. About 10% retire annually. The GAO's [2025 report](https://www.gao.gov/products/gao-25-107795) flagged the dwindling number of people with the skills to maintain these systems as a risk. COBOL survives because it is too critical to fail and too entangled to replace. This is not absorption in the sense that PostgreSQL absorbed document storage. PostgreSQL absorbed a useful capability and became stronger. COBOL's survival is not growth. It is dependency.

## When absorption becomes accumulation

The [previous posts](/blog/the-properties-that-survive/) in this series argued that four properties enable absorption: ground truth, provenance, contracts, and reversibility. The same properties diagnose when absorption has become pathological.

The 737 MAX violated [ground truth](/blog/ground-truth-as-foundation/). The aircraft's aerodynamics had fundamentally changed. MCAS was designed to make pilots believe they were flying a standard 737. The ground truth, that this was a different aircraft requiring different handling, was hidden behind software. When the software failed, pilots did not have the information they needed to recover.

IPv4/NAT violated [contracts](/blog/contracts-as-infrastructure/). The internet's foundational contract was end-to-end connectivity: any device can reach any other device directly. NAT broke this contract and replaced it with layers of workarounds that approximate the original capability at greater cost and complexity. The contract erosion was gradual. Each individual workaround seemed reasonable. The cumulative effect is an internet that runs on an architecture its designers called inappropriate.

COBOL systems violate [reversibility](/blog/reversibility-as-default/). They cannot be incrementally replaced. Migration requires moving everything simultaneously, which means any failure is catastrophic. They cannot be rolled back to a previous state. They cannot be partially modernized. Every year of continued operation makes the eventual replacement harder, not easier. The irreversibility compounds.

When absorption preserves these properties, the system grows stronger. When absorption violates them, the system grows more fragile. The difference between PostgreSQL absorbing JSONB and Boeing absorbing MCAS is not a difference of ambition or engineering talent. It is a difference of structural integrity. PostgreSQL added document storage as an option alongside relational tables: ground truth preserved, contract unbroken, fully reversible. Boeing hid changed aerodynamics behind software: ground truth obscured, pilot contract violated, failure irreversible at the moment it mattered.

## What I am still figuring out

Whether there is a reliable signal that distinguishes "absorb this" from "replace this" before the costs compound. The 737 MAX problems seem obvious in hindsight. In 2011, re-engining was the industry-standard approach. Airbus did the same with the A320neo, and it worked, because the A320's higher wing mounting gave its engines more clearance. Boeing's absorption failed not because the strategy was wrong in general, but because the specific airframe had less margin. Margin is hard to measure from the outside, and the consequences of misjudging it are not evenly distributed.

Whether AI systems are already accumulating rather than absorbing. Fine-tuning patches a foundation model for a specific task. Prompt engineering patches the gap between what a model can do and what you need it to do. [RAG](/blog/the-rag-trap/) patches the model's lack of current or proprietary knowledge. Each technique works around a limitation without addressing it structurally. If the next paradigm renders transformers obsolete, these workarounds become the COBOL of AI: critical systems running on architecture nobody fully understands and nobody can affordably replace. The question is whether anyone is building the IPv6 of AI infrastructure, the clean design for the next era, or whether the industry is collectively building NAT.

---

In 2011, Boeing's engineers could have designed a new aircraft. The limitations of the 1967 airframe were understood. The cost of a clean-sheet design was higher than one more round of modifications. For fifty-four years, each generation of 737 had validated the next.

The [four properties](/blog/the-properties-that-survive/) do not just predict which systems survive paradigm shifts. They diagnose when survival has become fragility. Ground truth preserved or obscured. Contracts honored or eroded. Reversibility maintained or foreclosed. When absorption starts violating the properties that made it possible, you are no longer growing stronger. You are accumulating debt that compounds until something breaks.

The cost of absorption is never zero. The question is whether you are paying for capability or for debt. The four properties tell you which.
