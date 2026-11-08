# TCP/IPv4 Endpoint Finite Exploration (Prototype Acceptance)

## Overview
This document describes the finite exploration data used within the existing 10-stage flow for the TCP/IPv4 endpoint component. It is strictly bounded and integrated deterministically into the existing pipeline without altering the model, seeds, or oracle. This is not a full implementation, proof, or coverage claim.

## Scope
- The component inherits from a finite one-peer Ethernet IPv4 UDP/Echo base, augmented with a bounded TCP data profile (finite16-byte, SMSS4, immediate ACK, explicit flush, RTO profile).
- The exploration targets only the `COMPOSED` state, representing the state after composition with existing TCP data model fragments. No uncomposed or low-level states are explored.
- It uses a single initial state `{}` and a fixed depth of 2 (exact).
- The selected events are limited to four application-level events: `T.app.connect`, `L.app.resolve`, `L.app.send`, and `T.app.abort`. These cover connection initiation, address resolution, small data send, and abort.
- All fields conform to the existing event schema; byte arrays are expressed as typed `{"bytes": [...]}` expressions. No raw lists, timers, clock advances, or callbacks are injected.

## Exploration Data
- **Depth**: 2
- **Initials**: one empty initial state
- **Cases**: four cases, each with `states: ["COMPOSED"]`:
  1. `T.app.connect` (no fields) – start connection attempt.
  2. `L.app.resolve` with `ip: [192,0,2,2]` – resolve the actual IPv4 address.
  3. `L.app.send` with `data: [1,2,3,4]` – send a small payload.
  4. `T.app.abort` (no fields) – abort the connection attempt.
- This exploration is deliberately tiny: at most 24 prefixes and 24 cases in the bounded generated test set. The controller builds tasks deterministically from this data plus the existing 58 requirement bindings, source hashes, and four frozen seeds.

## Integration with Existing Flow
The exploration data is hashed and added to the pipeline as an input. The original model, seed, and oracle hashes remain unchanged. The controller constructs the task deterministically; no additional budget, retry, or oracle modification is performed. The formal existing task-v2 bounded model checking (BMC) runs with depth 1, fixed empty symbolic initials, and a 10-second budget. If BMC yields UNKNOWN for any property, it remains UNKNOWN; the pipeline continues with all other independent stages. Generated C code is not treated as a compiler proof.

## Limitations and Honest Status
- This exploration does **not** provide full TCP coverage, state coverage, or protocol proof.
- It does **not** test live composed ingress evidence; actual composed peer interaction remains **PENDING** until a real composed peer passes.
- The flow run may be unresolved; no anticipated results are presented as actual.
- The component remains a prototype and is **not finished** until actual composed peer tests pass.
- The existing cutoff/uncovered rules remain visible; no attempt is made to hide or bypass them.
- Legacy network descriptors are retained as unused schema, always marked as model gaps; no descriptor bypass or handwritten codec exists.
- PSH/ACK and other TCP details are bounded by the inherited profile; no general scheduling or framing guarantees are made.

## Conclusion
This exploration provides a minimal, honest, finite set of cases to exercise the composed endpoint within the existing constrained flow. It is a step toward prototype acceptance, not a claim of correctness or completeness.