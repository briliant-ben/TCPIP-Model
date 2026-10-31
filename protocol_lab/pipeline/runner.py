"""Run fixed stages in isolated processes; verify retained integrity separately."""
import os
import json
from pathlib import Path
import platform
import signal
import subprocess
import sys
import time
import uuid
from .task import TOOL,load_task,inputs,check_inputs,read,write,sha

STAGES=('sources','ir','formal','tests','reference','generate','build','execute','compare','traceability')
DEPENDENCIES={'sources':(),'ir':(),'formal':('ir',),'tests':('ir',),'reference':('ir','tests'),
              'generate':('ir',),'build':('generate',),'execute':('tests','build'),
              'compare':('reference','execute'),'traceability':('sources','ir')}


def envelope(name,status,kind,reason):return dict(schema='spec-flow-stage-v1',stage=name,status=status,classification=kind,data=dict(reason=reason))


def child(name,job,seconds):
    command=[sys.executable,'-m','protocol_lab.pipeline.worker',name,'--job',str(job)]
    env=dict(os.environ);env['PYTHONPATH']=str(TOOL.parent)
    p=subprocess.Popen(command,cwd=TOOL.parent,env=env,stdout=subprocess.PIPE,stderr=subprocess.PIPE,text=True,start_new_session=True)
    timed_out=False;start=time.monotonic()
    try:stdout,stderr=p.communicate(timeout=seconds)
    except subprocess.TimeoutExpired:
        timed_out=True
        try:os.killpg(p.pid,signal.SIGKILL)
        except ProcessLookupError:pass
        stdout,stderr=p.communicate()
    # The session belongs exclusively to this worker. Clean up any compiler
    # descendants left behind even if the worker itself exited normally.
    try:os.killpg(p.pid,signal.SIGKILL)
    except ProcessLookupError:pass
    logs=job/'worker-logs';logs.mkdir(exist_ok=True)
    (logs/(name+'.stdout')).write_text(stdout);(logs/(name+'.stderr')).write_text(stderr)
    receipt=dict(command=command,returncode=p.returncode,timed_out=timed_out,process_group_cleanup_attempted=True,seconds=time.monotonic()-start)
    if timed_out:return envelope(name,'fail','resource_limit','Worker process group exceeded stage deadline'),receipt
    if p.returncode!=0:return envelope(name,'fail','tool_error','Worker failed; retained stderr is diagnostic'),receipt
    path=job/'stages'/name/'result.json'
    if not path.is_file():return envelope(name,'fail','tool_error','Missing worker result'),receipt
    r=read(path)
    if set(r)!={'schema','stage','status','classification','data'}or r['schema']!='spec-flow-stage-v1'or r['stage']!=name or r['status']not in ('pass','fail','unknown','blocked','rejected'):
        return envelope(name,'fail','tool_error','Invalid worker envelope'),receipt
    return r,receipt


def assess(stages):
    values=[r['status']for r in stages.values()]
    if any(s in ('fail','rejected')for s in values):return 'failed'
    if 'blocked'in values:return 'blocked'
    if 'unknown'in values:return 'unresolved'
    return 'verified_event_slice'


