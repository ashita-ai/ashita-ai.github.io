---
layout: post
title: "Zero Exposure Is Not Zero Trust"
date: 2026-07-23
category: "architecture"
description: "1Password for Claude is the right primitive: credential access granted at runtime, scoped to a task, kept out of the model. The uncomfortable part is what it proves. The password was never the boundary. Authority is."
---

On July 16, 2026, [1Password and Anthropic announced 1Password for Claude](https://1password.com/press/2026/july/1password-for-claude): a browser integration that lets Claude use approved credentials without those credentials reaching the model, its memory, or Anthropic's systems. The password stays in 1Password. The one-time code stays in 1Password. The user approves each request with a biometric prompt, 1Password injects the credential into the page, and Claude keeps working.

I want to say the unfashionable thing first: this is good. [The engineering details](https://1password.com/blog/1password-for-claude) read like someone listed everything that scares me about agents and credentials and worked the list: task-scoped access instead of standing sessions, a post-autofill scan so no secret is left visible, filled values wiped if a submission fails. I do not want an LLM looking at my TOTP code as if it were another paragraph to summarize.

I am also precisely the customer this was built for. I have told people to use a password manager for a decade, and I run a fleet of agents that act with my authority all day: they commit under my git identity, open pull requests under my name, read my Slack, file my tickets, and query databases I am responsible for. Not one of them knows a single password of mine. They do not need to. They have something better: my sessions.

And I know the instinct an approval prompt trains. The response starts before the review is finished. It is what a thousand harmless approvals teach, and it has to be fought every time the next prompt arrives.

Which is why the line that stayed with me is from 1Password's CTO, Nancy Wang: "The answer isn't handing agents your secrets. It is to let a user give an agent permission to use a credential without letting the agent see it."

Read the second sentence twice. *Permission to use.* Hiding the secret is the easy half, and 1Password just shipped the good version of it. Permission is the hard half, because it was never about the password. The problem is that the agent can act with your authority.

Zero exposure is not zero trust.

## The secret was the handle

For most of computing history, the credential was a useful stand-in for authority. If I had the password, I was probably the user; if I had the session cookie, probably the browser. Security systems learned to protect the credential because possession of it was the fact that mattered.

Agents break that shortcut. A browser agent can use a credential without possessing it — an improvement that separates two things our systems spent decades collapsing: knowledge of a secret and exercise of authority.

Claude does not need to know my Stripe password to read my revenue. The password stays clean; the action lands under my account; the audit log says I did it. The bank does not care whether the password touched a model; it cares that an authenticated session submitted a request.

This is the new boundary. Not the secret. The delegation.

## The browser is a production shell now

The browser agent is not a chatbot with tabs. It is an execution environment attached to a logged-in human. Anthropic's [safety guide](https://support.claude.com/en/articles/12902428-use-claude-in-chrome-safely) for Claude in Chrome is plain about this: prompt injection can hide in the pages Claude reads, whatever is visible in a tab enters the conversation through screenshots, and it recommends avoiding sensitive sites entirely because "Claude can't filter sensitive content out of what it sees." That is the honest version of the contract. The password can stay out of the model while the account data behind the password goes straight in.

We have known what failure looks like for a year. Last August, [Brave's security team demonstrated an attack](https://brave.com/blog/comet-prompt-injection/) on Perplexity's Comet browser: instructions hidden behind a spoiler tag in a Reddit comment. A user clicked "summarize this page." The agent, dutifully summarizing, followed the hidden instructions instead — navigated to account settings, extracted the user's email, opened Gmail, read a one-time code, and posted both back to the attacker as a Reddit reply. Account takeover, by comment section.

Notice what the attacker never obtained: the password. The agent read the OTP the way it reads everything else. Helpfully. A prompt injection does not have to steal the credential if the agent will use the credential for it.

Two days before the 1Password announcement, [Manifold Security reported](https://www.manifold.security/blog/claude-for-chrome-extension-bypass) that in Claude for Chrome v1.0.80, any script with DOM access on claude.ai could construct the task trigger, dispatch a synthetic click, and push Claude toward workflows that read Gmail, Docs, and Calendar. In default mode, Manifold said an approval modal still appeared before sensitive actions; in "Act without asking" mode, the same path ran silently. Reported May 21, acknowledged May 22, and eight releases later "still six lines of JavaScript." Outside reports are not vendor admissions. The durable part is the bug class: at the DOM layer, a trusted user gesture cannot be assumed just because a UI path was taken, and the failure is never "the model knew a password" — it is "something else drove the agent's authority."

## Consent will become the new checkmark

The comforting answer is to keep a human in the loop. Ask before the credential, before the email, before the account change. I believe in that loop. I also think it is about to suffer the fate of every overused approval channel. The first approval means something. The tenth still might. The thousandth is reflex. A biometric prompt is not magic; it is an interruption with a nicer sensor. It proves a finger was present, not that the person understood the downstream action graph. This is the channel-budget problem from [The Alarm Budget](/blog/the-alarm-budget/): every prompt spends a receiver's attention, which is not infinite just because the button says approve.

Claude's [permission guide](https://support.claude.com/en/articles/12902446-claude-in-chrome-permissions-guide) does more than throw a vague "OK?" at the user: manual mode presents a plan naming the websites Claude will use, asks before additional access, and checks before sensitive actions. It is also honest about the other end of the dial: "Skip all approvals" means "Claude doesn't pause to ask, and nothing checks its actions automatically." Manifold scored its bypass 7.7 against defaults and 9.6 with approvals off. The distance between those numbers is the measured value of asking a human. It is also a toggle.

And agents perform sequences, not single actions. The approval happens at the top; the risk accumulates in the middle — login, dashboards, exports, links, whatever instructions the pages contain.

If the only hard boundary is the moment of credential fill, then everything after that is vibes with audit logs.

## What zero trust would require

Zero trust is an abused phrase, but the original shape in [NIST SP 800-207](https://csrc.nist.gov/pubs/sp/800/207/final) survives: no implicit trust, and the system keeps asking whether this subject, action, and context should be allowed now.

Agent delegation needs the same move. The agent should not inherit a human's whole browser-shaped authority from one approved credential use. It should receive a delegation contract — a bounded grant of authority for a named task, with policy attached to every meaningful action in the run. [Contracts as infrastructure](/blog/contracts-as-infrastructure/), with a nervous system attached. It has to answer boring questions, because boring questions are where production systems live: which identity acted, who authorized the run, which credential was used, which reads and writes were allowed, what data could leave the origin where it was read, and what receipt survived after the tab closed.

Not as more modal dialogs — more prompts are how approval channels die. Machine-enforced where possible, human-readable where necessary, scored after the fact. I have written about [provenance](/blog/the-provenance-imperative/) as the ability to trace how you got here. Delegated authority needs the same property at action time.

## The hard part is visible now

This is why I like the launch. When a user pastes a password into an agent prompt, everything is tangled: exposure, memory, action, audit, revocation. Zero-exposure credential use removes one source of chaos, and the remaining problem becomes visible enough to name. The agent is not trusted because it did not see the password. The agent is trusted only to the extent that its delegated authority is bounded, enforced, observed, and revocable.

I do not know how much of this can be solved at the browser-extension layer; if Manifold's finding holds, one trust boundary still depended on a DOM event other code could synthesize. Nor do I know how much authority users will tolerate making explicit. The clean security answer is to define scope, egress, and revocation up front. The clean product answer is one biometric prompt and a happy path. History says the product answer ships first and the security answer arrives one incident at a time.

The password manager is becoming an authority broker, the browser a production shell, the approval prompt an operational budget — none of them bad things, all of them too load-bearing to leave as UX.

Tomorrow one of my agents will ask for approval, and the trained reflex will be there before the policy is. The question in that gap is no longer whether the model saw the password. It is whose authority is about to act, under which contract, and what record will survive.
