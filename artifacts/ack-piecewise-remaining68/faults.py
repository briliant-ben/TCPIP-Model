"""Reject incomplete partitions, false transformations and upgraded UNKNOWN metadata."""
import importlib.util,json
from pathlib import Path
import shutil,tempfile
HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('ack_partition_checker',HERE/'check.py')
checker=importlib.util.module_from_spec(spec);spec.loader.exec_module(checker)


def run(original):
    original=Path(original);records=[]
    hashes=lambda root:{str(p.relative_to(root)):checker.c.sha(p)for p in root.rglob('*')if p.is_file()}
    before=hashes(original)
    for kind in ('missing-original-partition','false-normalized-query','forged-unknown-upgrade'):
        with tempfile.TemporaryDirectory(prefix='ack-partition-fault-')as temp:
            copy=Path(temp)/'copy';shutil.copytree(original,copy)
            r=json.loads((copy/'result.json').read_text())
            if kind=='missing-original-partition':r['groups'].pop()
            elif kind=='false-normalized-query':
                row=next(x for x in r['groups']if x['accepted_unsat'])
                directory=copy/Path(row['file']).stem;q=directory/'normalized.smt2'
                q.write_text('(assert false)(check-sat)')
                child=json.loads((directory/'result.json').read_text());child['normalized_sha256']=checker.c.sha(q)
                checker.c.write(directory/'result.json',child)
            else:
                row=r['groups'][0]
                if row['disjunct']!=280 or row['accepted_unsat']:raise ValueError('Unexpected first original query')
                directory=copy/'group-280'
                for log in ('query.log','query.independent.log'):(directory/log).write_text('unsat\n')
                row['producer']=dict(query='unsat',log_sha256=checker.c.sha(directory/'query.log'))
                row['fresh']=dict(query='unsat',log_sha256=checker.c.sha(directory/'query.independent.log'))
                row['accepted_unsat']=True;r['accepted_unsat']+=1;r['unknown']-=1
            checker.c.write(copy/'result.json',r)
            try:checker.verify(copy)
            except ValueError as error:records.append(dict(fault=kind,status='rejected',reason=str(error)))
            else:raise ValueError('Fault accepted: '+kind)
    if hashes(original)!=before:raise ValueError('Original changed')
    return dict(status='all_partition_controls_rejected',controls=records,original_unchanged=True,
                scope='temporary-copy query proof controls, not new protocol/implementation evidence')

if __name__=='__main__':
    import argparse
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('source',type=Path)
    print(json.dumps(run(p.parse_args().source)))
