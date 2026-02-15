---
layout: post
title: "Ground Truth as Foundation"
date: 2026-03-10
---

On November 16, 2018, representatives from sixty nations [voted](https://en.wikipedia.org/wiki/2019_redefinition_of_the_SI_base_units) to redefine the kilogram. For 130 years, the kilogram had been a platinum-iridium cylinder in a vault outside Paris—Le Grand K. Not a reference for the kilogram. The kilogram itself.

Le Grand K was drifting. It had [lost approximately fifty micrograms](https://phys.org/news/2019-05-adieu-le-grand-kilogram-redefined.html) relative to its official copies over a century. Nobody could determine whether Le Grand K was gaining mass or its copies were losing it, because Le Grand K was, by definition, exactly one kilogram.

The ground truth was changing. Everything calibrated against it was changing too—invisibly.

The fix was not a better cylinder. It was redefining mass in terms of the Planck constant—a property of the universe that does not drift.

The ground truth underneath AI systems today is drifting too. Unlike Le Grand K, nobody is measuring the drift. And the decisions being built on top of it are getting bigger.

## The pattern

Ground truth is not data quality. Data quality is a spectrum. Ground truth is binary: the data corresponds to the reality it claims to represent, or it does not. Edgar Codd [stated](https://dl.acm.org/doi/10.1145/362384.362685) the principle in 1970: all information represented in exactly one way, by values in tables. One representation. No ambiguity. No hidden meaning.

When ground truth fails, it fails in one of three ways. The data is correct but means the wrong thing. The data claims to represent reality but does not. Or the data represents one reality and is applied to another. Each has killed people, cost billions, or both.

The Boeing 737 MAX MCAS system relied on a single angle-of-attack sensor. When that sensor failed on Lion Air Flight 610 and Ethiopian Airlines Flight 302, it transmitted data that did not represent the aircraft's physical state. Normal flight, misread as stall. MCAS pushed the nose down. Boeing [informed investigators](https://www.ntsb.gov/investigations/Documents/Response%20to%20EAIB%20final%20report.pdf) they had made "an engineering design error in their initial AOA Sensor Hazard Analysis." Three hundred and forty-six people died because one sensor's output was treated as ground truth without verification.

LIBOR—the London Interbank Offered Rate—underpinned approximately [$350 trillion in financial instruments](https://www.newyorkfed.org/medialibrary/media/research/staff_reports/sr667.pdf). Between 2003 and 2012, banks systematically submitted false data. Barclays alone made 257 documented attempts to manipulate the rate. LIBOR was eventually [phased out entirely](https://en.wikipedia.org/wiki/Libor_scandal)—too compromised to reform. The ground truth was a coordinated fiction, and $350 trillion in instruments were priced against it.

The UK Post Office prosecuted over 900 subpostmasters for theft based on the Horizon accounting software. The software had [bugs that created phantom shortfalls](https://en.wikipedia.org/wiki/British_Post_Office_scandal). At least thirteen people committed suicide. The [2025 inquiry](https://www.postofficehorizoninquiry.org.uk/) found that senior employees knew the system was faulty and maintained the fiction anyway.

These are not edge cases. They are the pattern. And the pattern is repeating—faster, at greater scale, with less visibility.

## The compound

Traditional software fails when ground truth is wrong. AI fails differently: it learns from the failure and propagates it.

IBM invested approximately $4 billion in Watson for Oncology, trained on synthetic cases from a small number of oncologists—not real patient data. It produced ["unsafe and incorrect" treatment recommendations](https://www.statnews.com/wp-content/uploads/2018/09/IBMs-Watson-recommended-unsafe-and-incorrect-cancer-treatments-STAT.pdf), including recommending a drug with a black box warning against the patient's exact condition. IBM sold the division for approximately $1 billion. The ground truth the model learned from did not represent the reality it was deployed against.

Curtis Northcutt and colleagues [found](https://arxiv.org/abs/2103.14749) that 6% of ImageNet's validation labels are wrong. These are the benchmarks the field uses to rank models. The researchers found that "higher-capacity models reflect systematic label errors in their predictions to a greater degree than lower-capacity models." The models that appear best may be the ones that learned the errors most thoroughly.

A database with a corrupted record has a localized problem. A model trained on corrupted data has a systemic one—distributed across billions of parameters, impossible to localize, difficult to detect.

This compounds. Most AI memory systems and RAG pipelines extract "important" facts from raw data, then discard the original. Each extraction introduces errors. Each summarization loses detail. The [HaluMem study](https://arxiv.org/abs/2511.03506) found memory system accuracies below 70%. After a few passes, you are querying a game of telephone.

And when a database has a type mismatch, it throws an error. When an LLM encounters something outside its training data, it generates a plausible response with high confidence. There is no error code for "this is fabricated." The system proceeds because nothing technically failed.

## What is coming

Models are getting better at sounding right. Ground truth is not getting better at being right. The gap is widening.

AI is moving from "assistant you might check" to "system that makes decisions." Cigna's automated PxDx system [denied over 300,000 claims in two months](https://www.propublica.org/article/cigna-pxdx-medical-health-insurance-rejection-claims) at 1.2 seconds per case. A class action lawsuit [alleged](https://www.cbsnews.com/news/unitedhealth-lawsuit-ai-deny-claims-medicare-advantage-health-insurance-denials/) that UnitedHealth's nH Predict algorithm had a 90% error rate on claim denials—and that UnitedHealth continued using it because only 0.2% of patients appealed. A New York lawyer [cited six fake cases](https://en.wikipedia.org/wiki/Mata_v._Avianca,_Inc.) generated by ChatGPT in a federal court filing. These are not hypotheticals. They are 2023.

Three things make the next few years worse.

First, the training data for the next generation of models is being poisoned by the current generation. Ilia Shumailov and colleagues [demonstrated](https://www.nature.com/articles/s41586-024-07566-y) in Nature that training on AI-generated data causes "irreversible defects" where "tails of the original content distribution disappear." As AI-generated content floods the internet, models increasingly train on their own outputs. The ground truth—human-generated data—is being diluted by approximations of itself. Shumailov warned: "The value of data collected about genuine human interactions with systems will be increasingly valuable." At the project level, this is what a [CLAUDE.md](/blog/the-intelligence-is-in-the-document/) is: ground truth derived from human observation and failure, not generated by the model it governs.

Second, the paradigm will shift. Transformers will give way to something else. Embedding-based retrieval will be replaced. The [vector databases and agent frameworks](/blog/the-properties-that-survive/) being built right now are coupled to the current architecture. When the architecture changes, all of it breaks. What survives the shift is not the model or the framework. It is the data underneath—if it means what it says it means.

Third, regulation is arriving. The [EU AI Act](https://en.wikipedia.org/wiki/Artificial_Intelligence_Act) requires explainability and risk assessment for high-risk AI systems. The companies deploying AI in healthcare, hiring, insurance, and finance will need to demonstrate that their systems' decisions trace back to verifiable ground truth. ISO 42001 already requires data provenance tracking across the AI system lifecycle. The companies that skipped the governance layer because it was "overhead" will discover it was a prerequisite.

## What survives

The metrological insight is that ground truth works when it has four properties—and these properties are paradigm-independent. They worked for Le Grand K. They work for databases. They will work for whatever replaces transformers.

Immutable sources at the bottom. The Planck constant does not drift. Immutable raw records do not drift either. They do not depend on any model, any embedding, any architecture. When the paradigm shifts, the raw data is still there.

Documented derivations from source to output. The International Vocabulary of Metrology [defines](https://jcgm.bipm.org/vim/en/2.41.html) traceability as "a documented unbroken chain of calibrations, each contributing to the measurement uncertainty." In data systems, every derived fact traces to the record it came from. When something goes wrong, you can find out why. This is not a feature of a particular framework. It is a property of any system that needs to be debuggable.

Quantified uncertainty. Metrological traceability does not claim perfect accuracy. It claims known accuracy. In data systems, this means tracking confidence: was this directly observed, pattern-extracted, or LLM-inferred? A system that knows what it does not know is more useful than one that is confidently wrong.

Continuous verification. National metrology institutes submit to the [CIPM Mutual Recognition Arrangement](https://www.bipm.org/en/cipm-mra)—international comparison and audit. Without enforcement, ground truth degrades into opinion. In data systems, this means [data contracts](/blog/the-metadata-control-plane/), schema validation, and automated checks that verify continuously—not once.

These are not features of a current system. They are properties of any system that will still work after the paradigm shifts.

## What I am still figuring out

Where the boundary is between ground truth and interpretation. Codd drew a clean line: the data is ground truth, the queries are interpretation. In AI systems, a vector embedding changes when the embedding model changes. The "ground truth" for retrieval is model-dependent. I do not have a clean answer.

Whether ground truth is achievable for generated content. Metrological traceability works because physical constants do not change. LLM outputs are generated, not measured. There is no Planck constant for language. Verifying every claim an LLM makes is the bottleneck that makes AI useful in the first place.

Whether any of this matters if nobody builds it. The Post Office had Horizon for twenty-five years before the inquiry. LIBOR ran for a decade on fabricated data before anyone checked. The pattern is not that ground truth fails. The pattern is that nobody notices until the damage is done.

---

On November 16, 2018, sixty nations voted to retire Le Grand K. The ground truth had been drifting, and everything built on it had drifted too.

The kilogram's fix took 130 years. AI does not have 130 years. The systems being deployed today are making decisions about health insurance, criminal risk, hiring, and medical treatment. The ground truth underneath those decisions is worse than Le Grand K's—it is not just drifting. In many cases, it was never established.

The foundation comes first. Provenance, how you trace it, is next.
