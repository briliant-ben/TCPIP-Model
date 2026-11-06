# PR8 capture boundary backport

Original failed job124784462166, run41285013344, headcc70a74d:
https://github.com/briliant-ben/TCPIP-Model/actions/runs/41285013344/job/124784462166
Artifact13075035408 original-failure.zip SHA256
aa24089f698e5bc55e31ea30f73b8fea22d3d0e0ed5b8c70b5aa3cb386cca872.
Failure: Quiet observation shorter than source scenario. Original capture remains
invalid; it is not the later d5eeca9f failure with the 83540ns shortfall.

Backport only cdb8bbec capture lifecycle driver/verifier/tests/workflow changes.
Wait until first selected PCAP timestamp plus ORIGINAL declared settle, ensure
capture/socket remain live, record actual stop request and independently recompute.
No oracle/model/hash/tolerance change.16 actual local driver checks pass; fresh
privileged Linux execution on this PR8 head is still required. Static server
DeepSeek reviews are advisory: generic requests for real CI are valid, invented
PR8 numeric measurements/stray files are not evidence. No old failure is promoted.
