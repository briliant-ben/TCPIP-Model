# UDP/IPv4 payload descriptor through the generic flow

## Specification and controller review

RFC768 (28 August1980), Fields page2 defines length including the8-byte UDP
header, absent checksum representation and checksum padding. Fields page1 defines
optional source port0. User Interface page2 motivates byte service delivery.
RFC1122 (October1989)§4.1.3.4 page78 requires checksum support/default-on and
silent discard of invalid nonzero checksums. Full source hashes are pinned by the
task. This profile accepts absent IPv4 UDP checksums as an explicit choice.
English-to-IR correspondence is reviewed, not proved by source hashes.

Original agents independently proposed IR and six literal scenario contracts.
Controller rejected the first candidate despite those scenarios passing: receive
metadata bounds and4096-byte admission guard were missing. Earlier UNKNOWN and
that failure remain in artifacts/udp-payload-agent-0002. The agent correction had
two unsupported3-term and nodes; controller recorded binary association with all
operands/order unchanged. The corrected0004 candidate passed six native scenarios,
13 literal trace steps, six fixed-input Z3 matches and nine hostile-domain probes;
depth3 safety/overlap UNSAT. Source evidence is in artifacts/udp-payload-agent-0004.
For integration only provenance/scope text and requirement attachments are revised;
protocol guards/actions/variables/events/messages are the accepted candidate's.
The original six scenario files stay byte-identical. A narrative note in reviewer
case02 incorrectly says12 data bytes; its actual literal input has4 data bytes
(12 octets including UDP header), and the expected2-byte delivery is correct.

## Scope and input contract

Protocol IR is the sole authority for all modeled decisions. One READY state,
prebound receive port8080, valid/local fixed IPv4 address context, no timers.
app.send emits identical bytes/ports and length=8+bytes_len(data), with default-on
configurable checksum-presence metadata. Zero source port and empty/odd/NUL payloads
are supported. This descriptor computes no checksum or pseudoheader: sum_valid is
an explicit assumed lower-layer fact. There is no UDP/IP wire codec or PCAP claim.

net.datagram.data is the entire available payload AFTER the UDP header, including
trailing IP padding. Valid uint16 metadata and data<=4096 are required by both
receive guards. Length below8 or greater than8+available data is discarded; valid
receive length selects exactly bytes_slice(data,0,length-8). Nonzero invalid
checksums discard; absent checksum is admitted. Duplicate valid inputs deliver
again. Discards preserve last_data and emit nothing. Invalid metadata is uncovered.
An unbound port is temporarily discarded in this service descriptor; required
ICMP feedback is an explicit implementation gap, not a full-endpoint RFC behavior.

All byte inputs/intermediates have the backend's4096-octet capacity. Oversized
native input parsing reports backend_domain_exceeded; reference admission reports
model_gap. Those diagnostic classes remain distinct. The generator exploration
therefore stays within the byte execution domain; a separate hostile reference
probe checks4097-byte input exclusion. No oracle is relaxed to erase the distinction.
The one-step finite exploration includes typed invalid uint16/app-port inputs;
six multi-step literal seeds cover configuration, padding, content and duplicates.
Depth3 symbolic checking covers defined transitions only, not universal coverage
or unbounded correctness. Missing behavior is not interpreted as a silent drop.

## Acceptance and exclusions

Task source/spec/profile/seed/exploration hashes are fixed before execution. Run
flows/udp-payload.json through the unchanged ten-stage provider-neutral client.
Require source and IR admission, bounded Z3, generated tests, independent reference
contracts, standalone C generate/build/run, exact comparison and traceability,
then read-only verify. Retain real stage failures and evidence from each attempt.

No full UDP compliance, physical/Linux UDP evidence, socket lifecycle, queues,
address/routing/fragmentation/options, checksum arithmetic, ICMP response, complete
IPv4 stack, compiler correctness or unbounded proof is claimed. Payload wire and
cross-layer composition follow after this bounded flow acceptance.
