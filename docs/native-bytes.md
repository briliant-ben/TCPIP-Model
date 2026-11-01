# Direct native bytes and finite string-state backend

`direct-c99-bytes-v2` extends the admitted IR0.1/0.2 atomic-ordered-v1 native
backend with bytes in state, inputs, outputs, equality/inequality, conditional
values, length, concatenation and slicing. Reference execution, independent Z3
semantics and existing protocol IR files are unchanged. The implementation emits
explicit C actions/guards; it does not execute JSON IR, Python or a host stack.

`bytes_slice(a, offset, count)` exactly follows the current authoritative IR:
`a[max(0,offset):max(0,offset)+max(0,count)]`. The third argument is a count, not an
end index. Native clipping computes remaining length without signed addition, so
INT64 extremes do not overflow. Struct values own their contents; assignments and
staged Machine copies cannot alias later mutations. Zero octets are ordinary data.

## Explicit execution domain

Each input/state/intermediate byte value is bounded to4096 octets. Oversized
literals reject generation; runtime parsing/concatenation returns byte_capacity.
No bytes are silently truncated to make them fit. Counts/offsets and ordinary
integers retain the checked signed64 domain. Native line input supports b:HEX
(empty b:), with a declared528384-byte command capacity for64 fields. JSON log
capacity is131072 bytes and timer steps4096 per operation. Snapshot checks reserve
4096 bytes for a valid rejection reply; capacity failure discards all staged state,
timers and observations, including timer steps preceding an external event.

Expressions are bounded to depth64; identity names are UTF8<=256 bytes and contain
no NUL. These are backend domains, not protocol limits. Initial snapshots exceeding
the declared reply domain reject generation. Initial overrides and subsequent
operations check snapshot capacity before committing; large output cannot corrupt
the following JSON error reply.

Scalar string states such as tcp-data's tx_flags are lowered to a closed interned
set of exact source literal values. Integer enum identity preserves full string
equality, including NUL and Unicode; output uses preescaped JSON table entries.
This avoids C-string prefix aliasing. Conditional string selection and assignments
are generated from IR. Initial strings outside this source set reject; arbitrary
string event inputs remain unsupported. The existing TCP wire adapter separately
maps only exact supported flags, preventing a NUL-suffixed flag from passing as S.

Rational, clock-v3, post-action targets and other unadmitted semantics still reject.
Admitting more values does not prove the generator correct for all inputs.

## Run actual TCP data

```
.venv/bin/python examples/run_native_suite.py model/tcp-data.json \
  --scenario-dir scenarios/data --formal-replay --out /tmp/new-native-data-suite
```

The same generated backend runs the15 existing data scenarios and compares exact
transitions, nonzero payload bytes, sequence/ACK/window state, buffers and timers
against separate reference execution. Optional Z3 replay constrains the concrete
inputs/rule choices without assuming poststates, then independently compares its
witness with reference execution. These15 fixed-input matches are not all-input
TCP safety or a proof of C translation. Existing depth6 UNKNOWN reports remain
unchanged; native execution does not promote them. This is event-level native
payload evidence, not native payload PCAP or Linux TCP data evidence.

The byte contract tests also cover all256 octet values, empty input, negative and
extreme offsets/counts, exact/excess capacity, long input lines, malformed hex,
ordered value copies, conditional values, output exhaustion, timer rollback,
NUL/Unicode string content and a same-length byte-order fault. An injected faulty
concat keeps the recombination invariant and length in one test but fails the
independent exact-content reference comparison. Address/undefined sanitizers run
on extreme inputs with leak checks/symbolization disabled; actual bounds/UB checks
remain enabled and halt on error. This is additional testing, not a memory proof.

## Deploy this backend separately

`deploy/package.py --profile native-bytes --source REVIEWED_COMMIT --out NEW`
adds the declared model base chain/local interpretation sources,15 data and101
connection scenario files,
byte/scalar tests and the fixed-input suite driver to the small release. Bootstrap
executes the existing37 tests,14 byte tests and12 scalar tests, the three baseline
flows,15-case independent fixed-input data suite and101-case native connection
regression. The connection regression does not request a new symbolic replay. The prior accepted server
release stays intact; no network/SSH changes or new model API credential is needed.
