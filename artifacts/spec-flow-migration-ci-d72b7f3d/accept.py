"""Audit official server execution with immutable Git tools; never archive code."""
import gzip
import hashlib
import io
import json
import os
from pathlib import Path
import subprocess
import sys
import tempfile
import zipfile
ROOT=Path(__file__).resolve().parents[2]
HERE=Path(__file__).resolve().parent
SOURCE='d72b7f3d4f0832a876ca87967916b47fbb6cb51c'
MERGE='6a46f71127159d9573e4a837dd4bf0687d5fcddc'
ZIP='fd69b4bc7c23c6209c863ce339b8acf631d60dfe0b243c7e344efc709c649543'
sha=lambda p:hashlib.sha256(Path(p).read_bytes()).hexdigest()
read=lambda p:json.loads(Path(p).read_text())


def accept():
    provenance=read(HERE/'provenance.json');artifact=provenance['artifact']
    assert provenance['source_head']==SOURCE and provenance['merge_snapshot']==MERGE
    assert provenance['run']==41222440458 and provenance['job']==124599629037 and provenance['conclusion']=='success'
    assert artifact['id']==13050482735 and artifact['digest']=='sha256:'+ZIP and artifact['size_in_bytes']==946217
    assert artifact['workflow_run']['head_sha']==SOURCE and artifact['name']=='spec-flow-'+MERGE
    assert sha(HERE/'workflow-artifact.zip')==ZIP
    log_hashes=read(HERE/'log-hashes.json')
    assert sha(HERE/'job.log.gz')==log_hashes['gzip_sha256']
    assert hashlib.sha256(gzip.decompress((HERE/'job.log.gz').read_bytes())).hexdigest()==log_hashes['decoded_sha256']
    with tempfile.TemporaryDirectory(prefix='server-spec-flow-audit-')as tmp:
        tmp=Path(tmp);data=tmp/'data';seen=set()
        with zipfile.ZipFile(HERE/'workflow-artifact.zip')as z:
            for info in z.infolist():
                rel=Path(info.filename)
                assert not rel.is_absolute()and '..'not in rel.parts and '\\'not in info.filename and info.filename not in seen
                mode=(info.external_attr>>16)&0o170000
                assert mode in (0,0o100000,0o040000)
                seen.add(info.filename)
                if info.is_dir():continue
                p=data/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(z.read(info))
        locations={'tcp_event':('run','verification.json',13,0),
                   'tcp_wire':('wire-run','wire-verification.json',13,5),
                   'udp_descriptor':('udp-client/job','udp-client/verification.json',12,0)}
        reports={key:read(data/loc/'flow.json')for key,(loc,_,_,_)in locations.items()}
        bindings={};tool_sets=[]
        for report in reports.values():
            tools={}
            for name,digest in report['input_hashes'].items():
                prefix,tail=name.split('/',1);assert prefix in ('workspace','tool')
                rel=tail if prefix=='workspace'else'protocol_lab/'+tail
                assert not Path(rel).is_absolute()and '..'not in Path(rel).parts and '\n'not in rel and '\r'not in rel
                assert rel not in bindings or bindings[rel]==digest
                bindings[rel]=digest
                if prefix=='tool':tools[rel]=digest
            tool_sets.append(tools)
        assert len(tool_sets[0])==29 and all(t==tool_sets[0]for t in tool_sets)
        client=read(data/'udp-client/client-result.json')
        assert client['accepted']and client['assessment']=='verified_event_slice'and client['client_source_unchanged']
        assert client['run_returncode']==client['verify_returncode']==0
        bindings['examples/run_spec_candidate.py']=client['client_source_sha256']
        # Only SHA-matching blobs from this approved immutable Git epoch are run.
        batch=('\n'.join(SOURCE+':'+rel for rel in bindings)+'\n').encode()
        stream=io.BytesIO(subprocess.check_output(['git','cat-file','--batch'],input=batch,cwd=ROOT))
        source=tmp/'source'
        for rel,digest in bindings.items():
            header=stream.readline().decode().split();assert len(header)==3 and header[1]=='blob'
            raw=stream.read(int(header[2]));assert stream.read(1)==b'\n'and hashlib.sha256(raw).hexdigest()==digest,rel
            p=source/rel;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(raw)
        assert not stream.read()
        env=dict(os.environ);env['PYTHONPATH']=str(source);env['PYTHONDONTWRITEBYTECODE']='1'
        checked=[]
        for key,(loc,verification,cases,wire_cases)in locations.items():
            job=data/loc;r=reports[key]
            assert len(r['stages'])==10 and all(s['status']=='pass'for s in r['stages'].values())
            assert len(r['stages']['compare']['data']['cases'])==cases
            f=r['stages']['formal']['data']
            assert f['depth']==6 and f['safety_query']==f['overlap_query']=='unsat'and not f['unbounded_proof']
            assert not r['pcap_evidence']and not r['protocol_correctness_proved']and not r['whole_goal_complete']
            p=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(job),'--workspace',str(source),'--task-sha256',r['task_sha256']],cwd=source,env=env,text=True,capture_output=True,timeout=30)
            assert p.returncode==0,(p.stdout,p.stderr)
            audit=json.loads(p.stdout);assert audit==read(data/verification)
            binary=job/'stages/build/build/protocol-native';compiler=r['stages']['build']['data']
            assert binary.read_bytes().startswith(b'\x7fELF')and sha(binary)==compiler['executable_sha256']
            wire=r['stages']['execute']['data']['wire_cases'];assert len(wire)==wire_cases
            if wire_cases:
                assert sum(w['native_egress_packets']for w in wire)==15
                for row in wire:
                    execution=read(job/row['path']);assert execution['status']=='pass'and execution['pcap_evidence']
                    assert not execution['linux_tcp_network_evidence']and not execution['physical_network_evidence']
                wb=job/'stages/build/wire-build/protocol-native';wc=r['stages']['build']['data']['wire_compile']
                assert wb.read_bytes().startswith(b'\x7fELF')and sha(wb)==wc['executable_sha256']
            checked.append(dict(task=key,inputs=len(r['input_hashes']),artifacts=len(r['outputs']),cases=cases,wire_cases=wire_cases,
                                native_executable_sha256=sha(binary),compiler_sha256=compiler['compiler_sha256'],compiler_version=compiler['compiler_version']))
        assert reports['udp_descriptor']['stages']['reference']['data']['trace_contract_steps_checked']==14
        assert len(reports['udp_descriptor']['stages']['tests']['data']['covered_rules'])==7
        tests={}
        for name,count in (('tests.log',20),('wire-tests.log',9),('migration-tests.log',8)):
            log=(data/name).read_text();assert 'Ran '+str(count)+' tests'in log and log.rstrip().endswith('OK')and 'skipped'not in log
            tests[name]=count
        result=dict(status='original_ubuntu_two_spec_flow_accepted',source_head=SOURCE,merge_snapshot=MERGE,
                    ci_run=provenance['run'],job=provenance['job'],artifact_id=artifact['id'],original_zip_sha256=ZIP,
                    tests_run=tests,source_git_blobs_checked=len(bindings),identical_generic_tool_files=29,tasks=checked,
                    validator_source_epoch=SOURCE,validator_from_immutable_git=True,archive_code_executed=False,
                    new_native_or_solver_execution=False,linux_tcp_network_evidence=False,
                    scope='actual Ubuntu TCP event/wire and UDP descriptor migration; retained audit only; no full protocol or English-to-IR/generator proof')
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result


if __name__=='__main__':print(json.dumps(accept()))
