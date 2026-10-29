"""Reproduce the original bound failure from retained IR, then replay the fix."""
from pathlib import Path
import gzip
import hashlib
import json
import shutil
import sys
import tempfile
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from protocol_lab.ir import load
from protocol_lab.flow import read, write, digest
from observe_old import replay

HERE = Path(__file__).resolve().parent
raw = gzip.decompress((HERE / 'historical-model.json.gz').read_bytes())
assert hashlib.sha256(raw).hexdigest() == read(HERE / 'historical-model-sha256.json')['model_sha256']
frozen = read(ROOT / 'artifacts/full-regression-a7866f0b/inputs.json')
for name, sha in frozen.items():
    if name.startswith('model/'):
        assert digest(ROOT / name) == sha, 'Historical parent changed: ' + name
with tempfile.TemporaryDirectory(prefix='sent-ledger-bound-history-') as tmp:
    folder = Path(tmp)
    for path in (ROOT / 'model').glob('*.json'):
        if path.name != 'tcp-sent-ledger.json': shutil.copyfile(path, folder / path.name)
    historical = folder / 'tcp-sent-ledger.json'; historical.write_bytes(raw)
    old, old_result = replay(load(historical))
    assert old_result['status'] == 'model_invariant_failure' and 'CB-INV-MASS' in old_result['error']
    old_state = old.snapshot()
    del old
current, current_result = replay(load(ROOT / 'model/tcp-sent-ledger.json'))
assert current_result == {'status': 'reference_pass', 'callback_bytes': 19}, current_result
write(HERE / 'reproduction.json', dict(status='historical_bound_failure_and_current19_credit_replay',
    historical=old_result, historical_pre_state=old_state, current=current_result,
    current_model_sha256=digest(ROOT / 'model/tcp-sent-ledger.json'),
    historical_model_sha256=hashlib.sha256(raw).hexdigest(),
    scope='concrete model reachability/replay; not a C execution or all-input proof'))
write(HERE / 'current-trace.json', current.trace)
print('Historical callback<=16 rejection reproduced; current exact path releases19')
