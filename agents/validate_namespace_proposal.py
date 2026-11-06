"""Trusted namespace gate: restricted pure source, exact AST inverse, native tests.

Only a small pure Python subset may run. Provider tests are never executed.
All validation and native commands below are fixed controller code.
"""
import argparse
import ast
import copy
import hashlib
import importlib.util
import json
from pathlib import Path
import sys
import traceback
import types

AUDIT=dict(proposal_executed=False,phase='preflight',model=None)

def require(ok,message):
    if not ok:raise ValueError(message)

def source_gate(path):
    tree=ast.parse(path.read_text());functions={n.name for n in ast.walk(tree)if isinstance(n,ast.FunctionDef)}
    builtins={'isinstance','str','int','bool','list','dict','set','tuple','len','enumerate','zip','sorted','any','all','range','ValueError','TypeError','KeyError','RuntimeError','AssertionError'}
    forbidden={'open','eval','exec','compile','globals','locals','vars','getattr','setattr','delattr','dir','input','print','help','breakpoint','exit','quit','type'}
    imported=set()
    methods={'items','keys','values','get','append','extend','add','update','pop','copy','startswith','endswith'}
    for n in ast.walk(tree):
        require(not isinstance(n,(ast.ClassDef,ast.AsyncFunctionDef,ast.With,ast.AsyncWith,ast.Global,ast.Nonlocal,ast.Try)),'Unsupported source construct')
        if isinstance(n,ast.Import):require(all(a.name=='copy'and a.asname is None for a in n.names),'Only copy import allowed')
        if isinstance(n,ast.ImportFrom):
            require(n.module=='protocol_lab.ir'and all(a.name=='validate'for a in n.names),'Only trusted validate import allowed')
            imported|={a.asname or a.name for a in n.names}
        if isinstance(n,ast.Attribute):require(n.attr in methods or (isinstance(n.value,ast.Name)and n.value.id=='copy'and n.attr=='deepcopy'),'Attribute outside pure subset')
        if isinstance(n,ast.Name):require(not n.id.startswith('__')and n.id not in forbidden,'Private runtime/capability access forbidden')
        if isinstance(n,(ast.Assign,ast.AnnAssign,ast.AugAssign)):
            targets=n.targets if isinstance(n,ast.Assign)else[n.target]
            require(not any(isinstance(t,ast.Attribute)for target in targets for t in ast.walk(target)),'Attribute mutation forbidden')
        if isinstance(n,ast.Call):
            f=n.func
            if isinstance(f,ast.Name):require(f.id in functions|builtins|imported,'Call outside pure subset: '+f.id)
            elif isinstance(f,ast.Attribute):require(f.attr in methods or (isinstance(f.value,ast.Name)and f.value.id=='copy'and f.attr=='deepcopy'),'Method outside pure subset: '+f.attr)
            else:raise ValueError('Dynamic callable forbidden')
    return tree

