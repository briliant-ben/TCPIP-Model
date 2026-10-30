"""Alternative declared2+2 choices; retain original single4 candidate failures."""
from pathlib import Path
import json
import subprocess
import sys
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import load, require
from protocol_lab.symbolic import model_hash
from protocol_lab.profiles import control_packets
from protocol_lab.capture import normalize
from protocol_lab.packets import compare
from tools.replay_schedule import replay_inputs
HERE = Path(__file__).resolve().parent
PORT = ROOT / 'ports/lwip-service'
BASE = HERE.parent
verification = read(BASE / 'verification.json')
require(verification['status'] == 'valid_independent_public_sent_observations', 'Original observations unverified')
verified = {r['id']: r for r in verification['scenarios']}
model_path = ROOT / 'model/tcp-sent-ledger.json'; model = load(model_path)
rows = []; files = [HERE / 'check.py']
for witness_path in sorted((HERE / 'candidates').glob('*.json')):
    name = witness_path.stem; original = BASE / name
    report = read(original / 'report.json')
    require(digest(original / 'report.json') == verified[name]['report_sha256'], 'Original report changed')
    require(report['comparison'] == 'mismatch', 'Original single4 comparison relabelled')
    old_hash = digest(original / 'difference.json')
    old_service_hash = digest(original / 'receiver-difference.json')
    scene_path = PORT / 'scenarios' / (name + '.json'); scene = read(scene_path)
    machine, audit, canonical = replay_inputs(model, scene, read(witness_path))
    require([a['source_step'] for a in audit if a['kind'] == 'source'] == list(range(len(scene['steps']))), 'Source consumption changed')
    require(sum(a['kind'] == 'choice' for a in audit) == 2, 'Unexpected choice count')
    expected = control_packets(machine, scene)
    actual, metadata = normalize(original / 'capture.pcap', read(ROOT / 'packet-profile.json'), expected,
        origin='external_capture', checksum_policy='strict', projection='tcp-connection-v1')
    difference = compare(expected, actual, tolerance_ms=0, projection='tcp-connection-v1')
    require(difference['status'] == 'match', 'Alternative full wire differs')
    callbacks = [{'time_ms': r['time_ms'], 'bytes': r['after']['variables']['cb_step_bytes']}
                 for r in machine.trace if r['after']['variables']['cb_step_bytes']]
    require(callbacks == report['summary']['sent_events'], 'Alternative service differs')
    # The original source's partial-only callback0 final oracle must still fail.
    require(canonical['status'] == ('mismatch' if name == 'partial-only-no-callback' else 'match'), 'Canonical assessment changed')
    out = HERE / name; out.mkdir(exist_ok=True)
    for filename, value in [('trace', machine.trace), ('audit', audit), ('canonical', canonical),
                             ('expected', expected), ('observed', actual), ('metadata', metadata),
                             ('difference', difference), ('callbacks', callbacks)]:
        write(out / (filename + '.json'), value)
    command = [sys.executable, str(ROOT / 'artifacts/tcp-sent-ledger-development/trace_worker.py'),
        '--model', str(model_path), '--trace', str(out / 'trace.json'), '--out', str(out / 'symbolic'),
        '--model-hash', model_hash(model)]
    process = subprocess.run(command, capture_output=True, text=True, timeout=180)
    (out / 'worker.log').write_text(process.stdout + process.stderr)
    require(process.returncode == 0, 'Alternative full-byte query failed')
    program = 'import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
    exported = subprocess.run([sys.executable, '-c', program, str(out / 'symbolic/path.smt2')],
                              capture_output=True, text=True, timeout=20)
    require(exported.returncode == 0 and exported.stdout.strip() == 'sat', 'Alternative exported query not SAT')
    require(digest(original / 'difference.json') == old_hash and digest(original / 'receiver-difference.json') == old_service_hash,
            'Original oracle/difference changed')
    rows.append(dict(id=name, wire='match', service='match', canonical=canonical,
        original_comparison='mismatch_preserved', original_difference_sha256=old_hash,
        original_service_difference_sha256=old_service_hash,
        original_report_sha256=digest(original / 'report.json'), raw_capture_sha256=digest(original / 'capture.pcap'),
        source_sha256=digest(scene_path), witness_sha256=digest(witness_path), independent_export='sat', command=command))
    files += [witness_path] + [p for p in out.rglob('*') if p.is_file()]
write(HERE / 'result.json', dict(status='three_finite_full_wire_and_timed_service_segmentation_witnesses',
    scenarios=rows, model_semantic_sha256=model_hash(model),
    original_verification_sha256=digest(BASE / 'verification.json'),
    new_implementation_execution=False, linux_execution=False, universal_refinement=False,
    scope='same original source inputs, declared2+2 scheduling candidates; preserve original canonical and single4 failures',
    file_hashes={str(p.relative_to(HERE)): digest(p) for p in files}))
print(json.dumps({'status': 'three_finite_full_wire_and_timed_service_segmentation_witnesses', 'scenarios': len(rows)}))
