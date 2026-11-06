"""Read-only Git-bound audit of local byte-access and TCP regression evidence."""
import hashlib,io,json,os,re,subprocess,sys,tarfile,tempfile
from pathlib import Path
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
SOURCE='b959876b8a7e1212be097be7399872c464cd063d'
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
    summary=read(HERE/'summary.json');archive=HERE/'raw-evidence.tar.gz';manifest=read(HERE/'release.json')
    assert manifest['source_commit']==summary['source_commit']==SOURCE
    assert sha(archive)==summary['archive_sha256']and archive.stat().st_size==summary['archive_bytes']
    with tempfile.TemporaryDirectory(prefix='byte-access-original-audit-')as temporary:
        tmp=Path(temporary);data=tmp/'data';seen=set();total=0
        with tarfile.open(archive)as tar:
            for m in tar:
                p=Path(m.name);total+=m.size
                assert m.isfile()and not p.is_absolute()and '..'not in p.parts and m.name not in seen and '\\'not in m.name
                assert p.parts[0]in ('flow','tcpdata','tcpconnection','logs')and m.size<=16*1024*1024 and total<=100*1024*1024
                dest=data/p;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(tar.extractfile(m).read());seen.add(m.name)
        assert len(seen)==summary['archive_members']
        source=tmp/'source';export(manifest['files'],source);assert len(manifest['files'])==241
        log=(data/'logs/regressions.log').read_text();assert sum(map(int,re.findall(r'Ran (\d+) tests',log)))==103
        assert 'FAILED'not in log and 'skipped'not in log
        assert 'Ran 6 tests'in(data/'logs/deploy-tests.log').read_text()
        env=dict(os.environ,PYTHONPATH=str(source),PYTHONDONTWRITEBYTECODE='1')
        folder=data/'flow';flow=read(folder/'job/flow.json')
        p=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(folder/'job'),'--workspace',str(source),'--task-sha256',flow['task_sha256']],cwd=source,env=env,capture_output=True,text=True,timeout=30)
        assert p.returncode==0,(p.stdout,p.stderr)
        assert json.loads(p.stdout)==read(folder/'verification.json')
        assert len(flow['stages']['tests']['data']['cases'])==9 and flow['stages']['reference']['data']['trace_contract_steps_checked']==8
        formal=read(folder/'job/stages/formal/queries/result.json')
        assert formal['safety_query']==formal['overlap_query']=='unsat'and formal['status']=='bounded_pass'
        assert formal['replay']['status']=='match'
        sys.path.insert(0,str(source))
        from protocol_lab.codegen import render
        from protocol_lab.codegen.execute import compare,commands
        from protocol_lab.ir import load
        def binding(n,h):
            roots=[(str(ROOT)+'/',source),(str(ROOT.parent/'byte-access-tcpdata-b959876b')+'/',data/'tcpdata'),(str(ROOT.parent/'byte-access-tcpconnection-b959876b')+'/',data/'tcpconnection')]
            for prefix,dest in roots:
                if n.startswith(prefix):assert sha(dest/n[len(prefix):])==h,n;return
            raise AssertionError('Unbound path: '+n)
        counts=[]
        for i,count in enumerate((15,101)):
            folder=data/('tcpdata'if i==0 else'tcpconnection');report=read(folder/'suite.json')
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
        result=dict(status='retained_local_byte_access_evidence_accepted',source_commit=SOURCE,source_files=241,raw_files=len(seen),specialized_test_methods=103,deployment_test_methods=6,flow_cases=9,literal_trace_steps=8,native_tcp_cases_recompared=counts,fixed_input_symbolic_reports_integrity_checked=15,archive_code_executed=False,fresh_native_or_solver_execution=False,server_deployed=False,udp_receive_implemented=False,whole_ipv4_endpoint_complete=False,compiler_correctness_proved=False)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result
if __name__=='__main__':print(json.dumps(accept()))
