# First verified Linux kernel terminal-handshake observation

GitHub Actions run41002939358/job123891276976 succeeded for head e62f799d87994e394de4189669558e0f8f5d111c (merge snapshot9191bc970520c0aef7f83fa660f9897c342765ce). The downloaded ZIP matches GitHub artifact12954515481 SHA256 f9c99c677e57fb69e08fe78371bf1269442e36bcc8bc31d1e7a56db83d0b369a.

Linux7.0.0-1017-azure performed the public active-open sequence in a distinct unshare network namespace. Independently captured three real packets have strict checksums and the existing active-open-v1 projection. Runtime verification independently regenerated the reference/query and checked equivalence UNSAT with the actual tool binary present. The strict0ms Difference retains only two time fields:10.055ms SYN+ACK and10.073ms ACK versus model10ms. No model field, oracle or timing tolerance was relaxed.

The observation ends at the three-packet ESTABLISHED boundary before tool cleanup. It does NOT cover the source scenario's later5010ms quiet interval, retransmission after establishment, windows/options/payload, loss/recovery, other protocols or complete TCP. A full quiet-window capture is subsequent work. This is an actual Linux VM/kernel observation, not physical-NIC or remote-peer testing.

The offline-verification.json was produced on the matching e62f799d source checkpoint and does not rerun Linux or recheck the absent CI tool binary. Runtime verification and trusted CI artifact provenance remain separate. Subsequent channel-source changes correctly make current-source verification of this historical snapshot stale; reproduce with the named source checkpoint, not by loosening hashes.
