"""Produce scalar IR law evidence; no TCP completion or translator-proof claim."""
from pathlib import Path
import copy
import hashlib
import json
import shutil
import sys
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT));sys.path.insert(0,str(ROOT/'formal'))
import modular_normalization as norm
from protocol_lab.ir import load,Machine
from protocol_lab.symbolic import Encoding,check,crosscheck_trace,replay,model_hash
from protocol_lab.inductive import verify as verify_inductive
import z3


def write(path,value):path.parent.mkdir(parents=True,exist_ok=True);path.write_text(json.dumps(value,indent=2)+'\n')


if (HERE/'acceptance.json').exists():raise ValueError('Use new snapshot; existing evidence retained')
model=load(ROOT/'model/seq32-contract.json')
# Reconstruct every original assertion from the authoritative model/backend.
enc=Encoding(model,1,(),sequence_encoding='modular-int')
enc.solver.add(z3.Int('choice_0')==0,z3.Not(z3.And(*[enc.expr(i['assert'],enc.frames[1])for i in model['invariants']])))
regenerated=HERE/'regenerated-modular.smt2';regenerated.write_text(enc.solver.to_smt2())
a=norm.read_query(HERE/'original-modular.smt2');b=norm.read_query(regenerated)
assert len(a)==len(b)==36 and all(x.eq(y)for x,y in zip(a,b))
normalization=norm.verify(HERE/'normalized');write(HERE/'normalization-verification.json',normalization)
queries={}
for name,path in [('original',HERE/'original-modular.smt2'),('normalized',HERE/'normalized/normalized.smt2')]:
    result=norm.cli(path,HERE/(name+'-cli.log'));assert result['query']=='unsat';queries[name]=result
inductive=verify_inductive(model,HERE/'inductive');write(HERE/'inductive-verification.json',inductive)
for name in ('initial.smt2','preservation.smt2','length-lemmas.smt2'):
    result=norm.cli(HERE/'inductive'/name,HERE/(name+'.cli.log'));assert result['query']=='unsat';queries[name]=result
primary=check(model,depth=1,symbolic_initials=(),out=HERE/'primary-bitvector')
write(HERE/'primary-cli.json',norm.cli(HERE/'primary-bitvector/model.smt2',HERE/'primary-cli.log'))
M=2**32
cases=[(0,0,0),(0,M-1,-1),(M-1,0,1),(M//2,0,-2**70+3),(0,M//2,2**70+7),(123,M-1,M+9),(M-1,1,-M-9),(M-1,M-1,2*M)]
scenes=[]
for i,(left,right,offset)in enumerate(cases):
    target=HERE/'boundary'/str(i);target.mkdir(parents=True,exist_ok=True)
    fields=dict(left=left,right=right,offset=offset);machine=Machine(model);machine.dispatch('probe',fields,0)
    assert machine.values['roundtrip']==right and machine.values['restored']==left
    result=crosscheck_trace(model,machine.trace,target/'symbolic');assert result['status']=='match'
    fresh=norm.cli(target/'symbolic/path.smt2',target/'fresh-cli.log');assert fresh['query']=='sat'
    write(target/'trace.json',machine.trace);write(target/'fields.json',fields)
    scenes.append(dict(fields=fields,symbolic=result['status'],fresh_cli=fresh['query']))
faults=[]
for name in ('reverse-distance','wrong-inverse'):
    variant=copy.deepcopy(model)
    if name=='reverse-distance':variant['transitions'][0]['actions'][3]['set']['value']['args'].reverse()
    else:variant['transitions'][0]['actions'][-1]['set']['value']['args'][1]={'var':'offset'}
    target=HERE/'faults'/name;target.mkdir(parents=True,exist_ok=True);write(target/'model.json',variant)
    enc=Encoding(variant,1,(),fixed_choices=[0])
    for key,value in dict(left=0,right=1,offset=1).items():
        enc.solver.add(enc.events[0]['probe'][key]==enc.literal(value,variant['events']['probe']['fields'][key]))
    enc.solver.add(z3.Not(z3.And(*[enc.expr(i['assert'],enc.frames[1])for i in variant['invariants']])))
    (target/'query.smt2').write_text(enc.solver.to_smt2());assert enc.solve()==z3.sat
    witness=enc.witness(enc.solver.model());actual=replay(variant,witness)
    assert actual['status']=='runtime_rejected'and 'Invariant failed'in actual['error']
    fresh=norm.cli(target/'query.smt2',target/'fresh-cli.log');assert fresh['query']=='sat'
    write(target/'witness.json',witness);write(target/'replay.json',actual)
    faults.append(dict(name=name,query='sat',fresh_cli='sat',replay=actual,scope='fixed legal typed witness, not unconstrained search completeness'))
for src,name in [('/tmp/seq32-contract-tests.log','contract-tests.log'),('/tmp/modular-normalization-tests.log','normalizer-tests.log'),('/tmp/seq32-contract-pilot.log','exploratory-bitvector-and-modular.log')]:shutil.copy2(src,HERE/name)
inputs=['model/seq32-contract.json','protocol_lab/ir.py','protocol_lab/symbolic.py','protocol_lab/inductive.py',
        'formal/modular_normalization.py','formal/tactic_recheck.py','formal/partition_queries.py','docs/semantics.md',
        'requirements-formal.txt','tests/test_modular_normalization.py','tests/test_seq32_contract.py',str(Path(__file__).relative_to(ROOT))]
write(HERE/'acceptance.json',dict(status='two_declared_scalar_ir_laws_inductively_checked_modular_backend',
    model_semantic_sha256=model_hash(model),input_hashes={p:norm.sha(ROOT/p)for p in inputs},
    statement='roundtrip a+distance(a,b)=b for all seq32 a,b; displacement inversion for all integer offsets',
    semantic_domain='full32bit sequence fields and unbounded signed integer offset; one scalar IR probe transition',
    original_assertions=36,rewrites=normalization['rewrites'],universal_equalities=normalization['universal_equalities'],
    modular_queries=queries,inductive=inductive,primary_bitvector=primary['status'],
    primary_bitvector_safety=primary['safety_query'],boundary_scenes=scenes,faults=faults,
    normalizer_methods=5,contract_methods=3,original_tcp_reports_unchanged=True,
    byte_content_proved=False,python_interpreter_universally_proved=False,translator_universally_proved=False,
    kernel_checked=False,tcp_invariants_closed=False,protocol_complete=False,
    trusted_components=['Protocol IR/model validation','Python expression/transition encoders and independent reference executor',
        'Python certificate traversal/instantiation/congruence checker','Z3 modular integer logic and CLI'],
    scope='declared scalar IR model laws and exact query equality; no TCP buffers/order/time/implementation or complete-protocol proof'))
print('Scalar IR contracts: modular induction and independent checks pass; bitvector primary='+primary['status'])
