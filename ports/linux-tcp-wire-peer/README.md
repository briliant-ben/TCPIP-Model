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
