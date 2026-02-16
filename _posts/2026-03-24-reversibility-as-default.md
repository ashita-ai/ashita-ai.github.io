---
layout: post
title: "Reversibility as Default"
date: 2026-03-24
---

On the night of January 27, 1986, engineers at Morton Thiokol held a teleconference with NASA about the planned launch of Space Shuttle Challenger the next morning. Roger Boisjoly [presented data](https://www.uml.edu/engineering/research/engineering-solutions/roger-boisjoly-challenger.aspx) showing that O-ring resilience degraded at low temperatures. He and his colleagues recommended against launching. NASA officials pressured Morton Thiokol to reverse its position.

Management held a separate meeting from which the engineering team was excluded. Senior Vice President Jerald Mason told Bob Lund, Boisjoly's manager: "Take off your engineering hat and put on your management hat." The managers overruled the engineers. Allan McDonald, Director of the Solid Rocket Motor Project, [refused to sign the launch authorization](https://www.npr.org/2021/03/07/974534021/remembering-allan-mcdonald-he-refused-to-approve-challenger-launch-exposed-cover). His supervisors faxed the approval without his signature.

On January 28, the temperature at launch was [36 degrees Fahrenheit](https://www.accuweather.com/en/space-news/how-record-setting-cold-contributed-to-the-space-shuttle-challenger-disaster-on-jan-28-1986/337486), far below the 53-degree threshold the engineers had identified. Seventy-three seconds after launch, [Challenger broke apart](https://en.wikipedia.org/wiki/Space_Shuttle_Challenger_disaster). Seven crew members died.

A launch hold would have been trivially reversible. Challenger had already been delayed six times. One more delay costs time and money. The launch itself was irreversible. The asymmetry is absolute: you can always launch tomorrow. You cannot un-launch.

## The compound

Three Mile Island shows what happens when irreversibility compounds.

At 4:00 a.m. on March 28, 1979, a relief valve on the pressurizer of [Three Mile Island Unit 2](https://en.wikipedia.org/wiki/Three_Mile_Island_accident) stuck open. The valve should have closed after ten seconds. It did not. Reactor coolant bled into the containment building. The critical failure: operators had no instrument showing the valve's actual position. They only had an indicator showing that a "close" signal had been sent. They believed it was closed. It was not.

Each subsequent decision narrowed the corridor for recovery. Operators [turned off the emergency cooling system](https://www.nrc.gov/reading-rm/doc-collections/fact-sheets/3mile-isle), believing the system had too much water (it had too little). They turned off coolant pumps when steam caused vibration. By the time someone realized the valve was open, 2.5 hours after the accident began, about half the core had melted.

The stuck valve was recoverable if operators had recognized it. Turning off the emergency cooling was recoverable if they had turned it back on quickly. Each step further reduced the options. By the time core melting began, the damage was irreversible. [Defense-in-depth](https://www.nuclear-power.com/nuclear-power/reactor-physics/nuclear-safety/defence-in-depth-principle/) (multiple independent barriers: fuel cladding, reactor vessel, containment building) is nuclear engineering's reversibility architecture: if one barrier fails, the next contains the damage. At TMI, the containment building held. The defense-in-depth architecture prevented catastrophe even after operators defeated several safety systems.

## The design principle

The principle that systems should be designed for recovery, not just prevention, is as old as interactive computing.

In 1971, Warren Teitelman at Bolt, Beranek, and Newman implemented the first known [undo function](https://en.wikipedia.org/wiki/Undo) as part of a Programmer's Assistant in BBN-LISP. Teitelman did not try to prevent errors. He assumed errors would happen and provided a mechanism to reverse them. When Apple shipped the Macintosh in 1984, it [required](https://www.howtogeek.com/804030/the-origins-of-ctrlc-ctrlv-ctrlx-and-ctrlz-explained/) that all standard applications include "Undo" as the first command in the Edit menu. The principle became infrastructure.

Jim Gray formalized it for databases. His 1981 paper "[The Transaction Concept](https://jimgray.azurewebsites.net/papers/thetransactionconcept.pdf)" defined the transaction as an atomic unit of work that either completes entirely or is rolled back entirely. [ACID](https://en.wikipedia.org/wiki/ACID) properties (atomicity, consistency, isolation, durability, named by Reuter and Harder in 1983) encode reversibility into the foundation of data systems. A transaction is not committed until its commit record is in the log. If the system crashes before the commit, the transaction is rolled back. Reversibility as a first-class property.

Blue-green deployments and canary releases apply the same principle to production systems. Dan North and Jez Humble [encountered the blue-green pattern](https://openpracticelibrary.com/practice/blue-green-deployments/) around 2005: deploy the new version alongside the live system, switch traffic, and if anything goes wrong, switch back. Netflix and Google collaborated on [Kayenta](https://netflixtechblog.com/automated-canary-analysis-at-netflix-with-kayenta-3260bc7acc69), an automated canary analysis tool that uses statistical tests to compare canary metrics against baselines and automatically promotes or rolls back. [Feature flags](https://launchdarkly.com/blog/what-are-feature-flags/) decouple deployment from release: code is deployed to production but not exposed to users until the flag is turned on. If the feature fails, flipping the flag off takes milliseconds. No deployment is ever irreversible.

Every surviving system encodes the same assumption: things will go wrong. The question is whether you can recover.

## The asymmetry

The cost of reversibility is always finite. Maintaining two production environments costs infrastructure. Holding a launch costs schedule. Running a canary costs a small cohort's experience. Undo costs memory.

The cost of irreversibility is unbounded.

Uber's self-driving test vehicle [detected Elaine Herzberg](https://en.wikipedia.org/wiki/Death_of_Elaine_Herzberg) 5.6 seconds before impact. The system could not determine what she was, alternating between classifying her as a vehicle, a bicycle, and an unknown object. At 1.2 seconds before impact, the system finally identified her as a bicycle in its path. But a feature called "action suppression," engineered to prevent false-alarm braking, [suppressed emergency braking](https://spectrum.ieee.org/ntsb-investigation-into-deadly-uber-selfdriving-car-crash-reveals-lax-attitude-toward-safety) for a full second. Uber had also disabled the Volvo's built-in emergency braking system. The system had a reversibility mechanism (emergency brakes) and a human fallback (the safety driver). Both were disabled. Herzberg died.

Health insurance is the clearest case. Cigna used an algorithm called PXDX to screen claims for diagnosis-procedure mismatches. ProPublica found Cigna [denied 300,000 claims in two months](https://www.propublica.org/article/cigna-pxdx-medical-health-insurance-rejection-claims) at 1.2 seconds per claim. UnitedHealthcare's nH Predict algorithm managed nursing home stays with what a class-action lawsuit [alleged was a 90% error rate](https://www.statnews.com/2023/11/14/unitedhealth-class-action-lawsuit-algorithm-medicare-advantage/). Technically, patients could appeal. In practice, roughly [80% of appealed Cigna denials were overturned](https://www.pbs.org/newshour/show/how-algorithms-are-being-used-to-deny-health-insurance-claims-in-bulk), suggesting most were inappropriate. But only about one in five patients appealed at all. The systems exploited the asymmetry between the cost of denying (near zero for the insurer) and the cost of appealing (substantial for a sick patient). For most patients, the denial was irreversible in practice.

The AI systems making the most consequential decisions are the ones with the least reversibility. Insurance denials at 1.2 seconds per claim. Self-driving decisions at millisecond latency. The higher the stakes, the more reversibility matters, and the less of it these systems have.

## What to build

The companies deploying AI that works build rollback first. Shadow deployment, automatic pullback, circuit breakers. They assume the system will fail and engineer the ability to recover. The companies that skip this step assume the system will work and are surprised when it does not.

Clinical trial phases offer a model: graduated reversibility gates where each phase has stopping rules, safety review, and a go/no-go decision before proceeding. [Phase I](https://med.uc.edu/depart/psychiatry/research/clinical-research/crm/trial-phases-1-2-3-defined) (20-100 volunteers, safety only) is designed to be stopped at any time. Phase III involves thousands of patients but still has mandatory stopping rules. Every gate is a chance to reverse course.

AI deployment should work the same way. Not "deploy and see what happens." Deploy to 1% of traffic. Monitor. Expand or roll back. Feature flags, canary releases, automated monitoring, and kill switches are not overhead. They are the infrastructure that determines whether a failure is recoverable or permanent.

## What I am still figuring out

Where the boundary is between reversibility and paralysis. Requiring rollback capability for every system means some systems never ship. Startups that build perfect reversibility infrastructure before they have users are solving the wrong problem. The question is which decisions warrant reversibility engineering and which do not. Nassim Taleb [argues](https://arxiv.org/abs/1410.5787) the precautionary principle applies only to systemic, potentially irreversible risks, but determining which risks qualify is itself a judgment call.

Whether speed and reversibility are fundamentally in tension. Feature flags add latency. Canary releases slow deployment. Shadow deployments double infrastructure costs. The systems making the fastest, most consequential decisions (autonomous vehicles, algorithmic trading, real-time content moderation) are the ones where reversibility is hardest to engineer and most important to have.

---

On the night of January 27, 1986, Morton Thiokol's engineers recommended against launching. Management overruled them. Allan McDonald refused to sign. A launch hold was trivially reversible. The launch was not.

The four properties form a stack. [Ground truth](/blog/ground-truth-as-foundation/) ensures the data means what it says. [Provenance](/blog/the-provenance-imperative/) traces every derived fact to its source. [Contracts](/blog/contracts-as-infrastructure/) enforce the boundaries between systems. Reversibility ensures that when something goes wrong (and it will), you can recover.

The [properties that survive](/blog/the-properties-that-survive/) are the ones that were valuable before the current paradigm and will be valuable after the next one. These four are not tied to transformers, to embedding models, to prompt engineering, or to any framework that exists today. They are the structure underneath. Build the structure first. The furniture can wait.
