"""Prepare an isolated venv and execute the two already-approved release tasks."""
import argparse
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import time


def bootstrap(release,out):
    release=Path(release).resolve();tools=release/'tools';out=Path(out).resolve();manifest=json.loads((release/'release.json').read_text())
    if sys.version_info<(3,12):raise ValueError('This release uses Python3.12+; no system Python changes are performed')
    if not shutil.which('cc'):raise ValueError('C99 compiler unavailable; install via the host administrator')
    out.mkdir(parents=True,exist_ok=False);env=dict(os.environ);env['PYTHONDONTWRITEBYTECODE']='1';env['PIP_DISABLE_PIP_VERSION_CHECK']='1'
    python=release/'venv/bin/python'
    with (out/'bootstrap.log').open('w')as log:
        subprocess.run([sys.executable,'-m','venv',str(release/'venv')],stdout=log,stderr=log,check=True)
        subprocess.run([str(python),'-m','pip','install','-q','-r',str(tools/'requirements-formal.txt')],cwd=tools,env=env,stdout=log,stderr=log,check=True)
        for test in manifest['tests']:
            subprocess.run([str(python),'-m','unittest','discover','-s','tests','-p',Path(test).name,'-v'],cwd=tools,env=env,stdout=log,stderr=log,check=True)
    rows=[]
    for i,task in enumerate(manifest['tasks']):
        folder=out/('task-'+str(i))
        p=subprocess.run([str(python),str(tools/'examples/run_spec_candidate.py'),'--workspace',str(tools),'--task',task['path'],'--task-sha256',task['sha256'],'--out',str(folder)],cwd=tools,env=env,capture_output=True,text=True)
        (out/('task-'+str(i)+'.stdout')).write_text(p.stdout);(out/('task-'+str(i)+'.stderr')).write_text(p.stderr)
        if p.returncode!=0:raise ValueError('Release task failed: '+task['id'])
        row=json.loads(p.stdout)
        if not row['accepted']:raise ValueError('Release task not accepted')
        rows.append(dict(id=task['id'],run_id=row['run_id'],client=str(folder/'client-result.json')))
    native_rows=[]
    for i,case in enumerate(manifest.get('native_suites',[])):
        folder=out/('native-suite-'+str(i))
        command=[str(python),str(tools/'examples/run_native_suite.py'),case['model'],'--scenario-dir',case['scenario_dir'],'--out',str(folder)]
        if case['formal_replay']:command.append('--formal-replay')
        p=subprocess.run(command,cwd=tools,env=env,capture_output=True,text=True)
        (out/('native-suite-'+str(i)+'.stdout')).write_text(p.stdout);(out/('native-suite-'+str(i)+'.stderr')).write_text(p.stderr)
        if p.returncode!=0:raise ValueError('Native fixed-input suite did not pass')
        report=json.loads(p.stdout)
        if report['status']!='pass':raise ValueError('Native suite not accepted')
        native_rows.append(dict(model=case['model'],cases=len(report['cases']),status=report['status'],formal_replay_requested=case['formal_replay']))
    result=dict(schema='spec-flow-server-bootstrap-v1',status='pass',source_commit=manifest['source_commit'],tasks=rows,native_suites=native_rows,python=sys.version.split()[0],compiler=shutil.which('cc'),network_configuration_changed=False,api_calls_made=0,completed_at=time.time())
    (out/'bootstrap.json').write_text(json.dumps(result,indent=2)+'\n');return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('release');parser.add_argument('--out',required=True);a=parser.parse_args()
    try:r=bootstrap(a.release,a.out)
    except (ValueError,OSError,subprocess.CalledProcessError)as error:r=dict(status='fail',reason=str(error));print(json.dumps(r));raise SystemExit(1)
    print(json.dumps(r))
