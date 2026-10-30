# Linux active-open with the full source quiet window

CI run41004399031/job123895886417 succeeded at head1551c535ef7fd1f8323fcf2a3b3a66a5a57f4a9e / merge snapshot eb7c8cdb19946ffda218dbe8a784bfa88a0d91a5. GitHub artifact12954952097 ZIP SHA256 is5dcfd2bfb4fdc2578666c95ed70f1f40314be2bbce34c9b100b122f00f163147.

Actual Linux7.0.0-1017-azure TCP ran in a checked distinct network namespace. Independent tcpdump had no packet-count cap and captured the entire declared5010ms source interval: observed window5010.89946ms from first SYN to the public-check barrier, zero packets dropped by kernel, three selected handshake packets. The socket remained open until capture stopped, then tool cleanup was released. No extra selected packet was observed in this finite window.

All packetdrill-generated packet expectations, source model, strict checksums and0ms independent Difference remain unchanged. The selected active-open projection matches direction/flags/relative SEQ/ACK; two time differences remain: incoming SYN+ACK10.093ms and final ACK10.131ms versus model10ms. Runtime verification checked the actual pinned tool/compiler bindings, source/query/capture/script/model hashes, namespace and capture lifetime, quiet boundary, reference regeneration and query equivalence UNSAT. Current-source offline verification independently checks saved bindings and queries, without claiming another Linux execution or local CI-binary check.

This is one real Linux VM/kernel test with an injected peer, not physical-NIC, real-peer-loss, TCP data/window/options/payload/recovery, other-protocol or universal correctness evidence. The old e62f snapshot remains a separately scoped three-packet prefix. Original SYN-loss2750ms lwIP Differences and all prior model oracles remain unchanged.

Run faults.py to reject four modified temporary copies even after rehashing metadata: changed reference time, corrupted TCP checksum, shortened quiet window and reintroduced packet-count cap. These are offline negative controls only; original evidence remains immutable. CI artifact provenance and byte integrity are separate from authenticity trust in the runner/toolchain.
