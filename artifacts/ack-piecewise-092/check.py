"""Compose exact conditional partitions with universal piecewise modulo proofs."""
import argparse
import hashlib
import json
from pathlib import Path
import sys
import tarfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'formal'))
import conditional_ssa as c
import modular_piecewise as p

PARENT=ROOT/'artifacts/ack-conditional-ssa'
SCOPE='one original ACK violation disjunct092 only; not full RTT/ACK invariant, parent basis, reachability or TCP proof'


def parent_inputs():
    return {name:c.sha(PARENT/name) for name in ('acceptance.json','evidence.tar.gz','members.json')}


def unpack_parent(out):
    record=json.loads((PARENT/'acceptance.json').read_text())
    if c.sha(PARENT/'evidence.tar.gz')!=record['evidence_sha256']or c.sha(PARENT/'members.json')!=record['members_sha256']:
        raise ValueError('Parent evidence changed')
    manifest=json.loads((PARENT/'members.json').read_text())
    selected={name:digest for name,digest in manifest.items()if name=='group-092.smt2'or name.startswith('group-092/')}
    with tarfile.open(PARENT/'evidence.tar.gz','r:gz')as stream:
        for name,digest in selected.items():
            entry=stream.getmember(name);path=Path(name)
            if not entry.isfile()or path.is_absolute()or '..'in path.parts:raise ValueError('Unsafe parent archive')
            data=stream.extractfile(entry).read()
            if hashlib.sha256(data).hexdigest()!=digest:raise ValueError('Parent member changed')
            target=out/path;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(data)
    original=json.loads((ROOT/'artifacts/sent-ledger-single-target-unknown/members.json').read_text())
    if c.sha(out/'group-092.smt2')!=original['group-092.smt2']:raise ValueError('Original disjunct changed')


def produce(out):
    out=Path(out)
    if out.exists():raise ValueError('Use a fresh evidence directory')
    out.mkdir(parents=True);unpack_parent(out/'parent')
    parent=c.verify(out/'parent/group-092',out/'parent/group-092.smt2')
    c.write(out/'parent-verification.json',parent)
    rows=[]
    for index in range(4):
        source=out/f'parent/group-092/case-{index:02}/query.smt2'
        directory=out/f'case-{index:02}'
        produced=p.produce(source,directory)
        checked=p.verify(directory,source)
        c.write(directory/'verification.json',checked)
        answer=c.cli(directory/'normalized.smt2',directory/'query.log')
        fresh=c.cli(directory/'normalized.smt2',directory/'query.independent.log')
        rows.append(dict(case=index,rewrites=produced['rewrite_count'],query=answer,fresh=fresh))
        print(json.dumps(rows[-1]),flush=True)
    closed=all(row['query']['query']=='unsat'and row['fresh']['query']=='unsat'for row in rows)
    result=dict(status='original_disjunct092_unsat_nonvacuous'if closed and parent['context']['query']=='sat'else'unknown',
        source_sha256=c.sha(out/'parent/group-092.smt2'),parent_inputs=parent_inputs(),
        checker_sha256=c.sha(__file__),normalizer_sha256=c.sha(ROOT/'formal/modular_piecewise.py'),
        original_assertions=444,original_target_number=92,cases=rows,
        integer_domain_restricted=False,kernel_checked=False,scope=SCOPE)
    c.write(out/'result.json',result)
    return result


def verify(out):
    out=Path(out);result=json.loads((out/'result.json').read_text())
    if result['parent_inputs']!=parent_inputs()or result['checker_sha256']!=c.sha(__file__)or result['normalizer_sha256']!=c.sha(ROOT/'formal/modular_piecewise.py'):
        raise ValueError('Parent/checker changed')
    if result['scope']!=SCOPE or result['kernel_checked'] is not False or result['integer_domain_restricted'] is not False:
        raise ValueError('Scope or domain changed')
    if result['status']!='original_disjunct092_unsat_nonvacuous'or result['original_target_number']!=92 or result['original_assertions']!=444:
        raise ValueError('No original query closure')
    original=json.loads((ROOT/'artifacts/sent-ledger-single-target-unknown/members.json').read_text())
    if c.sha(out/'parent/group-092.smt2')!=original['group-092.smt2']or result['source_sha256']!=original['group-092.smt2']:
        raise ValueError('Original target changed')
    # Bind the complete conditional source bundle, not just its self-report.
    manifest=json.loads((PARENT/'members.json').read_text())
    for name,digest in manifest.items():
        if name=='group-092.smt2'or name.startswith('group-092/'):
            if c.sha(out/'parent'/name)!=digest:raise ValueError('Original conditional evidence changed')
    parent=c.verify(out/'parent/group-092',out/'parent/group-092.smt2')
    if parent['context']['query']!='sat':raise ValueError('Nonvacuity not reproduced')
    if len(result['cases'])!=4 or [row['case']for row in result['cases']]!=list(range(4)):
        raise ValueError('Incomplete partition')
    checks=[]
    for row in result['cases']:
        index=row['case'];directory=out/f'case-{index:02}'
        source=out/f'parent/group-092/case-{index:02}/query.smt2'
        normalized=p.verify(directory,source)
        if normalized['rewrites']!=row['rewrites']:raise ValueError('Rewrite coverage changed')
        for key,name in (('query','query.log'),('fresh','query.independent.log')):
            if row[key]['query']!='unsat'or c.sha(directory/name)!=row[key]['log_sha256']or (directory/name).read_text().strip()!='unsat':
                raise ValueError('Prior positive result not bound')
        answer=c.cli(directory/'normalized.smt2',directory/'query.acceptance.log')
        if answer['query']!='unsat':raise ValueError('Original query leaf did not independently close')
        checks.append(dict(case=index,normalization=normalized,query=answer))
    return dict(status='valid_original_disjunct092_unsat_nonvacuous',source_sha256=result['source_sha256'],
        context=parent['context'],cases=checks,scope=SCOPE,kernel_checked=False,integer_domain_restricted=False,
        original_primary_reports_replaced=False)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out',required=True,type=Path);parser.add_argument('--verify',action='store_true')
    args=parser.parse_args()
    print(json.dumps(verify(args.out)if args.verify else produce(args.out)))
