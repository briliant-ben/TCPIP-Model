"""Source-bound ACK application of the generic checked query-reuse DAG."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import subprocess
import sys
import tarfile
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT/'formal'))
import query_lemmas as g
import query_certificates as q
c=g.c
HERE=Path(__file__).resolve().parent
ORIGINAL=ROOT/'artifacts/sent-ledger-single-target-unknown'


def selection():
    r=json.loads((HERE/'selection.json').read_text())
    if set(r)!={'targets','dependencies'}:raise ValueError('Unsupported selection')
    for key in ('targets','dependencies'):
        if not r[key]or any(type(x)is not int or not 0<=x<368 for x in r[key])or len(set(r[key]))!=len(r[key]):
            raise ValueError('Invalid query selection')
    if set(r['targets'])&set(r['dependencies']):raise ValueError('Target used as its own dependency')
    return r


def unpack(archive,manifest,prefix,destination):
    members=json.loads(Path(manifest).read_text())
    selected={name:digest for name,digest in members.items()if name.startswith(prefix+'/')}
    if not selected:raise ValueError('Missing certificate subtree')
    with tarfile.open(archive,'r:gz')as stream:
        for name,digest in selected.items():
            entry=stream.getmember(name);relative=Path(name).relative_to(prefix)
            if not entry.isfile()or relative.is_absolute()or '..'in relative.parts:raise ValueError('Unsafe archive member')
            data=stream.extractfile(entry).read()
            if hashlib.sha256(data).hexdigest()!=digest:raise ValueError('Certificate member changed')
            target=destination/relative;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(data)


def artifacts():
    data={}
    for name in ('ack-finite-280','ack-piecewise-remaining68'):
        folder=ROOT/'artifacts'/name;r=json.loads((folder/'acceptance.json').read_text())
        if c.sha(folder/'evidence.tar.gz')!=r['evidence_sha256']or c.sha(folder/'members.json')!=r['members_sha256']:
            raise ValueError('Existing certificate archive changed')
        data[name]=dict(archive_sha256=r['evidence_sha256'],members_sha256=r['members_sha256'])
    folder=ROOT/'artifacts/sent-ledger-tactic-refinement';r=json.loads((folder/'result.json').read_text())
    if c.sha(folder/'queries-and-checks.tar.gz')!=r['archive_sha256']or c.sha(folder/'members.json')!=r['members_sha256']:
        raise ValueError('Tactic certificate archive changed')
    data['sent-ledger-tactic-refinement']=dict(archive_sha256=r['archive_sha256'],members_sha256=r['members_sha256'])
    data['original']=dict(archive_sha256=c.sha(ORIGINAL/'exact-single-disjunct-attempt.tar.gz'),members_sha256=c.sha(ORIGINAL/'members.json'))
    return data


def produce(out):
    out=Path(out)
    if out.exists():raise ValueError('Use a fresh output directory')
    selected=selection();provenance=artifacts();out.mkdir(parents=True)
    source_members=json.loads((ORIGINAL/'members.json').read_text());sources={}
    with tarfile.open(ORIGINAL/'exact-single-disjunct-attempt.tar.gz','r:gz')as stream:
        prior=json.load(stream.extractfile('result.json'))
        legacy={x['disjunct_indices'][0]for x in prior['groups']if x['query']=='unsat'}
        for number in selected['targets']+selected['dependencies']:
            name=f'group-{number:03}.smt2';data=stream.extractfile(name).read()
            if hashlib.sha256(data).hexdigest()!=source_members[name]:raise ValueError('Original source member changed')
            sources[number]=data
    targets={};dependencies={}
    for number in selected['targets']:
        path=out/'inputs'/f'group-{number:03}.smt2';path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(sources[number])
        targets[f'group-{number:03}']=path
    for number in selected['dependencies']:
        item=f'group-{number:03}';directory=out/'inputs'/item;directory.mkdir(parents=True)
        (directory/'source.smt2').write_bytes(sources[number]);proof=directory/'proof'
        if number==52:
            kind='modular-normalization';shutil.copytree(ROOT/'artifacts/ack-modular-normalization/normalized',proof)
        elif number==280:
            kind='finite';folder=ROOT/'artifacts/ack-finite-280'
            # Copy all retained proof data without executing the artifact's Python.
            with tarfile.open(folder/'evidence.tar.gz','r:gz')as stream:
                manifest=json.loads((folder/'members.json').read_text())
                for name,digest in manifest.items():
                    entry=stream.getmember(name);relative=Path(name)
                    if not entry.isfile()or relative.is_absolute()or '..'in relative.parts:raise ValueError('Unsafe finite member')
                    data=stream.extractfile(entry).read()
                    if hashlib.sha256(data).hexdigest()!=digest:raise ValueError('Finite member changed')
                    path=proof/relative;path.parent.mkdir(parents=True,exist_ok=True);path.write_bytes(data)
        elif number in legacy:
            kind='tactic';folder=ROOT/'artifacts/sent-ledger-tactic-refinement'
            unpack(folder/'queries-and-checks.tar.gz',folder/'members.json',item,proof)
        else:
            kind='piecewise';folder=ROOT/'artifacts/ack-piecewise-remaining68'
            unpack(folder/'evidence.tar.gz',folder/'members.json',item,proof)
        c.write(directory/'certificate.json',dict(format=q.FORMAT,kind=kind,source='source.smt2',proof='proof'))
        dependencies[item]=directory
    r=g.produce(targets,dependencies,out/'graph')
    report=dict(status=r['status'],selection_sha256=c.sha(HERE/'selection.json'),archives=provenance,
        controller_sha256=c.sha(__file__),git_commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),
        target_source_hashes={name:source_members[name+'.smt2']for name in targets},
        scope='selected original ACK exported queries only; not full ACK/invariant basis, reachable TCP or IR translation proof')
    c.write(out/'controller-result.json',report);return report


def verify(out,verification_out):
    out=Path(out);r=json.loads((out/'controller-result.json').read_text());selected=selection()
    if r['selection_sha256']!=c.sha(HERE/'selection.json')or r['controller_sha256']!=c.sha(__file__)or r['archives']!=artifacts():
        raise ValueError('Source selection/controller/archive changed')
    source=json.loads((ORIGINAL/'members.json').read_text())
    graph=json.loads((out/'graph/result.json').read_text())
    if [x['name']for x in graph['targets']]!=[f'group-{i:03}'for i in selected['targets']]or graph['dependencies']!=[f'group-{i:03}'for i in selected['dependencies']]:
        raise ValueError('Original query selection changed')
    for number in selected['targets']:
        item=f'group-{number:03}'
        if c.sha(out/'graph/targets'/item/'original.smt2')!=source[item+'.smt2']or r['target_source_hashes'][item]!=source[item+'.smt2']:
            raise ValueError('Original target identity changed')
    for number in selected['dependencies']:
        item=f'group-{number:03}';path,_,_=q.source(out/'graph/dependencies'/item)
        if c.sha(path)!=source[item+'.smt2']:raise ValueError('Original dependency identity changed')
    result=g.verify(out/'graph',verification_out)
    if r['status']!=result['producer_status']:raise ValueError('Controller classification changed')
    return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    parser.add_argument('--verify-out',type=Path);args=parser.parse_args()
    print(json.dumps(verify(args.out,args.verify_out)if args.verify_out else produce(args.out)))
