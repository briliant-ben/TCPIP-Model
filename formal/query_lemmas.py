"""Exact shared-context proof reuse with freshly checked standalone parents.

A parent proves A & D is UNSAT. Only then can NOT D be added to A & V.
Parents must have exactly the same entire A vector. No cyclic or custom-code
certificate is admitted; every target keeps every original assertion in order.
"""
import argparse
import json
from pathlib import Path
import re
import shutil

import conditional_ssa as c
import modular_piecewise as p
import query_certificates as q

SCOPE='acyclic checked-proof reuse for exact exported conjunctions; not IR/kernel/reachability/protocol or invariant-basis proof'


def name(value):
    if not isinstance(value,str)or not re.fullmatch(r'[A-Za-z0-9][A-Za-z0-9_-]{0,79}',value):
        raise ValueError('Invalid or unsafe proof name')
    return value


def versions():
    folder=Path(__file__).parent
    return {file:c.sha(folder/file)for file in ('query_lemmas.py','query_certificates.py','finite_specialization.py',
        'modular_piecewise.py','conditional_ssa.py','modular_normalization.py','tactic_recheck.py','partition_queries.py')}


def schema(count):
    context=c.z3.Bool('shared_context');violation=c.z3.Bool('target_violation')
    lemmas=[c.z3.Bool(f'proved_conclusion_{i}')for i in range(count)]
    return [c.z3.Implies(context,item)for item in lemmas]+[
        c.z3.Not(c.z3.And(context,violation,*lemmas)),context,violation]


def inputs(out,targets,dependencies):
    if type(targets)is not list or type(dependencies)is not list:
        raise ValueError('Proof names must be ordered lists')
    for item in targets+dependencies:name(item)
    if not targets or not dependencies or len(targets)!=len(set(targets))or len(dependencies)!=len(set(dependencies)):
        raise ValueError('Need distinct targets and standalone dependencies')
    if set(targets)&set(dependencies):raise ValueError('Circular/self dependency name')
    for item in targets+dependencies:name(item)
    originals={item:c.read_query(out/'targets'/item/'original.smt2')for item in targets}
    common=originals[targets[0]][:-1]
    if not common:raise ValueError('Missing shared source context')
    for terms in originals.values():
        q.admitted(terms)
        if len(terms)!=len(common)+1 or any(not a.eq(b)for a,b in zip(common,terms[:-1])):
            raise ValueError('Targets do not share the entire exact source context')
    parents={}
    for item in dependencies:
        path,_,_=q.source(out/'dependencies'/item);terms=c.read_query(path)
        if len(terms)!=len(common)+1 or any(not a.eq(b)for a,b in zip(common,terms[:-1])):
            raise ValueError('Dependency does not share the entire exact source context')
        if any(terms[-1].eq(target[-1])for target in originals.values()):
            raise ValueError('Circular/self dependency conclusion')
        parents[item]=(path,terms)
    return common,originals,parents


def classification(rows,context):
    if all(row['query']['query']=='unsat'and row['fresh_query']['query']=='unsat'for row in rows):
        return {'sat':'original_queries_unsat_nonvacuous','unsat':'original_queries_unsat_vacuous_context','unknown':'original_queries_unsat_context_unresolved'}[context['query']]
    return 'partial_or_unknown'


def produce(targets,dependencies,out,_session=None):
    out=Path(out)
    if type(targets)is not dict or type(dependencies)is not dict:
        raise ValueError('Targets/dependencies must be named mappings')
    for source in dependencies.values():
        if out.resolve().is_relative_to(Path(source).resolve()):
            raise ValueError('Output cannot be inside an input certificate')
        if any(path.is_symlink()for path in Path(source).rglob('*')):
            raise ValueError('Symlink certificate members unsupported')
    if out.exists():raise ValueError('Use a fresh proof directory')
    out.mkdir(parents=True)
    target_names=list(targets);dependency_names=list(dependencies)
    for item,source in targets.items():
        directory=out/'targets'/name(item);directory.mkdir(parents=True)
        (directory/'original.smt2').write_bytes(Path(source).read_bytes())
    for item,source in dependencies.items():shutil.copytree(source,out/'dependencies'/name(item))
    common,originals,parents=inputs(out,target_names,dependency_names)
    session=_session if _session is not None else q.VerificationSession()
    parent_results=[]
    for item in dependency_names:
        path,_=parents[item]
        checked=q.verify(out/'dependencies'/item,c.sha(path),active={q.fingerprint(out/'targets'/target/'original.smt2')for target in target_names},_session=session);parent_results.append(dict(name=item,verification=checked))
        print('standalone-parent',item,checked['status'],flush=True)
    c.write(out/'dependency-results.json',parent_results)
    (out/'composition.smt2').write_text(c.script(schema(len(dependency_names))))
    composition=c.cli(out/'composition.smt2',out/'composition.log')
    if composition['query']!='unsat':raise ValueError('Propositional proof composition not established')
    (out/'context.smt2').write_text(c.script(common))
    context=c.cli(out/'context.smt2',out/'context.log')
    rows=[]
    lemmas=[c.z3.Not(parents[item][1][-1])for item in dependency_names]
    for item in target_names:
        directory=out/'targets'/item;augmented=directory/'augmented.smt2'
        augmented.write_text(c.script(originals[item]+lemmas))
        p.produce(augmented,directory/'modulo');normalization=p.verify(directory/'modulo',augmented)
        c.write(directory/'normalization-verification.json',normalization)
        query=c.cli(directory/'modulo/normalized.smt2',directory/'query.log')
        fresh=c.cli(directory/'modulo/normalized.smt2',directory/'query.independent.log')if query['query']=='unsat'else dict(query='unknown')
        rows.append(dict(name=item,source_sha256=c.sha(directory/'original.smt2'),
                         assertion_count=len(originals[item]),added_lemmas=len(lemmas),query=query,fresh_query=fresh))
        print('target',item,query['query'],fresh['query'],flush=True)
    result=dict(status=classification(rows,context),targets=rows,dependencies=dependency_names,
        context=context,composition=composition,versions=versions(),solver_sha256=c.sha(c.solver_binary()),timeout_ms=10000,
        kernel_checked=False,ir_translation_proved=False,whole_protocol_proved=False,proof_cache=session.stats(),scope=SCOPE)
    result['files']={str(path.relative_to(out)):c.sha(path)for path in sorted(out.rglob('*'))if path.is_file()}
    c.write(out/'result.json',result);return result


