"""Join an entire exported Boolean partition after fresh fixed-checker replay.

Plans reference hash-bound data archives. Their Python files are never imported.
Only known query_certificates/query_lemmas code checks the supplied proof data.
"""
import argparse
import hashlib
import json
from pathlib import Path,PurePosixPath
import shutil
import tarfile

import conditional_ssa as c
import partition_queries as p
import query_certificates as q
import query_lemmas as g

ROOT=Path(__file__).resolve().parents[1]
FORMAT='checked-partition-cover-v2'
SCOPE='one exact labelled exported conjunction; trusted Python/Z3/encoder, no kernel, invariant-basis, reachability, implementation or protocol proof'


def ref(value):
    if not isinstance(value,str)or not value:raise ValueError('Invalid input reference')
    path=Path(value)
    return path if path.is_absolute()else ROOT/path


def inside(root,value):
    if not isinstance(value,str)or '\\'in value:raise ValueError('Unsafe bundle path')
    path=PurePosixPath(value)
    if path.is_absolute()or '..'in path.parts or str(path)!=value or not value:raise ValueError('Unsafe bundle path')
    answer=(Path(root)/value).resolve()
    if not answer.is_relative_to(Path(root).resolve()):raise ValueError('Bundle path escapes root')
    return answer


def versions():return dict(g.versions(),**{'query_cover.py':c.sha(__file__)})


def checked_plan(plan):
    if type(plan)is not dict or set(plan)!={'format','source','bundles','proofs'}or plan['format']!=FORMAT:
        raise ValueError('Unsupported cover plan')
    source=plan['source']
    if type(source)is not dict or set(source)!={'file','sha256','label','assertion_index'}:raise ValueError('Unsupported source fields')
    if c.sha(ref(source['file']))!=source['sha256']:raise ValueError('Expected original export changed')
    terms=p.extract(ref(source['file']).read_text(),source['label']);q.admitted(terms)
    index=source['assertion_index']
    if type(index)is not int or not 0<=index<len(terms):raise ValueError('Invalid original assertion index')
    branches=p.disjuncts(terms[index]);common=terms[:index]+terms[index+1:]
    if not common or not branches:raise ValueError('Missing source context or partition')
    if type(plan['bundles'])is not dict or not plan['bundles']:raise ValueError('Missing proof bundles')
    for name,bundle in plan['bundles'].items():
        g.name(name)
        if type(bundle)is not dict or set(bundle)!={'archive','sha256','members','members_sha256'}:raise ValueError('Unsupported bundle fields')
        if c.sha(ref(bundle['archive']))!=bundle['sha256']or c.sha(ref(bundle['members']))!=bundle['members_sha256']:raise ValueError('Bundle or member manifest changed')
    if type(plan['proofs'])is not list or not plan['proofs']:raise ValueError('Missing proof sets')
    covered=[]
    for proof in plan['proofs']:
        if type(proof)is not dict:raise ValueError('Unsupported proof set')
        kind=proof.get('kind');required={'kind','bundle','path'}|({'group'}if kind=='certificate'else{'dependencies','targets'}if kind=='graph'else set())
        allowed=required|({'overrides'}if kind=='graph'else set())
        if kind not in ('certificate','graph')or not required<=set(proof)or not set(proof)<=allowed or proof['bundle']not in plan['bundles']:raise ValueError('Unsupported proof kind or fields')
        inside(ROOT,proof['path'])
        if kind=='graph':
            if type(proof.get('overrides',{}))is not dict:raise ValueError('Overrides must be named data references')
            for node,replacement in proof.get('overrides',{}).items():
                g.name(node)
                if type(replacement)is not dict or set(replacement)!={'bundle','path'}or replacement['bundle']not in plan['bundles']:raise ValueError('Unsupported certificate override')
                inside(ROOT,replacement['path'])
        if kind=='certificate':
            if type(proof['group'])is not int:raise ValueError('Group must be an integer')
            covered.append(proof['group'])
        else:
            for role in ('dependencies','targets'):
                mapping=proof[role]
                if type(mapping)is not dict:raise ValueError('Graph mapping must be named')
                for key,node in mapping.items():
                    if not isinstance(key,str)or not key.isdecimal()or str(int(key))!=key:raise ValueError('Noncanonical group index')
                    g.name(node);covered.append(int(key))
    if sorted(covered)!=list(range(len(branches))):raise ValueError('Partition coverage must contain every original group exactly once')
    return terms,index,common,branches


def schemas(terms,index,branches):
    context=c.z3.Bool('cover_context');violations=[c.z3.Bool(f'cover_violation_{i}')for i in range(len(branches))]
    clauses=[c.z3.Bool(f'cover_source_clause_{i}')for i in range(len(terms)-1)]
    selected=c.z3.Bool('cover_selected_assertion')
    return {'partition-equivalence.smt2':[c.z3.Xor(terms[index],c.z3.Or(*branches))],
        'assertion-order.smt2':[c.z3.Xor(c.z3.And(*(clauses[:index]+[selected]+clauses[index:])),c.z3.And(c.z3.And(*clauses),selected))],
        'composition.smt2':[c.z3.Implies(context,c.z3.Not(v))for v in violations]+[context,c.z3.Or(*violations)]}


