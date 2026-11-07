# Finite generated-C TCP peer channel (under construction)

exchange.py is server DeepSeek-authored and frozen at aa5f174a. It pumps raw bytes
and mechanical monotonic clock through an existing Session. It does not start
namespaces/peers/capture or implement TCP decisions. All TCP layout/state/guard/
action/retransmission/buffer policy is in model/tcp-wire-endpoint.json.

Only synthetic Python adapter acceptance currently exists. server.py is an
ordinary independent Linux socket peer; capture.py strictly decodes raw IPv4/TCP
PCAP. No live TCP peer success has been demonstrated. The isolated outer harness
is being authored in server candidate tcp-linux-harness-20261107-0022.

TIME-WAIT in this finite observation is FIN exchange observed; the 120000ms
pending deadline remains pending. It is not accelerated/expired or called CLOSED.
Current byte model may reject ordinary piggyback advancing ACK/window data.
Retain that first real counterexample rather than changing peer policy/oracle.
Before execution: fresh namespace proof, one generated-C PID, unchanged TUN bytes,
independent unlimited capture, zero drops, full quiet, capture stop before resource
closure, strict byte/trace/service/source-hash verification. No host networking
changes, synthetic-PCAP-as-evidence or full-stack/compiler-proof claim.

## Live runner (2026-11-07)

`run.py --out NEW_DIRECTORY` generates/compiles the subject and invokes a fresh
Linux network namespace before link configuration. It requires root, TUN, iproute2
and tcpdump. `run.py --verify --out DIRECTORY` reconstructs retained evidence
without executing the archived native binary or invoking Z3 again.

The finite experiment is active open, four-byte binary echo, active close to
TIME-WAIT with its timer still pending. Linux is the independent peer, never the
subject. One generated C process handles the entire exchange. No protocol packet
rewriting or kernel ACK/window/MSS policy forcing is allowed. Actual capture time
and mechanically sampled IR time are separate; no fixed wire latency is promised.
Fixed-input Z3 SAT/replay is not all-input safety or a compiler proof.

Candidate 0059 was reviewed manually after independent API reviews failed
(truncation, then HTTP 500). Sixteen revised local methods pass; these include
actual C/IR/Z3 checks but do not establish live Linux TCP success. The dedicated
`linux-tcp-wire-peer.yml` workflow retains both success and failure evidence.
Existing finite model gaps must be reported, not bypassed in the adapter.
