---
layout: post
title: "The Implicit Operator"
date: 2026-05-07
category: "architecture"
---

On February 22, 2017, Brandur Leach published a [Stripe engineering post](https://stripe.com/blog/idempotency) explaining the company's `Idempotency-Key` header. He opened with the wire: "Networks are unreliable. We've all experienced trouble connecting to Wi-Fi, or had a phone call drop on us abruptly." The header itself had been live since at least [September 2015](https://docs.stripe.com/changelog/2015-09-03/reuse-idempotency-tokens-alter-error), tightening over time as Stripe caught more of the ways clients misused it.

The framing was about networks. The thing the network actually broke was older. Before the header, the implicit answer to "did the request succeed when the connection died?" was: the operator on the client side will figure it out. Read the response. Check the database. Don't double-charge the customer. The header existed because the operator had been doing that work, and the API was admitting that the contract had been carrying a person it couldn't see.

The unstated participant in most APIs is a competent, attentive human. The wire does what the wire documents. The operator does the rest.

## The pattern

Most public APIs are designed around things they don't say. The 504 is for a human to investigate. The 409 is for a human to resolve. The "operation succeeded but didn't return an ID" is for someone to grep the logs. The pricing page is for someone to read before submitting the query. The `--force` flag is for fingers to type with deliberation.

None of this is in the contract. All of it is in the operator. The contract was always shorter than the practice it described, and the gap was filled by whoever was sitting at the keyboard.

This worked when keyboards had people behind them, and when the volume was low enough that the operator could be in the loop. When a senior engineer at the keyboard misreads a 409, one customer suffers and the engineer learns. When the same misread is encoded in a deploy script that runs once a quarter, the radius is small. When it runs at machine speed against the public API, the radius is the company.

Every primitive that becomes infrastructure is something the operator used to do.

## What the operator was doing

The list is short, and most of it has been hiding in plain sight.

**Knowing whether a retry is safe.** Network ambiguity has existed since the first packet was lost. The pre-2015 answer was: the operator notices, reads the response, decides whether to call again. This is what the [`Idempotency-Key`](https://stripe.com/blog/idempotency) put into the wire — first at Stripe in 2015, now at PayPal, Square, GitHub, AWS, and most production payment APIs. Eleven years of diffusion to standardize one header for one verb.

**Previewing the change before applying it.** When [HashiCorp announced Terraform](https://www.hashicorp.com/en/blog/terraform-announcement) on July 28, 2014, the central feature was not the configuration language. It was the section titled *Safely Iterating with Execution Plans*: "Execution plans show you what changes Terraform plans on making to your infrastructure." The plan was the operator's eyeball before commit, made into a separate verb. Without it, an `apply` was a person reading the configuration file and trusting their reading. With it, the trust moved into the wire.

**Reading the error.** Before [RFC 7807, *Problem Details for HTTP APIs*](https://datatracker.ietf.org/doc/html/rfc7807) (March 2016) and gRPC's [`google.rpc.Status`](https://grpc.io/docs/guides/status-codes/) error model, "what went wrong" was a string for a human to read. If the human couldn't, they paged someone who could. RFC 7807 made the error a machine-readable document with a `type`, a `title`, and a `detail`. gRPC made it a `code`, a `message`, and a `details` array of typed structured payloads. The shift was small in code and large in meaning: the recipient was no longer assumed to be a person.

**Knowing what something costs before doing it.** [BigQuery's `dryRun`](https://cloud.google.com/bigquery/docs/running-queries#dry-run) returns the bytes a query would scan without executing it, and the run itself is free. The operator's intuition — "this query touches a year of data, it'll cost something" — became a preflight call the API answers directly. Most APIs still do not have this. The implicit operator is still expected to know.

**Confirming an irreversible operation.** GNU coreutils added `--preserve-root` to `rm` in [version 6.0](https://lists.gnu.org/archive/html/info-gnu/2006-08/msg00006.html) (August 2006), and within two years it had become [the default](https://www.gnu.org/software/coreutils/manual/html_node/Treating-_002f-specially.html): `rm` now refuses to operate on `/` unless explicitly told otherwise. The behavior change was small. The reasoning was structural. Trusting that no one would ever type `rm -rf /` had failed often enough that the program now had to ask. AWS S3 MFA Delete, GitHub's typed-repo-name confirmation dialog, every dialog asking you to retype the resource name to proceed — same pattern. The operator's deliberation became a token in the protocol.

Each of these was somebody noticing that the operator could no longer carry the weight, and putting the missing weight into the wire.

## Where the operator was already failing

The "competent, attentive operator" was a useful fiction. The historical record is worse than the fiction allowed.

On August 1, 2012, [Knight Capital](https://www.sec.gov/files/litigation/admin/2013/34-70694.pdf) deployed new code to seven of eight servers handling its Retail Liquidity Program. The deploy reused a flag previously used by a dormant function called Power Peg. On the eighth server, the old Power Peg code was still installed. Production traffic hit it. Within forty-five minutes, while attempting to fill 212 small retail orders, Knight's routing system sent more than 4 million executions into the market across 154 stocks for more than 397 million shares. The firm ended the morning with a $3.5 billion long position, a $3.15 billion short position, and a loss the SEC's order documented at over $460 million. The implicit operator — the deploy engineer who was supposed to notice that the eighth server had not been updated, the runbook that was supposed to verify it, the monitoring that was supposed to flag the volume — failed at every layer that was supposed to catch it. The contract said: deploy. The contract did not say: verify the deploy reached every server, or refuse to honor a flag whose previous owner was supposed to be dead.

The [Mars Climate Orbiter](/blog/contracts-as-infrastructure/) had already failed by a related mechanism. The contract said newton-seconds; one party sent pound-force seconds; the implicit operator on the receiving end was supposed to validate the input, and did not. $327.6 million of spacecraft, gone.

[Unity's ad-targeting algorithm](/blog/contracts-as-infrastructure/) ingested malformed data from one client in 2022 and lost an estimated $110 million in revenue. Same mechanism. The implicit operator at the boundary was supposed to notice the schema had drifted. Did not.

Each of these is treated in its own post-mortem as a process failure or a deploy failure. Each is also evidence that the implicit operator was not reliable when the volume was small, the deploy was supervised, and the people involved were senior. The pattern is older than any failure mode the agent era will produce. Agents are not creating it. They are billing for it faster.

## Why the diffusion is slow

None of these primitives are dramatic. Each one looks like an extra parameter, an extra header, an extra verb. The cost is paid in DX complexity at the time the API is designed. The benefit is paid in incidents that don't happen at 3 a.m.

The economics of paying upfront for an absence are bad. The cost is concrete, the benefit is counterfactual. This is why diffusion takes a decade per primitive. APIs that ship without an idempotency story are easy to use until they aren't. APIs that ship without a plan/apply separation are fast to integrate until somebody wants to know what an `apply` is about to do. APIs that return strings instead of structured errors look human-friendly until the human has to write a parser.

The infrastructure properties that have already commoditized — version control, automated testing, deployment [reversibility](/blog/reversibility-as-default/) — paid the same upfront cost and waited the same decade for adoption. Each one externalized something the operator used to do. None of them looked obvious until the cost of not having them passed a threshold no one had measured in advance.

## What survives

The APIs that became infrastructure — [S3, Stripe, POSIX](/blog/contracts-as-infrastructure/) — are the ones that progressively externalized what they once expected the operator to handle. They did not externalize everything. They externalized the parts where the cost of trusting the operator had become measurable. Each generation, a little more of the contract becomes explicit. The operator does not disappear. The contract just gets longer.

The [substrate](/blog/the-fifty-year-stack/) is the other half of the answer. Some of the operator's job is moving down rather than out: into transactional databases that can roll back a write, into ephemeral environments that can be discarded, into snapshot filesystems that turn destruction into a `git checkout`. The post-mortem-driven primitives in the API and the recoverability primitives in the substrate are the same impulse from two directions. Both are admissions that the operator cannot be trusted with the slack the contract leaves.

What survives, in both directions, is whatever does not depend on someone competent and attentive being on the other end of the wire.

## What I am still figuring out

Whether the substrate-layer answer eats more of the API-layer's job than I expect. If every meaningful action runs in a discardable environment with a transactional record, the in-band primitives in the API matter less; the question becomes how to make the blast radius cheap, not how to make the call safe. A possible future is: APIs stay simple, environments do the work. The cost moves to the platform vendor. The operator is still implicit, but the substrate absorbs them.

Whether the operator-implicit pattern is a pathology specific to APIs or a general property of complex systems. Apply the same lens to legal contracts, medical protocols, military doctrine, regulatory regimes — the document is always shorter than the practice, and the practice is always carried by people who eventually fail at the rate the document does not anticipate. Externalizing the unwritten part is a project across all of these domains, not just software.

Whether "operator" is even the right word once the externalization is complete. If the wire carries everything the operator used to do, the operator is not implicit any more — there is no operator, just a richer contract. The word survives because the externalization is never complete and there is always more to take in. Possibly that is the right framing: the operator is the residual, the part of the practice that has not yet been written down. The job of API design, over decades, is to make the residual smaller.

---

On February 22, 2017, Brandur described an unreliable network. The deeper claim is older: operators have always been unreliable too, and pretending otherwise is how distributed systems have failed since the 1960s. Knight Capital lost over $460 million in 45 minutes because the implicit operator was supposed to verify a deploy. Mars Climate Orbiter lost $327.6 million because the implicit operator was supposed to validate units. Stripe shipped a header in 2015 because the implicit operator was supposed to know whether a charge had gone through.

Each in-band primitive is a piece of the operator that the contract finally absorbed. The list is not finished. It will not be finished. The work of making distributed systems durable is the work of writing down what the operator used to do — one header at a time, each one paid for by an incident.
