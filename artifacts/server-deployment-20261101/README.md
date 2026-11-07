# Actual private-server deployment and first controlled agent round

The accepted runtime commit5bddadf8 was exported as59 source files, about276KB,
into a new project-owned directory on the user's existing local Linux server.
Python3.12.3/C compiler/28 CPUs were observed. No system network/SSH/service
settings or other projects changed. The first58-file package omitted the event
baseline task; its tests failed and its log is retained. The revised package
passed37 specialized tests and three task runs plus verification.

The white-listed deployment-evidence.tar.gz contains696 original regular files:
first-failure log, accepted server bootstrap/tasks and a separate IPv4 candidate
workspace/run. It contains original generated native ELF evidence in task folders,
not standalone tracked build binaries. It excludes server credentials, venvs,
private API storage and unrelated projects. The archive digest/length and sanitized
provider usage are in deployment-summary.json; credentials are not in that file.

Two DeepSeek roles received the same pinned source/interface context independently.
The initial modeler response failed JSON decoding; an explicit controller-reviewed
format correction succeeded, with7808 input tokens actually reported as cache
hits. The critic returned scenarios independently. Before execution, the controller
removed an accepted no-op falsely claiming to be a gap, added missing field-domain
bounds/malformed-IHL handling, and corrected a count3/4 arithmetic error in the
reviewer's expected state. Original candidate JSON and controller-review.json
retain those differences. No model-proposed Python or shell code was executed.

Four unique actual provider requests consumed30519 reported total tokens,
including the invalid first model response. Local gateway deduplication and
request-count/output bounds are implemented; no automatic paid retry occurred.
The initial gateway did not retain the invalid modeler's raw content (only its
failure/usage); this evidence gap is explicit. The gateway was fixed to retain
key-checked raw response data for later requests. Provider output/usage is evidence
of a proposal/cost, not protocol acceptance or proof of overall agent quality.

Controller-reviewed model/ipv4-input.json then passed the ten-stage flow locally
and on the server:4 rules,9 cases,7 independent contract steps, depth6 Z3 safety/
overlap UNSAT, actual generated native execution and exact comparison. It remains
an input-header descriptor slice: checksum arithmetic, addresses/options,
fragmentation/reassembly, raw wire, ICMP and TCP/UDP composition are open.

retained-verification.json records safe unpack and read-only verification of all
four original server jobs against trusted source. It is not a fresh native/solver
run or authenticity attestation. The larger agreed IPv4+TCP/UDP+ARP/ICMP endpoint
implementation is ongoing; see docs/ipv4-endpoint-roadmap.md.
