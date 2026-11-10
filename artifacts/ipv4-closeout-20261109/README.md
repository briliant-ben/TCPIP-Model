# Finite IPv4 closeout evidence

`delivery.json` records **finite_ipv4_prototype_delivery_pass** under
[the fixed prototype delivery contract](../../docs/ipv4-prototype-acceptance.md).
It also retains the general flow's `unresolved` assessment: the declared-input
explorer still observes10/335 rules, while accepted old/new execution evidence
observes **71/335** (all71 have default-initial witnesses). The other264 are open
coverage gaps, not proven unreachable. See `rule-matrix.json` for every rule and
its requirement sources. This is not complete TCP/IP or an unbounded/compiler proof.

Source bcf0ce252de921cbaee037ca56f91ffdeafc361f was validated on Linux using the
original Z3 4.15.4 and10,000ms per-query budget. Its actual77-case ten-stage run
has9 passing stages and an explicitly unresolved exploration stage. All66 frozen
literal seeds plus10 generated witnesses and1 generated rejection pass the
reference/native comparisons. Formal:563 negative queries UNSAT and1 SAT
nonvacuity witness strictly replayed.103 targeted Linux methods pass; this is not
a claim of running every repository test. Independent DeepSeek review has no
blocking/findings, with initialized-depth1 and provenance limitations retained.

The11 frozen directed supplements passed exact reference/C comparison and actual
fixed-input Z3/strict replay (the unsupported-header negative has a committed-prefix
query, not a formal rejection proof). Active/passive/simultaneous close,
simultaneous open, checksum faults, resets and logical TIME-WAIT expiry are checked.
The1 local regression method reruns all11 against fresh generated C. These stimuli
are model-derived, not an independent wire or RFC oracle. Actual network evidence
is the previously accepted same-C Linux25-packet/zero-drop observation, bound to
the same model7d5a8254/C19ce9855; no new network capture is claimed here.

| Original bundle | Files | SHA-256 |
|---|---:|---|
| candidate-originals.tar.gz |824|a10d6aea1ba1b8a17fe208155b856d6ec011b265495684ad1b6bb209df8277be|
| validated-flow-originals.tar.gz |1790|fd90959eb0c3bace3560dac65fcf90ff4ad584d358c8cc57d2a10f6691108e03|
| incomplete-flow-export.tar.gz |1695|8b18482c777a62ae1d8c6eea6547abd6f431a13026388dce626c6a4fa34e576e|

The first bundle retains terminal0165–0178 proposals, original failures and
queries, excluding full working copies/private files. The second retains the
actual0179 flow, frozen inputs, all queries/receipts, C/compile/native outputs,
tests and independent review. The third is an intentionally retained **invalid
export**: the exporter omitted nested frozen workspace inputs. The strict local
verifier rejected it; only export selection was repaired, without rerunning the
protocol/solver or changing any hash check. Every original member in both final
bundles was checked against its manifest.1093 selected source files match exact
Gitbcf0ce25 blobs; generated C remains19ce9855. No archived Python/ELF/solver was
executed. Current trusted code re-rendered the complete canonical plan and replayed
original fixed-input witnesses. `source-audit.json` and `qualification.json` record
these boundaries and earlier rejected source/test drafts.

Hashes and consistent journals are not execution attestation. The report relies
on controlled server execution/CI provenance and the previously accepted network
audit. No key, private ledger or provider reasoning is included. Original UNKNOWN,
lwIP2750ms and LinuxTCP differences are unchanged. Automation remains paused.
