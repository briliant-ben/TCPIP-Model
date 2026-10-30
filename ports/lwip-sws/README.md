# Independent sender SWS observations

Pinned unmodified lwIP2.2.1, public raw API, memory netif capture, at most16 written bytes/64 commands/12000ms, one-millisecond sys_check_timeouts dispatch. The harness is byte-identical to the existing public sent-event harness; no TUN, upstream patch or PCB observation.

The authoritative model is tcp-sws. Exact source stimuli are consumed once in order with only declared choice events; all byte and send eligibility semantics stay in IR. Three initial scenarios examine full MSS, one tiny write and historical maximum-window shrink. Handwritten expectations distinguish model send time21/221ms and a source-based implementation hypothesis21ms; actual outcomes must be retained if that hypothesis is wrong. All ACK callbacks are predicted at230ms.

Source/compiler/binary/script/model/PCAP/trace/query hashes, exact checksums/order/time, public sent callbacks and independent query regeneration are required. Valid Differences are not execution failures or RFC bug findings. This is not Linux evidence, wire PSH/app.push validation, measured internal SWS state or general implementation conformance. Separate RFC/basic-policy versus lwIP variations are intentionally visible.
