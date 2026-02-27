---
layout: post
title: "The Provenance Imperative"
date: 2026-03-31
---

In 2008, forensic analysts found titanium white in a painting attributed to Heinrich Campendonk and dated 1914. Titanium white was not used in paint until the 1920s. A single anachronistic pigment trace collapsed an entire provenance fiction.

Wolfgang Beltracchi had not copied existing paintings. He created new works in the styles of Max Ernst, Fernand Léger, Heinrich Campendonk, and others, filling gaps in artists' known catalogs with plausible undiscovered works. He and his wife fabricated ownership histories dating to the 1920s, photographed the fakes with a period camera, and framed them in authentic vintage frames. A German court convicted Beltracchi relating to [14 works sold for $45 million](https://en.wikipedia.org/wiki/Wolfgang_Beltracchi), but the true scale is believed to be hundreds of works over decades. The art was competent. The provenance was the product.

Across New York, the Knoedler Gallery (founded 1846, the oldest commercial art gallery in the United States) had spent seventeen years [selling approximately 40 forged Abstract Expressionist paintings](https://en.wikipedia.org/wiki/Knoedler) from a dealer who claimed they came from an anonymous collector. No exhibition history. No prior publication. No documented ownership chain. The operation generated approximately [$80 million in sales](https://news.artnet.com/art-world/glafira-rosales-knoedler-art-fraud-1018190). Knoedler closed permanently on November 30, 2011. A 165-year-old institution destroyed because it sold works without verifiable provenance.

The paintings were not the problem. The provenance was the problem. Without it, nothing else mattered.

AI systems today have the same vulnerability. They produce outputs without traceability. When they fail, nobody can trace how they got there.

## The pattern

Provenance (the ability to trace how you got here) predates software. Every domain that requires trust has independently arrived at the same conclusion: without an unbroken chain from source to output, the thing you are looking at is worthless.

In criminal law, chain of custody is the documented trail showing who collected, handled, and stored physical evidence. If the chain breaks, the evidence is [inadmissible](https://www.ncbi.nlm.nih.gov/books/NBK551677/). During the O.J. Simpson trial, Detective Philip Vannatter drew Simpson's blood and [carried it in his pocket for roughly ninety minutes](https://www.crimemuseum.org/crime-library/famous-murders/forensic-investigation-of-the-oj-simpson-trial/) before entering it into evidence. The defense called him "the man who carried the blood." Despite overwhelming DNA evidence, provenance failures gave the jury enough doubt to acquit.

In science, provenance is reproducibility. C. Glenn Begley and Lee Ellis at Amgen attempted to reproduce 53 landmark preclinical cancer studies. [Only 6 of 53 could be confirmed](https://www.nature.com/articles/483531a). The Open Science Collaboration replicated 100 psychology studies and found [only 36% achieved significant results](https://www.science.org/doi/10.1126/science.aac4716), down from 97% in the originals. Bayer validated [only 21% of published findings](https://www.nature.com/articles/nrd3439-c1) they attempted to build drug discovery programs on. The studies failed not because the science was wrong but because the methodology provenance was incomplete: unstated assumptions, undocumented preprocessing, undisclosed researcher degrees of freedom.

In supply chains, provenance failures kill. In 2008, middlemen in China's dairy supply chain [added melamine to watered-down milk](https://en.wikipedia.org/wiki/2008_Chinese_milk_scandal) to inflate protein readings. Three hundred thousand children were affected. Fifty-four thousand were hospitalized. Six infants died. The dairy companies could not trace their inputs to their actual sources. As of 2018, Chinese parents [still widely distrusted domestic formula](https://qz.com/1323471/ten-years-after-chinas-melamine-laced-infant-milk-tragedy-deep-distrust-remains). The provenance failure created a trust deficit that persists across a generation.

The pattern holds across every domain. Evidence without chain of custody is inadmissible. Studies without reproducible methodology are unreliable. Products without traceable inputs are unsafe. If you cannot trace how you got here, you cannot trust where you are.

## The software supply chain

Software learned this the hard way, three times in four years.

The SolarWinds attack (discovered December 2020) compromised the build system for SolarWinds' Orion platform. Russian intelligence [injected malicious code before the code-signing step](https://www.gao.gov/blog/solarwinds-cyberattack-demands-significant-federal-and-private-sector-response-infographic). SolarWinds then digitally signed the compromised build and distributed it as a routine update. The digital signature, meant to be the provenance guarantee, was intact and valid. The build provenance was corrupted upstream of the attestation. Approximately [18,000 customers installed the backdoor](https://en.wikipedia.org/wiki/2020_United_States_federal_government_data_breach), including nine federal agencies.

Log4Shell (disclosed December 2021) was not a supply chain attack. It was a [provenance failure of a different kind](https://en.wikipedia.org/wiki/Log4Shell). A critical vulnerability had existed in the Apache Log4j library since 2013. When it was disclosed, most organizations could not answer a simple question: does our software contain Log4j? The library was a dependency of a dependency of a dependency. The Department of Homeland Security estimated it would take a decade to find every instance.

The XZ Utils backdoor (discovered March 2024) exploited the trust model of open-source maintenance. An entity using the name "Jia Tan" spent [three years building trust](https://en.wikipedia.org/wiki/XZ_Utils_backdoor) within the project, gradually becoming co-maintainer as the original developer cited burnout. In February 2024, they inserted a backdoor giving remote code execution on affected Linux systems. Andres Freund, a Microsoft engineer, caught it by accident: he noticed a 500-millisecond latency regression and traced it to the compromised package. The commit history looked legitimate because the attacker had legitimate access. The social provenance was manufactured.

Three attacks, three failure modes. SolarWinds: build provenance corrupted upstream of attestation. Log4Shell: dependency provenance unknown. XZ Utils: human provenance chain fabricated. Signing alone is not enough. Dependency scanning alone is not enough. Code review alone is not enough. Google responded with [SLSA](https://slsa.dev/) (Supply-chain Levels for Software Artifacts), defining provenance as "verifiable information about software artifacts describing where, when and how something was produced." The industry recognized that provenance is not a feature to add. It is the architecture.

## Provenance as architecture

Git is rarely described as a provenance system. It is one.

Linus Torvalds [designed it](https://en.wikipedia.org/wiki/Git) as a content-addressable filesystem where every object is identified by its SHA-1 hash. Each commit hash includes the parent commit's hash, creating a structure where every commit is a function of the entire history that precedes it. If a single bit changes anywhere in the history, all subsequent hashes change. You cannot produce a commit without simultaneously producing its provenance.

This is why git became the universal substrate of software development. Not because it is user-friendly. Because its provenance model makes collaboration possible at scale. Without provenance, concurrent modification of shared state is chaos. With provenance, it is version control.

Nakamoto [defined](https://www.ussc.gov/sites/default/files/pdf/training/annual-national-training-seminar/2018/Emerging_Tech_Bitcoin_Crypto.pdf) a digital coin as "a chain of digital signatures." Strip the transaction history from a Bitcoin and you have nothing. The coin has no existence independent of its provenance. The systems that endure share this structural property: provenance is not metadata attached to the thing. Provenance is the thing.

Building provenance into AI systems means applying this model at every transformation step. Data versioning tools like [DVC](https://dvc.org/) treat training datasets the way git treats code: content-addressable versioning where every dataset state has a reproducible identifier, and every model artifact traces to the data version that produced it. SLSA's framework, which Google designed for software supply chains, extends to ML training pipelines by the same logic: attest who ran which training job, when, on which dataset version, producing which model artifact. The principle from git still holds. Provenance that is structural, embedded in the artifact's identity, is harder to fabricate than provenance documented separately and attached afterward.

## What AI systems lack

Most deployed AI systems cannot trace how they produced their outputs. When a model hallucinates, which training data contributed? When an agent makes a bad decision, what was the reasoning chain? When a [RAG pipeline](/blog/the-rag-trap/) returns garbage, was the problem in retrieval, in chunking, in the source document, or in the model's synthesis?

Provenance debt accumulates in systems where nobody can trace how an output was produced. It compounds every time the output is used as input to another system. And unlike a database query that fails visibly when provenance breaks, an LLM generates a plausible response. Nothing technically fails. The system proceeds.

[ISO 42001](/blog/i-read-iso-42001-so-you-dont-have-to/) already requires data provenance tracking across the AI system lifecycle. The [EU AI Act](https://en.wikipedia.org/wiki/Artificial_Intelligence_Act) requires explainability for high-risk systems. The companies deploying AI without provenance are building systems that cannot survive regulatory scrutiny, cannot be debugged in production, and cannot be trusted when the stakes are high.

## What I am still figuring out

Whether provenance and transparency are the same thing. Full provenance for a model trained on billions of tokens means billions of provenance links. The question is what level of provenance is useful, not just what level is achievable.

Whether AI-generated provenance is trustworthy. If you use an LLM to explain its own reasoning, you are asking the system to produce provenance for itself. Git does not explain its own commits. The provenance is structural, not narrative. AI systems that generate natural-language explanations of their decisions may be producing plausible provenance rather than actual provenance, the same way they produce [plausible answers rather than accurate ones](/blog/the-cost-of-being-wrong/).

---

A single pigment trace exposed Beltracchi. A 165-year-old gallery collapsed because it sold works without verifiable provenance. The paintings were competent. The chain of custody was not.

The principle predates every technology involved. Evidence, art, science, food, software, currency: every domain that requires trust requires provenance. AI is not exempt. It is the newest domain where the oldest principle applies.

[Ground truth](/blog/ground-truth-as-foundation/) establishes the foundation: the data means what it says. Provenance traces the chain: every derived fact leads back to its source. Without both, AI systems are selling paintings without provenance, and the reckoning, when it comes, will be swift.
