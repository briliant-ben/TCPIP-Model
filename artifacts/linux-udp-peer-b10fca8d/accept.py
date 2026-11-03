"""Original-Git retained Linux UDP peer/IR audit; never execute archive code."""
import hashlib,io,json,os,subprocess,sys,tempfile,zipfile
from pathlib import Path
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
SOURCE='b10fca8dd5287552f61b415ad5cf614a93a24b3a'
TESTED='d2d9fa03fc019ecb6f79790b7cfe2381ed16cddf'
read=lambda p:json.loads(Path(p).read_text())
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()

def audit():
    provenance=read(HERE/'provenance.json');archive=HERE/'original.zip'
    assert provenance['source_commit']==TESTED and provenance['audit_git_commit']==SOURCE
    assert sha(archive)==provenance['archive_sha256']
    assert subprocess.check_output(['git','rev-parse',SOURCE+'^{tree}'],cwd=ROOT,text=True).strip()==provenance['tested_tree_sha1']
    with tempfile.TemporaryDirectory(prefix='linux-peer-original-git-audit-')as temporary:
        tmp=Path(temporary);data=tmp/'data';source=tmp/'source';seen=set();total=0
        with zipfile.ZipFile(archive)as z:
            for m in z.infolist():
                p=Path(m.filename);total+=m.file_size
                assert not m.is_dir()and not p.is_absolute()and '..'not in p.parts and '\\'not in m.filename and m.filename not in seen
                assert m.file_size<=16*1024*1024 and total<=100*1024*1024 and (m.external_attr>>16)&0o170000!=0o120000
                dest=data/p;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(z.read(m));seen.add(m.filename)
        assert len(seen)==provenance['archive_members']==370
        bindings=provenance['source_bindings']
        stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=('\n'.join(SOURCE+':'+n for n in bindings)+'\n').encode(),cwd=ROOT))
        for n,h in bindings.items():
            p=Path(n);assert not p.is_absolute()and '..'not in p.parts and '\n'not in n
            header=stream.readline().decode().split();assert len(header)==3 and header[1]=='blob'
            raw=stream.read(int(header[2]));assert stream.read(1)==b'\n'and hashlib.sha256(raw).hexdigest()==h,n
            dest=source/p;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(raw)
        assert not stream.read()
        env=dict(os.environ,PYTHONPATH=str(source),PYTHONDONTWRITEBYTECODE='1')
        peer=data/'linux-udp-peer';report=read(peer/'report.json')
        assert report['status']=='pass'and report['source_commit']==TESTED and report['roundtrips']==3 and report['captured_packets']==6
        p=subprocess.run([sys.executable,str(source/'ports/linux-udp-peer/verify.py'),'--offline','--out',str(peer)],cwd=source,env=env,capture_output=True,text=True,timeout=30)
        assert p.returncode==0,(p.stdout,p.stderr)
        checked=json.loads(p.stdout);assert checked['status']=='valid_retained_linux_udp_peer_bindings'
        job=data/'linux-udp-atomic-flow/job';flow=read(job/'flow.json')
        p=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(job),'--workspace',str(source),'--task-sha256',flow['task_sha256']],cwd=source,env=env,capture_output=True,text=True,timeout=30)
        assert p.returncode==0,(p.stdout,p.stderr)
        assert json.loads(p.stdout)==read(data/'linux-udp-atomic-flow/verification.json')
        assert len(flow['stages']['tests']['data']['cases'])==22 and flow['stages']['reference']['data']['trace_contract_steps_checked']==6
        assert flow['stages']['tests']['data']['negative_count']==9
        formal=read(job/'stages/formal/queries/result.json')
        assert formal['depth']==2 and formal['safety_query']==formal['overlap_query']=='unsat'and formal['status']=='bounded_pass'
        sys.path.insert(0,str(source))
        from protocol_lab.codegen import render
        from protocol_lab.codegen.execute import commands,compare
        from protocol_lab.ir import load
        folder=data/'linux-udp-atomic-fixed';suite=read(folder/'suite.json')
        assert suite['status']=='pass'and len(suite['cases'])==5
        assert not suite['all_input_safety_proved']and not suite['compiler_correctness_proved']and not suite['whole_protocol_complete']
        expected={p.relative_to(folder).as_posix()for p in folder.rglob('*')if p.is_file()}-{'suite.json'};assert set(suite['outputs'])==expected
        for n,h in suite['outputs'].items():assert sha(folder/n)==h
        def binding(n,h):
            a=report['execution_source_root']+'/';b=report['execution_source_root']+'/artifacts/'
            if n.startswith(b):p=data/n[len(b):]
            else:assert n.startswith(a),n;p=source/n[len(a):]
            assert sha(p)==h,n
        for n,h in suite['inputs'].items():binding(n,h)
        generation=read(folder/'generated/generation.json');compiled=read(folder/'build/compile.json')
        for n,h in generation['inputs'].items():binding(n,h)
        model=load(source/'model/udp-wire-receive-atomic.json')
        assert render(model)==(folder/'generated/protocol.c').read_text()
        assert compiled['status']=='pass'and compiled['returncode']==0
        assert compiled['generation_sha256']==sha(folder/'generated/generation.json')
        assert compiled['generated_source_sha256']==generation['outputs']['protocol.c']==sha(folder/'generated/protocol.c')
        assert compiled['executable_sha256']==sha(folder/'build/protocol-native')
        for i,row in enumerate(suite['cases']):
            parent=folder/'cases'/str(i).zfill(3);execution=parent/'execution';r=read(execution/'execution.json')
            assert r['status']=='pass'and r['native_returncode']==0 and r['executable_sha256']==compiled['executable_sha256']
            for n,h in r['inputs'].items():binding(n,h)
            for n,h in r['outputs'].items():assert sha(execution/n)==h
            scenario=read(source/'scenarios/udp-atomic-receive'/row['scenario'])
            assert commands(model,scenario)==(execution/'native-input.txt').read_text()
            observed=[json.loads(line)for line in(execution/'native.stdout').read_text().splitlines()]
            assert compare(model,scenario,observed)==read(execution/'difference.json')and read(execution/'difference.json')['status']=='match'
            symbolic=read(parent/'formal-fixed-input.json');assert symbolic==read(parent/'symbolic/result.json')
            assert symbolic['status']==symbolic['replay']['status']=='match'and symbolic['query']=='sat'
            assert symbolic['smt2_sha256']==sha(parent/'symbolic/path.smt2')
        result=dict(status='valid_retained_real_linux_udp_peer_evidence',source_commit=TESTED,audit_git_commit=SOURCE,source_blobs_checked=len(bindings),raw_files=len(seen),roundtrips=3,real_captured_packets=6,atomic_flow_cases=22,atomic_literal_trace_steps=6,fixed_input_native_z3_cases_checked=5,archive_code_executed=False,fresh_native_or_solver_execution=False,new_linux_execution=False,physical_ethernet_capture=False,project_server_deployed=False,compiler_correctness_proved=False,whole_ipv4_endpoint_complete=False,offline_provenance_requires_trusted_ci=True)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result
if __name__=='__main__':print(json.dumps(audit()))
