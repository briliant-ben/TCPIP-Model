# IR-generated complete IPv4/UDP transmit bytes

Actual Linux release1b13a36f12e4cef112e477c52927d1654934e650:228 immutable
source files,96 specialized methods, six full tasks/verify,15 TCPdata native/
fixed-input Z3 cases and101 connection cases pass. New raw transmit task passes
nine cases (2 generated witnesses,6 literal seeds,1 MTU rejection),10 literal
trace steps and nine C-emitted packets. The post-flow gate frames those exact
bytes as PCAP, independently checks fields/checksums/timestamps and compares six
fixed packet oracles. All layout/checksum policy is declarative IR, no UDP C codec.

1746 original server files retain C/ELF/stdout/PCAP/decoded/Difference, hash-bound
bootstrap source, formal queries and source/spec/traceability. Run accept.py with
repo .venv Python: it checks228 immutable Git files, six retained flow jobs,
re-compares116 TCP observations and every UDP PCAP packet against original C
stdout and the fixed oracle using the original Git decoder. It does not execute
archive Python/ELF/solver or claim fresh native execution/authenticity proof.

The first f9472593 Linux release failed due existential sample UNKNOWN, despite
all-input safety and overlap both UNSAT and the PCAP channel passing. Failure
log/source/diagnostic are separately retained; old sample-query artifact was not
exported and the old unittest temp job could not be recovered. New IR0.4 sampling
uses an exact one-event fixed-choice encoding, then any one-event, then original
unrestricted fallback. Only SAT plus reference replay establishes nonvacuity.
Both full-depth/all-input safety and overlap query files are BYTE-IDENTICAL to
original f9472593 diagnostics, explicitly checked by this audit. No protocol
model/invariant/guard/oracle/step count/resource cap was weakened. Sampling
queries/results/hashes are retained. General all-input UNKNOWN still blocks.

Eight transmit methods include strict packet literals, wrong zero mapping,
valid-checksum payload rotation, malformed IP/UDP/PCAP and output/oracle tampering,
and a forced all-input solver exception that must remain UNKNOWN. Prior model
regressions are separate, not whole-repository coverage or unbounded proof.
The independent DeepSeek review has no findings but executed no code; it is not
acceptance/proof and did not review the later witness-search optimization.
Its5562 tokens bring the unchanged12-call ledger to12/83412 known tokens.
Paid-agent channel is now budget-blocked; local model/backend/test work continues.

Scope is fixed tuple/TTL64/DF1/ID0/MTU1500 transmit-only virtual link. RFC6864§4.1
supports arbitrary ID on atomic datagrams. There is no UDP receive, ARP/ICMP,
routing/fragmentation, socket binding, Linux peer or physical-network capture.
PCAP envelopes are recorded from actual C output, not sniffed on a network and
not constructed from reference packets. Old TCP UNKNOWN and2750ms Difference stay.
