"""Reconstruct the scalar IR statements and recheck positive/negative evidence."""
from pathlib import Path
import copy
import json
import sys
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT));sys.path.insert(0,str(ROOT/'formal'))
import modular_normalization as norm
from protocol_lab.ir import load,Machine,ModelError
from protocol_lab.symbolic import Encoding,encode_trace,model_hash
from protocol_lab.inductive import verify as verify_inductive
import z3


api_checks=[]
def same_query(path,expected):
    actual=norm.read_query(path)
    assert len(actual)==len(expected),'Statement/assumption coverage changed'
    for index,(a,b)in enumerate(zip(actual,expected)):
        if a.eq(b):continue
        # Numeral serialization can change AST form. Require unconditional
        # equivalence, never use the other original premises to conceal a change.
        folder=HERE/'api-export-checks';folder.mkdir(exist_ok=True)
        target=folder/('equality-'+str(len(api_checks)).zfill(3)+'.smt2')
        solver=z3.Solver();solver.add(z3.Xor(a,b));target.write_text(solver.to_smt2())
        answer=norm.cli(target,target.with_suffix('.log'))
        assert answer['query']=='unsat','Statement/assumption differs or equivalence unknown'
        api_checks.append(dict(source_file=str(path.relative_to(HERE)),assertion_index=index,
            proof_file=str(target.relative_to(HERE)),proof_sha256=norm.sha(target),
            query_premises_used=False,**answer))


r=json.loads((HERE/'acceptance.json').read_text())
assert r['status']=='two_declared_scalar_ir_laws_inductively_checked_modular_backend'
for path,sha in r['input_hashes'].items():assert norm.sha(ROOT/path)==sha,path
assert not any(r[k]for k in ('byte_content_proved','python_interpreter_universally_proved','translator_universally_proved','kernel_checked','tcp_invariants_closed','protocol_complete'))
model=load(ROOT/'model/seq32-contract.json');assert model_hash(model)==r['model_semantic_sha256']
assert [i['id']for i in model['invariants']]==['SEQ32-ROUNDTRIP','SEQ32-INVERSE-DISPLACEMENT']
enc=Encoding(model,1,(),sequence_encoding='modular-int')
enc.solver.add(z3.Int('choice_0')==0,z3.Not(z3.And(*[enc.expr(i['assert'],enc.frames[1])for i in model['invariants']])))
same_query(HERE/'original-modular.smt2',list(enc.solver.assertions()))
normalization=norm.verify(HERE/'normalized')
assert normalization['assertions']==r['original_assertions']==36
assert normalization['rewrites']==r['rewrites']==3 and normalization['universal_equalities']==r['universal_equalities']==3
induction=verify_inductive(model,HERE/'inductive')
queries={}
for name,path in [('original',HERE/'original-modular.smt2'),('normalized',HERE/'normalized/normalized.smt2')]:
    answer=norm.cli(path,HERE/(name+'-independent.log'));assert answer['query']=='unsat';queries[name]=answer
boundaries=[]
for i,row in enumerate(r['boundary_scenes']):
    target=HERE/'boundary'/str(i);fields=json.loads((target/'fields.json').read_text());assert fields==row['fields']
    machine=Machine(model);machine.dispatch('probe',fields,0)
    assert machine.values['roundtrip']==fields['right']and machine.values['restored']==fields['left']
    assert machine.trace==json.loads((target/'trace.json').read_text())
    encoding=encode_trace(model,machine.trace);same_query(target/'symbolic/path.smt2',list(encoding.solver.assertions()))
    answer=norm.cli(target/'symbolic/path.smt2',target/'independent-cli.log');assert answer['query']=='sat';boundaries.append(answer)
faults=[]
for row in r['faults']:
    name=row['name'];expected=copy.deepcopy(model)
    if name=='reverse-distance':expected['transitions'][0]['actions'][3]['set']['value']['args'].reverse()
    else:
        assert name=='wrong-inverse';expected['transitions'][0]['actions'][-1]['set']['value']['args'][1]={'var':'offset'}
    target=HERE/'faults'/name;assert json.loads((target/'model.json').read_text())==expected
    enc=Encoding(expected,1,(),fixed_choices=[0]);fields=dict(left=0,right=1,offset=1)
    for key,value in fields.items():enc.solver.add(enc.events[0]['probe'][key]==enc.literal(value,expected['events']['probe']['fields'][key]))
    enc.solver.add(z3.Not(z3.And(*[enc.expr(i['assert'],enc.frames[1])for i in expected['invariants']])))
    same_query(target/'query.smt2',list(enc.solver.assertions()))
    answer=norm.cli(target/'query.smt2',target/'independent-cli.log');assert answer['query']=='sat'
    try:Machine(expected).dispatch('probe',fields,0)
    except ModelError as e:
        invariant='SEQ32-ROUNDTRIP'if name=='reverse-distance'else'SEQ32-INVERSE-DISPLACEMENT'
        assert 'Invariant failed: '+invariant in str(e)
    else:raise AssertionError('Fault did not violate its declared scalar invariant')
    faults.append(dict(name=name,**answer))
primary=json.loads((HERE/'primary-bitvector/result.json').read_text())
assert primary['model_semantic_sha256']==r['model_semantic_sha256']and primary['status']==r['primary_bitvector']
assert primary['smt2_sha256']==norm.sha(HERE/'primary-bitvector/model.smt2')
result=dict(status='valid_scalar_ir_contract_and_exact_modular_certificates',source_model_sha256=norm.sha(ROOT/'model/seq32-contract.json'),
    checker_sha256=norm.sha(__file__),normalization=normalization,inductive=induction,api_export_checks=api_checks,
    original_and_normalized_queries=queries,boundary_rechecks=boundaries,fault_rechecks=faults,
    primary_bitvector_status_retained=primary['status'],kernel_checked=False,full_tcp_proved=False,
    scope='two scalar IR laws, all seq32 inputs and all integer displacements in modular induction; reference checks finite')
norm.write(HERE/'verification.json',result)
print('Scalar IR model/queries/certificates reconstructed;8 boundary SAT and2 fault SAT checked; BV primary retained '+primary['status'])
