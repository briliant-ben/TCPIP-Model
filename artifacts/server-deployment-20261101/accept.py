"""Replay retained integrity using immutable reviewed Git sources, not archive code."""
import hashlib
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tarfile
import tempfile
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
SOURCE='84dcce78ffc0ef6464a368fda4a588b38d7f6a5c'
BASE='5bddadf89b37f9836fec1837f691fd134ce3cc75'
read=lambda p:json.loads(Path(p).read_text())


def export(bindings,commit,out):
    data=('\n'.join(commit+':'+p for p in bindings)+'\n').encode()
    stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=data,cwd=ROOT))
    for rel,digest in bindings.items():
        p=Path(rel);assert not p.is_absolute()and '..'not in p.parts and '\n'not in rel and '\r'not in rel
        header=stream.readline().decode().split();assert len(header)==3 and header[1]=='blob'
        raw=stream.read(int(header[2]));assert stream.read(1)==b'\n'and hashlib.sha256(raw).hexdigest()==digest,rel
        target=out/p;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(raw)
    assert not stream.read()


def accept():
    summary=read(HERE/'deployment-summary.json');archive=HERE/'deployment-evidence.tar.gz'
    assert archive.stat().st_size==summary['archive_bytes']and hashlib.sha256(archive.read_bytes()).hexdigest()==summary['archive_sha256']
    release=read(HERE/'release-manifest.json');assert release['source_commit']==BASE and len(release['files'])==59
    with tempfile.TemporaryDirectory(prefix='deployed-flow-original-audit-')as tmp:
        tmp=Path(tmp);data=tmp/'data';seen=set()
        with tarfile.open(archive)as t:
            for m in t:
                p=Path(m.name)
                assert m.isfile()and not p.is_absolute()and '..'not in p.parts and '\\'not in m.name and m.name not in seen
                target=data/p;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(t.extractfile(m).read());seen.add(m.name)
        assert len(seen)==summary['archive_members']==696
        export(release['files'],BASE,tmp/'release-source')
        bootstrap=read(data/'runs/bootstrap-5bddadf89b37-r2/bootstrap.json');assert bootstrap['status']=='pass'and len(bootstrap['tasks'])==3 and bootstrap['api_calls_made']==0
        log=(data/'runs/bootstrap-5bddadf89b37-r2/bootstrap.log').read_text()
        assert all('Ran '+str(n)+' tests'in log for n in (20,9,8))and 'FAILED'not in log
        jobs=[data/'runs/bootstrap-5bddadf89b37-r2'/('task-'+str(i))for i in range(3)]+[data/'runs/ipv4-0001']
        bindings={}
        for folder in jobs:
            for name,h in read(folder/'job/flow.json')['input_hashes'].items():
                prefix,rel=name.split('/',1);assert prefix in ('workspace','tool')
                rel=('protocol_lab/'+rel if prefix=='tool'else'flows/ipv4-input.json'if rel=='task.json'else rel)
                assert rel not in bindings or bindings[rel]==h;bindings[rel]=h
        source=tmp/'source';export(bindings,SOURCE,source)
        env=dict(os.environ);env['PYTHONPATH']=str(source);env['PYTHONDONTWRITEBYTECODE']='1'
        reports=[]
        for i,folder in enumerate(jobs):
            r=read(folder/'job/flow.json');workspace=source
            if i==3:
                workspace=tmp/'candidate'
                for name,h in r['input_hashes'].items():
                    if not name.startswith('workspace/'):continue
                    rel=name.split('/',1)[1];p=workspace/rel;p.parent.mkdir(parents=True,exist_ok=True)
                    p.write_bytes((source/('flows/ipv4-input.json'if rel=='task.json'else rel)).read_bytes())
            p=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(folder/'job'),'--workspace',str(workspace),'--task-sha256',r['task_sha256']],cwd=source,env=env,capture_output=True,text=True,timeout=30)
            assert p.returncode==0,(p.stdout,p.stderr)
            result=json.loads(p.stdout);assert result==read(folder/'verification.json')
            assert all(s['status']=='pass'for s in r['stages'].values());reports.append(result)
        requests=summary['requests'];assert len(requests)==4
        assert sum(r['usage']['total_tokens']for r in requests)==30519
        assert sum(r['usage'].get('prompt_cache_hit_tokens',0)for r in requests)==7808
        result=dict(status='original_private_server_deployment_and_ipv4_slice_accepted',release_source=BASE,validator_source=SOURCE,
                    original_release_git_files_checked=59,original_task_tool_git_files_checked=len(bindings),tasks=reports,
                    actual_provider_requests=4,reported_total_tokens=30519,reported_cache_hit_input_tokens=7808,
                    archive_code_executed=False,fresh_native_or_solver_execution=False,credentials_archived=False,
                    complete_ipv4_endpoint_implementation=False)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result


if __name__=='__main__':print(json.dumps(accept()))
