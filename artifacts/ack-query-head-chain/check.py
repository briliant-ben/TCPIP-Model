"""Fresh epoch bootstrap and checked chain for original ACK head queries."""
import argparse,hashlib,importlib.util,json,shutil,sys,tarfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT),str(ROOT/'formal')]
import query_lemmas as g
import query_certificates as q
c=g.c
HERE=Path(__file__).resolve().parent

def old_controller():
    path=ROOT/'artifacts/ack-query-reuse/check.py'
    spec=importlib.util.spec_from_file_location('original_primitive_reader',path)
    mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod);return mod

def selection():
    value=json.loads((HERE/'selection.json').read_text())
    if set(value)!={'targets','dependencies','bootstrap_targets','bootstrap_dependencies'}:raise ValueError('Unexpected plan')
    for values in value.values():
        if not values or any(type(x)is not int or not 0<=x<368 for x in values)or len(set(values))!=len(values):raise ValueError('Bad query IDs')
    if set(value['targets'])&set(value['dependencies']):raise ValueError('Circular plan')
    return value

def sources():
    folder=ROOT/'artifacts/sent-ledger-single-target-unknown'
    manifest=json.loads((folder/'members.json').read_text());result={}
    with tarfile.open(folder/'exact-single-disjunct-attempt.tar.gz')as stream:
        for i in range(368):
            name=f'group-{i:03}.smt2';data=stream.extractfile(name).read()
            if hashlib.sha256(data).hexdigest()!=manifest[name]:raise ValueError('Original member changed')
            result[i]=data
        data=stream.extractfile('result.json').read()
        if hashlib.sha256(data).hexdigest()!=manifest['result.json']:raise ValueError('Original report changed')
    legacy={x['disjunct_indices'][0]for x in json.loads(data)['groups']if x['query']=='unsat'}
    return result,legacy

def primitive(directory,number,data,legacy,reader):
    directory.mkdir(parents=True);(directory/'source.smt2').write_bytes(data);proof=directory/'proof'
    if number==52:
        kind='modular-normalization';shutil.copytree(ROOT/'artifacts/ack-modular-normalization/normalized',proof)
    elif number==92:
        kind='piecewise';folder=ROOT/'artifacts/ack-piecewise-092'
        reader.unpack(folder/'evidence.tar.gz',folder/'members.json','direct-pilot/92',proof)
    elif number==280:
        kind='finite';folder=ROOT/'artifacts/ack-finite-280'
        manifest=json.loads((folder/'members.json').read_text())
        with tarfile.open(folder/'evidence.tar.gz')as stream:
            for name,digest in manifest.items():
                entry=stream.getmember(name);relative=Path(name)
                if not entry.isfile()or relative.is_absolute()or '..'in relative.parts:raise ValueError('Unsafe finite member')
                payload=stream.extractfile(entry).read()
                if hashlib.sha256(payload).hexdigest()!=digest:raise ValueError('Finite member changed')
                path=proof/relative;path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(payload)
    else:
        kind='tactic'if number in legacy else'piecewise'
        folder=ROOT/'artifacts'/('sent-ledger-tactic-refinement'if kind=='tactic'else'ack-piecewise-remaining68')
        archive='queries-and-checks.tar.gz'if kind=='tactic'else'evidence.tar.gz'
        reader.unpack(folder/archive,folder/'members.json',f'group-{number:03}',proof)
    c.write(directory/'certificate.json',dict(format=q.FORMAT,kind=kind,source='source.smt2',proof='proof'))
    return directory

def produce(out):
    out=Path(out)
    if out.exists():raise ValueError('Fresh output required')
    out.mkdir(parents=True);plan=selection();raw,legacy=sources();reader=old_controller();reader.artifacts()
    dependencies={}
    for i in sorted(set(plan['dependencies']+plan['bootstrap_dependencies'])-set(plan['bootstrap_targets'])):
        item=f'group-{i:03}';dependencies[item]=primitive(out/'inputs'/item,i,raw[i],legacy,reader)
    targets={}
    for i in plan['targets']+plan['bootstrap_targets']:
        item=f'group-{i:03}';path=out/'inputs'/f'{item}.smt2';path.write_bytes(raw[i]);targets[item]=path
    session=q.VerificationSession()
    bootstrap=g.produce({f'group-{i:03}':targets[f'group-{i:03}']for i in plan['bootstrap_targets']},
                        {f'group-{i:03}':dependencies[f'group-{i:03}']for i in plan['bootstrap_dependencies']},out/'bootstrap',_session=session)
    if bootstrap['status']!='original_queries_unsat_nonvacuous':raise ValueError('Bootstrap not closed')
    for i in plan['bootstrap_targets']:
        item=f'group-{i:03}';directory=out/'inputs'/item;directory.mkdir()
        (directory/'source.smt2').write_bytes(raw[i]);shutil.copytree(out/'bootstrap',directory/'proof')
        c.write(directory/'certificate.json',dict(format=q.FORMAT,kind='reuse',source='source.smt2',proof='proof',target=item))
        dependencies[item]=directory
    graph=g.produce({f'group-{i:03}':targets[f'group-{i:03}']for i in plan['targets']},
                    {f'group-{i:03}':dependencies[f'group-{i:03}']for i in plan['dependencies']},out/'graph',_session=session)
    c.write(out/'controller-result.json',dict(status=graph['status'],selection_sha256=c.sha(HERE/'selection.json'),
        controller_sha256=c.sha(__file__),versions=g.versions(),proof_cache=session.stats(),
        scope='selected original finite state/length queries only; not full ACK, invariant basis, IR translation, bytes/time or protocol proof'))
    return graph

def verify(out,verification_out):
    out=Path(out);record=json.loads((out/'controller-result.json').read_text())
    if record['controller_sha256']!=c.sha(__file__)or record['selection_sha256']!=c.sha(HERE/'selection.json')or record['versions']!=g.versions():raise ValueError('Controller epoch changed')
    raw,_=sources();plan=selection();graph=json.loads((out/'graph/result.json').read_text())
    if [r['name']for r in graph['targets']]!=[f'group-{i:03}'for i in plan['targets']]or graph['dependencies']!=[f'group-{i:03}'for i in plan['dependencies']]:raise ValueError('Source selection changed')
    for kind in ('targets','dependencies'):
        for i in plan[kind]:
            item=f'group-{i:03}';source=out/'graph/targets'/item/'original.smt2'if kind=='targets'else q.source(out/'graph/dependencies'/item)[0]
            if source.read_bytes()!=raw[i]:raise ValueError('Wrong original query source')
    return g.verify(out/'graph',verification_out)

if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path);parser.add_argument('--verify-out',type=Path)
    args=parser.parse_args();result=verify(args.out,args.verify_out)if args.verify_out else produce(args.out)
    print(json.dumps(result),flush=True)
