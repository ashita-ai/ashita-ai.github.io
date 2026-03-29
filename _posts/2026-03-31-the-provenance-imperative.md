---
layout: post
title: "The Provenance Imperative"
date: 2026-03-31
series: "the-properties-that-survive"
category: "properties-series"
---

In 2008, forensic analysts found titanium white in a painting attributed to Heinrich Campendonk and dated 1914. Titanium white was not available as an artist's pigment until the early 1920s. A single anachronistic pigment trace collapsed an entire provenance fiction.

Wolfgang Beltracchi had not copied existing paintings. He created new works in the styles of Max Ernst, Fernand Léger, Heinrich Campendonk, and others, filling gaps in artists' known catalogs with plausible undiscovered works. He and his wife fabricated ownership histories dating to the 1920s, photographed the fakes with a period camera, and framed them in authentic vintage frames. A German court convicted Beltracchi relating to [14 works sold for $45 million](https://en.wikipedia.org/wiki/Wolfgang_Beltracchi), but the true scale is believed to be hundreds of works over decades. The art was competent. The provenance was the product.

Across New York, the Knoedler Gallery (founded 1846, the oldest commercial art gallery in the United States) had spent seventeen years [selling approximately 40 forged Abstract Expressionist paintings](https://en.wikipedia.org/wiki/Knoedler) from a dealer who claimed they came from an anonymous collector. No exhibition history. No prior publication. No documented ownership chain. The operation generated approximately [$80 million in sales](https://news.artnet.com/art-world/glafira-rosales-knoedler-art-fraud-1018190). Knoedler closed permanently on November 30, 2011. A 165-year-old institution destroyed because it sold works without verifiable provenance.

The paintings were not the problem. The provenance was the problem. Without it, nothing else mattered.

AI systems today have the same vulnerability. They produce outputs without traceability. When they fail, nobody can trace how they got there.

## The pattern

Provenance — the ability to trace how you got here — predates software. The domains are different. The failure mode is the same.

In criminal law, chain of custody is the documented trail showing who collected, handled, and stored physical evidence. If the chain breaks, the evidence is [inadmissible](https://www.ncbi.nlm.nih.gov/books/NBK551677/). During the O.J. Simpson trial, Detective Philip Vannatter drew Simpson's blood and [carried it in his pocket for roughly three hours](https://www.crimemuseum.org/crime-library/famous-murders/forensic-investigation-of-the-oj-simpson-trial/) before entering it into evidence. The defense called him "the man who carried the blood." Despite overwhelming DNA evidence, provenance failures gave the jury enough doubt to acquit.

In science, provenance is reproducibility. C. Glenn Begley and Lee Ellis at Amgen attempted to reproduce 53 landmark preclinical cancer studies. [Only 6 of 53 could be confirmed](https://www.nature.com/articles/483531a). The Open Science Collaboration replicated 100 psychology studies and found [only 36% achieved significant results](https://www.science.org/doi/10.1126/science.aac4716), down from 97% in the originals. Bayer validated [only 21% of published findings](https://www.nature.com/articles/nrd3439-c1) they attempted to build drug discovery programs on. The studies failed not because the science was wrong but because the methodology provenance was incomplete: unstated assumptions, undocumented preprocessing, undisclosed researcher degrees of freedom.

In supply chains, provenance failures kill. In 2008, middlemen in China's dairy supply chain [added melamine to watered-down milk](https://en.wikipedia.org/wiki/2008_Chinese_milk_scandal) to inflate protein readings. Three hundred thousand children were affected. Fifty-four thousand were hospitalized. At least six infants died. The dairy companies could not trace their inputs to their actual sources. As of 2018, Chinese parents [still widely distrusted domestic formula](https://qz.com/1323471/ten-years-after-chinas-melamine-laced-infant-milk-tragedy-deep-distrust-remains). The provenance failure created a trust deficit that persists across a generation.

The pattern holds across every domain. Evidence without chain of custody is inadmissible. Studies without reproducible methodology are unreliable. Products without traceable inputs are unsafe. If you cannot trace how you got here, you cannot trust where you are.

## The software supply chain

Software learned this the hard way, three times in four years.

The SolarWinds attack (discovered December 2020) compromised the build system for SolarWinds' Orion platform. Russian intelligence [injected malicious code before the code-signing step](https://www.gao.gov/blog/solarwinds-cyberattack-demands-significant-federal-and-private-sector-response-infographic). SolarWinds then digitally signed the compromised build and distributed it as a routine update. The digital signature, meant to be the provenance guarantee, was intact and valid. The build provenance was corrupted upstream of the attestation. Approximately [18,000 customers installed the backdoor](https://en.wikipedia.org/wiki/2020_United_States_federal_government_data_breach), including nine federal agencies.

Log4Shell (disclosed December 2021) was not a supply chain attack. It was a [provenance failure of a different kind](https://en.wikipedia.org/wiki/Log4Shell). A critical vulnerability had existed in the Apache Log4j library since 2013. When it was disclosed, most organizations could not answer a simple question: does our software contain Log4j? The library was a dependency of a dependency of a dependency. The Department of Homeland Security estimated it would take a decade to find every instance.

The XZ Utils backdoor (discovered March 2024) exploited the trust model of open-source maintenance. An entity using the name "Jia Tan" spent [approximately two years building trust](https://en.wikipedia.org/wiki/XZ_Utils_backdoor) within the project, gradually becoming co-maintainer as the original developer cited burnout. In February 2024, they inserted a backdoor giving remote code execution on affected Linux systems. Andres Freund, a Microsoft engineer, caught it by accident: he noticed a 500-millisecond latency regression and traced it to the compromised package. The commit history looked legitimate because the attacker had legitimate access. The social provenance was manufactured.

Three attacks, three failure modes. SolarWinds: build provenance corrupted upstream of attestation. Log4Shell: dependency provenance unknown. XZ Utils: human provenance chain fabricated. Signing alone is not enough. Dependency scanning alone is not enough. Code review alone is not enough. Google responded with [SLSA](https://slsa.dev/) (Supply-chain Levels for Software Artifacts), defining provenance as "verifiable information about software artifacts describing where, when and how something was produced." The industry recognized that provenance is not a feature to add. It is the architecture.

This is what led me to build [Akashi](/projects/akashi/). I was running multiple AI coding agents against the same codebase and kept hitting a specific failure mode: two agents would make contradictory decisions — one choosing connection pooling, the other choosing per-request connections — and neither could explain why. There was no trail. The codebase just accumulated silent contradictions until something broke in CI, and I would spend an hour reconstructing which agent had decided what, when, and based on what context. The problem was not that the agents were wrong. The problem was that I could not trace how they got there. Akashi records every decision with its reasoning, confidence, and lineage so that the next agent — or the next human — can see the chain before deciding. It is a small version of the same principle: if the provenance is not structural, it does not exist.

## Provenance as architecture

Git is rarely described as a provenance system. It is one.

Linus Torvalds [designed it](https://en.wikipedia.org/wiki/Git) as a content-addressable filesystem where every object is identified by its SHA-1 hash. Each commit hash includes the parent commit's hash, creating a structure where every commit is a function of the entire history that precedes it. If a single bit changes anywhere in the history, all subsequent hashes change. You cannot produce a commit without simultaneously producing its provenance.

This is why git became the universal substrate of software development. Not because it is user-friendly. Because its provenance model makes collaboration possible at scale. Without provenance, concurrent modification of shared state is chaos. With provenance, it is version control.

Nakamoto [defined](https://www.ussc.gov/sites/default/files/pdf/training/annual-national-training-seminar/2018/Emerging_Tech_Bitcoin_Crypto.pdf) a digital coin as "a chain of digital signatures." Strip the transaction history from a Bitcoin and you have nothing. The coin has no existence independent of its provenance. The systems that endure share this structural property: the provenance is not a layer on top. Strip it away and there is nothing left.

Building provenance into AI systems means applying this model at every transformation step. Data versioning tools like [DVC](https://dvc.org/) treat training datasets the way git treats code: content-addressable versioning where every dataset state has a reproducible identifier, and every model artifact traces to the data version that produced it. SLSA's framework, which Google designed for software supply chains, extends to ML training pipelines by the same logic: attest who ran which training job, when, on which dataset version, producing which model artifact. The principle from git still holds. Provenance that is structural, embedded in the artifact's identity, is harder to fabricate than provenance documented separately and attached afterward.

## What AI systems lack

Most deployed AI systems cannot trace how they produced their outputs. The consequences are already arriving.

UnitedHealth's subsidiary NaviHealth deployed an AI model called nH Predict to determine how much post-acute care elderly Medicare Advantage patients should receive. The model's predictions overrode treating physicians' clinical judgments to [deny coverage for nursing home and rehabilitation care](https://www.statnews.com/2023/11/14/unitedhealth-class-action-lawsuit-algorithm-medicare-advantage/). When patients appealed, nine out of ten denials were reversed — the model was wrong overwhelmingly. But neither patients nor their doctors could see why they were denied. The system produced a coverage decision without a traceable chain from patient data to output. In March 2026, a court [ordered UnitedHealth to produce all documents](https://distilinfo.com/2026/03/12/court-orders-unitedhealth-to-disclose-ai-denial-algorithm/) analyzing nH Predict, including records from its internal AI review board. The provenance that should have been built in is now being extracted by subpoena.

In December 2023, the FTC [banned Rite Aid from using facial recognition](https://www.ftc.gov/news-events/news/press-releases/2023/12/rite-aid-banned-using-ai-facial-recognition-after-ftc-says-retailer-deployed-technology-without) for five years. The company had deployed the technology across hundreds of stores to identify suspected shoplifters. Enrollment images were screenshots from CCTV cameras and photos taken on employees' cell phones. The FTC found that Rite Aid never tested accuracy after deployment, never monitored false-positive rates, and never documented outcomes. During one five-day period, the system generated over 900 alerts across more than 130 stores, all matching against a single image. Rite Aid could not trace which identifications were accurate, which were false, or why the system was generating them. The FTC ordered deletion of all photos, videos, models, and algorithms derived from the surveillance.

In February 2024, Google paused Gemini's image generation feature after it produced historically inaccurate images: racially diverse depictions of groups like the Founding Fathers and Nazi German soldiers. Google could identify the symptom. It could not trace the output to its source — which training examples, which RLHF signal, which fine-tuning stage had produced the behavior. Without that chain, the fix was not targeted remediation. It was retraining and hope.

These are not edge cases. They are the same pattern from the courtroom and the laboratory, now running at machine speed. Provenance debt accumulates in systems where nobody can trace how an output was produced. It compounds every time the output is used as input to another system. And unlike a database query that fails visibly when provenance breaks, an LLM generates a plausible response. Nothing technically fails. The system proceeds.

[ISO 42001](/blog/i-read-iso-42001-so-you-dont-have-to/) already requires data provenance tracking across the AI system lifecycle. The [EU AI Act](https://en.wikipedia.org/wiki/Artificial_Intelligence_Act) requires explainability for high-risk systems. In February 2025, the Court of Justice of the EU [ruled](https://www.insideprivacy.com/gdpr/cjeu-clarifies-gdpr-rights-on-automated-decision-making-and-trade-secrets/) that organizations must explain "the procedure and principles actually applied" in automated decisions — and that neither a complex mathematical formula nor trade secret claims satisfy the requirement. The companies deploying AI without provenance are building systems that cannot survive the regulatory environment that already exists.

## What I am still figuring out

Whether useful provenance is achievable at scale. Full provenance for a model trained on hundreds of billions of tokens means hundreds of billions of attribution links. Mechanistic interpretability is making progress — identifying which circuits activate for which outputs — but even complete circuit-level understanding does not produce the causal chain that chain-of-custody or scientific reproducibility require. The more tractable question is whether partial provenance is sufficient: dataset versioning, training run attestation, retrieval source tracking at query time. The answer depends on stakes. A customer service chatbot and a sepsis prediction model require different levels of provenance to be trustworthy. The field has not agreed on what those levels should be, which means most deployments are making an implicit judgment call about what they can get away with.

Whether AI-generated provenance is trustworthy. If you use an LLM to explain its own reasoning, you are asking the system to produce provenance for itself. Git does not explain its own commits. The provenance is structural, not narrative. AI systems that generate natural-language explanations of their decisions may be producing plausible provenance rather than actual provenance, the same way they produce [plausible answers rather than accurate ones](/blog/the-cost-of-being-wrong/).

---

A single pigment trace exposed Beltracchi. A 165-year-old gallery collapsed because it sold works without verifiable provenance. The paintings were competent. The chain of custody was not.

The principle predates every technology involved. Evidence, art, science, food, software, currency: every domain that requires trust requires provenance. AI is not exempt. It is the newest domain where the oldest principle applies.

[Ground truth](/blog/ground-truth-as-foundation/) establishes the foundation: the data means what it says. Provenance traces the chain: every derived fact leads back to its source. Without both, AI systems are selling paintings without provenance, and the reckoning, when it comes, will be swift.
