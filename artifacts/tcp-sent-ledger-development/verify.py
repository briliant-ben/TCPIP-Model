"""Fresh source/reference/codec/query reconstruction with persistent query pairs."""
from pathlib import Path
import subprocess
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest, run_scenario, verify_sources
from protocol_lab.ir import load, require
from protocol_lab.profiles import profile_inputs, control_packets
from protocol_lab.claims import verify as verify_claims
from protocol_lab.symbolic import model_hash
from protocol_lab.capture import normalize
from protocol_lab.packets import compare
HERE = Path(__file__).resolve().parent
profile = read(HERE / 'development-profile.json')
report = read(HERE / 'report.json')
model_path = ROOT / profile['model']; model = load(model_path)
tools_before = {name: digest(HERE / name) for name in ['generate.py', 'verify.py', 'trace_worker.py']}
generation = read(HERE / 'generation-binding.json')
require(generation['status'] == 'complete' and generation['report_sha256'] == digest(HERE / 'report.json'), 'Generation incomplete')
require(all(tools_before[name] == sha for name, sha in generation['tool_hashes'].items()), 'Generation tools stale')
require(report['input_hashes'] == profile_inputs(profile, model) == read(HERE / 'frozen-inputs.json'), 'Stale inputs')
primary = read(ROOT / 'spec/sources/tcp-sent-ledger.json')
require(primary == read(HERE / 'primary-source-binding.json'), 'Primary source binding changed')
for name, sha in primary['sha256'].items(): require(digest(ROOT / name) == sha, 'Primary bytes changed')
verify_sources()
for name, sha in report['artifact_hashes'].items():
    path = (HERE / name).resolve()
    require(path.is_relative_to(HERE) and digest(path) == sha, 'Profile artifact changed: ' + name)
verify_claims(model, profile, report, HERE)
rows = []; files = []
for scene in report['scenarios']:
    target = HERE / scene['id']; source = read(target / 'scenario.json')
    machine = run_scenario(model, source); packets = control_packets(machine, source)
    require(machine.trace == read(target / 'trace.json') and packets == read(target / 'packets.json'), 'Reference changed')
    observed, metadata = normalize(target / 'model.synthetic.pcap', read(ROOT / 'packet-profile.json'), packets,
        origin='synthetic', projection='tcp-connection-v1')
    require(observed == read(target / 'normalized.synthetic.json') and metadata == read(target / 'capture-metadata.json'), 'Synthetic codec changed')
    require(compare(packets, observed, tolerance_ms=0, projection='tcp-connection-v1')['status'] == 'match', 'Synthetic codec mismatch')
    out = HERE / 'verification' / scene['id']; out.mkdir(parents=True, exist_ok=True)
    command = [sys.executable, str(HERE / 'trace_worker.py'), '--model', str(model_path),
        '--trace', str(target / 'trace.json'), '--out', str(out), '--model-hash', model_hash(model),
        '--equivalent-to', str(target / 'symbolic/path.smt2')]
    process = subprocess.run(command, capture_output=True, text=True, timeout=180)
    (out / 'worker.log').write_text(process.stdout + process.stderr)
    require(process.returncode == 0, 'Fresh query reconstruction failed: ' + scene['id'] + process.stderr)
    require(read(out / 'equivalence.json')['status'] == 'unsat', 'Query equivalence not proved')
    program = 'import sys,z3;s=z3.Solver();s.set(timeout=10000);s.add(z3.parse_smt2_file(sys.argv[1]));print(s.check())'
    exported = subprocess.run([sys.executable, '-c', program, str(target / 'symbolic/path.smt2')],
                              capture_output=True, text=True, timeout=20)
    require(exported.returncode == 0 and exported.stdout.strip() == 'sat', 'Independent export SAT did not pass')
    rows.append(dict(id=scene['id'], reference='match', synthetic_codec='match_synthetic_only',
        fresh_full_byte_replay='match', equivalence='unsat', independent_export='sat', command=command))
    files += list(out.glob('*'))
files += [HERE / name for name in ['generate.py', 'verify.py', 'trace_worker.py', 'report.json', 'generation-binding.json']]
require(report['input_hashes'] == profile_inputs(profile, load(model_path)), 'Inputs changed during verification')
require(primary == read(ROOT / 'spec/sources/tcp-sent-ledger.json'), 'Primary source lock changed')
for name, sha in primary['sha256'].items(): require(digest(ROOT / name) == sha, 'Primary source changed during verification')
require(tools_before == {name: digest(HERE / name) for name in tools_before}, 'Verification tools changed')
write(HERE / 'development-verification.json', dict(status='valid_unregistered_sent_ledger_fixed_input_evidence',
    input_hashes=report['input_hashes'], primary_sources=primary, scenarios=rows,
    formal=report['formal'], model_semantic_sha256=model_hash(model),
    tool_hashes=tools_before,
    external_implementation_evidence=False, linux_execution=False, protocol_complete=False,
    file_hashes={str(p.relative_to(HERE)): digest(p) for p in files}))
print({'status': 'valid_unregistered_sent_ledger_fixed_input_evidence', 'scenarios': len(rows), 'formal': report['formal']})
