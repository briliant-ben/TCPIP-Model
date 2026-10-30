"""Reproduce legal-window17 rejection and recheck retained SAT exports."""
import gzip
import hashlib
import json
from pathlib import Path
import shutil
import sys
import tempfile
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import Machine, ModelError, load
HERE = Path(__file__).resolve().parent


def connect(model):
    machine = Machine(model)
    machine.dispatch('app.connect')
    machine.dispatch('net.synack', dict(seq=9000, ack=machine.values['snd_nxt'], window=17), 10)
    return machine


parents = read(HERE / 'parent-hashes.json')
for name, sha in parents.items():
    assert digest(ROOT / name) == sha, 'Historical parent changed: ' + name
raw = gzip.decompress((HERE / 'window16-model.json.gz').read_bytes())
with tempfile.TemporaryDirectory(prefix='sws-window-history-') as tmp:
    folder = Path(tmp)
    for name in parents: shutil.copyfile(ROOT / name, folder / Path(name).name)
    historical = folder / 'tcp-sws.json'; historical.write_bytes(raw)
    try:
        connect(load(historical))
    except ModelError as error:
        assert 'SWS-INV' in str(error)
        old = dict(status='legal_window17_invariant_failure', error=str(error))
    else:
        raise AssertionError('Historical defect did not reproduce')
machine = connect(load(ROOT / 'model/tcp-sws.json'))
assert machine.state == 'ESTABLISHED' and machine.values['sws_max_window'] == 17
write(HERE / 'reproduction.json', dict(status='historical_window17_failure_and_current_acceptance',
    historical=old, current=dict(state=machine.state, maximum=machine.values['sws_max_window']),
    historical_model_sha256=hashlib.sha256(raw).hexdigest(), current_model_sha256=digest(ROOT / 'model/tcp-sws.json'),
    scope='one concrete legal handshake; not reachability of all arbitrary induction prestates'))
write(HERE / 'current-window17-trace.json', machine.trace)
import z3
report = read(HERE / 'window16-component/result.json'); rows = []
for row in report['queries']:
    if row['query'] != 'sat': continue
    path = HERE / 'window16-component' / row['file']
    assert digest(path) == row['sha256']
    solver = z3.Solver(); solver.set(timeout=10000); solver.add(z3.parse_smt2_file(str(path)))
    answer = str(solver.check()); assert answer == 'sat', (row['label'], answer)
    rows.append(dict(label=row['label'], file=row['file'], sha256=row['sha256'], query=answer))
write(HERE / 'sat-export-recheck.json', dict(status='retained_sat_exports_confirmed',
    checker_version=z3.get_version_string(), queries=rows, reachability_proved=False))
print('Old legal-window failure reproduced; current accepts17; SAT exports confirmed:', len(rows))