def bindings(plan):
    return dict(source_sha256=c.sha(ref(plan['source']['file'])),
        bundles={name:dict(archive_sha256=c.sha(ref(b['archive'])),members_sha256=c.sha(ref(b['members'])))for name,b in plan['bundles'].items()})


def stage(plan,out):
    out=Path(out)
    if out.exists():raise ValueError('Use a fresh proposal directory')
    terms,index,common,branches=checked_plan(plan);out.mkdir(parents=True)
    c.write(out/'plan.json',plan)
    for name,expected in schemas(terms,index,branches).items():(out/name).write_text(c.script(expected))
    (out/'context.smt2').write_text(c.script(common))
    record=dict(status='partition_cover_proposed_pending_replay',versions=versions(),solver_sha256=c.sha(c.solver_binary()),
        inputs=bindings(plan),source_assertions=len(terms),disjuncts=len(branches),timeout_ms=10000,
        kernel_checked=False,ir_translation_proved=False,whole_protocol_proved=False,scope=SCOPE)
    record['files']={path.name:c.sha(path)for path in out.iterdir()if path.is_file()}
    c.write(out/'result.json',record);return record


def unpack(bundle,destination):
    members=json.loads(ref(bundle['members']).read_text());destination=Path(destination);destination.mkdir(parents=True)
    with tarfile.open(ref(bundle['archive']),'r:gz')as stream:
        entries=stream.getmembers()
        if type(members)is not dict or len(entries)!=len(members)or len({e.name for e in entries})!=len(entries):raise ValueError('Bundle coverage changed')
        for entry in entries:
            target=inside(destination,entry.name)
            if not entry.isfile()or entry.name not in members:raise ValueError('Unsafe or unexpected bundle member')
            raw=stream.extractfile(entry).read()
            if hashlib.sha256(raw).hexdigest()!=members[entry.name]:raise ValueError('Bundle member changed')
            target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(raw)


def refresh_graph(original,overrides,imports,work):
    """Propose data changes only; the unchanged DAG checker replays everything."""
    original,work=Path(original),Path(work)
    if not overrides:return original
    old=json.loads((original/'result.json').read_text());replacements=[]
    for node,reference in overrides.items():
        if node not in old['dependencies']:raise ValueError('Override must name an existing dependency')
        replacement=inside(imports/reference['bundle'],reference['path'])
        before=q.source(original/'dependencies'/node)[0];after=q.source(replacement)[0]
        if before.read_bytes()!=after.read_bytes():raise ValueError('Override must prove byte-identical original source')
        replacements.append((node,replacement,c.sha(before),q.certificate_digest(replacement)))
    shutil.copytree(original,work)
    for node,replacement,_,_ in replacements:
        shutil.rmtree(work/'dependencies'/node);shutil.copytree(replacement,work/'dependencies'/node)
    c.write(work/'source-preserving-overrides.json',dict(original_graph_result_sha256=c.sha(original/'result.json'),
        changes=[dict(node=node,original_source_sha256=sha,replacement_source_sha256=sha,replacement_certificate_digest=digest)
            for node,_,sha,digest in replacements],
        scope='untrusted successor proposal; original producer leaf/context/schema data and event metadata retained; every parent and target must be freshly rechecked'))
    # This is a new proposal, not an edit of the referenced immutable bundle.
    # Original leaf proofs have identical statements and logical parent facts.
    # The fixed verifier reconstructs them and checks every replacement natively.
    old['files']={str(p.relative_to(work)):c.sha(p)for p in sorted(work.rglob('*'))if p.is_file()and p!=work/'result.json'}
    c.write(work/'result.json',old);return work


def match(path,group,common,branches):
    actual=c.read_query(path);expected=common+[c.z3.Or(branches[group])]
    if len(actual)!=len(expected)or any(not a.eq(b)for a,b in zip(actual,expected)):
        raise ValueError('Proof does not retain the entire ordered original context and selected violation')


