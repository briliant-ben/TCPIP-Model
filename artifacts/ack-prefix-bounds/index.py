"""Derive the named original-query index after independent archive acceptance."""
import hashlib,json,sys
from pathlib import Path
ROOT=Path(__file__).resolve().parents[2]
sys.path.insert(0,str(ROOT))
from protocol_lab.ir import load
HERE=Path(__file__).resolve().parent
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()

def derive():
    previous=ROOT/'artifacts/ack-query-head-chain/coverage-index.json';old=json.loads(previous.read_text())
    accepted=json.loads((HERE/'archive-acceptance.json').read_text())
    if accepted['status']!='accepted_original_prefix_queries_after_archive_replay'or accepted['closed_original_disjuncts']!=[295,296]:raise ValueError('Missing named archive acceptance')
    if old['remaining_unknown_disjuncts']!=[295,296]or old['total_named_unsat_disjuncts']!=366:raise ValueError('Wrong previous index')
    rows=accepted['proof_checks']['queries']
    if [r['disjunct']for r in rows]!=[295,296]or any(r['verification']['status']!='verified_standalone_query_unsat'for r in rows):raise ValueError('Incomplete fresh query verification')
    model=load(ROOT/'model/tcp-sent-ledger.json');inv=next(x for x in model['invariants']if x['id']=='CB-INV-PARTIAL')
    new=[]
    for row in rows:
        new.append(dict(disjunct=row['disjunct'],source_sha256=row['verification']['source_sha256'],
            checkpoint='artifacts/ack-prefix-bounds/acceptance.json',checkpoint_sha256=sha(HERE/'acceptance.json'),
            proof_kind='full_source_domain_raw_finite_with_checked_local_and_leaf_routes',source_assertions=444,
            finite_cases=16,checked_tactic_routes=32,declared_invariant=inv['id'],ir_assertion=inv['assert'],
            requirements={key:model['requirements'][key]for key in inv['requirements']},
            trace_scope='one lower/upper prefix subclause in the declared finite IR invariant; IR compiler correctness remains trusted'))
    return dict(status='all_named_disjuncts_have_evidence_not_a_combined_target_proof',target=old['target'],
        previous_index=str(previous.relative_to(ROOT)),previous_index_sha256=sha(previous),previous_named_unsat_disjuncts=366,
        new_checked_disjuncts=new,total_named_unsat_disjuncts=368,total_original_disjuncts=368,remaining_unknown_disjuncts=[],
        whole_target_closed=False,kernel_checked=False,
        scope='named original finite ledger query evidence only; original combined target and full basis/IR/bytes/time/implementation/TCP proof are separate')

if __name__=='__main__':print(json.dumps(derive(),indent=2))