def verify(out,verification_out,_active=None,_session=None):
    out=Path(out);verification_out=Path(verification_out)
    if verification_out.resolve().is_relative_to(out.resolve()):
        raise ValueError('Verification output cannot modify original evidence')
    if verification_out.exists():raise ValueError('Preserve previous verification evidence; use a fresh output')
    r=json.loads((out/'result.json').read_text())
    if set(r)!={'status','targets','dependencies','context','composition','versions','solver_sha256','timeout_ms','kernel_checked','ir_translation_proved','whole_protocol_proved','proof_cache','scope','files'}:
        raise ValueError('Unsupported result fields or proof claims')
    if r['versions']!=versions()or r['solver_sha256']!=c.sha(c.solver_binary()):raise ValueError('Checker/dependency/solver changed')
    if r['proof_cache'].get('invocation_local')is not True or r['proof_cache'].get('loaded_from_artifacts')is not False:
        raise ValueError('Untrusted or persisted verification cache claim')
    if r['scope']!=SCOPE or r['timeout_ms']!=10000 or any(r[key]is not False for key in ('kernel_checked','ir_translation_proved','whole_protocol_proved')):
        raise ValueError('Scope, domain of claim or budget changed')
    actual={str(path.relative_to(out)):c.sha(path)for path in sorted(out.rglob('*'))if path.is_file()and path!=out/'result.json'}
    if actual!=r['files']:raise ValueError('Evidence coverage or binding changed')
    target_names=[row['name']for row in r['targets']];dependency_names=r['dependencies']
    common,originals,parents=inputs(out,target_names,dependency_names)
    verification_out.mkdir(parents=True)
    session=_session if _session is not None else q.VerificationSession()
    dependency_results=[]
    for item in dependency_names:
        copy=verification_out/'dependencies'/item;shutil.copytree(out/'dependencies'/item,copy)
        path,_=parents[item]
        checked=q.verify(copy,c.sha(path),active=set(_active or ())|{q.fingerprint(out/'targets'/target/'original.smt2')for target in target_names},_session=session);dependency_results.append(dict(name=item,verification=checked))
        print('fresh-parent',item,checked['status'],flush=True)
    c.check_terms(out/'composition.smt2',schema(len(dependency_names)))
    composition=c.cli(out/'composition.smt2',verification_out/'composition.log')
    if composition['query']!='unsat'or r['composition']['query']!='unsat':raise ValueError('Composition not independently checked')
    c.check_terms(out/'context.smt2',common)
    context=c.cli(out/'context.smt2',verification_out/'context.log')
    if r['context']['query']=='sat'and context['query']!='sat':raise ValueError('Nonvacuity not independently reproduced')
    lemmas=[c.z3.Not(parents[item][1][-1])for item in dependency_names]
    rows=[]
    for old in r['targets']:
        item=old['name'];original=out/'targets'/item;copy=verification_out/'targets'/item
        if old['source_sha256']!=c.sha(original/'original.smt2')or old['assertion_count']!=len(originals[item])or old['added_lemmas']!=len(lemmas):
            raise ValueError('Target/lemma coverage changed')
        c.check_terms(original/'augmented.smt2',originals[item]+lemmas)
        shutil.copytree(original,copy)
        normalized=p.verify(copy/'modulo',copy/'augmented.smt2')
        answer=c.cli(copy/'modulo/normalized.smt2',copy/'query.acceptance.log')
        if old['query']['query']=='unsat'and (old['fresh_query']['query']!='unsat'or answer['query']!='unsat'):
            raise ValueError('Original query closure not independently reproduced')
        for key,file in (('query','query.log'),('fresh_query','query.independent.log')):
            if old[key]['query']=='unsat'and (c.sha(original/file)!=old[key]['log_sha256']or (original/file).read_text().strip()!='unsat'):
                raise ValueError('Positive query result not bound')
        rows.append(dict(name=item,source_sha256=old['source_sha256'],normalization=normalized,query=answer))
        print('fresh-target',item,answer['query'],flush=True)
    if r['status']!=classification(r['targets'],r['context']):raise ValueError('Classification inconsistent')
    result=dict(status='valid_shared_context_query_reuse',producer_status=r['status'],context=context,
        dependencies=dependency_results,targets=rows,scope=SCOPE,kernel_checked=False,whole_protocol_proved=False,
        proof_cache=session.stats(),dependency_query_fingerprints=sorted({key for row in dependency_results
          for key in row['verification']['proof_query_fingerprints']}))
    c.write(verification_out/'result.json',result);return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    parser.add_argument('--plan',type=Path);parser.add_argument('--verify-out',type=Path);args=parser.parse_args()
    if args.verify_out:result=verify(args.out,args.verify_out)
    else:
        if args.plan is None:parser.error('--plan or --verify-out required')
        plan=json.loads(args.plan.read_text())
        if set(plan)!={'targets','dependencies'}:parser.error('Unsupported plan')
        result=produce(plan['targets'],plan['dependencies'],args.out)
    print(json.dumps(result))
