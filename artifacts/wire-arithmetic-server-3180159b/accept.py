"""Audit retained server observations using named Git sources, never archive code."""
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
SOURCE='3180159bca4cb97fb735bc8d9762d5e5b4927dca'
SERVER='/home/blxu/protocol-flow/'
TOOLS=SERVER+'releases/wire-arithmetic-3180159b/tools/'
RUN='runs/wire-arithmetic-3180159b'
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
    summary=read(HERE/'wire-arithmetic-3180159b-summary.json');archive=HERE/'wire-arithmetic-3180159b-evidence.tar.gz'
    assert archive.stat().st_size==summary['archive_bytes']and sha(archive)==summary['archive_sha256']
    manifest=read(HERE/'release.json');assert manifest['source_commit']==summary['source_commit']==SOURCE
    with tempfile.TemporaryDirectory(prefix='native-bytes-original-audit-')as temporary:
        tmp=Path(temporary);data=tmp/'data';seen=set();total=0
        with tarfile.open(archive)as tar:
            for m in tar:
                p=Path(m.name);total+=m.size
                assert m.isfile()and not p.is_absolute()and '..'not in p.parts and '\\'not in m.name and m.name not in seen
                assert m.name.startswith(RUN+'/')and m.size<=16*1024*1024 and total<=100*1024*1024
                target=data/p;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(tar.extractfile(m).read());seen.add(m.name)
        assert len(seen)==summary['archive_members']==1562
        source=tmp/'source';export(manifest['files'],source)
        run=data/RUN;bootstrap=read(run/'bootstrap.json');assert bootstrap['status']=='pass'and bootstrap['source_commit']==SOURCE
        log=(run/'bootstrap.log').read_text()
        assert all('Ran '+str(n)+' tests'in log for n in (20,9,8,4,13,12,14))and 'FAILED'not in log and 'skipped'not in log
        env=dict(os.environ,PYTHONPATH=str(source),PYTHONDONTWRITEBYTECODE='1')
        for i in range(5):
            folder=run/('task-'+str(i));flow=read(folder/'job/flow.json')
            p=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(folder/'job'),'--workspace',str(source),'--task-sha256',flow['task_sha256']],cwd=source,env=env,capture_output=True,text=True,timeout=30)
            assert p.returncode==0,(p.stdout,p.stderr)
            assert json.loads(p.stdout)==read(folder/'verification.json')
        sys.path.insert(0,str(source))
        from protocol_lab.codegen import render
        from protocol_lab.codegen.execute import compare,commands
        from protocol_lab.ir import load
        def binding(n,h):
            if n.startswith(TOOLS):p=source/n[len(TOOLS):]
            else:
                assert n.startswith(SERVER+RUN+'/'),n
                p=data/n[len(SERVER):]
            assert sha(p)==h,n
        counts=[]
        for i,count in enumerate((15,101)):
            folder=run/('native-suite-'+str(i));report=read(folder/'suite.json')
            assert report['status']=='pass'and len(report['cases'])==count
            assert not report['all_input_safety_proved']and not report['compiler_correctness_proved']and not report['whole_protocol_complete']
            expected={p.relative_to(folder).as_posix()for p in folder.rglob('*')if p.is_file()}-{'suite.json'}
            assert set(report['outputs'])==expected
            for n,h in report['outputs'].items():assert sha(folder/n)==h,n
            for n,h in report['inputs'].items():binding(n,h)
            generation=read(folder/'generated/generation.json');compiled=read(folder/'build/compile.json')
            for n,h in generation['inputs'].items():binding(n,h)
            model_name=manifest['native_suites'][i]['model'];model=load(source/model_name)
            assert render(model)==(folder/'generated/protocol.c').read_text()
            assert compiled['status']=='pass'and compiled['returncode']==0
            assert compiled['generation_sha256']==sha(folder/'generated/generation.json')
            assert compiled['generated_source_sha256']==generation['outputs']['protocol.c']==sha(folder/'generated/protocol.c')
            assert compiled['executable_sha256']==sha(folder/'build/protocol-native')
            for j,row in enumerate(report['cases']):
                execution=folder/'cases'/str(j).zfill(3)/'execution';r=read(execution/'execution.json')
                assert r['status']=='pass'and r['native_returncode']==0 and r['executable_sha256']==compiled['executable_sha256']
                for n,h in r['inputs'].items():binding(n,h)
                for n,h in r['outputs'].items():assert sha(execution/n)==h
                scenario=read(source/manifest['native_suites'][i]['scenario_dir']/row['scenario'])
                assert commands(model,scenario)==(execution/'native-input.txt').read_text()
                observed=[json.loads(line)for line in (execution/'native.stdout').read_text().splitlines()]
                assert compare(model,scenario,observed)==read(execution/'difference.json')
                assert read(execution/'difference.json')['status']=='match'
                if i==0:
                    formal=read(execution.parent/'formal-fixed-input.json')
                    assert formal==read(execution.parent/'symbolic/result.json')
                    assert formal['status']==formal['replay']['status']=='match'and formal['query']=='sat'
                    assert formal['smt2_sha256']==sha(execution.parent/'symbolic/path.smt2')
            counts.append(count)
        arithmetic=read(run/'task-4/job/flow.json')
        assert len(arithmetic['stages']['tests']['data']['cases'])==12
        assert arithmetic['stages']['reference']['data']['trace_contract_steps_checked']==11
        assert len(manifest['files'])==213
        result=dict(arithmetic_cases=12,arithmetic_trace_contract_steps=11,whole_checksum_equivalence_proved=False,status='retained_wire_arithmetic_server_evidence_accepted',source_commit=SOURCE,git_files_checked=len(manifest['files']),archive_members=len(seen),specialized_test_methods=88,flow_jobs_reverified=5,native_cases_recompared=counts,fixed_input_symbolic_reports_integrity_checked=15,archive_code_executed=False,fresh_native_or_solver_execution=False,compiler_correctness_proved=False,whole_ipv4_endpoint_complete=False)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result


if __name__=='__main__':print(json.dumps(accept()))
