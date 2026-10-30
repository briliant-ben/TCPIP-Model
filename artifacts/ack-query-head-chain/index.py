"""Derive a named-query index only after retained independent archive replay."""
import hashlib,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from protocol_lab.ir import load
HERE=Path(__file__).resolve().parent
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()

def derive():
    prior_path=ROOT/'artifacts/ack-query-reuse/coverage-index.json';prior=json.loads(prior_path.read_text())
    accepted=json.loads((HERE/'archive-acceptance.json').read_text());record=json.loads((HERE/'acceptance.json').read_text())
    selected=json.loads((HERE/'selection.json').read_text())['targets']
    graph=accepted['proof_graph']
    if accepted['status']!='accepted_original_queries_with_checked_dependencies'or accepted['closed_original_disjuncts']!=selected or record['closed_original_disjuncts']!=selected:
        raise ValueError('Missing independent archive acceptance')
    if graph['producer_status']!='original_queries_unsat_nonvacuous'or graph['context']['query']!='sat'or [r['name']for r in graph['targets']]!=[f'group-{i:03}'for i in selected]or any(r['query']['query']!='unsat'for r in graph['targets']):
        raise ValueError('Not all selected original queries closed')
    model=load(ROOT/'model/tcp-sent-ledger.json');rows=[]
    for number,row in zip(selected,graph['targets']):
        slot=(number-300)//4
        if not 1<=slot<=15 or number!=300+4*slot:raise ValueError('Wrong slot query index')
        key=f'CB-INV-SLOT-{slot:02}'
        inv=next(x for x in model['invariants']if x['id']==key)
        rows.append(dict(disjunct=number,source_sha256=row['source_sha256'],checkpoint='artifacts/ack-query-head-chain/acceptance.json',
            checkpoint_sha256=sha(HERE/'acceptance.json'),proof_kind='checked_same_context_dependency_chain',
            source_assertions=444,proved_dependencies=351,declared_invariant=key,ir_assertion=inv['assert'],
            requirements={r:model['requirements'][r]for r in inv['requirements']},
            trace_scope='documentation trace to resolved source IR; IR-to-SMT compiler correctness remains trusted'))
    if not set(selected)<=set(prior['remaining_unknown_disjuncts']):raise ValueError('Queries already counted or not in original remainder')
    return dict(status='derived_named_query_index_not_a_combined_proof',target=prior['target'],
        previous_index=str(prior_path.relative_to(ROOT)),previous_index_sha256=sha(prior_path),
        previous_named_unsat_disjuncts=prior['total_named_unsat_disjuncts'],new_checked_disjuncts=rows,
        total_named_unsat_disjuncts=prior['total_named_unsat_disjuncts']+len(rows),total_original_disjuncts=368,
        remaining_unknown_disjuncts=sorted(set(prior['remaining_unknown_disjuncts'])-set(selected)),
        whole_target_closed=False,kernel_checked=False,
        scope='original finite ledger state/length query index only; not a combined368 proof, specification coverage, ACK/basis or TCP proof')

if __name__=='__main__':print(json.dumps(derive(),indent=2))
