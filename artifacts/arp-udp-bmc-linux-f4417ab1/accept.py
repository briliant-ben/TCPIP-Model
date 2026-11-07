"""Original-Git read-only native evidence audit; original BMC remains UNKNOWN."""
import hashlib,io,json,os,subprocess,sys,tempfile,zipfile
from pathlib import Path
HERE=Path(__file__).resolve().parent;ROOT=HERE.parents[1]
SOURCE='f4417ab16d2c065d95ad9f07f82e7c2b89dfeb0c';TESTED='c3d8af4b6b5a2deeaeae2823c3aad03edd8afe13'
SERVER='/home/runner/work/TCPIP-Model/TCPIP-Model/'
read=lambda p:json.loads(Path(p).read_text())
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()


def accept():
    p=read(HERE/'provenance.json');require=lambda b:None if b else(_ for _ in()).throw(AssertionError('Retained binding invalid'))
    require(p['source_commit']==TESTED and p['audit_git_commit']==SOURCE)
    require(subprocess.check_output(['git','rev-parse',SOURCE+'^{tree}'],cwd=ROOT,text=True).strip()==p['tested_tree_sha1'])
    with tempfile.TemporaryDirectory(prefix='arp-udp-original-git-')as temporary:
        root=Path(temporary);data=root/'data';source=root/'source';counts={}
        for name,meta in p['archives'].items():
            require(name in ('flow.zip','native.zip')and sha(HERE/name)==meta['sha256']);seen=set();total=0
            with zipfile.ZipFile(HERE/name)as z:
                for m in z.infolist():
                    q=Path(m.filename);total+=m.file_size
                    require(not m.is_dir()and not q.is_absolute()and '..'not in q.parts and '\\'not in m.filename and m.filename not in seen)
                    require((m.external_attr>>16)&0o170000!=0o120000 and m.file_size<=16*1024*1024 and total<=100*1024*1024)
                    dest=data/name.removesuffix('.zip')/q;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(z.read(m));seen.add(m.filename)
            require(len(seen)==meta['archive_members']);counts[name]=len(seen)
        stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=('\n'.join(SOURCE+':'+n for n in p['source_bindings'])+'\n').encode(),cwd=ROOT))
        for n,h in p['source_bindings'].items():
            q=Path(n);require(not q.is_absolute()and '..'not in q.parts and '\n'not in n)
            header=stream.readline().decode().split();require(len(header)==3 and header[1]=='blob');raw=stream.read(int(header[2]));require(stream.read(1)==b'\n'and hashlib.sha256(raw).hexdigest()==h)
            dest=source/q;dest.parent.mkdir(parents=True,exist_ok=True);dest.write_bytes(raw)
        require(not stream.read())
        env=dict(os.environ,PYTHONPATH=str(source),PYTHONDONTWRITEBYTECODE='1');job=data/'flow/run/job';flow=read(job/'flow.json')
        result=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(job),'--workspace',str(source),'--task-sha256',flow['task_sha256']],cwd=source,env=env,capture_output=True,text=True,timeout=30)
        require(result.returncode==1);checked=json.loads(result.stdout);require(checked['status']=='retained_evidence_consistent'and checked['assessment']=='unresolved')
        proof=read(job/'stages/formal/queries/result.json');require(proof['depth']==3 and proof['status']=='unknown'and proof['safety_query']=='unknown'and proof['overlap_query']=='unsat')
        require(len(flow['stages']['tests']['data']['cases'])==93 and len(flow['stages']['tests']['data']['covered_rules'])==30 and flow['stages']['tests']['data']['negative_count']==33)
        require(flow['stages']['reference']['data']['trace_contract_steps_checked']==80)
        sys.path.insert(0,str(source))
        from protocol_lab.ir import load
        from protocol_lab.codegen import render
        from protocol_lab.codegen.execute import compare,commands
        from examples.ethernet_udp_observe import decode_frame
        model=load(source/'model/arp-udp-transmit.json');native=data/'native';packet_count=0
        def binding(n,h):
            if n.startswith(SERVER+'artifacts/arp-udp-native/'):path=native/n[len(SERVER+'artifacts/arp-udp-native/'):]
            else:require(n.startswith(SERVER));path=source/n[len(SERVER):]
            require(sha(path)==h)
        for folder,count,scenes in [('composed',17,'scenarios/arp-udp-transmit'),('legacy-arp',13,'scenarios/arp-endpoint')]:
            base=native/folder;suite=read(base/'suite.json');require(suite['status']=='pass'and len(suite['cases'])==count)
            require(not suite['all_input_safety_proved']and not suite['compiler_correctness_proved']and not suite['whole_protocol_complete'])
            require(set(suite['outputs'])=={str(f.relative_to(base))for f in base.rglob('*')if f.is_file()}-{'suite.json'})
            for n,h in suite['outputs'].items():require(sha(base/n)==h)
            for n,h in suite['inputs'].items():binding(n,h)
            generated=read(base/'generated/generation.json');compiled=read(base/'build/compile.json')
            for n,h in generated['inputs'].items():binding(n,h)
            require(render(model)==(base/'generated/protocol.c').read_text())
            require(compiled['status']=='pass'and compiled['returncode']==0 and compiled['generation_sha256']==sha(base/'generated/generation.json'))
            require(compiled['generated_source_sha256']==generated['outputs']['protocol.c']==sha(base/'generated/protocol.c')and compiled['executable_sha256']==sha(base/'build/protocol-native'))
            for i,row in enumerate(suite['cases']):
                parent=base/'cases'/str(i).zfill(3);execution=parent/'execution';r=read(execution/'execution.json');require(r['status']=='pass'and r['native_returncode']==0 and r['executable_sha256']==compiled['executable_sha256'])
                for n,h in r['inputs'].items():binding(n,h)
                for n,h in r['outputs'].items():require(sha(execution/n)==h)
                scene=read(source/scenes/row['scenario']);require(commands(model,scene)==(execution/'native-input.txt').read_text())
                rows=[json.loads(line)for line in(execution/'native.stdout').read_text().splitlines()];require(compare(model,scene,rows)==read(execution/'difference.json')and read(execution/'difference.json')['status']=='match')
                symbolic=read(parent/'formal-fixed-input.json');require(symbolic==read(parent/'symbolic/result.json')and symbolic['status']==symbolic['replay']['status']=='match'and symbolic['query']=='sat'and symbolic['smt2_sha256']==sha(parent/'symbolic/path.smt2'))
                for observed in rows:
                    for e in observed.get('emitted',[]):
                        if e['message']=='ethernet.tx'and bytes(e['fields']['frame'])[12:14]==b'\x08\0':decode_frame(bytes(e['fields']['frame']));packet_count+=1
        result=dict(status='retained_native_composition_bindings_valid_bmc_unknown',source_commit=TESTED,audit_git_commit=SOURCE,source_files=len(p['source_bindings']),archive_files=counts,flow_cases=93,literal_contract_inputs=80,covered_rules=30,model_gaps=33,native_cases_recompared=30,fixed_input_z3_reports_integrity_checked=30,decoded_generated_ipv4_ethernet_frames=packet_count,bmc_safety_query='unknown',bmc_overlap_query='unsat',flow_assessment='unresolved',archive_code_executed=False,fresh_native_or_solver_execution=False,new_linux_execution=False,linux_network_evidence=False,whole_ipv4_endpoint_complete=False,compiler_correctness_proved=False,ci_provenance_separately_trusted=True)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result
if __name__=='__main__':print(json.dumps(accept()))
