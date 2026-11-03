# Atomic IPv4 ID receive profile

This explicit IR0.5 extension of udp-wire-receive changes only the atomic ID
admission domain. RFC6864 (February2013)4 defines atomic as DF1/MF0/offset0;
4.1 allows any ID at the source and requires nodes examining headers to ignore
atomic ID for its semantic use. It does not remove IP header checksum validation:
the original twenty header bytes, including their actual ID, still enter it.
Equal ID across datagrams does not imply UDP duplicate suppression. This profile
therefore removes only the equality-to-zero restriction for those two ID octets.

New model/udp-wire-receive-atomic.json is an explicit inherited IR guard extension
with clause/source requirements. The original ID0 model/flows/scenarios/oracles
remain unchanged. All inherited actions, pseudoheader, length and UDP/absent
policy and invariants are identical. DF/MF/offset, TTL64, TOS0/IHL5, tuple, MTU,
UDP surplus exclusions and other boundaries remain as before; non-atomic and
fragmented inputs stay model_gap, not unsupported behavior relabeled as a drop.
No parser callback, packet repair or Linux configuration enforces this policy.

Independent pre-frozen fixtures cover ID1/1234/FFFF, repeated identical ID, wrong
IP checksum after ID changes, plus fragment/non-atomic gaps. Old ID0 fixtures are
regressions. Reference, independent fixed-input exact Z3 and actual generated C
must agree. Flow checks remain bounded payload/drop-empty/overlap properties,
not a universal checksum/compiler or complete IPv4 proof.

The first independent Linux peer run43f4e3d7 observed valid DF1/TTL64 packets with
IDs42967/42968/42972. The old model correctly reported model_gap, not a Linux bug.
Its capture had0 saved packets despite6 filter receipts (capture buffering);
that failed evidence stays invalid, never promoted. Immediate-mode capture changes
only delivery of packet buffers, not protocol/oracle/timing/packet count policy.
Live raw peer bytes are never rewritten to ID0 or used to define expected bytes.
