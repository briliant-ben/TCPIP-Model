"""Unregistered profile with fresh-process fixed-query generation; no TCP host logic."""
from pathlib import Path
import subprocess
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from protocol_lab import profiles
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import load, require
from protocol_lab.symbolic import model_hash
HERE = Path(__file__).resolve().parent
MODEL = ROOT / 'model/tcp-sent-ledger.json'


def primary_sources():
    source = read(ROOT / 'spec/sources/tcp-sent-ledger.json')
    for name, sha in source['sha256'].items():
        require(digest(ROOT / name) == sha, 'Primary source changed: ' + name)
    return source


def isolated(model, trace, out):
    out = Path(out)
    trace_path = out.parent / 'trace.json'
    require(read(trace_path) == trace, 'Worker trace input differs')
    command = [sys.executable, str(HERE / 'trace_worker.py'), '--model', str(MODEL),
        '--trace', str(trace_path), '--out', str(out), '--model-hash', model_hash(model)]
    result = subprocess.run(command, capture_output=True, text=True, timeout=180)
    out.mkdir(parents=True, exist_ok=True)
    (out / 'worker.log').write_text(result.stdout + result.stderr)
    require(result.returncode == 0, 'Trace worker failed: ' + result.stderr)
    return read(out / 'result.json')


profile = dict(id='tcp-sent-ledger-development', model='model/tcp-sent-ledger.json',
    scenarios=['scenarios/sent-ledger'], packetdrill=None, symbolic_replay=True,
    wire_projection='tcp-connection-v1', inductive=False)
model = load(MODEL)
before = profiles.profile_inputs(profile, model)
source = primary_sources()
tools_before = {name: digest(HERE / name) for name in ['generate.py', 'trace_worker.py']}
write(HERE / 'development-profile.json', profile)
write(HERE / 'frozen-inputs.json', before)
write(HERE / 'primary-source-binding.json', source)
write(HERE / 'generation-binding.json', dict(status='incomplete', tool_hashes=tools_before))
profiles.crosscheck_trace = isolated
report = profiles.run_profile(profile, HERE, formal=True, depth=6)
require(before == profiles.profile_inputs(profile, load(MODEL)) and source == primary_sources(), 'Inputs changed')
require(tools_before == {name: digest(HERE / name) for name in tools_before}, 'Generation tools changed')
write(HERE / 'generation-binding.json', dict(status='complete', tool_hashes=tools_before,
    report_sha256=digest(HERE / 'report.json'), input_hashes=before))
print({'status': report['status'], 'scenarios': len(report['scenarios']), 'formal': report['formal']})
