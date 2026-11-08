# Finite composed IPv4 virtual-link receive profile

`model/ipv4-endpoint-virtual-link.json` preserves the TCP virtual-link profile and
uses the **unchanged30 UDP/ICMP ingress guards** from the existing pinned
`ipv4-udp-icmp-tap.json` component. Semantic input hashes are recorded by the pure
offline builder `tools/ipv4_endpoint_virtual_link.py`. Only those30 guards and
their source requirements/scope metadata change; actions, state/control domains,
variables, timers, invariants, TCP/ARP guards and generated outbound padding stay
unchanged. Runtime execution uses the explicit resulting JSON, never this builder.

The existing [TAP scope](ipv4-udp-icmp-tap.md) declares exact Ethernet14+IPv4 total
length or canonical padded length, rejecting partial padding and truncation;
malformed length handling precedes extraction. Its RFC894/erratum570 and pinned
Linuxv6.12 TUN/TAP document interpretations remain unchanged. This is a finite
virtual-service assumption, not an RFC amendment, physical minimum relaxation,
universal TAP guarantee or proof about the current runner kernel.

The separate earlier TCP-only virtual model remains unchanged. Actual source
e70fab1b, run42451436092/artifact13605518430 completed TCP and sent an empty UDP
packet which the independent Linux UDP socket received/echoed. The unmodified
42-byte reply was atomically rejected by that earlier model's60-byte UDP entry
boundary. Fifteen capture/filter records, zero drops and raw evidence are retained;
original failed execution is not upgraded. ZIP SHA-256:
`2e95a85a54301bfb5ce35504302a836df7c36be4460428c048cc92eebab97494`.

Acceptance uses the old frozen11 TAP component scenarios after mechanical event/
variable/message qualification, the unchanged10 TCP seeds, boundary negatives,
and new reference/C/fixed-input Z3 results. No expected wire bytes come from the
candidate. A fresh single-C-process Linux TCP/UDP/ICMP exchange is required before
combined peer acceptance. Neither offline replay nor old component observations
constitute new Linux evidence. Existing all-input UNKNOWN/coverage gaps remain.
