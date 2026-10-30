"""Reachable duplicate-idle-prefix diagnosis, isolated historical expanded IR."""
from pathlib import Path
import hashlib
import json
import sys
import tarfile
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest
from protocol_lab.ir import Machine, load

HERE = Path(__file__).resolve().parent
parent = load(ROOT / 'model/tcp-segment-choice.json')
old_name = 'artifacts/tcp-output-schedule-development/expanded-model.json'
with tarfile.open(HERE / 'historical-snapshot.tar.gz') as archive:
    old_bytes = archive.extractfile(old_name).read()
old_hash = hashlib.sha256(old_bytes).hexdigest()
assert old_hash == read(HERE / 'member-hashes.json')[old_name]
models = {'parent': parent, 'historical': json.loads(old_bytes),
          'current': load(ROOT / 'model/tcp-output-schedule.json')}
scene = read(ROOT / 'scenarios/idle-restart/idle-restart-budget.json')
machines = {n: Machine(m, scene['initial']) for n, m in models.items()}
rules = {t['id']: t for t in parent['transitions']}
rows = []
for step in scene['steps']:
    for m in machines.values():
        if step.get('tick'): m.tick(step['at_ms'])
        else: m.dispatch(step['event'], step.get('fields', {}), step['at_ms'])
    reference = machines['parent']
    if step.get('event') == 'app.transmit':
        rule = rules[reference.trace[-1]['transition']]
        if any('set' in a and a['set']['var'] == 'take' for a in rule['actions']):
            for name in ['historical', 'current']:
                machines[name].dispatch('choice.segment', {'count': reference.values['take']}, step['at_ms'])
    row = {'time_ms': step['at_ms'], 'event': step.get('event', 'tick')}
    for name in ['historical', 'current']:
        m = machines[name]
        differences = {key: {'parent': value, name: m.values[key]}
                       for key, value in reference.values.items()
                       if not key.startswith('choice_') and value != m.values[key]}
        row[name + '_differences'] = differences
        if name == 'current':
            assert not differences, differences
            assert m.state == reference.state and m.timers == reference.timers
    rows.append(row)
assert any('idle_restart_count' in r['historical_differences'] for r in rows)
write(HERE / 'reproduction.json', {'status': 'reachable_historical_duplicate_idle_accounting_current_fixed',
    'steps': rows, 'historical_model_sha256': old_hash,
    'current_model_sha256': digest(ROOT / 'model/tcp-output-schedule.json'),
    'source_sha256': digest(ROOT / 'scenarios/idle-restart/idle-restart-budget.json')})
print('Historical duplicate restart count reproduced; all current shared variables match parent')
