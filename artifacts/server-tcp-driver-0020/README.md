# Server DeepSeek TCP driver synthetic acceptance

Original TAR SHA256 61a4ccf1fa708b83d48765be692fceb430c0b672f291ff0663f5e69d4a22cb05.
Frozen driver SHA256 aa5f174a82976625517ef963c4f57117ec0f5655ca456c21c3ef0020bc375a9c.
0020 run/validation-1 is the accepted SECOND round:1 actual unittest/1 real Python
driver call, no errors/failures/skips. validation-0 failed its hardcoded link-1
assumption (that record was ingress SYNACK); preserve its failure. Controller
instruments actual driver call, hashes frozen code before/after and runs original
unittest under CPU/memory/time constraints. Static independent review has no
blocking but notes limited coverage/liveness stubs/order/error-path gaps.

Local integration initially selected round0 and reproduced that failure; round1
was then selected by actual per-round receipts, not by candidate_ready alone.
Only sys.path import setup changed for repository unittest discovery. Driver bytes
unchanged; local round1 test passed. Original archive never executed locally.

Synthetic AF_UNIX/mock actor/application scheduling ONLY. No TCP checksum,
sequence/window/RTO, generated-C or live Linux TCP proof is inferred from this
unit test. The independent finite TCP wire IR and11 frozen scenarios separately
passed7 server tests, actual native C and fixed-input Z3; source-baseline.json
binds those unchanged files. That IR predates DeepSeek work and is NOT falsely
attributed to DeepSeek. Commit CI will independently recheck current Git source.
