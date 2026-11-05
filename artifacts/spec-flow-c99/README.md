# First native implementation-generation milestone

The current IR model/tcp.json is lowered into standalone C99, compiled by the
recorded local C compiler, then actually executed on four input scenarios.
Handshake, first SYN loss, two SYN losses and 32-bit sequence wrap exactly match
the separate reference execution's transitions, requirements, event fields,
outputs, variables and timers. Only inputs are supplied to the native program.

The generated source and generation/build manifests, compiler logs, exact stdin,
raw native stdout/stderr and per-scenario Difference are retained. The compiler
and original executable SHA are recorded; a local executable is not committed.
Reproduction uses new directories and the commands in docs/spec-flow.md.
verify.py audits retained source bytes and re-evaluates the reference comparison;
it does not rebuild or rerun an absent native executable.

12 actual native tests pass, including atomic rollback after due timers then an
invalid input, conflicts, injection/domain/clock rejection, overflow, escaped
source strings, a real wrong-sequence C mutant, regenerated/rehashed tampering,
and execution with an empty PATH in an isolated directory. A separate scalar
contract uses the same backend; this is not second-spec migration acceptance.
24 legacy flow tests pass. The initial test fixture attempted invalid post-target
semantics and was rejected by the existing IR validator before the new backend;
its log is retained. The corrected test uses a valid IR with an unsupported
extension and verifies explicit backend rejection.

No byte buffers, general TCP data, IPv4 wire execution, PCAP, Linux network
observation, universal generator proof or completed modeling flow is claimed.
Native integers have an explicit checked signed64 domain and resource limits.
The prior model/proof epochs, UNKNOWN results and lwIP differences are unchanged.
