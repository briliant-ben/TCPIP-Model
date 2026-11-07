# Typed construction and actual dispatch conflict checkpoint

Archive SHA256e566bb67de2ad408d9907ef73faf8c97c688235575b5733c588adcc4d1b1059d.
Original0065 completed repairs/receipts/checkers: first rejected unsupported lt,
second rejected five-operand bytes_concat. No failed API was retried. Original
sources and rejected statuses remain unchanged.

0066 made zero API calls: one exact source AST dictionary constructor containing
five byte operands was expanded into four left-associated binary bytes_concat
nodes, preserving operand order and all source outside that span. Original/new
source SHA and exact edit are retained; IR validator and oracle were unchanged.
The resulting IR passed constructor schema validation, then real cold ARP ingress
raised Conflict between L.LOCAL-REPLY-PENDING-QUEUED and
T.WIRE-DROP-SHORT-SYN-SENT. This is an actual reference dispatch conflict, not a
native/solver failure. The validator's coarse stage label still says
restricted_builder_validation; its traceback/candidate-model show the distinction.
No native/fixedZ3/network/whole endpoint pass is claimed.

Before0067 API request, the controller ACTUALLY froze four independent cases to
8f66ce0af1f88072d2de8990dd55b584edad299abc9b5baf55bcf00e6bedb919:
cold/cached/abort plus a twelve-step complete bidirectional TCP close projection.
The fourth case retains all original frozen raw TCP bytes/time, adding only ARP
reply at1ms and exact Ethernet framing; final cache due60001 and original TCP
final timers are explicit. Existing three-case expectations remain unchanged.
New intermediate TCP steps lacking original published timer contracts assert
literal output; final timers are exact. No expected result comes from the new model.
The validator checks this exact fixture hash BEFORE constructing the new candidate.

0067 is a new completed-source semantic correction using exact old/new patches,
authoritative infer() operator signatures and the actual conflict. It must conjoin
the complete declared Ethernet/IPv4/TCP envelope to original TCP ingress rules,
never hide overlap by rule priority or block all TCP ingress. Fixed controller
performs reference/actual generated C/fixed-input independent Z3, then advisory
review only after pass. PID175365 was actually non-zombie with expected command
line in repair round2 at archive time. Snapshot is not current liveness proof.
No force/main merge, peer coercion, oracle/hash relaxation or universal proof.
