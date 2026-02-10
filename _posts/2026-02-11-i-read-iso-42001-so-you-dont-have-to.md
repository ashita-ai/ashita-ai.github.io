---
layout: post
title: "I Read ISO 42001 So You Don't Have To"
date: 2026-02-11
---

In November 2024, AWS [became](https://aws.amazon.com/blogs/machine-learning/aws-achieves-iso-iec-420012023-artificial-intelligence-management-system-accredited-certification/) the first major cloud provider to certify against ISO/IEC 42001—a 53-page standard for AI management systems published eleven months earlier. Google Cloud [followed](https://cloud.google.com/blog/products/identity-security/google-clouds-commitment-to-responsible-ai-is-now-iso-iec-certified) in December. Anthropic [in January 2025](https://www.anthropic.com/news/anthropic-achieves-iso-42001-certification-for-responsible-ai). Microsoft [in March](https://techcommunity.microsoft.com/blog/microsoft365copilotblog/microsoft-365-copilot-achieves-isoiec-420012023-certification/4397144).

By late 2025, roughly [a hundred companies](https://www.prnewswire.com/news-releases/automation-anywhere-among-the-first-100-companies-to-earn-certification-of-the-iso-standard-for-ai-governance-and-security-strengthening-its-leadership-in-responsible-ai-management-302610256.html) had certified against a document most engineers have never opened. I bought both standards and read all 79 pages—53 for 42001, 26 for its companion risk guidance, ISO/IEC 23894. Here is what they actually say, what they get right, and where they fall short.

## What it is

ISO 42001 is a certifiable management system standard for organizations that develop, provide, or use AI systems. If a client, partner, or regulator asks "are you ISO compliant for AI?"—they mean 42001.

It follows the ISO Harmonized Structure: ten clauses, Plan-Do-Check-Act. Context and planning (4–7), operations (8), evaluation (9), improvement (10). If you have implemented ISO 27001 for information security, the skeleton is identical—and 42001 is designed to bolt on. You share risk assessment methodology, internal audit, management review, and documentation control. If you do not have 27001, you are building the management system from scratch.

The real substance is in Annex A: 38 controls across nine domains covering policies, internal organization, resources, impact assessment, lifecycle management, data, stakeholder information, AI system use, and third-party relationships.

The companion standard, ISO/IEC 23894, extends ISO 31000 (general risk management) to AI-specific risks. It is guidance—not certifiable on its own. You use it to implement 42001's risk management requirements. Its value is Annex C: a table mapping risk management activities to each phase of the AI system lifecycle—inception, design, verification, deployment, operation, re-evaluation, retirement. Risk as a continuous process, not a pre-launch checkbox. If you build AI governance into engineering workflows, this is the operational blueprint.

## The Statement of Applicability

The most important deliverable in the entire standard is not an AI system. It is a document.

Clause 6.1.3(f) requires a Statement of Applicability: a formal record listing every Annex A control, declaring whether you are including or excluding it, and justifying your decision. This is the document auditors scrutinize. It is also where you can legitimately scope down the overhead—excluding controls that do not apply to your risk profile is built into the standard's design.

You do not implement all 38 controls. You make a deliberate, documented decision about each one. A company using a third-party API has different obligations than one training foundation models. The standard acknowledges this explicitly, rather than mandating blanket compliance.

## The two assessments

The standard separates two processes that most organizations conflate.

**Risk assessment (6.1.2)** looks at risks *to the organization*—what could go wrong for the business. Legal exposure, reputational damage, operational failures, financial loss. This feeds the risk treatment plan and determines which Annex A controls you need.

**Impact assessment (6.1.4)** looks at consequences *for individuals and societies*—what your AI system does to people who may never interact with it directly. The standard uses "shall" language here. Mandatory, recurring, and must account for the specific technical and societal context where the system operates.

The distinction matters. In 2023, the EEOC settled its first AI discrimination case: iTutorGroup's hiring algorithm [automatically rejected applicants over 55](https://www.eeoc.gov/newsroom/itutorgroup-pay-365000-settle-eeoc-discriminatory-hiring-suit), resulting in a $365,000 settlement. The risk to the company (legal liability) is a risk assessment concern. The harm to the applicants (age discrimination by algorithm) is an impact assessment concern. Different processes, different stakeholders, different controls.

## The controls that matter

Most of the 38 controls are organizational boilerplate—policies, roles, awareness training. A handful encode engineering principles that matter regardless of the certificate.

**Data governance (A.7.2–A.7.6).** The standard requires documented processes for data acquisition (A.7.3), data quality (A.7.4), data provenance (A.7.5), and data preparation (A.7.6). Where did the training data come from? Under what terms? What quality checks were applied? Can you trace from model output back to the data that produced it? These five controls represent roughly 30% of the actual implementation work. If you have [data contracts and lineage tracking](/blog/introducing-tessera/), you are halfway there. If you do not, this is where the effort goes.

**Lifecycle management (A.6.1–A.6.2).** Nine controls spanning design through retirement. Requirements and specification (A.6.2.2). Verification and validation (A.6.2.4). Deployment planning (A.6.2.5). Operation and monitoring (A.6.2.6). Event logs (A.6.2.8). The standard treats the AI system lifecycle as an engineering discipline, not a one-time deployment.

Systems that update themselves in production get special treatment throughout both standards. Continuous learning models that retrain on live data are uniquely risky—behavior changes post-deployment, and the validation you did at launch no longer holds. If your models retrain on production data, you need monitoring and re-evaluation processes specifically for drift.

**Transparency by audience (A.6.2.7).** The standard requires different technical documentation for different stakeholders—users, partners, supervisory authorities. One level of documentation for people using your product, another for their compliance teams, and potentially another for regulators. Getting the layering right up front saves rework later.

**Human oversight.** Both standards emphasize that automated decision-making affecting individuals requires defined human oversight processes. Not "we have a dashboard." Documented processes for where a human can override or review AI-generated outputs—and proof that the override capability actually exists in production, not just in the documentation.

**Third-party governance (A.10.2–A.10.4).** If you use third-party models, APIs, or data, you are still responsible. The standard requires supplier evaluation processes and documented responsibility allocation across the AI system lifecycle. You cannot outsource your governance to your vendor and claim compliance.

## What it gets right

The impact assessment requirement has teeth. Most AI governance frameworks treat impact assessment as a suggestion. ISO 42001 makes it mandatory, auditable, and recurring. Systems that [produce confident wrong answers](/blog/the-cost-of-being-wrong/) affect people who never asked to be subjected to them. The standard forces you to account for those people before deployment—if you actually do the work.

The data provenance controls encode what data engineers already know. Data contracts, lineage tracking, and quality measures are not innovations. They are the infrastructure every AI system needs. The standard's contribution is making them externally auditable—creating an enforcement mechanism for practices that organizations skip under deadline pressure.

The 23894 lifecycle table (Annex C) is the best part of either standard. It maps specific risk management activities—identification, analysis, evaluation, treatment, monitoring—to each phase of the AI system lifecycle. This is the artifact that translates committee language into engineering practice. If you build one thing from these two standards, build this.

## What it gets wrong

Oxebridge, an ISO certification watchdog, [called it](https://www.oxebridge.com/emma/iso-42001-on-ai-includes-text-plagiarized-from-iso-27001/) "a rushed copy-and-paste of the ISO 27001 standard." They are not entirely wrong. Large sections—leadership commitment, competence, awareness, documented information—are transplanted with minimal modification. The Harmonized Structure requires shared clause structure, but the implementation guidance in Annex B often reads like information security advice with "AI" substituted for "information."

The controls are vague where they should be specific. "The organization should define processes for data quality" does not tell you what data quality means for training data versus inference data versus evaluation data. "The organization should consider" appears throughout Annex B. "Consider" is not an auditable requirement.

The standard says nothing about model evaluation methodology, bias detection techniques, or specific testing approaches. It tells you to assess your AI systems. It does not tell you how. For an engineer looking for technical guidance, this is a framework-shaped hole. You still need to decide what [your evals actually measure](/blog/your-evals-wont-save-you/).

And critically: ISO 42001 certification does not equal EU AI Act compliance. Freshfields Bruckhaus Deringer [analyzed the gap](https://technologyquotient.freshfields.com/post/102jcog/eu-ai-act-unpacked-10-iso-42001-a-tool-to-achieve-ai-act-compliance) and concluded that "ISO-compliance does not equal AI Act-compliance, even to the extent there are overlapping requirements." The AI Act requires public registration of high-risk systems, CE marking, EU Declarations of Conformity, and prohibitions on specific practices like social scoring—none of which ISO 42001 addresses. ISO 42001 is not a harmonized standard under the AI Act. Certifying against it does not create a legal presumption of conformity with the regulation.

## Why companies are certifying anyway

Because the alternative is worse.

Italy [fined OpenAI EUR 15 million](https://www.euronews.com/next/2024/12/20/italys-privacy-watchdog-fines-openai-15-million-after-probe-into-chatgpt-data-collection) in December 2024. The Dutch DPA [fined Clearview AI EUR 30.5 million](https://www.autoriteitpersoonsgegevens.nl/en/current/dutch-dpa-imposes-a-fine-on-clearview-because-of-illegal-data-collection-for-facial-recognition) in September 2024. The EU AI Act begins full enforcement in August 2026, with fines up to [EUR 35 million or 7% of global turnover](https://www.europarl.europa.eu/topics/en/article/20230601STO93804/eu-ai-act-first-regulation-on-artificial-intelligence). Enforcement is not hypothetical. It is arriving.

ISO 42001 is the closest thing to a certifiable AI governance framework that exists. It is imperfect. It is also what procurement teams are starting to require. AWS, Google, Microsoft, and Anthropic did not certify because the standard is brilliant. They certified because enterprise sales increasingly require demonstrable AI governance. Right now, this is the only auditable framework on the market.

Certification costs range from [$15,000 for small organizations to over $200,000](https://sprinto.com/blog/iso-42001-certification/) for large enterprises. Organizations with existing ISO 27001 certification can typically reduce that by 30–50%, because the management system infrastructure already exists. The certification race will accelerate as EU AI Act enforcement approaches and procurement teams add 42001 to their vendor requirements.

## What I am still figuring out

Whether the standard produces real governance or expensive paperwork. ISO 27001 has a well-documented problem with checkbox compliance—companies certify, hang the certificate on the wall, and continue operating as before. ISO 42001 has the same vulnerability. An impact assessment template that nobody reads is not governance. It is documentation.

The EU AI Act gap is larger than most companies realize. Companies treating ISO 42001 as a compliance pathway will discover the gap when enforcement begins in August 2026. Harmonized European standards are being developed by CEN/CENELEC, but they are not ready. The question is whether ISO 42001 evolves fast enough to close the gap—or whether a parallel European standard replaces it.

Whether 53 pages can govern a technology that reinvents itself every quarter. The standard was published in December 2023. It does not mention agents, RAG, fine-tuning, or prompt engineering. It operates at a level of abstraction above all of these—which is either its greatest strength or its most fundamental limitation.

---

In November 2024, AWS certified against a 53-page standard most engineers have never read. A hundred companies followed within a year.

The standard is imperfect. The controls are vague. Annex B never quite escapes its ISO 27001 origins. The standard does not map cleanly to the regulation that actually has enforcement teeth.

But underneath the ISO committee language, it encodes real engineering principles: data provenance, impact assessment, lifecycle management, human oversight, third-party governance. These are not compliance requirements. They are the infrastructure that AI systems need to work in production.

The 53 pages are not the point. The infrastructure is.
