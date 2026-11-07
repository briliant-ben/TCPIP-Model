"""Original-Git audit of retained real composed peer and supplementary flow."""
import hashlib,io,json,os,subprocess,sys,tempfile,zipfile
from pathlib import Path
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
SOURCE='5755f71505455486ffea2a6dc2bf3b4773e7a35b'
TESTED='224a394ab0f46461f2a208a5c8f0d89c70450588'
read=lambda p:json.loads(Path(p).read_text())
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()

def audit():
    p=read(HERE/'provenance.json');assert p['source_commit']==TESTED and p['audit_git_commit']==SOURCE
    assert sha(HERE/'original.zip')==p['archive_sha256']
    assert subprocess.check_output(['git','rev-parse',SOURCE+'^{tree}'],cwd=ROOT,text=True).strip()==p['tested_tree_sha1']
    with tempfile.TemporaryDirectory(prefix='composed-peer-git-audit-')as temporary:
        root=Path(temporary);data=root/'data';source=root/'source';seen=set();total=0
        with zipfile.ZipFile(HERE/'original.zip')as z:
            for m in z.infolist():
                q=Path(m.filename);total+=m.file_size
                assert not m.is_dir()and not q.is_absolute()and '..'not in q.parts and '\\'not in m.filename and m.filename not in seen
                assert (m.external_attr>>16)&0o170000!=0o120000 and m.file_size<=16*1024*1024 and total<=100*1024*1024
                dest=data/q;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(z.read(m));seen.add(m.filename)
        assert len(seen)==p['archive_members']==330
        stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=('\n'.join(SOURCE+':'+n for n in p['source_bindings'])+'\n').encode(),cwd=ROOT))
        for n,h in p['source_bindings'].items():
            q=Path(n);assert not q.is_absolute()and '..'not in q.parts and '\n'not in n
            head=stream.readline().decode().split();assert len(head)==3 and head[1]=='blob'
            raw=stream.read(int(head[2]));assert stream.read(1)==b'\n'and hashlib.sha256(raw).hexdigest()==h,n
            dest=source/q;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(raw)
        assert not stream.read()
        env=dict(os.environ,PYTHONPATH=str(source),PYTHONDONTWRITEBYTECODE='1');peer=data/'linux-arp-udp-peer'
        report=read(peer/'report.json');assert report['source_commit']==TESTED and report['status']=='pass'
        proc=subprocess.run([sys.executable,str(source/'ports/linux-arp-udp-peer/verify.py'),'--offline','--out',str(peer)],cwd=source,env=env,capture_output=True,text=True,timeout=30)
        assert proc.returncode==0,(proc.stdout,proc.stderr)
        checked=json.loads(proc.stdout);assert checked['status']=='valid_retained_linux_arp_udp_peer_bindings'
        assert checked['cases']==dict(status='pass',packets=6,udp_deliveries=4,process_starts=1,arp_queue_flush=True,cached_empty_odd_mtu=True)
        job=data/'icmp-inductive/job';flow=read(job/'flow.json')
        proc=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(job),'--workspace',str(source),'--task-sha256',flow['task_sha256']],cwd=source,env=env,capture_output=True,text=True,timeout=30)
        assert proc.returncode==0,(proc.stdout,proc.stderr)
        verified=json.loads(proc.stdout);assert verified['assessment']=='verified_event_slice'
        proof=read(job/'stages/formal/queries/result.json');assert proof['status']=='inductive_invariants_pass'and len(proof['query_hashes'])==13
        ns=read(peer/'network/namespace.json');symbolic=read(peer/'network/symbolic/result.json')
        result=dict(status='retained_real_composed_arp_udp_peer_and_icmp_invariant_flow_valid',source_commit=TESTED,audit_git_commit=SOURCE,source_blobs_checked=len(p['source_bindings']),raw_files=len(seen),kernel=report['kernel'],native_pid=ns['native_pid'],quiet_ms=(ns['capture_stop_request_monotonic_ns']-ns['last_receive_monotonic_ns'])/1000000,captured_packets=6,udp_deliveries=4,native_process_starts=1,actual_fixed_input_z3_query_count=1,actual_fixed_input_z3_steps=len(symbolic['witness']['steps']),icmp_induction_obligations=13,old_bmc_unknown_preserved=True,archive_code_executed=False,fresh_native_or_solver_execution=False,new_linux_execution=False,physical_ethernet=False,whole_ipv4_endpoint_complete=False,compiler_correctness_proved=False,ci_provenance_separately_trusted=True)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result
if __name__=='__main__':print(json.dumps(audit()))