def verify(proposal,out):
    proposal,out=Path(proposal),Path(out)
    if out.exists()or out.resolve().is_relative_to(proposal.resolve()):raise ValueError('Use a fresh separate verification directory')
    record=json.loads((proposal/'result.json').read_text());plan=json.loads((proposal/'plan.json').read_text())
    terms,index,common,branches=checked_plan(plan);before=bindings(plan);epoch=versions()
    required={'status','versions','solver_sha256','inputs','source_assertions','disjuncts','timeout_ms','kernel_checked','ir_translation_proved','whole_protocol_proved','scope','files'}
    if set(record)!=required or record['status']!='partition_cover_proposed_pending_replay'or record['versions']!=epoch or record['solver_sha256']!=c.sha(c.solver_binary()):raise ValueError('Checker/solver/proposal epoch changed')
    if record['inputs']!=before or record['source_assertions']!=len(terms)or record['disjuncts']!=len(branches):raise ValueError('Source binding or coverage changed')
    if record['timeout_ms']!=10000 or record['scope']!=SCOPE or any(record[x]is not False for x in ('kernel_checked','ir_translation_proved','whole_protocol_proved')):raise ValueError('Scope or budget changed')
    actual={path.name:c.sha(path)for path in proposal.iterdir()if path.is_file()and path.name!='result.json'}
    if actual!=record['files']:raise ValueError('Proposal files changed')
    for name,expected in schemas(terms,index,branches).items():c.check_terms(proposal/name,expected)
    c.check_terms(proposal/'context.smt2',common)
    out.mkdir(parents=True);local={}
    for name in schemas(terms,index,branches):
        answer=c.cli(proposal/name,out/(name+'.log'))
        if answer['query']!='unsat':raise ValueError('Partition/order/composition theorem not proved: '+name)
        local[name]=answer
    context=c.cli(proposal/'context.smt2',out/'context.log')
    for name,bundle in plan['bundles'].items():unpack(bundle,out/'imports'/name)
    session=q.VerificationSession();closures=[];proof_results=[]
    for ordinal,proof in enumerate(plan['proofs']):
        path=inside(out/'imports'/proof['bundle'],proof['path'])
        if proof['kind']=='certificate':
            source=q.source(path)[0];match(source,proof['group'],common,branches)
            copy=out/f'certificate-{ordinal:03}';shutil.copytree(path,copy)
            checked=q.verify(copy,c.sha(source),_session=session)
            if checked['status']!='verified_standalone_query_unsat':raise ValueError('Standalone original group not proved')
            closures.append(dict(group=proof['group'],source_sha256=c.sha(source),proof_set=ordinal,kind='certificate'))
        else:
            path=refresh_graph(path,proof.get('overrides',{}),out/'imports',out/f'graph-proposal-{ordinal:03}')
            for role in ('dependencies','targets'):
                for key,node in proof[role].items():
                    source=q.source(path/'dependencies'/node)[0]if role=='dependencies'else path/'targets'/node/'original.smt2'
                    match(source,int(key),common,branches)
            checked=g.verify(path,out/f'graph-{ordinal:03}',_session=session)
            if checked['producer_status']not in ('original_queries_unsat_nonvacuous','original_queries_unsat_vacuous_context','original_queries_unsat_context_unresolved'):raise ValueError('Graph lacks prior checked original closures')
            parents={r['name']:r['verification']for r in checked['dependencies']};targets={r['name']:r for r in checked['targets']}
            for role in ('dependencies','targets'):
                for key,node in proof[role].items():
                    row=(parents if role=='dependencies'else targets).get(node)
                    if row is None or (row['status']!='verified_standalone_query_unsat'if role=='dependencies'else row['query']['query']!='unsat'):raise ValueError('Mapped graph original not independently proved')
                    source=q.source(path/'dependencies'/node)[0]if role=='dependencies'else path/'targets'/node/'original.smt2'
                    if row['source_sha256']!=c.sha(source):raise ValueError('Mapped original source changed')
                    closures.append(dict(group=int(key),source_sha256=c.sha(source),proof_set=ordinal,kind=role,node=node))
        proof_results.append(checked);print('checked-cover-proof-set',ordinal,flush=True)
    if sorted(r['group']for r in closures)!=list(range(len(branches))):raise ValueError('Final exact partition coverage missing')
    if bindings(plan)!=before or versions()!=epoch:raise ValueError('Source/bundle/checker changed during replay')
    result=dict(status='verified_original_query_cover',source=plan['source'],source_assertions=len(terms),disjuncts=len(branches),
        context=context,context_classification={'sat':'nonvacuous','unsat':'vacuous_context','unknown':'context_unresolved'}[context['query']],local_theorems=local,original_groups=sorted(closures,key=lambda r:r['group']),proof_results=proof_results,
        proof_cache=session.stats(),inputs=before,versions=epoch,solver_sha256=c.sha(c.solver_binary()),timeout_ms=10000,
        whole_named_exported_query_closed=True,kernel_checked=False,ir_translation_proved=False,whole_protocol_proved=False,
        scope=SCOPE)
    c.write(out/'result.json',result);return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    parser.add_argument('--plan',type=Path);parser.add_argument('--proposal',type=Path);args=parser.parse_args()
    if bool(args.plan)==bool(args.proposal):parser.error('Specify one of --plan or --proposal')
    print(json.dumps(stage(json.loads(args.plan.read_text()),args.out)if args.plan else verify(args.proposal,args.out)),flush=True)
