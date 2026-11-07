"""Read-only Git-bound audit of finite logical-time ARP evidence."""
import hashlib,io,json,os,re,subprocess,sys,tarfile,tempfile,zipfile
from pathlib import Path
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
SOURCE='b7ad787450ef364c4c5790ce89788b8d62027095'
read=lambda p:json.loads(Path(p).read_text())
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
def export(bindings,out):
    stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=('\n'.join(SOURCE+':'+n for n in bindings)+'\n').encode(),cwd=ROOT))
    for n,h in bindings.items():
        p=Path(n);assert not p.is_absolute()and '..'not in p.parts and '\n'not in n and '\r'not in n
        header=stream.readline().decode().split();assert len(header)==3 and header[1]=='blob'
        raw=stream.read(int(header[2]));assert stream.read(1)==b'\n'and hashlib.sha256(raw).hexdigest()==h,n
        target=out/p;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(raw)
    assert not stream.read()


def accept():
    summary=read(HERE/'summary.json');manifest=read(HERE/'release.json');archive=HERE/'flow-evidence.zip'
    assert summary['source_commit']==manifest['source_commit']==SOURCE and sha(archive)==summary['archive_sha256']
    assert 'Ran 130 tests'in(HERE/'regressions.log').read_text()and 'FAILED'not in(HERE/'regressions.log').read_text()
    with tempfile.TemporaryDirectory(prefix='icmp-original-git-budget-audit-')as temporary:
        tmp=Path(temporary);source=tmp/'source';data=tmp/'data';seen=set();total=0
        export(manifest['files'],source)
        with zipfile.ZipFile(archive)as z:
            for m in z.infolist():
                p=Path(m.filename);total+=m.file_size
                assert not m.is_dir()and not p.is_absolute()and '..'not in p.parts and p.parts[0]=='flow'and m.filename not in seen and '\\'not in m.filename
                assert m.file_size<=16*1024*1024 and total<=100*1024*1024
                dest=data/p;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(z.read(m));seen.add(m.filename)
        assert len(seen)==summary['flow_archive_files']
        job=data/'flow/job';flow=read(job/'flow.json');formal=read(job/'stages/formal/queries/result.json')
        env=dict(os.environ,PYTHONPATH=str(source),PYTHONDONTWRITEBYTECODE='1')
        p=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(job),'--workspace',str(source),'--task-sha256',flow['task_sha256']],cwd=source,env=env,capture_output=True,text=True,timeout=30)
        assert p.returncode==0,(p.stdout,p.stderr)
        assert json.loads(p.stdout)==read(data/'flow/verification.json')
        assert formal['depth']==2 and formal['solver_timeout_ms']==60000 and formal['safety_query']==formal['overlap_query']=='unsat'
        assert len(flow['stages']['tests']['data']['cases'])==28 and flow['stages']['reference']['data']['trace_contract_steps_checked']==13
        with zipfile.ZipFile(HERE.parent/'icmp-echo-linux-failed-d511f44f/flow.zip')as z:
            for name in ('model.smt2','overlap.smt2'):
                assert z.read('run/job/stages/formal/queries/'+name)==(job/'stages/formal/queries'/name).read_bytes()
        result=dict(status='retained_local_icmp_budget_flow_verified',source_commit=SOURCE,source_files=len(manifest['files']),raw_flow_files=len(seen),specialized_methods=130,flow_cases=28,literal_trace_steps=13,depth=2,solver_timeout_ms=60000,old_linux_queries_byte_identical=True,archive_code_executed=False,fresh_solver_or_native_execution=False,new_linux_execution=False,whole_ipv4_endpoint_complete=False)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result
if __name__=='__main__':print(json.dumps(accept()))
