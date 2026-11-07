"""Actual generated-native scenario suite with optional fixed-input Z3 replay.

This reports fixed-input correspondence, never all-input TCP/generator safety.
"""
import argparse
import json
from pathlib import Path
import sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from protocol_lab.codegen import generate,sha
from protocol_lab.codegen.execute import build,run,write
from protocol_lab.ir import load,model_files
from protocol_lab.flow import run_scenario


def suite(model_file,scenario_dir,out,formal_replay=False):
    model_file=Path(model_file).resolve();scenario_dir=Path(scenario_dir).resolve();out=Path(out).resolve()
    scenarios=sorted(scenario_dir.glob('*.json'))
    if not scenarios:raise ValueError('No declared scenario files')
    inputs={str(p):sha(p)for p in [*model_files(model_file),*scenarios,Path(__file__).resolve()]}
    out.mkdir(parents=True,exist_ok=False);g=out/'generated';b=out/'build'
    generation=generate(model_file,g);compiled=build(g,b);rows=[]
    if compiled['status']=='pass':
        model=load(model_file)
        for i,path in enumerate(scenarios):
            folder=out/'cases'/str(i).zfill(3);r=run(g,b,path,folder/'execution');formal=None
            if formal_replay:
                from protocol_lab.symbolic import crosscheck_trace
                reference=run_scenario(model,json.loads(path.read_text()))
                formal=crosscheck_trace(model,reference.trace,folder/'symbolic');write(folder/'formal-fixed-input.json',formal)
            rows.append(dict(scenario=path.name,status=r['status'],formal_fixed_input=formal['status']if formal else'not_requested',execution=str((folder/'execution/execution.json').relative_to(out))))
    changed=any(sha(n)!=h for n,h in inputs.items())or scenarios!=sorted(scenario_dir.glob('*.json'))
    status='invalidated_inputs'if changed else'blocked'if compiled['status']=='blocked'else'fail'if compiled['status']!='pass'or any(r['status']!='pass'for r in rows)else'unresolved'if formal_replay and any(r['formal_fixed_input']!='match'for r in rows)else'pass'
    report=dict(schema='generated-native-fixed-suite-v1',status=status,inputs=inputs,backend=generation['backend'],model_semantic_sha256=generation['model_semantic_sha256'],cases=rows,
                observation='actual generated C event traces; no native network/PCAP claim',fixed_input_formal_replay_requested=formal_replay,
                all_input_safety_proved=False,compiler_correctness_proved=False,whole_protocol_complete=False)
    report['outputs']={p.relative_to(out).as_posix():sha(p)for p in out.rglob('*')if p.is_file()}
    write(out/'suite.json',report);return report


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('model');p.add_argument('--scenario-dir',required=True);p.add_argument('--out',required=True);p.add_argument('--formal-replay',action='store_true');a=p.parse_args()
    try:r=suite(a.model,a.scenario_dir,a.out,a.formal_replay)
    except (ValueError,OSError)as e:r=dict(status='rejected',reason=str(e))
    print(json.dumps(r));raise SystemExit(0 if r['status']=='pass'else 1)
