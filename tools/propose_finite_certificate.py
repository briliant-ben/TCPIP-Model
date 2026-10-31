"""Generate untrusted raw-substitution proposals for existing finite checkers.

This generator supplies data, never a protocol callback or custom verifier.
Default finite strategies are explicitly not run here. Every case instead has
source-bound exact-tactic routes for BOTH equivalence and leaf. Acceptance is a
separate query_certificates.verify invocation with the expected original SHA.
"""
import argparse
import json
from pathlib import Path
import sys

ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import finite_specialization as f
import modular_piecewise as p
import query_certificates as q
import tactic_recheck as t
c=f.c


def write_case(terms,variable,value,directory):
    """Bind the local XOR to the proposal as actually serialized and parsed."""
    directory=Path(directory);directory.mkdir()
    guard=variable==value
    derived=c.z3.substitute(c.z3.And(*terms),(variable,c.z3.IntVal(value)))
    query=directory/'query.smt2';query.write_text(c.script(terms+[guard,derived]))
    # SMT printing/parsing can reassociate shared ANDs. Use the proposal that
    # the independent checker will read, rather than the pre-export AST.
    actual_derived=c.read_query(query)[-1]
    c.check_terms(query,terms+[guard,actual_derived])
    expected=[guard,c.z3.Xor(c.z3.And(*terms),actual_derived)]
    equivalence=directory/'equivalence.smt2';equivalence.write_text(c.script(expected))
    c.check_terms(equivalence,expected)


def produce(source,out,recipe):
    source,out=Path(source),Path(out)
    if out.exists():raise ValueError('Use a fresh proposal directory')
    epoch=c.sha(__file__);raw=source.read_bytes();out.mkdir(parents=True)
    (out/'source.smt2').write_bytes(raw)
    proof=out/'proof';proof.mkdir();(proof/'original.smt2').write_bytes(raw)
    p.produce(out/'source.smt2',proof/'modulo')
    normalization=p.verify(proof/'modulo',out/'source.smt2')
    normalized=proof/'modulo/normalized.smt2';terms=c.read_query(normalized)
    variable,values,bounds,target=f.parts(terms,recipe)
    finite=proof/'finite';finite.mkdir();(finite/'source.smt2').write_bytes(normalized.read_bytes())
    (finite/'coverage.smt2').write_text(c.script(bounds+[c.z3.Not(c.z3.Or(*[variable==v for v in values]))]))
    covered=c.cli(finite/'coverage.smt2',finite/'coverage.log')
    if covered['query']!='unsat':raise ValueError('Full finite coverage not proved')
    (finite/'context.smt2').write_text(c.script(terms[:target]+terms[target+1:]))
    context=c.cli(finite/'context.smt2',finite/'context.log')
    cases=[];methods=[];routes=[]
    for index,value in enumerate(values):
        directory=finite/f'case-{index:02}'
        write_case(terms,variable,value,directory)
        not_run=dict(query='unknown',reason='default strategy not run; explicit exact-tactic route selected')
        cases.append(dict(value=value,equivalence=dict(not_run),query=dict(not_run)))
        method=dict(value=value)
        for kind,key,file in (('equivalence','equivalence_method','equivalence.smt2'),('query','method','query.smt2')):
            path=directory/file
            answer=t.produce(path,proof/f'{kind}-tactic-{index:02}')
            method[key]='exact_tactic';method[key+'_source_sha256']=c.sha(path)
            routes.append(dict(value=value,kind=kind,source_sha256=c.sha(path),result=answer))
            print('proposal-route',value,kind,answer['query'],flush=True)
        methods.append(method)
    result=dict(status=f.classify(cases,context),recipe=recipe,source_sha256=c.sha(normalized),
        assertion_count=len(terms),coverage=covered,context=context,cases=cases,
        checker_sha256=c.sha(f.__file__),solver_sha256=c.sha(c.solver_binary()),
        dependencies={name:c.sha(ROOT/'formal'/name)for name in
            ('conditional_ssa.py','modular_normalization.py','tactic_recheck.py','partition_queries.py')},
        timeout_ms=10000,scope=f.SCOPE,kernel_checked=False)
    result['files']={str(path.relative_to(finite)):c.sha(path)for path in sorted(finite.rglob('*'))if path.is_file()}
    c.write(finite/'result.json',result);c.write(proof/'proof-methods.json',methods)
    c.write(out/'certificate.json',dict(format=q.FORMAT,kind='finite',source='source.smt2',proof='proof'))
    if c.sha(__file__)!=epoch:raise ValueError('Proposal generator changed during execution')
    report=dict(status='native_routes_complete_unverified'if all(row['result']['query']=='unsat'for row in routes)else'native_routes_incomplete',
        generator_sha256=epoch,source_sha256=c.sha(out/'source.smt2'),normalization=normalization,routes=routes,
        default_finite_strategy_run=False,independent_certificate_verification_run=False,
        kernel_checked=False,ir_translation_proved=False,whole_protocol_proved=False,
        scope='untrusted finite proposal only; fixed existing checkers must verify coverage, equivalence and every leaf')
    c.write(out/'proposal-result.json',report);return report


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('source',type=Path)
    parser.add_argument('--out',required=True,type=Path);parser.add_argument('--recipe',required=True,type=Path)
    args=parser.parse_args();result=produce(args.source,args.out,json.loads(args.recipe.read_text()))
    print(json.dumps(result),flush=True)
    raise SystemExit(0 if result['status']=='native_routes_complete_unverified'else 2)
