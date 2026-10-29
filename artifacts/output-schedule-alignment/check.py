"""Fixed-input full wire/service witness, retaining the canonical failure."""
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.capture import normalize
from protocol_lab.flow import digest, read, write
from protocol_lab.ir import load
from protocol_lab.packets import compare
from protocol_lab.profiles import control_packets, profile_inputs
from protocol_lab.symbolic import crosscheck_trace, model_hash
from tools.replay_schedule import replay_inputs

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('original_stream', ROOT / 'ports/lwip-stream/run.py')
original = importlib.util.module_from_spec(spec)
spec.loader.exec_module(original)
source = ROOT / 'artifacts/lwip-stream/four-byte-peer-window'
scene_path = original.PORT / 'scenarios/four-byte-peer-window.json'
scene = read(scene_path)
verification = original.verify(source, scene_path)
assert verification['comparison'] == 'mismatch'
bound = {str(p.relative_to(ROOT)): digest(p) for p in
         [scene_path, source / 'report.json', source / 'capture.pcap', source / 'difference.json']}
model = load(ROOT / 'model/tcp-output-schedule.json')
profile = read(ROOT / 'artifacts/tcp-output-schedule-development/development-profile.json')
inputs = profile_inputs(profile, model)
for path in ['tools/replay_schedule.py', 'tools/build_output_schedule_model.py',
             'artifacts/output-schedule-alignment/check.py',
             'artifacts/output-schedule-alignment/bindings.json',
             'artifacts/output-schedule-alignment/witness.json']:
    inputs[path] = digest(ROOT / path)
witness = read(HERE / 'witness.json')
machine, audit, canonical = replay_inputs(model, scene, witness)
assert canonical['status'] == 'mismatch'
assert [a['source_step'] for a in audit if a['kind'] == 'source'] == list(range(7))
assert sum(a['kind'] == 'choice' for a in audit) == 3
expected = control_packets(machine, scene)
observed, metadata = normalize(source / 'capture.pcap', read(ROOT / 'packet-profile.json'), expected,
    origin='external_capture', checksum_policy='strict', projection='tcp-connection-v1')
assert len(expected) == len(observed) == 9
difference = compare(expected, observed, tolerance_ms=0, projection='tcp-connection-v1')
assert difference['status'] == 'match'
bindings = read(HERE / 'bindings.json')
assert bindings == {'written_bytes': 'svc_written_bytes', 'acknowledged_bytes': 'svc_acked_bytes'}
summary = read(source / 'report.json')['summary']
service = {name: {'observed': summary[name], 'model': machine.values[var]}
           for name, var in bindings.items()}
assert all(v['observed'] == v['model'] for v in service.values())
assert machine.values['svc_abandoned_bytes'] == 0
replay = crosscheck_trace(model, machine.trace, HERE / 'symbolic')
assert replay['status'] == 'match'
program = 'import z3,sys;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
command = [sys.executable, '-c', program, str(HERE / 'symbolic/path.smt2')]
process = subprocess.run(command, capture_output=True, text=True, timeout=20)
assert process.returncode == 0 and process.stdout.strip() == 'sat', process.stderr
negatives = []
for field, value in [('payload', [128, 0]), ('seq', 1002), ('time_ms', 22)]:
    mutated = copy.deepcopy(observed)
    mutated[3][field] = value
    answer = compare(expected, mutated, tolerance_ms=0, projection='tcp-connection-v1')
    assert answer['status'] == 'mismatch'
    negatives.append(dict(field=field, status=answer['status']))
# A fourth segment satisfies the old final contract but contradicts the capture.
alternative = copy.deepcopy(witness)
alternative['steps'].insert(-2, {'at_ms': 30, 'event': 'choice.segment', 'fields': {'count': 2}})
other, _, other_canonical = replay_inputs(model, scene, alternative)
assert other_canonical['status'] == 'match'
other_difference = compare(control_packets(other, scene), observed, tolerance_ms=0,
                           projection='tcp-connection-v1')
assert other_difference['status'] == 'mismatch'
assert other.values['svc_acked_bytes'] != summary['acknowledged_bytes']
for name, sha in bound.items():
    assert digest(ROOT / name) == sha
for name, sha in inputs.items():
    assert digest(ROOT / name) == sha
for name, data in [('trace', machine.trace), ('audit', audit), ('canonical-final', canonical),
                   ('expected', expected), ('observed', observed), ('metadata', metadata),
                   ('difference', difference), ('service', service),
                   ('alternative-canonical-match-wire-mismatch', other_difference)]:
    write(HERE / (name + '.json'), data)
files = ['check.py', 'bindings.json', 'witness.json', 'trace.json', 'audit.json',
         'canonical-final.json', 'expected.json', 'observed.json', 'metadata.json',
         'difference.json', 'service.json', 'alternative-canonical-match-wire-mismatch.json',
         'symbolic/path.smt2', 'symbolic/result.json']
result = dict(status='matched_finite_wire_service_projection_witness_canonical_final_mismatch',
    scope='one fixed seven-input nine-frame capture; whole-segment ACK callback credit only; existential scheduling witness, not implementation refinement',
    canonical_final=canonical, original_comparison='mismatch_preserved',
    original_verification=verification, bound_original_inputs=bound,
    model_semantic_sha256=model_hash(model), independent_full_byte_query='sat',
    input_hashes=inputs, solver_version=__import__('z3').get_version_string(),
    python_version=sys.version,
    query_command=command, negative_variants=negatives,
    alternative_canonical_match_wire_comparison=other_difference['status'],
    linux_execution=False, new_implementation_execution=False, full_stack_complete=False,
    trusted_components=['IR interpreter', 'independent Z3 translator and solver',
        'pinned C compiler/upstream and public API driver', 'PCAP parser, normalizer and comparator',
        'source-step replay adapter and this witness checker'],
    file_hashes={n: digest(HERE / n) for n in files})
write(HERE / 'result.json', result)
print(json.dumps({k: result[k] for k in ['status', 'original_comparison', 'negative_variants']}))
