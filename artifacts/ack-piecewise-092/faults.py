"""Rehashed composite-evidence rejection controls; original data stays immutable."""
import importlib.util
import json
from pathlib import Path
import shutil
import tempfile

HERE=Path(__file__).resolve().parent
spec=importlib.util.spec_from_file_location('ack_piecewise_check',HERE/'check.py')
checker=importlib.util.module_from_spec(spec);spec.loader.exec_module(checker)


def run(original):
    original=Path(original);records=[]
    before={str(p.relative_to(original)):checker.c.sha(p)for p in original.rglob('*')if p.is_file()}
    for kind in ('missing-Boolean-case','false-normalized-query','wrong-original-target'):
        with tempfile.TemporaryDirectory(prefix='ack-piecewise-fault-')as temp:
            copy=Path(temp)/'evidence';shutil.copytree(original,copy)
            if kind=='missing-Boolean-case':
                record=json.loads((copy/'result.json').read_text());record['cases'].pop()
                checker.c.write(copy/'result.json',record)
            elif kind=='false-normalized-query':
                directory=copy/'case-00';query=directory/'normalized.smt2'
                query.write_text('(assert false)\n(check-sat)\n')
                record=json.loads((directory/'result.json').read_text())
                record['normalized_sha256']=checker.c.sha(query)
                checker.c.write(directory/'result.json',record)
            else:
                query=copy/'parent/group-092.smt2';query.write_text('(assert false)\n(check-sat)\n')
                record=json.loads((copy/'result.json').read_text());record['source_sha256']=checker.c.sha(query)
                checker.c.write(copy/'result.json',record)
            try:checker.verify(copy)
            except ValueError as error:records.append(dict(fault=kind,status='rejected',reason=str(error)))
            else:raise ValueError('Fault accepted: '+kind)
    after={str(p.relative_to(original)):checker.c.sha(p)for p in original.rglob('*')if p.is_file()}
    if before!=after:raise ValueError('Original evidence changed')
    return dict(status='all_composite_faults_rejected',controls=records,original_unchanged=True,
                kernel_checked=False,scope='temporary-copy proof evidence controls, not new network executions')

if __name__=='__main__':
    import argparse
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('source',type=Path)
    print(json.dumps(run(parser.parse_args().source)))
