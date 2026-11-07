# TCP runtime candidate checkpoint

Original server candidate 0059 and review task metadata are retained in original.tar.gz
(SHA256 4a2b64bad6fbdd7649ebf5373f3c349fe5ee0eb6e161285f45712d2cfb28c7e7).
It contains no private provider response, credentials or reasoning text.
Candidate validation: 9 symbolic gate + 4 preflight methods passed on the server.
This is generated-C/adapter evidence, not live TCP.

Review 0060 produced no usable content (length termination, 65,536 completion tokens).
Three distinct smaller review tasks 0061 returned HTTP 500, usage unavailable.
All are terminal; no automatic retry or positive review is claimed.

Controller manual review then fixed integer monotonic metadata, no-contract replay,
actual-scene binding, transition counts versus operation counts, and final native
snapshot/timer binding. Local revised checks: 12 gate + 4 preflight methods pass,
including actual generated C execution and fixed-input independent Z3 replay.
The synthetic snapshot fault test is not network evidence. Original archive remains
unchanged. A dedicated Linux CI workflow is the next live execution gate.
