---
layout: post
title: "Contracts as Infrastructure"
date: 2026-03-19
---

On April 26, 1956, a converted World War II tanker named the Ideal X sailed from Newark, New Jersey to Houston, Texas carrying 58 aluminum truck bodies on a specially constructed spar deck. Loading loose cargo onto a medium-sized ship cost [$5.83 per ton](https://press.princeton.edu/books/paperback/9780691170817/the-box). Loading the Ideal X cost 15.8 cents per ton. A 97% reduction.

Malcom McLean, the North Carolina trucking magnate behind the Ideal X, understood that the value was not in the container itself. It was in the system: containers, ships, trucks, and cranes all agreeing on the same dimensions and fittings. He [released his patents royalty-free](https://en.wikipedia.org/wiki/Malcom_McLean) to the International Organization for Standardization. He chose industry-wide adoption over proprietary control.

[ISO 668](https://en.wikipedia.org/wiki/ISO_668), published in 1968, defined the contract: 20 feet by 8 feet by 8 feet 6 inches, with twist-lock corner fittings that enable stacking and intermodal transfer. Dimensional tolerance: one-quarter inch. Behind that contract, everything changed. Ships went from converted tankers to purpose-built container vessels. Cranes went from manual to automated. Ports were rebuilt. The entire global logistics infrastructure was replaced multiple times over. The contract has survived since 1968.

The contract is the thing that survives. The implementations behind it are supposed to change.

## The pattern

The infrastructure that outlasts its era shares a structural property: a stable interface that implementations can change behind.

[USB 1.0](https://en.wikipedia.org/wiki/USB) was released in 1996 by a consortium of seven companies (Compaq, DEC, IBM, Intel, Microsoft, NEC, and Nortel) to replace serial ports, parallel ports, PS/2 connectors, and game ports. The contract was the physical connector, the electrical signaling protocol, and the enumeration handshake. Behind that contract, data rates went from 1.5 Mbps to 80 Gbps: a 53,000x improvement. Power delivery went from 2.5W to 240W. The devices connected went from keyboards to external GPUs. The contract survived.

[POSIX](https://en.wikipedia.org/wiki/POSIX) (named by Richard Stallman, standardized in 1988) says: if you write to these system calls, file operations, and shell behaviors, your code runs everywhere. The implementations behind it (the Linux kernel, Darwin/macOS, FreeBSD, Solaris) share almost no code. They are entirely different operating systems. Applications written to POSIX in 1990 still run on modern systems. The contract survived.

Stripe has maintained backward compatibility with every version of its API [since 2011](https://docs.stripe.com/api/versioning). Over 60 distinct API versions, each one backward-compatible. From the [Stripe blog](https://stripe.com/blog/api-versioning): "Like a connected power grid or water supply, an API should run without interruption for as long as possible." Fifteen years later, the contract holds.

The AWS S3 API, [launched in 2006](https://en.wikipedia.org/wiki/Amazon_S3), became so stable that competitors chose to implement it rather than fight it. Cloudflare R2, Backblaze B2, MinIO, and [over 40 S3-compatible providers](https://rclone.org/s3/) all speak S3. The contract is more valuable than any individual implementation behind it.

## What breaks

The Mars Climate Orbiter offers the clearest example of a contract violation. The Software Interface Specification said: this value is in newton-seconds. Lockheed Martin's ground software [output pound-force seconds](https://en.wikipedia.org/wiki/Mars_Climate_Orbiter). NASA's trajectory software trusted the contract and did not validate the data. The error accumulated silently over 10 to 14 thruster firings across 9.5 months, shifting the trajectory by 20 m/s. The spacecraft arrived at 57 km altitude instead of 226 km and was destroyed. Cost: [$327.6 million](https://nssdc.gsfc.nasa.gov/nmc/spacecraft/display.action?id=1998-073A). One side of the interface violated the contract. Nobody checked.

Twitter broke its API contract in [February 2023](https://techcrunch.com/2023/02/01/twitter-to-end-free-access-to-its-api/), discontinuing free access with roughly 30 days notice. Thousands of bots went dark, student projects broke, researchers lost data access. Google breaks contracts so routinely that "[Killed by Google](https://killedbygoogle.com/)" tracks 299 discontinued products. TechCrunch's headline when Stadia shut down: "[Stadia died because no one trusts Google](https://techcrunch.com/2022/10/01/stadia-died-because-no-one-trusts-google/)." The contract is the thing that makes infrastructure reliable. Break the contract, lose the ecosystem.

Jon Postel formulated the [robustness principle](https://en.wikipedia.org/wiki/Robustness_principle) for the early Internet: "Be conservative in what you do, be liberal in what you accept from others." It sounds pragmatic. It means: tolerate violations of the interface specification. In 2023, [RFC 9413](https://datatracker.ietf.org/doc/html/rfc9413) formally argued that Postel's principle makes protocols less robust over time. Every bug you tolerate becomes a feature someone depends on. Every deviation you accept becomes part of the de facto contract. The explicit contract erodes, replaced by an implicit contract nobody can fully specify. Contracts work because they are enforced. Postel's Law teaches what happens when they are not.

## Where AI contracts fail

The interface between data producers and AI consumers is a contract: the schema, the value ranges, the semantic meaning of fields, the distribution of values. When any of these change without the consumer knowing, the system breaks.

Unity's ad-targeting algorithm ingested corrupted data from a single client in 2022 and lost an estimated [$110 million in revenue](https://www.datachecks.io/post/unity-technologies-110m-ad-targeting-error). The data contract (expected schema, expected value ranges, expected semantic meaning) was not enforced at the boundary. Apple made App Tracking Transparency mandatory in iOS 14.5, unilaterally changing the de facto data contract between its platform and the advertising ecosystem. Meta reported a [$10 billion revenue impact](https://appleinsider.com/articles/22/02/03/facebook-rebuilding-ad-platform-due-to-app-tracking-transparency-data-laws) for 2022. In each case, the failure was at the contract boundary. Not in the algorithm. Not in the infrastructure. At the interface.

LLM APIs are the [opposite of stable contracts](/blog/against-agentic-everything/). Model behaviors change between versions without notice. Prompts that worked last month fail after an update. Agent systems that chain multiple calls compound the instability: every link in the chain is a contract that might break silently. This is why [data contracts](/blog/the-metadata-control-plane/) are not bureaucracy. They are the thing that separates infrastructure that survives from infrastructure that [constrains you for a decade](/blog/the-data-platform-decisions-that-haunt-you/).

## What survives

The AI infrastructure that survives will define stable interfaces that implementations can change behind. The model behind the contract will be replaced. The embedding architecture will be replaced. The agent framework will be replaced. The contract, if it is well-designed, will not.

This is what Tessera is [building toward](/blog/introducing-tessera/): explicit agreements about data interfaces where consumers register dependencies, producers see who depends on them, and breaking changes require acknowledgment before they proceed. It is what schema registries promised but never delivered, because they validated structure without coordinating change.

The shipping container did not standardize ships. It standardized the interface between ships, trucks, and cranes. The contract freed everything behind it to evolve independently. AI infrastructure needs the same: stable boundaries that let the components behind them change without breaking everything downstream.

## What I am still figuring out

Whether contracts and innovation are in tension. Stable contracts enable independent evolution behind the interface, but they also constrain what the interface can express. The S3 API is stable, but it cannot express operations that were not imagined in 2006. At some point, the contract itself becomes the bottleneck. Knowing when to evolve a contract versus when to honor it is a judgment call that no framework resolves.

Whether AI systems can even have stable contracts. A traditional API contract specifies inputs and outputs deterministically. An LLM contract is probabilistic: the same input may produce different outputs. Contracts for probabilistic systems may require fundamentally different primitives than contracts for deterministic ones.

---

On April 26, 1956, the Ideal X proved that standardizing the interface was worth more than optimizing the implementation. Behind ISO 668's dimensions, the entire global logistics industry rebuilt itself multiple times. The contract, unchanged since 1968, outlasted every ship, every crane, and every port it was designed for.

[Ground truth](/blog/ground-truth-as-foundation/) establishes the foundation. [Provenance](/blog/the-provenance-imperative/) traces the chain. Contracts enforce the boundaries. The last property, reversibility, determines whether you survive your first production failure. That is next.
