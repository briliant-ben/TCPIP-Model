"""Bind query-level proofs to the named, unchanged ledger IR/export checkpoint."""
import argparse
import hashlib
import tarfile
import json
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT),str(ROOT/'formal')]
from protocol_lab.ir import load
from protocol_lab.symbolic import model_hash
from partition_queries import extract,disjuncts
import conditional_ssa as c
import query_certificates as q

MODEL_SHA='f44d0c74397487e17a5c5e0358105fff4ca7a27dc5cf239130ce1c54056cf0dd'
EXPORT_SHA='b83da01cb5f1f4ec72c7e9485e357ec9c57044d99c5411be5634087bc62aad8d'


def verify(out):
    out=Path(out);model_path=ROOT/'model/tcp-sent-ledger.json'
    if model_hash(load(model_path))!=MODEL_SHA:raise ValueError('Named Protocol IR checkpoint changed')
    folder=ROOT/'artifacts/sent-ledger-current-induction';report=json.loads((folder/'result.json').read_text())
    export=folder/'preservation.smt2'
    if report['model_semantic_sha256']!=MODEL_SHA or c.sha(export)!=EXPORT_SHA or report['query_hashes']['preservation.smt2']!=EXPORT_SHA:
        raise ValueError('Named induction/export checkpoint changed')
    frozen=ROOT/'artifacts/full-regression-71a3e1a8/inputs.json'
    manifest=json.loads(frozen.read_text())
    changed=[name for name,digest in manifest.items()if not (ROOT/name).is_file()or c.sha(ROOT/name)!=digest]
    if changed:raise ValueError('Original IR/encoder/specification input epoch changed: '+str(changed[:3]))
    original=ROOT/'artifacts/sent-ledger-single-target-unknown'
    members=json.loads((original/'members.json').read_text())
    with tarfile.open(original/'exact-single-disjunct-attempt.tar.gz','r:gz')as stream:
        data=stream.extractfile('result.json').read()
    if hashlib.sha256(data).hexdigest()!=members['result.json']:raise ValueError('Original partition manifest changed')
    prior=json.loads(data)
    if prior['source_sha256']!=EXPORT_SHA or prior['label']!='S-ACK-VALID -> ESTABLISHED':raise ValueError('Wrong original target')
    terms=extract(export.read_text(),prior['label']);index=prior['assertion_index']
    branches=disjuncts(terms[index]);common=terms[:index]+terms[index+1:]
    if len(branches)!=368 or len(common)!=443:raise ValueError('Original coverage/source vector changed')
    selected=json.loads((Path(__file__).parent/'selection.json').read_text());checked=[]
    for number in selected['targets']:
        item=f'group-{number:03}';source=q.source(out/'certificates'/item)[0]
        expected=common+[c.z3.Or(branches[number])];actual=c.read_query(source)
        if len(actual)!=len(expected)or any(not a.eq(b)for a,b in zip(actual,expected)):
            raise ValueError('Prefix query no longer reconstructs from original export: '+item)
        checked.append(dict(disjunct=number,source_sha256=c.sha(source)))
    return dict(status='valid_named_ir_export_anchor',model='model/tcp-sent-ledger.json',
        model_semantic_sha256=MODEL_SHA,source_export_sha256=EXPORT_SHA,
        source_input_manifest_sha256=c.sha(frozen),unchanged_input_files=len(manifest),queries=checked,
        byte_encoding=report['byte_encoding'],sequence_encoding=report['sequence_encoding'],
        ir_translation_proved=False,kernel_checked=False,
        scope='named finite ledger state/length checkpoint only; encoder remains trusted, no full-byte/time/implementation or general protocol proof')


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    print(json.dumps(verify(parser.parse_args().out)))
