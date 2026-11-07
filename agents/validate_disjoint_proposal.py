"""Controller-owned acceptance for pure disjoint IR union, not packet routing."""
import argparse
import ast
import copy
import hashlib
import json
from pathlib import Path
import sys
import traceback
import types
from validate_namespace_proposal import source_gate

def need(ok, reason):
    if not ok: raise ValueError(reason)

def check(workspace, proposals, out):
    sys.path.insert(0, str(workspace))
    from protocol_lab.ir import load, validate
    from protocol_lab.flow import run_scenario
    from protocol_lab.compose.namespace_component import namespace_component
    from protocol_lab.compose.lower_component_state import lower_component_state
    from protocol_lab.codegen import generate
    from protocol_lab.codegen.execute import build, run
    paths=[p for p in proposals.rglob('*.py') if any(isinstance(n, ast.FunctionDef) and n.name=='merge_disjoint_components' for n in ast.parse(p.read_text()).body)]
    need(len(paths)==1,'Exactly one union implementation required')
    path=paths[0]; tree=source_gate(path); module=types.ModuleType('restricted_union')
    exec(compile(tree,str(path),'exec'),module.__dict__)
    models=[]
    for name in ('word32-contract','ipv4-udp-icmp-tap','tcp-wire-endpoint'):
        original=load(workspace/'model'/(name+'.json'))
        transformed,_=namespace_component(lower_component_state(original,'control','GLOBAL'),name)
        models.append(transformed)
    # Legal metadata and application string values are not type declarations.
    # A broad textual rational/clock/post scan must not reject this valid IR.
    models[0]['scope']['legal_string_labels']=['rational','clock','post']
    models[0]['variables']['ordinary_rational_label']={'type':'string','initial':'post'}
    frozen=copy.deepcopy(models); actual=module.merge_disjoint_components(models,'disjoint-test')
    need(models==frozen,'Source components mutated'); validate(actual)
    expected=copy.deepcopy(models[0]); expected['protocol']='disjoint-test'; expected['ir_version']='0.6'
    expected['scope']=dict(terminal_states=[],component_scopes=[copy.deepcopy(m.get('scope',{})) for m in models])
    for key in ('variables','events','timers','messages','requirements'):
        expected[key]={k:copy.deepcopy(v) for m in models for k,v in m[key].items()}
    for key in ('transitions','invariants'):
        expected[key]=[copy.deepcopy(v) for m in models for v in m[key]]
    need(actual==expected,'Exact disjoint union contract differs')
    negatives=[]
    for kind in ('duplicate','terminal','state','semantics','extension','rational','old-version'):
        bad=copy.deepcopy(models)
        if kind=='duplicate':bad.append(copy.deepcopy(bad[0]))
        elif kind=='terminal':bad[0]['scope']['terminal_states']=['GLOBAL']
        elif kind=='state':bad[0]['states']=['OTHER'];bad[0]['initial_state']='OTHER'
        elif kind=='semantics':bad[0]['semantics']='flat-efsm-atomic-ordered-clock-v3'
        elif kind=='extension':bad[0]['unknown_semantics']={}
        elif kind=='old-version':bad[0]['ir_version']='0.4'
        else:bad[0]['variables']['unsupported']={'type':'rational','initial':{'n':0,'d':1}}
        before=copy.deepcopy(bad)
        try:module.merge_disjoint_components(bad,'negative')
        except ValueError:pass
        else:raise ValueError('Unsupported union admitted: '+kind)
        need(before==bad,'Rejected source mutated');negatives.append(kind)
    results=[]
    # Original literals drive expected output; the union must preserve every
    # component's packet and state contract without regenerating an oracle.
    for name,component in zip(('word32-contract','ipv4-udp-icmp-tap','tcp-wire-endpoint'),models):
        scenes=sorted((workspace/'scenarios'/name).glob('*.json'))
        need(len(scenes)==(10 if name=='word32-contract' else 11),'Frozen fixture set missing')
        adapted=[]
        for file in scenes:
            scene=json.loads(file.read_text()); oldstate=scene['expect']['state']
            scene['initial']={name+'.'+k:v for k,v in scene.get('initial',{}).items()}
            for step in scene['steps']:
                if 'event' in step:step['event']=name+'.'+step['event']
                for trace in step.get('expect_trace',[]):
                    for emitted in trace['emitted']:emitted['message']=name+'.'+emitted['message']
            scene['expect']['state']='GLOBAL'
            scene['expect']['variables']={name+'.'+k:v for k,v in scene['expect'].get('variables',{}).items()}
            scene['expect']['variables'][name+'.control']=oldstate
            scene['expect']['timers']={name+'.'+k:v for k,v in scene['expect']['timers'].items()}
            run_scenario(actual,scene);adapted.append(scene)
        folder=out/name;folder.mkdir();model_file=folder/'model.json';model_file.write_text(json.dumps(actual))
        generate(model_file,folder/'generated');need(build(folder/'generated',folder/'build')['status']=='pass','Native compile failed')
        scenario=folder/'scenario.json';scenario.write_text(json.dumps(adapted[0]))
        need(run(folder/'generated',folder/'build',scenario,folder/'native')['status']=='pass','Actual union native mismatch')
        results.append(dict(component=name,frozen_scenarios=len(scenes),native_cases=1))
    return dict(status='validated_disjoint_union',source_sha256=hashlib.sha256(path.read_bytes()).hexdigest(),components=results,negative_cases=negatives,proposal_executed=True,packet_routing=False,protocol_complete=False)

if __name__=='__main__':
    parser=argparse.ArgumentParser()
    for key in ('workspace','proposals','out'):parser.add_argument('--'+key,type=Path,required=True)
    args=parser.parse_args();args.out.mkdir(parents=True,exist_ok=False)
    try:result=check(args.workspace.resolve(),args.proposals.resolve(),args.out)
    except Exception as error:
        result=dict(status='rejected',error_type=type(error).__name__,reason=str(error)[:600],classification='environment_or_checker' if isinstance(error,(FileNotFoundError,ImportError)) else 'candidate_invalid')
        (args.out/'traceback.txt').write_text(traceback.format_exc())
    (args.out/'result.json').write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result));raise SystemExit(result['status']!='validated_disjoint_union')
