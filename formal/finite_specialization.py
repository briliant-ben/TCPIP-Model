"""Exact finite integer specialization with source-bound coverage proofs.

No original assertion is removed. Coverage uses selected positive source clauses,
not the violation; local equivalence uses only the case equality as a premise.
"""
import argparse
import json
from pathlib import Path

import z3
import conditional_ssa as c

SCOPE='one exported conjunction; finite specialization, not IR/kernel/reachability/protocol proof'


def parts(terms,recipe):
    if set(recipe)!={'variable','values','bounds','target'}:raise ValueError('Unsupported recipe')
    values=recipe['values'];target=recipe['target']
    if type(values)is not list or not 1<=len(values)<=64 or any(type(v)is not int for v in values)or len(set(values))!=len(values):
        raise ValueError('Invalid finite domain')
    if type(target)is not int or not 0<=target<len(terms):raise ValueError('Invalid target')
    seen=set();symbols={}
    def walk(expr):
        if expr.get_id()in seen:return
        seen.add(expr.get_id())
        if not z3.is_app(expr):raise ValueError('Quantifiers unsupported')
        if z3.is_const(expr)and expr.decl().kind()==z3.Z3_OP_UNINTERPRETED:symbols[str(expr)]=expr
        for child in expr.children():walk(child)
    for term in terms:walk(term)
    variable=symbols.get(recipe['variable'])
    if variable is None or variable.sort()!=z3.IntSort():raise ValueError('Finite selector must be a source integer')
    bounds=[]
    for row in recipe['bounds']:
        if set(row)!={'assertion','path'}:raise ValueError('Invalid bound reference')
        index=row['assertion']
        if type(index)is not int or not 0<=index<len(terms)or index==target:raise ValueError('Bound must not use violation')
        options={tuple(path):expr for path,expr in c.conjuncts(terms[index])}
        if tuple(row['path'])not in options:raise ValueError('Bound is not a positive source conjunct')
        bounds.append(options[tuple(row['path'])])
    if not bounds:raise ValueError('No source domain clauses')
    return variable,values,bounds,target


def classify(rows,context):
    if any(row['equivalence']['query']!='unsat'for row in rows):return'local_equivalence_unknown'
    if all(row['query']['query']=='unsat'for row in rows):
        return {'sat':'exact_finite_query_unsat_nonvacuous','unsat':'exact_finite_query_unsat_vacuous','unknown':'exact_finite_query_unsat_context_unknown'}[context['query']]
    return 'sat_not_reachability_proof'if any(row['query']['query']=='sat'for row in rows)else'unknown'


def produce(source,out,recipe):
    source,out=Path(source),Path(out)
    if out.exists():raise ValueError('Use a fresh directory')
    terms=c.read_query(source);variable,values,bounds,target=parts(terms,recipe)
    out.mkdir(parents=True);(out/'source.smt2').write_bytes(source.read_bytes())
    coverage=bounds+[z3.Not(z3.Or(*[variable==value for value in values]))]
    (out/'coverage.smt2').write_text(c.script(coverage))
    covered=c.cli(out/'coverage.smt2',out/'coverage.log')
    if covered['query']!='unsat':raise ValueError('Finite coverage not established: '+covered['query'])
    (out/'context.smt2').write_text(c.script(terms[:target]+terms[target+1:]))
    context=c.cli(out/'context.smt2',out/'context.log')
    rows=[];original=z3.And(*terms)
    for index,value in enumerate(values):
        directory=out/f'case-{index:02}';directory.mkdir()
        guard=variable==value
        derived=z3.simplify(z3.substitute(original,(variable,z3.IntVal(value))))
        (directory/'equivalence.smt2').write_text(c.script([guard,z3.Xor(original,derived)]))
        equivalent=c.cli(directory/'equivalence.smt2',directory/'equivalence.log')
        (directory/'query.smt2').write_text(c.script(terms+[guard,derived]))
        answer=c.cli(directory/'query.smt2',directory/'query.log')if equivalent['query']=='unsat'else dict(query='unknown')
        rows.append(dict(value=value,equivalence=equivalent,query=answer))
        print('finite-case',value,answer['query'],flush=True)
    result=dict(status=classify(rows,context),recipe=recipe,source_sha256=c.sha(source),
        assertion_count=len(terms),coverage=covered,context=context,cases=rows,
        checker_sha256=c.sha(__file__),solver_sha256=c.sha(c.solver_binary()),
        dependencies={name:c.sha(Path(__file__).parent/name)for name in
          ('conditional_ssa.py','modular_normalization.py','tactic_recheck.py','partition_queries.py')},
        timeout_ms=10000,scope=SCOPE,kernel_checked=False)
    result['files']={str(p.relative_to(out)):c.sha(p)for p in sorted(out.rglob('*'))if p.is_file()}
    c.write(out/'result.json',result);return result


