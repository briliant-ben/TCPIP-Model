"""Trusted restricted-source and state-projection gate for a DeepSeek helper."""
import argparse
import ast
import copy
import hashlib
import json
from pathlib import Path
import sys
import types
import traceback
from validate_namespace_proposal import source_gate

def need(ok,text):
    if not ok:raise ValueError(text)

def check(workspace,proposals,out):
    for name,count in [('word32-contract',10),('ipv4-udp-icmp-tap',11),('tcp-wire-endpoint',11)]:
        if len(list((workspace/'scenarios'/name).glob('*.json')))!=count:raise FileNotFoundError('Frozen fixtures missing: '+name)
    sys.path.insert(0,str(workspace))
    from protocol_lab.ir import load,validate,Machine,ModelError
    from protocol_lab.flow import run_scenario
    from protocol_lab.codegen import generate
    from protocol_lab.codegen.execute import build,run
    files=[p for p in proposals.rglob('*.py')if any(isinstance(n,ast.FunctionDef)and n.name=='lower_component_state'for n in ast.parse(p.read_text()).body)]
    need(len(files)==1,'One state-lowering module required');path=files[0];tree=source_gate(path);module=types.ModuleType('restricted_state_lowering');exec(compile(tree,str(path),'exec'),module.__dict__)
    state_var='internal_control';global_state='COMPOSED';rid='COMPONENT-STATE-DOMAIN'
    binding=dict(source='docs/component-state-lowering.md',kind='modeling_choice',strength='exact control-state representation',interpretation='Internal control variable represents the original finite component state under default initialization.')
    def expr(e):
        if not isinstance(e,dict):return copy.deepcopy(e)
        if set(e)=={'state'}:return dict(op='eq',args=[dict(var=state_var),e['state']])
        result=copy.deepcopy(e)
        if set(e)=={'op','args'}:result['args']=[expr(a)for a in e['args']]
        return result
    def action(a):
        a=copy.deepcopy(a);k=next(iter(a));v=a[k]
        if k=='set':v['value']=expr(v['value'])
        elif k=='emit':v['fields']={n:expr(e)for n,e in v['fields'].items()}
        elif k=='arm':v['delay_ms']=expr(v['delay_ms'])
        elif k!='cancel':raise ValueError('Unsupported action')
        return a
    results=[]
    for name in ('word32-contract','ipv4-udp-icmp-tap','tcp-wire-endpoint'):
        original=load(workspace/'model'/(name+'.json'));frozen=copy.deepcopy(original);actual=module.lower_component_state(original,state_var,global_state)
        need(original==frozen,'Input mutated');validate(actual)
        expected=copy.deepcopy(original);expected['states']=[global_state];expected['initial_state']=global_state
        expected['variables'][state_var]=dict(type='string',initial=original['initial_state']);expected['requirements'][rid]=binding
        domain=[dict(op='eq',args=[dict(var=state_var),s])for s in original['states']];assertion=domain[0]
        for term in domain[1:]:assertion=dict(op='or',args=[assertion,term])
        expected['invariants']=[dict(i,**{'assert':expr(i['assert'])})for i in original['invariants']]+[dict(id=rid,requirements=[rid],**{'assert':assertion})]
        expected['transitions']=[]
        for t in original['transitions']:
            transformed=copy.deepcopy(t);transformed['from']=transformed['to']=global_state
            transformed['guard']=dict(op='and',args=[dict(op='eq',args=[dict(var=state_var),t['from']]),expr(t['guard'])])
            transformed['actions']=[action(a)for a in t['actions']]+[dict(set=dict(var=state_var,value=t['to']))];expected['transitions'].append(transformed)
        need(actual==expected,'State lowering differs from exact source/target/action/invariant contract')
        try:Machine(actual,{state_var:'not-a-component-state'})
        except ModelError:pass
        else:raise ValueError('Internal control-state domain invariant missing')
        for invalid in ('collision','terminal'):
            sample=copy.deepcopy(original)
            if invalid=='collision':sample['variables'][state_var]=dict(type='string',initial='x')
            else:sample['scope']['terminal_states']=[sample['states'][0]]
            try:module.lower_component_state(sample,state_var,global_state)
            except (ValueError,TypeError):pass
            else:raise ValueError('Unsupported lowering accepted: '+invalid)
        scenes=sorted((workspace/'scenarios'/name).glob('*.json'));need(bool(scenes),'Missing frozen fixtures')
        for f in scenes:
            scene=json.loads(f.read_text());reference=run_scenario(original,scene);machine=Machine(actual,scene.get('initial'))
            for s in scene['steps']:
                if s.get('tick'):machine.tick(s['at_ms'])
                else:machine.dispatch(s['event'],s.get('fields',{}),s['at_ms'])
            if 'settle_ms'in scene:machine.tick(scene['settle_ms'])
            need(len(reference.trace)==len(machine.trace),'Trace length changed')
            for a,b in zip(reference.trace,machine.trace):
                need(b['time_ms']==a['time_ms']and b['transition']==a['transition']and b['emitted']==a['emitted'],'Rule/time/packet bytes changed')
                need(b['after']['state']==global_state and b['after']['variables']==dict(a['after']['variables'],**{state_var:a['after']['state']})and b['after']['timers']==a['after']['timers'],'State projection changed')
        folder=out/name;folder.mkdir();p=folder/'model.json';p.write_text(json.dumps(actual));generate(p,folder/'generated');need(build(folder/'generated',folder/'build')['status']=='pass','Native build failed')
        scene=json.loads(scenes[0].read_text());scene['expect'].setdefault('variables',{})[state_var]=scene['expect']['state'];scene['expect']['state']=global_state;p=folder/'scene.json';p.write_text(json.dumps(scene));need(run(folder/'generated',folder/'build',p,folder/'native')['status']=='pass','Native mismatch')
        results.append(dict(model=name,rules=len(original['transitions']),frozen_scenarios=len(scenes),native_cases=1))
    return dict(status='validated_state_lowering',source_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),models=results,proposal_executed=True,protocol_complete=False,compiler_correctness_proved=False)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--workspace',type=Path,required=True);p.add_argument('--proposals',type=Path,required=True);p.add_argument('--out',type=Path,required=True);a=p.parse_args();a.out.mkdir(parents=True,exist_ok=False)
    try:result=check(a.workspace.resolve(),a.proposals.resolve(),a.out)
    except Exception as error:
        frames=traceback.extract_tb(error.__traceback__)
        classification='environment_or_checker'if isinstance(error,(FileNotFoundError,ImportError))or(isinstance(error,(IndexError,KeyError))and frames[-1].filename==__file__)else'candidate_invalid'
        result=dict(status='rejected',error_type=type(error).__name__,reason=str(error)[:600],classification=classification)
    (a.out/'result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result));raise SystemExit(result['status']!='validated_state_lowering')