def validate_proposal(workspace,proposals,out):
    for name,count in [('word32-contract',10),('ipv4-udp-icmp-tap',11),('tcp-wire-endpoint',11)]:
        if len(list((workspace/'scenarios'/name).glob('*.json')))!=count:raise FileNotFoundError('Frozen fixture set missing: '+name)
    sys.path.insert(0,str(workspace))
    from protocol_lab.ir import load,validate,Machine
    from protocol_lab.flow import run_scenario
    from protocol_lab.codegen import generate
    from protocol_lab.codegen.execute import build,run
    selected=[]
    for p in proposals.rglob('*.py'):
        tree=ast.parse(p.read_text())
        if any(isinstance(n,ast.FunctionDef)and n.name=='namespace_component'for n in tree.body):selected.append(p)
    require(len(selected)==1,'Exactly one namespace module required');path=selected[0];tree=source_gate(path)
    module=types.ModuleType('restricted_namespace_proposal')
    # Execute exactly the reviewed AST, not a second encoding-cookie parse.
    exec(compile(tree,str(path),'exec'),module.__dict__)
    prefix='checked';label=lambda n:prefix+'.'+n
    def expr(old,new):
        if not isinstance(old,dict):require(old==new,'Literal changed');return
        require(set(old)==set(new),'AST shape changed')
        if set(old)in ({'var'},{'timer_active'}):
            key=next(iter(old));require(new[key]==label(old[key]),'Identifier expression not renamed');return
        if set(old)=={'op','args'}:
            require(old['op']==new['op']and len(old['args'])==len(new['args']),'Operator changed')
            for a,b in zip(old['args'],new['args']):expr(a,b)
        else:require(old==new,'Event field/state/literal must remain unchanged')
    def actions(old,new):
        require(len(old)==len(new),'Action count changed')
        for a,b in zip(old,new):
            require(set(a)==set(b),'Action kind changed');kind=next(iter(a));x,y=a[kind],b[kind]
            if kind=='set':require(set(x)==set(y)=={'var','value'}and y['var']==label(x['var']),'Assignment changed');expr(x['value'],y['value'])
            elif kind=='emit':
                require(set(x)==set(y)=={'message','fields'}and y['message']==label(x['message'])and x['fields'].keys()==y['fields'].keys(),'Message schema changed')
                for n in x['fields']:expr(x['fields'][n],y['fields'][n])
            elif kind=='arm':require(set(x)==set(y)=={'timer','delay_ms'}and y['timer']==label(x['timer']),'Timer changed');expr(x['delay_ms'],y['delay_ms'])
            elif kind=='cancel':require(y==label(x),'Cancel changed')
            else:raise ValueError('Unsupported atomic action')
    results=[]
    for model_name,scenes in [('word32-contract','word32-contract'),('ipv4-udp-icmp-tap','ipv4-udp-icmp-tap'),('tcp-wire-endpoint','tcp-wire-endpoint')]:
        AUDIT.update(phase='component_namespace',model=model_name,proposal_executed=True)
        old=load(workspace/'model'/(model_name+'.json'));frozen=copy.deepcopy(old)
        # Field/variable collision catches erroneous event-field renaming.
        if model_name=='word32-contract':
            old['events']['pack']['fields']={'packed':'int'}
            old['transitions'][0]['actions'][0]['set']['value']['args']=[{'event':'packed'}]
            frozen=copy.deepcopy(old)
        transformed,tables=module.namespace_component(old,prefix);require(old==frozen,'Input mutated');validate(transformed)
        require(set(old)==set(transformed),'Model fields changed')
        for k in ('ir_version','protocol','semantics','scope','states','initial_state'):require(old[k]==transformed[k],'Component metadata/state changed: '+k)
        expected_tables={}
        for k in ('variables','events','timers','messages','requirements'):
            expected_tables[k]={n:label(n)for n in old[k]};require(set(transformed[k])==set(expected_tables[k].values()),'Identifier set changed: '+k)
            for n,body in old[k].items():
                expected=copy.deepcopy(body)
                if k=='timers':expected['event']=label(body['event'])
                require(transformed[k][label(n)]==expected,'Declaration/field names/literals changed: '+k+'/'+n)
        for k in ('transitions','invariants'):
            expected_tables[k]={r['id']:label(r['id'])for r in old[k]};require(len(old[k])==len(transformed[k]),'Rule/property omitted')
            for a,b in zip(old[k],transformed[k]):
                require(set(a)==set(b)and b['id']==label(a['id'])and b['requirements']==[label(n)for n in a['requirements']],'Rule/property identity changed')
                if k=='invariants':expr(a['assert'],b['assert'])
                else:
                    require(a['from']==b['from']and a['to']==b['to']and b['event']==label(a['event']),'Transition state/event changed')
                    expr(a['guard'],b['guard']);actions(a['actions'],b['actions'])
        require(tables==expected_tables,'Exact plural-key mapping tables required')
        AUDIT['phase']='frozen_reference_scenarios';cases=sorted((workspace/'scenarios'/scenes).glob('*.json'))
        for scene_path in cases:
            scene=json.loads(scene_path.read_text())
            if model_name=='word32-contract':
                for s in scene['steps']:s['fields']={'packed':s['fields']['value']}
            reference=run_scenario(old,scene);machine=Machine(transformed,{label(n):v for n,v in scene.get('initial',{}).items()})
            for step in scene['steps']:
                if step.get('tick'):machine.tick(step['at_ms'])
                else:machine.dispatch(label(step['event']),step.get('fields',{}),step['at_ms'])
            if 'settle_ms'in scene:machine.tick(scene['settle_ms'])
            require(len(machine.trace)==len(reference.trace),'Trace count changed')
            for a,b in zip(reference.trace,machine.trace):
                require(b['transition']==label(a['transition'])and b['time_ms']==a['time_ms'],'Rule/time changed')
                require(b['after']['state']==a['after']['state']and b['after']['variables']=={label(n):v for n,v in a['after']['variables'].items()}and b['after']['timers']=={label(n):v for n,v in a['after']['timers'].items()},'State/value/timer changed')
                require(b['emitted']==[dict(message=label(e['message']),fields=e['fields'])for e in a['emitted']],'Output bytes/fields changed')
        AUDIT['phase']='native';folder=out/model_name;folder.mkdir();model_path=folder/'model.json';model_path.write_text(json.dumps(transformed));generate(model_path,folder/'generated');require(build(folder/'generated',folder/'build')['status']=='pass','Native build failed')
        # Preserve the independently frozen literals; rename identifiers only.
        scene=json.loads(cases[0].read_text())
        for s in scene['steps']:
            if model_name=='word32-contract':s['fields']={'packed':s['fields']['value']}
            if 'event'in s:s['event']=label(s['event'])
            for row in s.get('expect_trace',[]):
                for emitted in row['emitted']:emitted['message']=label(emitted['message'])
        scene['expect']['variables']={label(n):v for n,v in scene['expect'].get('variables',{}).items()}
        scene['expect']['timers']={label(n):v for n,v in scene['expect']['timers'].items()}
        scene['initial']={label(n):v for n,v in scene.get('initial',{}).items()};scene_path=folder/'native-scene.json';scene_path.write_text(json.dumps(scene))
        require(run(folder/'generated',folder/'build',scene_path,folder/'native')['status']=='pass','Native/reference mismatch')
        results.append(dict(model=model_name,exact_rules=len(old['transitions']),frozen_scenarios=len(cases),native_cases=1))
    return dict(status='validated_namespace_component',source_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),models=results,protocol_complete=False,compiler_correctness_proved=False,**AUDIT)

if __name__=='__main__':
    p=argparse.ArgumentParser();p.add_argument('--workspace',type=Path,required=True);p.add_argument('--proposals',type=Path,required=True);p.add_argument('--out',type=Path,required=True);a=p.parse_args();a.out.mkdir(parents=True,exist_ok=False)
    try:result=validate_proposal(a.workspace.resolve(),a.proposals.resolve(),a.out)
    except Exception as error:
        frames=traceback.extract_tb(error.__traceback__)
        classification='environment_or_checker'if isinstance(error,(FileNotFoundError,ImportError))or(isinstance(error,IndexError)and frames[-1].filename==__file__)else'candidate_invalid'
        result=dict(status='rejected',classification=classification,error_type=type(error).__name__,reason=str(error)[:600],checker_sha256=hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),**AUDIT)
    (a.out/'result.json').write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result));raise SystemExit(result['status']!='validated_namespace_component')
