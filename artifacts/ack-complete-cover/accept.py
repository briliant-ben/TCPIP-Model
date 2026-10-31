"""Freshly replay the full named ledger query and bind it to its IR epoch."""
import argparse,hashlib,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path[:0]=[str(ROOT),str(ROOT/'formal')]
from protocol_lab.ir import load
from protocol_lab.symbolic import model_hash
import query_cover as cover
HERE=Path(__file__).resolve().parent
MODEL_SHA='f44d0c74397487e17a5c5e0358105fff4ca7a27dc5cf239130ce1c54056cf0dd'
EXPORT_SHA='b83da01cb5f1f4ec72c7e9485e357ec9c57044d99c5411be5634087bc62aad8d'
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()


def anchor():
    if model_hash(load(ROOT/'model/tcp-sent-ledger.json'))!=MODEL_SHA:raise ValueError('Named IR semantics changed')
    folder=ROOT/'artifacts/sent-ledger-current-induction';report=json.loads((folder/'result.json').read_text())
    if report['model_semantic_sha256']!=MODEL_SHA or report['query_hashes']['preservation.smt2']!=EXPORT_SHA or sha(folder/'preservation.smt2')!=EXPORT_SHA:raise ValueError('Named source export changed')
    frozen=ROOT/'artifacts/full-regression-71a3e1a8/inputs.json';inputs=json.loads(frozen.read_text())
    changed=[name for name,digest in inputs.items()if not (ROOT/name).is_file()or sha(ROOT/name)!=digest]
    if changed:raise ValueError('Original IR/compiler/specification epoch changed: '+str(changed[:3]))
    plan=json.loads((HERE/'proposal/plan.json').read_text())
    expected=dict(file='artifacts/sent-ledger-current-induction/preservation.smt2',sha256=EXPORT_SHA,label='S-ACK-VALID -> ESTABLISHED',assertion_index=440)
    if plan['source']!=expected:raise ValueError('Wrong original preservation query')
    return dict(status='valid_named_ir_and_encoder_input_anchor',model='model/tcp-sent-ledger.json',model_semantic_sha256=MODEL_SHA,
        source_export_sha256=EXPORT_SHA,label=expected['label'],assertion_index=440,unchanged_original_inputs=len(inputs),input_manifest_sha256=sha(frozen),
        byte_encoding=report['byte_encoding'],sequence_encoding=report['sequence_encoding'],ir_translation_proved=False,
        scope='named finite state/length IR checkpoint; encoder remains trusted, not general TCP or implementation correctness')


def check_result(result):
    if result['status']!='verified_original_query_cover'or result['context_classification']!='nonvacuous'or result['context']['query']!='sat':raise ValueError('No nonvacuous complete cover')
    if result['source_assertions']!=444 or result['disjuncts']!=368 or [x['group']for x in result['original_groups']]!=list(range(368)):raise ValueError('Original partition incomplete')
    if result['source']['sha256']!=EXPORT_SHA or result['source']['label']!='S-ACK-VALID -> ESTABLISHED'or result['source']['assertion_index']!=440:raise ValueError('Wrong named source')
    if result['versions']!=cover.versions():raise ValueError('Cover checker epoch changed')


def accept(out):
    before=anchor();result=cover.verify(HERE/'proposal',out);check_result(result);after=anchor()
    if before!=after:raise ValueError('Named source model changed during verification')
    accepted=dict(status='accepted_named_ledger_preservation_target',ir_anchor_before=before,ir_anchor_after=after,
        cover=result,application_checker_sha256=sha(__file__),whole_named_exported_query_closed=True,
        whole_model_inductive_proof=False,kernel_checked=False,ir_translation_proved=False,whole_protocol_proved=False,
        scope='S-ACK-VALID to ESTABLISHED finite state/length preservation only; other targets, full basis, IR/bytes/time/implementation/TCP remain separate')
    (Path(out)/'named-target-result.json').write_text(json.dumps(accepted,indent=2)+'\n');return accepted


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    print(json.dumps(accept(parser.parse_args().out)),flush=True)