def run(task_file,workspace,out):
    if os.name!='posix':raise ValueError('This worker isolation implementation requires POSIX process groups')
    workspace=Path(workspace).resolve();task_file=Path(task_file).resolve();out=Path(out).resolve()
    if out.is_relative_to(TOOL):raise ValueError('Output directory must not modify the installed tool tree')
    before=sha(task_file);t=load_task(task_file,workspace)
    if sha(task_file)!=before:raise ValueError('Task changed during admission')
    snapshot=inputs(task_file,workspace,t)
    out.mkdir(parents=True,exist_ok=False)
    write(out/'request.json',dict(task=t,workspace=str(workspace),task_file=str(task_file)))
    request_sha=sha(out/'request.json')
    r=dict(schema='spec-flow-run-v1',run_id=str(uuid.uuid4()),task_id=t['id'],task_sha256=before,
           execution_status='running',assessment='pending',finalized=False,scope=t['scope'],
           input_hashes=snapshot,request_sha256=request_sha,stages={},workers={},
           environment=dict(python=sys.version,platform=platform.platform()),
           observation_kind='generated_native_event_trace',pcap_evidence=False,
           protocol_correctness_proved=False,generator_correctness_proved=False,
           english_to_ir_correctness_proved=False,whole_goal_complete=False)
    write(out/'flow.json',r)
    for name in STAGES:
        blockers=[d for d in DEPENDENCIES[name]if r['stages'][d]['status']not in ('pass','unknown')]
        if sha(out/'request.json')!=request_sha:
            stage=envelope(name,'rejected','evidence_changed','Worker request changed')
        elif blockers:
            stage=envelope(name,'blocked','dependency','Required upstream stages: '+','.join(blockers))
        else:
            print(json.dumps(dict(schema='spec-flow-event-v1',event='stage_started',stage=name,run_id=r['run_id'])),flush=True)
            stage,receipt=child(name,out,t['limits']['stage_seconds']);r['workers'][name]=receipt
        folder=out/'stages'/name;folder.mkdir(parents=True,exist_ok=True)
        # Failed/timed-out worker state is retained as diagnostic before the
        # coordinator records the authoritative stage envelope.
        p=folder/'result.json'
        if p.exists()and read(p)!=stage:write(folder/'unaccepted-worker-result.json',read(p))
        write(p,stage);r['stages'][name]=stage;write(out/'flow.json',r)
    r.update(execution_status='completed',assessment=assess(r['stages']),finalized=True)
    try:
        check_inputs(snapshot,workspace)
        if sha(out/'request.json')!=request_sha:raise ValueError('Request changed during execution')
    except (ValueError,OSError)as e:r.update(assessment='invalidated_inputs',reason=str(e))
    r['outputs']={p.relative_to(out).as_posix():sha(p)for p in sorted(out.rglob('*'))if p.is_file()and p!=out/'flow.json'}
    write(out/'flow.json',r);return r


def verify(out,workspace):
    out=Path(out).resolve();r=read(out/'flow.json')
    if r['schema']!='spec-flow-run-v1'or not r['finalized']or r['execution_status']!='completed':raise ValueError('No finalized complete flow execution')
    if set(r['stages'])!=set(STAGES):raise ValueError('Incomplete stage coverage')
    check_inputs(r['input_hashes'],workspace)
    if sha(out/'request.json')!=r['request_sha256']:raise ValueError('Request changed')
    request=read(out/'request.json')
    if set(request)!={'task','workspace','task_file'}:raise ValueError('Unknown request fields')
    relative=Path(request['task_file']).relative_to(Path(request['workspace']))
    task_path=Path(workspace).resolve()/relative
    canonical=load_task(task_path,workspace)
    if canonical!=request['task']or sha(task_path)!=r['task_sha256']or r['scope']!=canonical['scope']or r['task_id']!=canonical['id']:
        raise ValueError('Task/request/source binding differs')
    actual={p.relative_to(out).as_posix():sha(p)for p in out.rglob('*')if p.is_file()and p!=out/'flow.json'}
    if actual!=r['outputs']:raise ValueError('Missing/extra/changed evidence')
    for name in STAGES:
        stage=r['stages'][name]
        if stage!=read(out/'stages'/name/'result.json'):raise ValueError('Stage/report disagreement')
        if stage['stage']!=name or stage['schema']!='spec-flow-stage-v1':raise ValueError('Stage identity changed')
        if stage['status']=='pass'and any(r['stages'][d]['status']not in ('pass','unknown')for d in DEPENDENCIES[name]):raise ValueError('Dependency falsely promoted')
        if name=='formal'and stage['status']=='pass'and stage['data'].get('status')!='bounded_pass':raise ValueError('Unknown/failed formal result falsely promoted')
        if name=='formal'and stage['status']in ('pass','unknown')and stage['data']!=read(out/'stages/formal/queries/result.json'):
            raise ValueError('Underlying formal report changed')
        if name=='sources'and stage['status']=='pass'and any(s['observed']!=s['expected']for s in stage['data']['sources']):
            raise ValueError('Failed source integrity falsely promoted')
    if r['assessment']!=assess(r['stages']):raise ValueError('Assessment differs from actual stage verdicts')
    if any(r[k]for k in ('pcap_evidence','protocol_correctness_proved','generator_correctness_proved','english_to_ir_correctness_proved','whole_goal_complete')):
        raise ValueError('Event prototype scope broadened')
    return dict(schema='spec-flow-verification-v1',status='retained_evidence_consistent',assessment=r['assessment'],
                run_id=r['run_id'],inputs_checked=len(r['input_hashes']),artifacts_checked=len(actual),
                fresh_execution=False,authenticity_established=False,
                scope='retained file/source/dependency/verdict integrity only; rerun flow for fresh execution')
