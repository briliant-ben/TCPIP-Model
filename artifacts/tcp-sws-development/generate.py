"""Finite fixed-input contracts and BMC; no duplicate expanded-model artifact."""
from pathlib import Path
import subprocess
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest, run_scenario
from protocol_lab.ir import load, require
from protocol_lab.profiles import profile_inputs, scenario_paths, control_packets
from protocol_lab.packets import write_pcap, compare
from protocol_lab.capture import normalize
from protocol_lab.symbolic import check, model_hash
HERE = Path(__file__).resolve().parent
MODEL = ROOT / 'model/tcp-sws.json'
WORKER = ROOT / 'artifacts/tcp-sent-ledger-development/trace_worker.py'
profile = read(HERE / 'development-profile.json'); model = load(MODEL)
before = profile_inputs(profile, model)
before.update({str(p.relative_to(ROOT)): digest(p) for p in [HERE / 'generate.py', HERE / 'development-profile.json', WORKER]})
source = read(ROOT / 'spec/sources/tcp-sws.json')
for name, sha in source['sha256'].items(): require(digest(ROOT / name) == sha, 'Primary source changed')
rows = []; artifacts = []
for path in scenario_paths(profile):
    scene = read(path); machine = run_scenario(model, scene)
    packets = control_packets(machine, scene)
    out = HERE / scene['id']; out.mkdir(exist_ok=True)
    write(out / 'trace.json', machine.trace); write(out / 'packets.json', packets)
    write(out / 'scenario.json', scene)
    write_pcap(out / 'model.synthetic.pcap', packets)
    observed, metadata = normalize(out / 'model.synthetic.pcap', read(ROOT / 'packet-profile.json'), packets,
        origin='synthetic', checksum_policy='strict', projection='tcp-connection-v1')
    difference = compare(packets, observed, tolerance_ms=0, projection='tcp-connection-v1')
    require(difference['status'] == 'match', 'Synthetic codec failed')
    write(out / 'normalized.synthetic.json', observed); write(out / 'metadata.json', metadata)
    write(out / 'difference.json', dict(**difference, evidence_scope='synthetic_codec_only'))
    command = [sys.executable, str(WORKER), '--model', str(MODEL), '--trace', str(out / 'trace.json'),
        '--out', str(out / 'symbolic'), '--model-hash', model_hash(model)]
    worker = subprocess.run(command, capture_output=True, text=True, timeout=240)
    (out / 'worker.log').write_text(worker.stdout + worker.stderr)
    require(worker.returncode == 0, 'Fixed-byte worker failed: ' + scene['id'])
    rows.append(dict(id=scene['id'], source=str(path.relative_to(ROOT)), steps=len(machine.trace),
        full_byte_query='sat', codec='synthetic_only', command=command))
    names = ['trace.json', 'packets.json', 'scenario.json', 'model.synthetic.pcap', 'normalized.synthetic.json',
        'metadata.json', 'difference.json', 'worker.log', 'symbolic/path.smt2', 'symbolic/result.json']
    artifacts.extend(out / name for name in names)
formal = check(model, depth=6, out=HERE / 'formal')
artifacts.extend(HERE / 'formal' / name for name in ['result.json', 'model.smt2', 'overlap.smt2'])
require(all(digest(ROOT / name) == sha for name, sha in before.items()), 'Generation inputs changed')
write(HERE / 'report.json', dict(status='fixed_input_pass_formal_pending' if formal['status'] == 'unknown' else 'fixed_input_with_bmc_result',
    profile=profile['id'], model_semantic_sha256=model_hash(model), registered=False,
    scenarios=rows, formal=formal, linux_execution=False, new_independent_execution=False,
    scope='six fixed byte/time contracts; synthetic codec only; BMC is bounded and may remain unknown',
    input_hashes=before, artifact_hashes={str(p.relative_to(HERE)): digest(p) for p in artifacts}))
require(formal['status'] in ['bounded_pass', 'unknown'], 'Primary BMC found a failure; report retained')
print({'status': 'fixed_input_generation_complete', 'scenarios': len(rows), 'formal': formal['status']})
