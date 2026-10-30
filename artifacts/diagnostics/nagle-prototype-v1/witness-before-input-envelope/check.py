"""Retain a same-input basic-Nagle witness; never overwrite parent evidence."""
import copy
import json
from pathlib import Path
import subprocess
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.capture import normalize
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import load, require
from protocol_lab.packets import compare
from protocol_lab.profiles import control_packets
from protocol_lab.symbolic import model_hash
from tools.replay_schedule import replay_inputs
HERE = Path(__file__).resolve().parent
model_path = ROOT / 'model/tcp-nagle.json'
model = load(model_path)
lock = read(ROOT / 'spec/sources/tcp-nagle.json')
require(lock['specification'] == {'rfc': 9293, 'version': 'August2022', 'sections': ['3.7.4', '3.8.6.2.1']}, 'Source scope changed')
for name, sha in lock['sha256'].items(): require(digest(ROOT / name) == sha, 'Primary source changed')
name = 'duplicate-future-no-credit'
original = ROOT / 'artifacts/lwip-service' / name
source_path = ROOT / 'ports/lwip-service/scenarios' / (name + '.json')
source = read(source_path)
previous = ROOT / 'artifacts/lwip-service/segmentation-witnesses/candidates' / (name + '.json')
witness = read(previous)
position = next(i for i, row in enumerate(witness['steps']) if row.get('source_step') == 6)
witness['steps'].insert(position + 1, dict(at_ms=40, event='choice.segment', fields={'count': 2}))
old_hash = digest(original / 'difference.json')
old_service = digest(original / 'receiver-difference.json')
original_report = read(original / 'report.json')
verified = read(ROOT / 'artifacts/lwip-service/verification.json')
verified_row = next(r for r in verified['scenarios'] if r['id'] == name)
require(verified['status'] == 'valid_independent_public_sent_observations'
        and verified_row['report_sha256'] == digest(original / 'report.json'), 'Original execution binding changed')
for filename, sha in original_report['file_hashes'].items(): require(digest(original / filename) == sha, 'Original artifact changed')
machine, audit, canonical = replay_inputs(model, source, witness)
require(canonical['status'] == 'match', 'Canonical observation differs')
require([r['source_step'] for r in audit if r['kind'] == 'source'] == list(range(len(source['steps']))), 'Source mapping differs')
expected = control_packets(machine, source)
actual, metadata = normalize(original / 'capture.pcap', read(ROOT / 'packet-profile.json'), expected,
    origin='external_capture', checksum_policy='strict', projection='tcp-connection-v1')
difference = compare(expected, actual, tolerance_ms=0, projection='tcp-connection-v1')
require(difference['status'] == 'match', 'Full wire differs')
callbacks = [{'time_ms': r['time_ms'], 'bytes': r['after']['variables']['cb_step_bytes']}
             for r in machine.trace if r['after']['variables']['cb_step_bytes']]
require(callbacks == original_report['summary']['sent_events'], 'Timed service differs')
negative = []
packet_index = next(i for i, packet in enumerate(expected) if packet['direction'] == 'out' and packet.get('payload'))
for kind in ['payload', 'time', 'sequence']:
    altered = copy.deepcopy(expected)
    if kind == 'payload': altered[packet_index]['payload'][0] ^= 1
    elif kind == 'time': altered[packet_index]['time_ms'] += 1
    else: altered[packet_index]['seq'] += 1
    answer = compare(altered, actual, tolerance_ms=0, projection='tcp-connection-v1')
    require(answer['status'] == 'mismatch', 'Fault passed: ' + kind)
    negative.append({'fault': kind, 'difference': answer})
for filename, value in [('trace', machine.trace), ('witness', witness), ('audit', audit),
        ('canonical', canonical), ('expected', expected), ('observed', actual), ('metadata', metadata),
        ('difference', difference), ('callbacks', callbacks), ('negative-controls', negative)]:
    write(HERE / (filename + '.json'), value)
command = [sys.executable, str(ROOT / 'artifacts/tcp-sent-ledger-development/trace_worker.py'),
    '--model', str(model_path), '--trace', str(HERE / 'trace.json'), '--out', str(HERE / 'symbolic'),
    '--model-hash', model_hash(model)]
worker = subprocess.run(command, capture_output=True, text=True, timeout=180)
(HERE / 'worker.log').write_text(worker.stdout + worker.stderr)
require(worker.returncode == 0, 'Full-byte trace query failed')
program = 'import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
exported = subprocess.run([sys.executable, '-c', program, str(HERE / 'symbolic/path.smt2')],
                          capture_output=True, text=True, timeout=20)
(HERE / 'export-verification.log').write_text(exported.stdout + exported.stderr)
require(exported.returncode == 0 and exported.stdout.strip() == 'sat', 'Exported query not SAT')
require(digest(original / 'difference.json') == old_hash and digest(original / 'receiver-difference.json') == old_service,
        'Original Difference changed')
inputs = [model_path, source_path, previous, ROOT / 'spec/sources/tcp-nagle.json',
          ROOT / 'docs/tcp-nagle.md', ROOT / 'tools/build_nagle_model.py',
          ROOT / 'tools/replay_schedule.py', ROOT / 'artifacts/tcp-sent-ledger-development/trace_worker.py',
          ROOT / 'artifacts/lwip-service/verification.json', original / 'capture.pcap', original / 'report.json']
inputs.extend(ROOT / p for p in lock['sha256'])
for folder in ['protocol_lab']:
    inputs.extend((ROOT / folder).glob('*.py'))
for filename in ['tcp-sent-ledger.json', 'tcp-output-schedule.json', 'tcp-segment-choice.json']:
    inputs.append(ROOT / 'model' / filename)
write(HERE / 'result.json', dict(status='finite_basic_nagle_full_wire_timed_service_witness',
    model_semantic_sha256=model_hash(model), source_inputs=len(source['steps']), declared_choices=2,
    original_wire_difference_sha256=old_hash, original_service_difference_sha256=old_service,
    callbacks=callbacks, full_byte_export='sat', raw_capture_sha256=digest(original / 'capture.pcap'),
    new_C_execution=False, linux_execution=False, universal_refinement=False,
    scope='basic RFC Nagle, fixed MSS4, exact original inputs; one retained real capture, not all lwIP variants',
    input_hashes={str(p.relative_to(ROOT)): digest(p) for p in inputs},
    file_hashes={str(p.relative_to(HERE)): digest(p) for p in sorted(HERE.rglob('*'))
        if p.is_file() and p.name != 'result.json' and '__pycache__' not in p.parts}))
print('finite_basic_nagle_full_wire_timed_service_witness')
