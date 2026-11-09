# Finite IPv4 prototype delivery contract

This closes the first working experimental prototype, not the entire TCP/IP
standard or the future Formal-Spec-Agent framework. The authoritative model is
`model/ipv4-endpoint-virtual-link.json`: fixed single peer/tuple, Ethernet/ARP,
atomic IPv4 MTU1500, UDP and Echo, finite TCP buffer16/SMSS4. Its previously
published profile, source clauses, excluded inputs and initial configuration do
not change for closeout. No upper application protocol is included.

Delivery requires all of the following independent channels, with original
source/input/output hashes and explicit trust boundaries:

1. Same generated C process exchanges real ARP, TCP data/close, three UDP payload
   sizes and three ICMP Echo sizes with independent Linux peers. Original raw
   frames/PCAP, exact byte/checksum oracle, zero capture drops and complete quiet
   interval/lifecycle evidence must pass. This is already retained in the final
   92896425 Linux observation; it is virtual Ethernet, not physical networking.
2. All 21 original final-profile literal seeds and all 45 unchanged frozen
   component projections pass reference/scenario contracts and generated-C
   comparison in the new ten-stage task. Original frozen inputs are preserved.
3. Directed supplements exercise active/passive/simultaneous close, simultaneous
   open, checksum faults, reset handling and logical TIME-WAIT expiry. These are
   model-derived stimuli, not independent wire or RFC oracles. Domain-negative
   unsupported TCP headers must remain explicit `model_gap` cases; they cannot
   be relabeled as a modeled RFC drop. Reference/native comparison remains exact;
   positive committed paths additionally get fixed-input Z3/replay. A rejected
   input's committed prefix is not a formal proof of the rejection.
4. The new explicitly scoped initialized depth-one formal strategy passes under
   its original per-query budget and its retained evidence verifies. The old
   monolithic UNKNOWN and old task remain unchanged. See
   [the exact scope and trusted base](initial-step-contracts.md).
5. The final matrix reports each of the 335 declared rules as actually observed
   or unobserved, with origin and default/override initialization separated. It
   must not call scenario success, bounded proof or 100% rule coverage full RFC
   correctness. Test-generation exploration and the union of executed literal/
   directed/live traces are separate metrics.

The general flow still requires complete declared-rule exploration for its
`verified_event_slice` assessment. If that metric remains incomplete, the flow
continues to say `unresolved`, even when the independently listed **finite
prototype delivery** channels pass. This contract does not change the flow's
oracle, assessment or hash checks to manufacture a green result. Residual rule
coverage is recorded as an open verification limitation, not unsupported protocol
behavior. No missing rule is asserted unreachable without a checked obligation.

Dynamic routing, fragmentation/reassembly, arbitrary TCP buffers/options,
general congestion/recovery, sockets, IPv6 and upper protocols remain outside
this delivery. The accepted real TCP observation ends at pending TIME-WAIT;
logical expiry supplementation is not a new real-time wait measurement. Existing
TCP/ICMP UNKNOWN, lwIP 2750ms retransmission and LinuxTCP differences stay visible.
The reusable framework repository is separate and begins after this closeout.
