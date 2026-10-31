"""Thin provider-neutral CLI client; no model SDK or task-supplied commands.

Run from the trusted tool checkout. Candidate workspaces supply data only. An
external agent/harness can call this same command for each isolated candidate.
The approved task digest must come from the acceptance caller.
"""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import sys

TOOL_ROOT=Path(__file__).resolve().parents[1]


def run_candidate(workspace,task,out,task_sha256):
    workspace=Path(workspace).resolve();task=(workspace/task).resolve();out=Path(out).resolve()
    if not task.is_relative_to(workspace):raise ValueError('Candidate task escapes workspace')
    out.mkdir(parents=True,exist_ok=False)
    client_source=Path(__file__).resolve();client_sha=hashlib.sha256(client_source.read_bytes()).hexdigest()
    python_sha=hashlib.sha256(Path(sys.executable).resolve().read_bytes()).hexdigest()
    env=dict(os.environ);env['PYTHONPATH']=str(TOOL_ROOT);env['PYTHONDONTWRITEBYTECODE']='1'
    base=[sys.executable,'-m','protocol_lab.pipeline']
    command=base+['run',str(task),'--workspace',str(workspace),'--out',str(out/'job'),'--task-sha256',task_sha256]
    with (out/'run.jsonl').open('w')as stdout,(out/'run.stderr').open('w')as stderr:
        p=subprocess.run(command,cwd=TOOL_ROOT,env=env,stdout=stdout,stderr=stderr)
    # The coordinator gives every worker its own bounded process group. An outer
    # harness owns scheduling; this client adds no independent timeout/restart.
    rows=(out/'run.jsonl').read_text().splitlines()
    report=json.loads(rows[-1])if rows else dict(assessment='missing_report')
    verify_code=None
    if p.returncode==0:
        with (out/'verification.json').open('w')as stdout,(out/'verify.stderr').open('w')as stderr:
            v=subprocess.run(base+['verify',str(out/'job'),'--workspace',str(workspace),'--task-sha256',task_sha256],cwd=TOOL_ROOT,env=env,stdout=stdout,stderr=stderr)
        verify_code=v.returncode
    result=dict(schema='spec-flow-client-v1',run_id=report.get('run_id'),assessment=report.get('assessment',report.get('classification','invalid_report')),
                run_returncode=p.returncode,verify_returncode=verify_code,approved_task_sha256=task_sha256,
                artifacts=str(out),task_file=str(task),provider_specific_dependency=False,
                client_source_sha256=client_sha,python_executable_sha256=python_sha,tool_root=str(TOOL_ROOT),run_command=command,
                complete_goal=False)
    result['client_source_unchanged']=hashlib.sha256(client_source.read_bytes()).hexdigest()==client_sha
    result['accepted']=result['client_source_unchanged']and p.returncode==0 and verify_code==0 and result['assessment']=='verified_event_slice'
    (out/'client-result.json').write_text(json.dumps(result,indent=2)+'\n');return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--workspace',required=True,type=Path);parser.add_argument('--task',required=True,type=Path);parser.add_argument('--out',required=True,type=Path);parser.add_argument('--task-sha256',required=True)
    a=parser.parse_args()
    try:result=run_candidate(a.workspace,a.task,a.out,a.task_sha256)
    except (ValueError,OSError)as error:result=dict(schema='spec-flow-client-v1',accepted=False,classification='client_input_or_environment',reason=str(error))
    print(json.dumps(result));raise SystemExit(0 if result['accepted']else 1)
