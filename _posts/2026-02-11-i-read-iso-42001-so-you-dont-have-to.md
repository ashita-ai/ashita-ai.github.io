---
layout: post
title: "I Read ISO 42001 So You Don't Have To"
date: 2026-02-11
category: "regulation"
---

In November 2024, AWS [became](https://aws.amazon.com/blogs/machine-learning/aws-achieves-iso-iec-420012023-artificial-intelligence-management-system-accredited-certification/) the first major cloud provider to certify against ISO/IEC 42001, a 53-page standard for AI management systems published eleven months earlier. Google Cloud [followed](https://cloud.google.com/blog/products/identity-security/google-clouds-commitment-to-responsible-ai-is-now-iso-iec-certified) in December. Anthropic [in January 2025](https://www.anthropic.com/news/anthropic-achieves-iso-42001-certification-for-responsible-ai). Microsoft [in March](https://techcommunity.microsoft.com/blog/microsoft365copilotblog/microsoft-365-copilot-achieves-isoiec-420012023-certification/4397144).

By late 2025, roughly [a hundred companies](https://www.prnewswire.com/news-releases/automation-anywhere-among-the-first-100-companies-to-earn-certification-of-the-iso-standard-for-ai-governance-and-security-strengthening-its-leadership-in-responsible-ai-management-302610256.html) had certified against a document most engineers have never opened. I read all 79 pages: 53 for 42001, 26 for its companion risk guidance, ISO/IEC 23894. Here is the honest assessment.

## What it is, briefly

ISO 42001 is a certifiable management system standard for organizations that develop, provide, or use AI systems. It follows the same Plan-Do-Check-Act skeleton as ISO 27001 and is designed to bolt on top of it. The substance lives in Annex A: 38 controls across nine domains (policies, internal organization, resources, impact assessment, lifecycle management, data, stakeholder information, AI use, third-party relationships). You do not implement all 38. You write a Statement of Applicability declaring which controls apply, which you exclude, and why. The Statement is the document auditors read.

The companion standard 23894 is guidance, not certifiable. Its value is Annex C: a table mapping risk management activities to each phase of the AI system lifecycle (inception, design, verification, deployment, operation, re-evaluation, retirement). If you build one thing from these two standards, build that table.

## What it gets right

The standard distinguishes two assessments most organizations conflate. **Risk assessment** looks at risks *to the organization*: legal exposure, reputational damage, operational failures. **Impact assessment** looks at consequences *for individuals and societies*: what your AI does to people who may never interact with it directly. The standard uses "shall" language for impact assessment. It is mandatory, recurring, and scoped to the technical and societal context where the system actually runs.

The distinction matters. In 2023, the EEOC settled its first AI discrimination case: iTutorGroup's hiring algorithm [automatically rejected female applicants 55 and older and male applicants 60 and older](https://www.eeoc.gov/newsroom/itutorgroup-pay-365000-settle-eeoc-discriminatory-hiring-suit), filtering out over 200 qualified applicants for a $365,000 settlement. The gendered age thresholds are the detail worth noticing: the algorithm encoded intersectional bias, and no human reviewed the rejections. The risk to the company is a risk assessment concern. The harm to the applicants is an impact assessment concern. Different processes, different stakeholders, different controls. Most AI governance frameworks treat impact assessment as a suggestion. ISO 42001 makes it auditable.

The data provenance controls (A.7.2 through A.7.6) encode what data engineers already know: data contracts, lineage tracking, and quality measures are the infrastructure every AI system needs. The standard's contribution is making them externally enforceable, creating a stick for practices that organizations skip under deadline pressure.

## What it gets wrong

Oxebridge, an ISO certification watchdog, [called it](https://www.oxebridge.com/emma/iso-42001-on-ai-includes-text-plagiarized-from-iso-27001/) "a rushed copy-and-paste of the ISO 27001 standard." They are not entirely wrong. Large sections (leadership commitment, competence, awareness, documented information) are transplanted with minimal modification. The implementation guidance in Annex B often reads like information security advice with "AI" substituted for "information."

The controls are vague where they should be specific. "The organization should define processes for data quality" does not tell you what data quality means for training data versus inference data versus evaluation data. "The organization should consider" appears throughout Annex B. "Consider" is not an auditable requirement.

The standard says nothing about model evaluation methodology, bias detection techniques, or specific testing approaches. It tells you to assess your AI systems. It does not tell you how. For an engineer looking for technical guidance, this is a framework-shaped hole. You still need to decide what [your evals actually measure](/blog/your-evals-wont-save-you/).

And critically: ISO 42001 certification does not equal EU AI Act compliance. Freshfields Bruckhaus Deringer [analyzed the gap](https://technologyquotient.freshfields.com/post/102jcog/eu-ai-act-unpacked-10-iso-42001-a-tool-to-achieve-ai-act-compliance) and concluded that "ISO-compliance does not equal AI Act-compliance, even to the extent there are overlapping requirements." The AI Act requires public registration of high-risk systems, CE marking, EU Declarations of Conformity, and prohibitions on specific practices like social scoring. ISO 42001 addresses none of these. It is not a harmonized standard under the AI Act. Certifying against it does not create a legal presumption of conformity with the regulation.

## Why companies are certifying anyway

Because the alternative is worse.

Italy [fined OpenAI EUR 15 million](https://www.euronews.com/next/2024/12/20/italys-privacy-watchdog-fines-openai-15-million-after-probe-into-chatgpt-data-collection) in December 2024. The Dutch DPA [fined Clearview AI EUR 30.5 million](https://www.autoriteitpersoonsgegevens.nl/en/current/dutch-dpa-imposes-a-fine-on-clearview-because-of-illegal-data-collection-for-facial-recognition) in September 2024. The EU AI Act has been enforcing prohibited AI practices since February 2025, with GPAI obligations live since August 2025. High-risk AI system requirements take effect in August 2026. Fines reach [€35 million or 7% of global turnover for prohibited practices, €15 million or 3% for high-risk violations](https://artificialintelligenceact.eu/article/99/). Enforcement is already underway.

ISO 42001 is the closest thing to a certifiable AI governance framework that exists. It is imperfect. It is also what procurement teams are starting to require. AWS, Google, Microsoft, and Anthropic did not certify because the standard is brilliant. They certified because enterprise sales increasingly require demonstrable AI governance, and right now this is the only auditable framework on the market.

## What I am still figuring out

Whether the standard produces real governance or expensive paperwork. ISO 27001 has a well-documented problem with checkbox compliance: companies certify, hang the certificate on the wall, and continue operating as before. ISO 42001 has the same vulnerability. An impact assessment template that nobody reads is not governance. It is documentation.

Whether the EU AI Act gap is closeable. Companies treating ISO 42001 as a compliance pathway will discover the gap as high-risk enforcement phases in through 2026 and 2027. Harmonized European standards are being developed by CEN/CENELEC, but they are not ready. Either ISO 42001 evolves fast enough to close the gap, or a parallel European standard replaces it.

Whether the standard's abstraction is a feature or a failure mode. ISO 42001 does not mention agents, RAG, fine-tuning, or prompt engineering. That abstraction let it stay relevant through two years of rapid capability shifts. But it also means the hardest governance questions (how do you audit a system that rewrites its own tool use? what does "human oversight" mean for an autonomous agent?) live entirely in the gap between what the standard requires and what an organization chooses to implement.

---

A hundred companies certified against ISO 42001 within a year of AWS going first. Most of them will discover that the certificate is a starting point, not a finish line, especially as EU AI Act high-risk obligations start landing in August 2026 and the gaps between the standard and the regulation become audit findings.

The 53 pages are worth reading anyway. Not because they solve AI governance, but because they force you to write down what you are actually doing: where your data comes from, who your systems affect, what happens when something goes wrong, and who is responsible. Most organizations cannot answer those questions today. The standard does not give you the answers. It gives you a structure for discovering that you do not have them yet.
