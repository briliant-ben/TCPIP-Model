"""Source-bound raw finite certificates for two original ACK prefix queries."""
import argparse,hashlib,importlib.util,json,shutil,sys,tarfile
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT),str(ROOT/'formal')]
import query_certificates as q
import query_lemmas as g
c=g.c
HERE=Path(__file__).resolve().parent
SCOPE='two named finite ledger state/length queries; not full ACK, invariant basis, IR translation, bytes/time, implementation or TCP proof'


def selection():
    r=json.loads((HERE/'selection.json').read_text())
    if r!={'targets':[295,296],'recipe':dict(variable='v_0_cb_head',values=list(range(16)),bounds=[dict(assertion=420,path=[0]),dict(assertion=420,path=[1])],target=443)}:
        raise ValueError('Named full source-domain selection changed')
    return r


def sources():
    folder=ROOT/'artifacts/sent-ledger-single-target-unknown';members=json.loads((folder/'members.json').read_text());raw={}
    with tarfile.open(folder/'exact-single-disjunct-attempt.tar.gz')as stream:
        for number in selection()['targets']:
            name=f'group-{number:03}.smt2';data=stream.extractfile(name).read()
            if hashlib.sha256(data).hexdigest()!=members[name]:raise ValueError('Original query member changed')
            raw[number]=data
    return raw


def metadata():
    return dict(status='source_bound_proposals_pending_independent_verification',controller_sha256=c.sha(__file__),
        generator_sha256=c.sha(ROOT/'tools/propose_finite_certificate.py'),checker_versions=g.versions(),
        selection_sha256=c.sha(HERE/'selection.json'),source_hashes={str(i):hashlib.sha256(data).hexdigest()for i,data in sources().items()},
        kernel_checked=False,ir_translation_proved=False,whole_target_closed=False,scope=SCOPE)


def produce(out,adopt=None):
    out=Path(out)
    if out.exists():raise ValueError('Use a fresh output directory')
    before=metadata();out.mkdir(parents=True);raw=sources()
    if adopt is not None and set(adopt)!=set(raw):raise ValueError('Incomplete adopted certificate mapping')
    spec=importlib.util.spec_from_file_location('known_finite_proposer',ROOT/'tools/propose_finite_certificate.py')
    proposer=importlib.util.module_from_spec(spec);spec.loader.exec_module(proposer)
    for number,data in raw.items():
        item=f'group-{number:03}';directory=out/'certificates'/item
        if adopt is None:
            source=out/f'{item}.smt2';source.write_bytes(data)
            proposer.produce(source,directory,selection()['recipe'])
        else:shutil.copytree(adopt[number],directory)
        if q.source(directory)[0].read_bytes()!=data:raise ValueError('Proposed original source mismatch')
        proposal=json.loads((directory/'proposal-result.json').read_text())
        if proposal['generator_sha256']!=before['generator_sha256']or proposal['status']!='native_routes_complete_unverified':
            raise ValueError('Incomplete native proposal routes or different generator')
    if metadata()!=before:raise ValueError('Source/checker/generator epoch changed')
    c.write(out/'controller-result.json',before);return before


def verify(out,verification_out):
    out,verification_out=Path(out),Path(verification_out)
    if verification_out.exists()or verification_out.resolve().is_relative_to(out.resolve()):raise ValueError('Use a fresh separate verification directory')
    if json.loads((out/'controller-result.json').read_text())!=metadata():raise ValueError('Controller/source/epoch/scope changed')
    raw=sources()
    for number,data in raw.items():
        cert=out/'certificates'/f'group-{number:03}'
        if q.source(cert)[0].read_bytes()!=data:raise ValueError('Wrong original source')
        if json.loads((cert/'proof/finite/result.json').read_text())['recipe']!=selection()['recipe']:raise ValueError('Finite source domain changed')
    verification_out.mkdir(parents=True);rows=[]
    for number,data in raw.items():
        item=f'group-{number:03}';copy=verification_out/item;shutil.copytree(out/'certificates'/item,copy)
        checked=q.verify(copy,hashlib.sha256(data).hexdigest())
        if checked['status']!='verified_standalone_query_unsat'or checked['details']['finite']['context']['query']!='sat':raise ValueError('Original query not independently closed/nonvacuous')
        rows.append(dict(disjunct=number,verification=checked));print('verified-original-prefix',number,flush=True)
    result=dict(status='verified_original_prefix_queries_nonvacuous',queries=rows,scope=SCOPE,kernel_checked=False,whole_target_closed=False)
    c.write(verification_out/'result.json',result);return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    parser.add_argument('--verify-out',type=Path);parser.add_argument('--adopt',nargs=2,type=Path)
    args=parser.parse_args()
    print(json.dumps(verify(args.out,args.verify_out)if args.verify_out else produce(args.out,dict(zip([295,296],args.adopt))if args.adopt else None)),flush=True)
