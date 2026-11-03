"""Original-Git retained Linux ICMP peer/IR audit; never execute archive code."""
import hashlib,io,json,os,subprocess,sys,tempfile,zipfile
from pathlib import Path
HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
SOURCE='a3da139342a93b530cfaa662620ba17c4a7e6813'
TESTED='7435b620964dca9f80c33e66ab49a71f9be785a0'
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
        assert len(seen)==provenance['archive_members']==52
        bindings=provenance['source_bindings']
        stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=('\n'.join(SOURCE+':'+n for n in bindings)+'\n').encode(),cwd=ROOT))
        for n,h in bindings.items():
            p=Path(n);assert not p.is_absolute()and '..'not in p.parts and '\n'not in n
            header=stream.readline().decode().split();assert len(header)==3 and header[1]=='blob'
            raw=stream.read(int(header[2]));assert stream.read(1)==b'\n'and hashlib.sha256(raw).hexdigest()==h,n
            dest=source/p;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(raw)
        assert not stream.read()
        env=dict(os.environ,PYTHONPATH=str(source),PYTHONDONTWRITEBYTECODE='1')
        peer=data/'linux-icmp-peer';report=read(peer/'report.json')
        assert report['status']=='pass'and report['source_commit']==TESTED and len(report['cases'])==3
        p=subprocess.run([sys.executable,str(source/'ports/linux-icmp-peer/verify.py'),'--offline','--out',str(peer)],cwd=source,env=env,capture_output=True,text=True,timeout=30)
        assert p.returncode==0,(p.stdout,p.stderr)
        checked=json.loads(p.stdout);assert checked['status']=='valid_retained_linux_icmp_peer_bindings'
        result=dict(status='valid_retained_real_linux_icmp_peer_evidence',source_commit=TESTED,audit_git_commit=SOURCE,source_blobs_checked=len(bindings),raw_files=len(seen),cases=checked['cases'],real_captured_packets=6,native_process_starts=1,actual_fixed_input_z3_trace_steps=3,actual_fixed_input_z3_query_count=1,archive_code_executed=False,fresh_native_or_solver_execution=False,new_linux_execution=False,physical_ethernet_capture=False,project_server_deployed=False,compiler_correctness_proved=False,whole_ipv4_endpoint_complete=False,offline_provenance_requires_trusted_ci=True)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result
if __name__=='__main__':print(json.dumps(audit()))