def verify(out,source=None):
    out=Path(out);r=json.loads((out/'result.json').read_text())
    if r['checker_sha256']!=c.sha(__file__)or r['solver_sha256']!=c.sha(c.solver_binary()):raise ValueError('Checker/solver changed')
    dependencies={name:c.sha(Path(__file__).parent/name)for name in
      ('conditional_ssa.py','modular_normalization.py','tactic_recheck.py','partition_queries.py')}
    if dependencies!=r['dependencies']or r['scope']!=SCOPE or r['kernel_checked']is not False or r['timeout_ms']!=10000:
        raise ValueError('Dependency/scope/budget changed')
    files={str(p.relative_to(out)):c.sha(p)for p in sorted(out.rglob('*'))if p.is_file()
           and p.name!='result.json'and not p.name.endswith('.independent.log')}
    if files!=r['files']:raise ValueError('File coverage/binding changed')
    if c.sha(out/'source.smt2')!=r['source_sha256']or source is not None and c.sha(source)!=r['source_sha256']:
        raise ValueError('Expected source changed')
    terms=c.read_query(out/'source.smt2');variable,values,bounds,target=parts(terms,r['recipe'])
    if len(terms)!=r['assertion_count']:raise ValueError('Assertion count changed')
    if len(r['cases'])!=len(values)or [row['value']for row in r['cases']]!=values:raise ValueError('Missing/duplicated cases')
    c.check_terms(out/'coverage.smt2',bounds+[z3.Not(z3.Or(*[variable==value for value in values]))])
    covered=c.cli(out/'coverage.smt2',out/'coverage.independent.log')
    if r['coverage']['query']!='unsat'or covered['query']!='unsat':raise ValueError('Finite coverage not independently proved')
    c.check_terms(out/'context.smt2',terms[:target]+terms[target+1:])
    context=c.cli(out/'context.smt2',out/'context.independent.log')
    if r['context']['query']=='sat'and context['query']!='sat':raise ValueError('Nonvacuity not independently reproduced')
    original=z3.And(*terms);rows=[]
    for index,(value,old)in enumerate(zip(values,r['cases'])):
        directory=out/f'case-{index:02}';guard=variable==value
        actual=c.read_query(directory/'query.smt2');derived=actual[-1]
        c.check_terms(directory/'query.smt2',terms+[guard,derived])
        c.check_terms(directory/'equivalence.smt2',[guard,z3.Xor(original,derived)])
        eq=c.cli(directory/'equivalence.smt2',directory/'equivalence.independent.log')
        answer=c.cli(directory/'query.smt2',directory/'query.independent.log')if eq['query']=='unsat'else dict(query='unknown')
        for key,current in (('equivalence',eq),('query',answer)):
            if old[key]['query']=='unsat'and current['query']!='unsat':raise ValueError('UNSAT not independently reproduced')
        rows.append(dict(value=value,equivalence=eq,query=answer))
    if r['status']!=classify(r['cases'],r['context']):raise ValueError('Inconsistent classification')
    return dict(status='valid_finite_specialization',producer_status=r['status'],fresh_status=classify(rows,context),
                source_sha256=r['source_sha256'],context=context,cases=rows,scope=SCOPE,kernel_checked=False)


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('source',nargs='?',type=Path)
    parser.add_argument('--out',required=True,type=Path);parser.add_argument('--recipe',type=Path)
    parser.add_argument('--verify',action='store_true');args=parser.parse_args()
    if args.verify:answer=verify(args.out,args.source)
    else:
        if args.source is None or args.recipe is None:parser.error('source and recipe required')
        answer=produce(args.source,args.out,json.loads(args.recipe.read_text()))
    print(json.dumps(answer))
