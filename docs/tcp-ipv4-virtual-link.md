# Finite TCP receive boundary for a virtual Ethernet link

The canonical model `tcp-ipv4-endpoint.json` remains unchanged. This separate
profile admits an additional representation at the **receive service boundary**:
a complete Ethernet header plus the exact IPv4 total length, with no Ethernet
padding present. It also retains the canonical padded representation.

For TCP ingress only, after all existing fixed tuple, Ethernet, IPv4 and TCP
checks, frame length must be either `14 + IPv4.total_length` or
`max(60, 14 + IPv4.total_length)`. IPv4 total length remains40..1500 and the
complete input remains54..1514 bytes. Arbitrary surplus or truncated data is not
admitted. Sender MAC/IP/port restrictions, checksum/drop policies, sequence
arithmetic, TCP states, variables, actions, timers and invariants are unchanged.
Bare malformed extent and wrong peer inputs remain explicit model gaps, not
assertions of required RFC behavior. Existing checksum-invalid admitted packets
remain silent drops. Other protocols retain their original receive boundaries.

## Specification and observation

[RFC894, Frame Format](https://www.rfc-editor.org/rfc/rfc894#page-1) requires
physical Ethernet payload padding when needed, and excludes that padding from
IPv4 total length. The existing [erratum570](https://www.rfc-editor.org/errata/eid570)
corrects the maximum-length wording; MTU remains1500. Outbound IR-generated
Ethernet frames still include minimum padding. No physical Ethernet minimum or
FCS policy is relaxed or claimed to have changed.

The additional input representation is a **declared finite virtual-link profile**,
not an RFC amendment or a universal TAP guarantee. Actual isolated Linux
run42445362865, source6bf69248, artifact13603282242 observed a checksum-valid
58-byte SYN-ACK: Ethernet14 + IPv420 + TCP24. The canonical model rejected that
raw packet unchanged, while the capture retained4 records, zero drops and the
complete quiet window. Original ZIP SHA-256:
`20a5588b3603481c4535bdf07fea71961ea479915c8af1a0963b822d1dc25d07`.
The original rejection remains evidence and is never upgraded.

The profile's independent frozen oracle includes the actual58-byte input plus
separately labelled offline padded60, synthetic no-options54/wrapped-sequence,
checksum faults, truncation, partial surplus and wrong-MAC cases. Expected
packets use independent standard byte/checksum construction, with no IR imports
or generated-implementation callbacks. Offline padded fixtures are never
submitted instead of original peer bytes and are not Linux measurement evidence.

## Acceptance boundary

All receive policy is explicit typed IR. An offline pure builder may construct
that IR; no Python/runtime codec normalizes or repairs ingress packets. The
adapter forwards original bytes. Existing canonical model/seeds/oracle stay
unchanged. New reference/native/fixed-input Z3 results, source hashes and raw
network evidence must be separately retained. This profile is not complete TCP,
all-protocol coverage, a compiler proof or unbounded protocol correctness.
