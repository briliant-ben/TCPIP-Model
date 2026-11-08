# Prototype closeout and repository boundaries

User decision, 2026-11-08:

- [TCPIP-Model](https://github.com/briliant-ben/TCPIP-Model) retains the TCP/IP
  models, generated C reproduction inputs, simulation, tests, specification
  bindings and original validation evidence.
- [Formal-Spec-Agent](https://github.com/briliant-ben/Formal-Spec-Agent) is the
  destination for the reusable formal protocol agent framework. It is separate
  from the TCP/IP subject implementation.

Finish and review the finite IPv4 prototype before moving common code. The
current repository remains executable during closeout. A future extraction
must select one authoritative implementation of the IR semantics, reference
executor, independent formal backend and C lowering, rather than maintain
divergent copies. TCP/IP should become a version-pinned benchmark/client of
that framework. Whether the integration uses a dependency or a pinned Git
submodule is deferred until the interface and extraction are reviewed.
Historical evidence must keep its original checker and source bindings.

## Remaining prototype acceptance work

The retained 32-case flow is **unresolved**: all-input depth-one formal queries
are UNKNOWN at the declared solver budget, and exploration covers 10/335 rules.
Read-only inspection of the retained successful reference/native comparisons
finds 32 distinct executed rules; their union with the accepted live trace has
36 distinct rules. These are different metrics. Neither is full rule coverage,
specification coverage, a reachability proof or an unbounded correctness proof.

Closeout must retain all original UNKNOWN results, investigate exact query
processing without narrowing the domain or changing contracts, and distinguish
exploration, default-initial execution and initial-override coverage. Missing
rules require actual witnesses or explicit checked unreachable/dead-rule
findings; report changes alone cannot resolve the acceptance gap. Existing
fixed-peer and finite-TCP scope remains explicit. General TCP implementation,
compiler correctness and English-specification-to-IR correctness are not
established by the current evidence.

Server task `ipv4-closeout-20261108-0140` starts two bounded roles: an exact-v1
diagnostic of the unchanged retained full-input queries at the original 10 s
per-query budget, and a pure coverage-accounting helper proposal. Both are
candidate work until their original outputs, tests and scope are reviewed;
neither authorizes changing the flow verdict. The shared original API ledger
is retained, failed/uncertain paid calls are not automatically retried, and
the paused automation stays paused.
