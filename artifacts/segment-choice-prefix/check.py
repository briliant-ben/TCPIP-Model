"""A strictly bounded segmentation witness; preserve original full Difference."""
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.capture import normalize
from protocol_lab.flow import digest, read, write, run_scenario
from protocol_lab.ir import load
from protocol_lab.packets import compare
from protocol_lab.profiles import control_packets
from protocol_lab.symbolic import crosscheck_trace, model_hash

HERE = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('original_stream_witness', ROOT / 'ports/lwip-stream/run.py')
original = importlib.util.module_from_spec(spec)
spec.loader.exec_module(original)
source = ROOT / 'artifacts/lwip-stream/four-byte-peer-window'
original_verification = original.verify(source, original.PORT / 'scenarios/four-byte-peer-window.json')
assert original_verification['comparison'] == 'mismatch'
original_difference_hash = digest(source / 'difference.json')
scene_path = ROOT / 'scenarios/segment-choice/choice-two-by-two.json'
scene = read(scene_path)
model = load(ROOT / 'model/tcp-segment-choice.json')
machine = run_scenario(model, scene)
expected = control_packets(machine, scene)
replay = crosscheck_trace(model, machine.trace, HERE / 'symbolic')
assert replay['status'] == 'match'
program = 'import z3,sys;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
command = [sys.executable, '-c', program, str(HERE / 'symbolic/path.smt2')]
process = subprocess.run(command, capture_output=True, text=True, timeout=20)
assert process.returncode == 0 and process.stdout.strip() == 'sat', process.stderr
observed, metadata = normalize(source / 'capture.pcap', read(ROOT / 'packet-profile.json'), expected,
                               origin='external_capture', checksum_policy='strict', projection='tcp-connection-v1')
prefix = [p for p in observed if p['time_ms'] <= 21]
assert len(prefix) == len(expected) == 5
difference = compare(expected, prefix, tolerance_ms=0, projection='tcp-connection-v1')
assert difference['status'] == 'match'
canonical_prefix = [p for p in read(source / 'expected.json') if p['time_ms'] <= 21]
canonical_difference = compare(canonical_prefix, prefix, tolerance_ms=0, projection='tcp-connection-v1')
assert canonical_difference['status'] == 'mismatch'
negatives = []
for field, value in [('payload', [128, 0]), ('seq', 1002), ('time_ms', 22)]:
    mutated = copy.deepcopy(prefix)
    mutated[3][field] = value
    answer = compare(expected, mutated, tolerance_ms=0, projection='tcp-connection-v1')
    assert answer['status'] == 'mismatch'
    negatives.append(dict(field=field, status=answer['status']))
assert digest(source / 'difference.json') == original_difference_hash
write(HERE / 'expected-prefix.json', expected)
write(HERE / 'observed-prefix.json', prefix)
write(HERE / 'difference.json', difference)
write(HERE / 'trace.json', machine.trace)
write(HERE / 'metadata.json', metadata)
result = dict(status='bounded_initial_data_prefix_choice_witness', cutoff_ms=21,
              scope='declared segment counts2+2 match exactly this initial wire prefix; not full capture/API-call/refinement acceptance',
              full_original_comparison='mismatch_preserved',
              original_canonical_prefix_comparison=canonical_difference['status'],
              original_verification=original_verification,
              original_capture_sha256=digest(source / 'capture.pcap'),
              original_report_sha256=digest(source / 'report.json'),
              original_difference_sha256=original_difference_hash,
              model_semantic_sha256=model_hash(model), scene_sha256=digest(scene_path),
              independent_full_byte_query='sat', query_command=command, negative_variants=negatives,
              linux_execution=False, full_stack_complete=False,
              file_hashes={n: digest(HERE / n) for n in ['check.py', 'expected-prefix.json',
                  'observed-prefix.json', 'difference.json', 'trace.json', 'metadata.json',
                  'symbolic/path.smt2', 'symbolic/result.json']})
write(HERE / 'result.json', result)
print(json.dumps({k: result[k] for k in ['status', 'cutoff_ms', 'full_original_comparison', 'negative_variants']}))
