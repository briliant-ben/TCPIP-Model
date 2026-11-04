"""Check erasure and exact payload observation for the declarative byte overlay.

This checks source structure, not protocol logic or reachable-state correctness.
"""
import json
from pathlib import Path
import sys
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT))
from protocol_lab.ir import load
from protocol_lab.symbolic import model_hash


def check(base, observed):
    ghost=set(observed['variables'])-set(base['variables'])
    if not ghost or any(not n.startswith('bc_')for n in ghost):raise ValueError('Unexpected observer variables')
    for name,spec in base['variables'].items():
        if observed['variables'].get(name)!=spec:raise ValueError('Inherited variable changed')
    for key in ('ir_version','semantics','states','initial_state','events','timers','messages','scope'):
        if observed[key]!=base[key]:raise ValueError('Inherited '+key+' changed')
    for group in ('requirements','invariants'):
        if group=='requirements':
            if any(observed[group].get(k)!=v for k,v in base[group].items()):raise ValueError('Inherited requirement changed')
        elif observed[group][:len(base[group])]!=base[group]:raise ValueError('Inherited invariant changed')
    if len(base['transitions'])!=len(observed['transitions']):raise ValueError('Rule coverage changed')
    snapshots={'bc_before_snd':{'var':'snd_buf'},'bc_before_rtx':{'var':'rtx_buf'}}
    emissions=0;selected=[]
    for before,after in zip(base['transitions'],observed['transitions']):
        def erased(r):
            r=dict(r);r['actions']=[a for a in r['actions']if not ('set'in a and a['set']['var']in ghost)]
            r['requirements']=[x for x in r['requirements']if x in base['requirements']]
            return r
        if erased(after)!=before:raise ValueError('Inherited ordered rule changed: '+before['id'])
        actions=after['actions']
        if not actions or set(actions[0])!={'set'}or actions[0]['set']['var']!='bc_kind':raise ValueError('Missing observer selector reset')
        if type(actions[0]['set']['value'])is not int:raise ValueError('Nonliteral observer selector')
        if sum('set'in a and a['set']['var']=='bc_kind'for a in actions)!=1:raise ValueError('Selector rewritten')
        if actions[0]['set']['value']==0:
            if any('set'in a and a['set']['var']in ghost for a in actions[1:]):raise ValueError('Unexpected inactive observer writes')
            continue
        selected.append(before['id'])
        for offset,(name,value)in enumerate(snapshots.items(),1):
            if actions[offset]!={'set':{'var':name,'value':value}}:raise ValueError('Snapshot not taken before inherited actions')
            if sum('set'in a and a['set']['var']==name for a in actions)!=1:raise ValueError('Snapshot rewritten')
        if actions[4]!={'set':{'var':'bc_wire','value':{'bytes':[]}}}:raise ValueError('Missing wire reset')
        for i,a in enumerate(actions):
            emit=a.get('emit',a.get('emit_if'))
            if emit and emit['message']=='tcp_data':
                payload=emit['fields']['payload']
                if 'emit_if'in a:payload={'op':'ite','args':[emit['when'],payload,{'bytes':[]}]}
                expected={'set':{'var':'bc_wire','value':{'op':'bytes_concat','args':[{'var':'bc_wire'},payload]}}}
                if i==0 or actions[i-1]!=expected:raise ValueError('Payload observer does not match actual ordered emission')
                emissions+=1
            if 'set'in a and a['set']['var']=='bc_wire'and i!=4:
                if i+1>=len(actions):raise ValueError('Detached wire observer')
                following=actions[i+1].get('emit',actions[i+1].get('emit_if'))
                if not following or following['message']!='tcp_data':raise ValueError('Detached wire observer')
    return dict(status='inherited_semantics_erasure_and_wire_observation_checked',
                base_model_semantic_sha256=model_hash(base),observed_model_semantic_sha256=model_hash(observed),
                inherited_rules_checked=len(base['transitions']),selected_rules=selected,
                exact_ordered_data_emission_sites=emissions,
                observer_structure_is_kernel_proof=False,protocol_correctness_proved=False)


if __name__=='__main__':print(json.dumps(check(load(ROOT/'model/tcp-sws.json'),load(ROOT/'model/tcp-byte-content.json')),indent=2))
