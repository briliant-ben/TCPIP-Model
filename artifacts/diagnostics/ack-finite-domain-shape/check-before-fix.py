"""Original callback-count query: exact modulo plus all declared head values."""
import argparse
import json
from pathlib import Path
import sys
import tarfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'formal'))
import modular_piecewise as p
import finite_specialization as f
c=f.c
ORIGINAL=ROOT/'artifacts/sent-ledger-single-target-unknown'
SCOPE='one original S-ACK-VALID disjunct280: callback count <= retransmission bytes; not whole invariant/ACK/basis/TCP proof'


def inputs():
    return {name:c.sha(ORIGINAL/name)for name in ('members.json','exact-single-disjunct-attempt.tar.gz')}


def recipe(source):
    terms=c.read_query(source);head=f.z3.Int('v_0_cb_head')
    wanted=[0<=head,f.z3.Not(16<=head)];bounds=[]
    for expected in wanted:
        found=[]
        for index,term in enumerate(terms[:-1]):
            for path,expr in c.conjuncts(term):
                if expr.eq(expected):found.append(dict(assertion=index,path=path))
        if not found:raise ValueError('Declared source head bound absent')
        bounds.append(found[0])
    return dict(variable='v_0_cb_head',values=list(range(16)),bounds=bounds,target=len(terms)-1)


def produce(out):
    out=Path(out)
    if out.exists():raise ValueError('Use a fresh evidence directory')
    out.mkdir(parents=True)
    manifest=json.loads((ORIGINAL/'members.json').read_text())
    with tarfile.open(ORIGINAL/'exact-single-disjunct-attempt.tar.gz','r:gz')as stream:
        data=stream.extractfile('group-280.smt2').read()
    source=out/'original.smt2';source.write_bytes(data)
    if c.sha(source)!=manifest['group-280.smt2']:raise ValueError('Original member changed')
    normalized=p.produce(source,out/'modulo');checked=p.verify(out/'modulo',source)
    c.write(out/'modulo-verification.json',checked)
    domain=recipe(out/'modulo/normalized.smt2')
    result=f.produce(out/'modulo/normalized.smt2',out/'finite',domain)
    fresh=f.verify(out/'finite',out/'modulo/normalized.smt2')
    c.write(out/'finite-verification.json',fresh)
    closed=result['status']==fresh['fresh_status']=='exact_finite_query_unsat_nonvacuous'
    report=dict(status='original_disjunct280_unsat_nonvacuous'if closed else'unknown',source_sha256=c.sha(source),
        original_inputs=inputs(),original_assertions=len(c.read_query(source)),
        normalizer_sha256=c.sha(ROOT/'formal/modular_piecewise.py'),finite_checker_sha256=c.sha(ROOT/'formal/finite_specialization.py'),
        checker_sha256=c.sha(__file__),recipe=domain,integer_domain_restricted=False,kernel_checked=False,scope=SCOPE)
    c.write(out/'result.json',report);return report


def verify(out):
    out=Path(out);r=json.loads((out/'result.json').read_text())
    if r['status']!='original_disjunct280_unsat_nonvacuous'or r['scope']!=SCOPE or r['integer_domain_restricted']is not False or r['kernel_checked']is not False:
        raise ValueError('No exact original query closure or altered scope')
    if r['original_inputs']!=inputs()or r['checker_sha256']!=c.sha(__file__)or r['normalizer_sha256']!=c.sha(ROOT/'formal/modular_piecewise.py')or r['finite_checker_sha256']!=c.sha(ROOT/'formal/finite_specialization.py'):
        raise ValueError('Source/checkers changed')
    original=json.loads((ORIGINAL/'members.json').read_text())
    if c.sha(out/'original.smt2')!=original['group-280.smt2']or r['source_sha256']!=original['group-280.smt2']or r['original_assertions']!=444:
        raise ValueError('Original source changed')
    normalized=p.verify(out/'modulo',out/'original.smt2')
    if r['recipe']!=recipe(out/'modulo/normalized.smt2'):raise ValueError('Declared domain binding changed')
    checked=f.verify(out/'finite',out/'modulo/normalized.smt2')
    if checked['producer_status']!=checked['fresh_status']or checked['fresh_status']!='exact_finite_query_unsat_nonvacuous':
        raise ValueError('Full original query did not close')
    return dict(status='valid_original_disjunct280_unsat_nonvacuous',source_sha256=r['source_sha256'],
        normalization=normalized,finite=checked,scope=SCOPE,integer_domain_restricted=False,kernel_checked=False,
        original_unknown_reports_replaced=False)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    parser.add_argument('--verify',action='store_true');args=parser.parse_args()
    print(json.dumps(verify(args.out)if args.verify else produce(args.out)))
