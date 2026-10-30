"""Reconstruct each fixed trace/codec and freshly check exact byte queries."""
from pathlib import Path
import subprocess
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest, run_scenario
from protocol_lab.ir import load, require
from protocol_lab.profiles import profile_inputs, scenario_paths, control_packets
from protocol_lab.capture import normalize
from protocol_lab.packets import compare
from protocol_lab.symbolic import model_hash
HERE = Path(__file__).resolve().parent
MODEL = ROOT / 'model/tcp-sws.json'
WORKER = ROOT / 'artifacts/tcp-sent-ledger-development/trace_worker.py'
report = read(HERE / 'report.json'); model = load(MODEL)
profile = read(HERE / 'development-profile.json')
current = profile_inputs(profile, model)
current.update({str(p.relative_to(ROOT)): digest(p) for p in [HERE / 'generate.py', HERE / 'development-profile.json', WORKER]})
require(report['input_hashes'] == current and report['model_semantic_sha256'] == model_hash(model), 'Stale fixed inputs')
for name, sha in report['artifact_hashes'].items(): require(digest(HERE / name) == sha, 'Fixed artifact changed')
require([r['id'] for r in report['scenarios']] == [p.stem for p in scenario_paths(profile)], 'Scenario coverage changed')
rows = []
for row in report['scenarios']:
    scene = read(ROOT / row['source']); machine = run_scenario(model, scene); out = HERE / row['id']
    require(read(out / 'trace.json') == machine.trace and read(out / 'scenario.json') == scene, 'Reference trace changed')
    packets = control_packets(machine, scene)
    require(packets == read(out / 'packets.json'), 'Reference packet changed')
    actual, metadata = normalize(out / 'model.synthetic.pcap', read(ROOT / 'packet-profile.json'), packets,
        origin='synthetic', checksum_policy='strict', projection='tcp-connection-v1')
    require(actual == read(out / 'normalized.synthetic.json') and metadata == read(out / 'metadata.json'), 'Synthetic codec mapping changed')
    difference = compare(packets, actual, tolerance_ms=0, projection='tcp-connection-v1')
    require(dict(**difference, evidence_scope='synthetic_codec_only') == read(out / 'difference.json')
        and difference['status'] == 'match', 'Synthetic Difference changed')
    regenerated = HERE / 'verification' / row['id']; regenerated.mkdir(parents=True, exist_ok=True)
    command = [sys.executable, str(WORKER), '--model', str(MODEL), '--trace', str(out / 'trace.json'),
        '--out', str(regenerated), '--model-hash', model_hash(model), '--equivalent-to', str(out / 'symbolic/path.smt2')]
    worker = subprocess.run(command, capture_output=True, text=True, timeout=240)
    (regenerated / 'worker.log').write_text(worker.stdout + worker.stderr)
    require(worker.returncode == 0, 'Independent full-byte/equivalence check failed: ' + row['id'])
    program = 'import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
    exported = subprocess.run([sys.executable, '-c', program, str(out / 'symbolic/path.smt2')],
        capture_output=True, text=True, timeout=20)
    (regenerated / 'export.log').write_text(exported.stdout + exported.stderr)
    require(exported.returncode == 0 and exported.stdout.strip() == 'sat', 'Exported full-byte query not SAT')
    rows.append(dict(id=row['id'], regenerated_query='sat', original_export='sat',
        equivalence=read(regenerated / 'equivalence.json'), codec='synthetic_only'))
formal = read(HERE / 'formal/result.json')
require(formal == report['formal'] and formal['depth'] == 6
    and formal['model_semantic_sha256'] == model_hash(model)
    and formal['status'] in ['bounded_pass', 'unknown'] and not formal['unbounded_proof'], 'BMC scope changed')
require(all(digest(ROOT / name) == sha for name, sha in current.items()), 'Inputs changed during verification')
write(HERE / 'verification.json', dict(status='valid_sws_fixed_byte_time_evidence',
    scenarios=rows, report_sha256=digest(HERE / 'report.json'), checker_sha256=digest(HERE / 'verify.py'),
    input_hashes=current, primary_bmc=formal['status'], new_independent_execution=False, linux_execution=False,
    file_hashes={str(p.relative_to(HERE)): digest(p) for p in sorted((HERE / 'verification').rglob('*')) if p.is_file()}))
print({'status': 'valid_sws_fixed_byte_time_evidence', 'scenarios': len(rows), 'primary_bmc': formal['status']})
