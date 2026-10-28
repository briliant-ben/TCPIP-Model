"""Rebuild the arbitrary-state SAT obligation from isolated historical sources."""
import hashlib
import json
from pathlib import Path
import subprocess
import sys
import tarfile
import tempfile

HERE = Path(__file__).resolve().parent
program = '''
import json,z3
from protocol_lab.ir import load
from protocol_lab.symbolic import Encoding,model_hash
m=load('model/tcp-limited-transmit.json')
e=Encoding(m,1,tuple(m['variables']),byte_encoding='length',sequence_encoding='modular-int',arbitrary_state=True)
e.solver.add(*[e.expr(i['assert'],e.frames[0])for i in m['invariants']])
new=e.frames[1]
post=[e.expr(i['assert'],new)for i in m['invariants']]
post += [z3.Implies(new['active'][n],new['due'][n]>=new['now'])for n in m['timers']]
e.solver.add(z3.Or(z3.Not(z3.And(*post)),*e.action_faults))
j=next(j for j,t in enumerate(m['transitions'])if t['id']=='S-ACK-VALID')
state=z3.IntVal(m['states'].index('ESTABLISHED'))
s=z3.Solver();s.set(timeout=10000)
s.add(*[z3.simplify(z3.substitute(a,(z3.Int('choice_0'),z3.IntVal(j)),(e.frames[0]['state'],state),(new['state'],state)))for a in e.solver.assertions()])
s.add(z3.Int('choice_0')==j,e.frames[0]['state']==state,new['state']==state)
a=s.check();assert a==z3.sat
solution=s.model();failed=[i['id']for i in m['invariants']if not z3.is_true(solution.eval(e.expr(i['assert'],new),model_completion=True))]
assert 'LT-INV-EPOCH'in failed
print(json.dumps(dict(status=str(a),model_semantic_sha256=model_hash(m),failed_invariants=failed,checker_version=z3.get_version_string(),classification='arbitrary invariant-state failure; reachability not established')))
'''

with tempfile.TemporaryDirectory(prefix='lt-historical-reproduction-') as directory:
    root = Path(directory)
    hashes = json.loads((HERE / 'historical-file-hashes.json').read_text())
    with tarfile.open(HERE / 'historical-snapshot.tar.gz') as archive:
        assert len(archive.getmembers()) == len(hashes)
        for member in archive.getmembers():
            name = Path(member.name)
            assert member.isfile() and not name.is_absolute() and '..' not in name.parts
            data = archive.extractfile(member).read()
            assert hashlib.sha256(data).hexdigest() == hashes[member.name]
            target = root / name
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)
    result = subprocess.run([sys.executable, '-c', program], cwd=root,
                            capture_output=True, text=True, timeout=90)
    assert result.returncode == 0, result.stderr
    report = json.loads(result.stdout)
    original = json.loads((root / 'artifacts/limited-transmit-initial-induction/result.json').read_text())
    assert report['model_semantic_sha256'] == original['model_semantic_sha256']
    print(json.dumps(report))
