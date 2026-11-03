# Retained real Linux ARP peer evidence

Run 41621776194 / job 125869015485 / artifact 13223608824 passed on Linux
7.0.0-1017-azure. Source 8fadeb006dfa9edbfb4e150bbeb84d17b09be163 and tested
merge b3b869251114fb0eb6f58736f4788ee3bb28218e have the identical complete Git
tree. original.zip retains 68 original files; SHA256 is
`e320b2b1fdf640d69eada206a6a122745995191d01ec1ad477956de4d06c8b11`.

Active PID2618 has one initialization and four subsequent operations: C request,
unchanged TAP kernel reply, cache hit and generic clock advance. Passive PID2630
has one initialization and two subsequent operations: Linux ARP request, C reply
and generic clock advance. Each case has two captured/two filtered frames, zero
drops. Quiet capture lasts 100.4107ms and 101.299777ms respectively (>=100ms).
Kernel neighbor confirmation passes in passive mode. All packet bytes, complete
reference/native trace and cache deadlines match. Eight old ARP contract tests
and five live adapter methods passed in the runner (CI log provenance trusted).

Run `.venv/bin/python artifacts/linux-arp-peer-8fadeb00/accept.py` to recheck all
61 immutable Git source bindings, source tree, safe ZIP members, original runtime
verification, compile/C/ELF, one-PID transcript, monotonic clock ledger, reference
trace, full raw TAP/PCAP bytes and Linux neighbor observations. It uses original
Git Python, never archived Python, ELF or solver; it does not rerun Linux. Hashes
establish binding, not authenticity; independent CI provenance is still trusted.

TAP is virtual Ethernet, not physical capture. Only selected untagged ARP is
accepted; other EtherTypes remain separately retained. No live cache expiry,
latency equality, compiler proof, complete ARP host, single cross-layer IR or
complete IPv4 endpoint claim. Existing model depth3 contracts and UDP peer
milestones are separate evidence. Project server remained unreachable (one SSH
connection-refused check this turn); no server deployment or paid API call.
