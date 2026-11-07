# Separate Linux ICMP outcomes; UNKNOWN remains UNKNOWN

Source b7ad787450ef364c4c5790ce89788b8d62027095 / tested merge
bd618fde35b044803e795a335cd14a62cd39e57b have the identical full Git tree.
PR run41656635390: immutable-release job125988583175 PASSES; direct job
125988583447 FAILS because depth2 safety remains UNKNOWN at60000ms. Both
use Z3 4.15.4 and byte-identical all-input safety and overlap SMT files.
The passing release's UNSAT answer does not promote the direct UNKNOWN or the
old10s failures. This is a solver/runtime reproducibility gap, not evidence of
an RFC/model violation. No automatic rerun or further time-budget increase.

release.zip has3147 original files (artifact13240975612, SHA256
5920b1eff73ee1f123d53e3f17abeae60d295521b66261135fed20c4dbed1d4e);
flow.zip has271 (artifact13240366470, SHA256
2325ebcdae3d1ac5004630bb606f7407dff32b23c411dd37f13fdaf2e4a3a057).
The immutable release executes130 specialized methods, ten tasks+verify,
15TCPdata+101connection+13ARP+13ICMP native cases (41 fixed-input Z3 query/report
sets), plus nine UDP TX packets/six independent oracles. ICMP flow28cases =
5witnesses+13seeds+10model-gaps,13literal trace steps, five rules covered.
Depth2 safety/overlap UNSAT only checks declared output-bound/drop-empty contracts
on defined transitions, not universal checksum/translation/compiler correctness.

accept.py exports305 named immutable Git blobs, checks package/bootstrap/source,
all ten original flow verifications, full142 native traces/C/ELF/input/output
hashes,41 SMT/report bindings, old UDP observations, and raw equality of the
passing versus UNKNOWN ICMP queries. It runs no archived Python/ELF/solver and
performs no new Linux execution. Authentic CI provenance is separately trusted.
No ICMP network peer/capture, complete ICMP host, physical network, composed
endpoint or server deployment claim. Existing real ARP/UDP peers are separate.
