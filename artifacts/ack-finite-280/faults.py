"""Rehashed finite-case proof controls, never modifying original evidence."""
import importlib.util,json
from pathlib import Path
import shutil,tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('ack_finite_checker',HERE/'check.py')
checker=importlib.util.module_from_spec(spec);spec.loader.exec_module(checker)


def run(original):
    original=Path(original);records=[]
    hashes=lambda root:{str(p.relative_to(root)):checker.c.sha(p)for p in root.rglob('*')if p.is_file()}
    before=hashes(original)
    for kind in ('missing-head-case','false-specialized-query','unproved-local-equivalence','substituted-original'):
        with tempfile.TemporaryDirectory(prefix='ack-finite-fault-')as temp:
            copy=Path(temp)/'copy';shutil.copytree(original,copy)
            if kind=='missing-head-case':
                r=json.loads((copy/'finite/result.json').read_text());r['cases'].pop()
                checker.c.write(copy/'finite/result.json',r)
            elif kind=='false-specialized-query':
                q=copy/'finite/case-00/query.smt2';q.write_text('(assert false)(check-sat)')
                r=json.loads((copy/'finite/result.json').read_text());r['files']['case-00/query.smt2']=checker.c.sha(q)
                checker.c.write(copy/'finite/result.json',r)
            elif kind=='unproved-local-equivalence':
                methods=json.loads((copy/'proof-methods.json').read_text());methods[15]['equivalence_method']='finite_default'
                checker.c.write(copy/'proof-methods.json',methods)
                r=json.loads((copy/'result.json').read_text());r['proof_methods_sha256']=checker.c.sha(copy/'proof-methods.json')
                checker.c.write(copy/'result.json',r)
            else:
                q=copy/'original.smt2';q.write_text('(assert false)(check-sat)')
                r=json.loads((copy/'result.json').read_text());r['source_sha256']=checker.c.sha(q)
                checker.c.write(copy/'result.json',r)
            try:checker.verify(copy)
            except ValueError as error:records.append(dict(fault=kind,status='rejected',reason=str(error)))
            else:raise ValueError('Fault accepted: '+kind)
    if before!=hashes(original):raise ValueError('Original changed')
    return dict(status='all_finite_composite_faults_rejected',controls=records,original_unchanged=True,
                scope='offline proof-evidence negative controls, not more TCP/network executions')

if __name__=='__main__':
    import argparse
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('source',type=Path)
    print(json.dumps(run(p.parse_args().source)))
