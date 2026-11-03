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
import zipfile

HERE=Path(__file__).resolve().parent
ROOT=HERE.parents[1]
SOURCE='b7ad787450ef364c4c5790ce89788b8d62027095'
TESTED='bd618fde35b044803e795a335cd14a62cd39e57b'
SERVER='/home/runner/work/TCPIP-Model/TCPIP-Model/artifacts/icmp-echo-release/'
TOOLS='/tmp/icmp-echo-immutable-release/tools/'
RUN='run'
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
    summary=read(HERE/'provenance.json');archive=HERE/'release.zip'
    assert sha(archive)==summary['hashes']['release.zip']
    assert sha(HERE/'flow.zip')==summary['hashes']['flow.zip']
    assert subprocess.check_output(['git','rev-parse',SOURCE+'^{tree}'],cwd=ROOT,text=True).strip()==summary['tested_tree_sha1']
    with tempfile.TemporaryDirectory(prefix='byte-access-linux-original-audit-')as temporary:
        tmp=Path(temporary);data=tmp/'data';seen=set();total=0
        with zipfile.ZipFile(archive)as z:
            for m in z.infolist():
                p=Path(m.filename);total+=m.file_size
                assert not m.is_dir()and not p.is_absolute()and '..'not in p.parts and m.filename not in seen and '\\'not in m.filename
                assert p.parts[0]in ('bundle','run','bootstrap-result.json')and m.file_size<=16*1024*1024 and total<=100*1024*1024
                target=data/p;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(z.read(m));seen.add(m.filename)
        assert len(seen)==summary['archive_members']==3147
        manifest=read(data/'bundle/release.json');assert manifest['source_commit']==summary['source_commit']==TESTED
        build=read(data/'bundle/build.json');package=data/'bundle/spec-flow-server.tar.gz'
        assert build['archive_sha256']==sha(package)and build['archive_bytes']==package.stat().st_size
        package_seen=set()
        with tarfile.open(package)as tar:
            for m in tar:
                assert m.isfile()and m.name not in package_seen;package_seen.add(m.name)
                raw=tar.extractfile(m).read()
                if m.name=='release.json':assert json.loads(raw)==manifest
                else:assert m.name.startswith('tools/')and hashlib.sha256(raw).hexdigest()==manifest['files'][m.name[6:]]
        assert package_seen=={'release.json',*('tools/'+n for n in manifest['files'])}
        builder=subprocess.check_output(['git','show',SOURCE+':deploy/package.py'],cwd=ROOT)
        assert hashlib.sha256(builder).hexdigest()==manifest['builder_sha256']
        source=tmp/'source';export(manifest['files'],source)
        run=data/RUN;bootstrap=read(run/'bootstrap.json');assert bootstrap['status']=='pass'and bootstrap['source_commit']==TESTED
        log=(run/'bootstrap.log').read_text()
        assert all('Ran '+str(n)+' tests'in log for n in (20,9,8,4,13,12,14))and 'FAILED'not in log and 'skipped'not in log
        env=dict(os.environ,PYTHONPATH=str(source),PYTHONDONTWRITEBYTECODE='1')
        for i in range(10):
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
        for i,count in enumerate((15,101,13,13)):
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
                if i in (0,2,3):
                    formal=read(execution.parent/'formal-fixed-input.json')
                    assert formal==read(execution.parent/'symbolic/result.json')
                    assert formal['status']==formal['replay']['status']=='match'and formal['query']=='sat'
                    assert formal['smt2_sha256']==sha(execution.parent/'symbolic/path.smt2')
            counts.append(count)
        arithmetic=read(run/'task-4/job/flow.json')
        assert len(arithmetic['stages']['tests']['data']['cases'])==12
        assert arithmetic['stages']['reference']['data']['trace_contract_steps_checked']==11
        assert len(manifest['files'])==305
        import re
        assert sum(map(int,re.findall(r'Ran (\d+) tests',log)))==130
        original_bootstrap=subprocess.check_output(['git','show',SOURCE+':deploy/bootstrap.py'],cwd=ROOT)
        assert (run/'bootstrap-source.py').read_bytes()==original_bootstrap
        assert bootstrap['bootstrap_source_sha256']==hashlib.sha256(original_bootstrap).hexdigest()
        assert bootstrap['packet_observations']==[dict(kind='ipv4-udp-transmit-v1',packets=9,fixed_oracle_cases=6,linux_network_evidence=False)]
        from protocol_lab.udp_observe import decode_pcap
        packet_dir=run/'udp-transmit-pcap';observation=read(packet_dir/'observation.json')
        assert observation['status']=='pass'and observation['native_packet_count']==9 and observation['fixed_packet_oracles']==6
        assert observation['linux_network_evidence']is False and observation['physical_network_evidence']is False
        assert observation['reference_packets_used_to_construct_pcap']is False
        assert set(observation['outputs'])=={p.name for p in packet_dir.iterdir()if p.is_file()}-{'observation.json'}
        for n,h in observation['outputs'].items():assert sha(packet_dir/n)==h
        for n,h in observation['inputs'].items():binding(n,h)
        txflow=read(run/'task-5/job/flow.json');oracle=read(source/'spec/udp-wire-transmit-oracle.json');seen_oracles=set();packet_count=0
        cases={r['key']:r for r in txflow['stages']['tests']['data']['cases']}
        assert len(cases)==9 and txflow['stages']['reference']['data']['trace_contract_steps_checked']==10
        for row,actual in zip(observation['cases'],txflow['stages']['execute']['data']['cases'],strict=True):
            assert row['key']==actual['key']and row['status']=='pass'
            records=decode_pcap(packet_dir/(row['key']+'.pcap'));assert records==row['decoded']
            emitted=[];tracking=[]
            for event in map(json.loads,(run/'task-5/job'/actual['stdout']).read_text().splitlines()):
                if event['status']!='transition':continue
                for message in event['emitted']:
                    assert message['message']=='ipv4.tx'
                    emitted.append((event['time_ms'],bytes(message['fields']['packet']).hex()))
                    tracking.append(dict(transition=event['transition'],requirements=event['requirements'],time_ms=event['time_ms']))
            assert emitted==[(r['at_ms'],r['hex'])for r in records]and tracking==row['traceability']
            packet_count+=len(records)
            case=cases[row['key']]
            if case['origin']=='declared_seed':
                scenario=read(run/'task-5/job'/case['path']);name=scenario['id'];assert name not in seen_oracles;seen_oracles.add(name)
                assert records==oracle['cases'][name]['packets']
            if case['negative']:assert not records
        assert packet_count==9 and seen_oracles==set(oracle['cases'])
        queries=run/'task-5/job/stages/formal/queries';formal=read(queries/'result.json')
        assert formal['safety_query']==formal['overlap_query']=='unsat'and formal['status']=='bounded_pass'
        for n in ('model.smt2','overlap.smt2'):
            prior=subprocess.check_output(['git','show',SOURCE+':artifacts/udp-transmit-f9472593-failed/udp-transmit-f9472593-original-formal/'+n],cwd=ROOT)
            assert prior==(queries/n).read_bytes() # identical full-depth/all-input queries
        assert formal['sample_queries'][0]['scope']=='existential_nonvacuity_only'and formal['sample_queries'][0]['depth']==1
        assert formal['sample_queries'][0]['query']=='sat'and formal['replay']['status']=='match'
        for sample in formal['sample_queries']:assert sample['smt2_sha256']==sha(queries/sample['file'])
        byteflow=read(run/'task-6/job/flow.json')
        assert len(byteflow['stages']['tests']['data']['cases'])==9 and byteflow['stages']['reference']['data']['trace_contract_steps_checked']==8
        byteformal=read(run/'task-6/job/stages/formal/queries/result.json')
        assert byteformal['safety_query']==byteformal['overlap_query']=='unsat'and byteformal['status']=='bounded_pass'
        rxflow=read(run/'task-7/job/flow.json')
        assert len(rxflow['stages']['tests']['data']['cases'])==27 and rxflow['stages']['reference']['data']['trace_contract_steps_checked']==13
        assert rxflow['stages']['tests']['data']['negative_count']==7 and len(rxflow['stages']['tests']['data']['covered_rules'])==8
        rxformal=read(run/'task-7/job/stages/formal/queries/result.json')
        assert rxformal['depth']==2 and rxformal['safety_query']==rxformal['overlap_query']=='unsat'and rxformal['status']=='bounded_pass'
        arp=read(run/'task-8/job/flow.json')
        assert len(arp['stages']['tests']['data']['cases'])==64 and arp['stages']['reference']['data']['trace_contract_steps_checked']==32
        assert arp['stages']['tests']['data']['negative_count']==30 and len(arp['stages']['tests']['data']['covered_rules'])==21
        proof=read(run/'task-8/job/stages/formal/queries/result.json')
        assert proof['depth']==3 and proof['safety_query']==proof['overlap_query']=='unsat'and proof['status']=='bounded_pass'
        icmp=read(run/'task-9/job/flow.json');icmp_proof=read(run/'task-9/job/stages/formal/queries/result.json')
        assert len(icmp['stages']['tests']['data']['cases'])==28 and icmp['stages']['reference']['data']['trace_contract_steps_checked']==13
        assert icmp['stages']['tests']['data']['negative_count']==10 and len(icmp['stages']['tests']['data']['covered_rules'])==5
        assert icmp_proof['depth']==2 and icmp_proof['solver_timeout_ms']==60000 and icmp_proof['safety_query']==icmp_proof['overlap_query']=='unsat'and icmp_proof['status']=='bounded_pass'
        with zipfile.ZipFile(HERE/'flow.zip')as direct:
            failed= json.loads(direct.read('run/job/stages/formal/queries/result.json'))
            assert failed['solver_timeout_ms']==60000 and failed['safety_query']=='unknown'and failed['overlap_query']=='unsat'
            for n in ('model.smt2','overlap.smt2'):assert direct.read('run/job/stages/formal/queries/'+n)==(run/'task-9/job/stages/formal/queries'/n).read_bytes()
        result=dict(icmp_cases=28,icmp_literal_steps=13,icmp_model_gaps=10,icmp_rules_covered=5,icmp_real_peer_observed=False,direct_linux_60s_unknown_preserved=True,icmp_queries_byte_identical_across_release_pass_and_direct_unknown=True,arp_cases=64,arp_literal_steps=32,arp_model_gaps=30,arp_rules_covered=21,arp_real_peer_observed=False,receive_cases=27,receive_literal_steps=13,receive_model_gaps=7,byte_access_cases=9,byte_access_literal_steps=8,native_udp_packets=9,fixed_packet_oracle_cases=6,unchanged_legacy_udp_unrestricted_safety_and_overlap_queries=True,udp_receive_scope="fixed raw byte profile, no peer/composition",linux_network_evidence=False,arithmetic_cases=12,arithmetic_trace_contract_steps=11,whole_checksum_equivalence_proved=False,status='retained_finite_icmp_linux_ci_release_evidence_accepted',project_server_deployed=False,source_commit=TESTED,audit_git_commit=SOURCE,git_files_checked=len(manifest['files']),archive_members=len(seen),specialized_test_methods=130,flow_jobs_reverified=10,native_cases_recompared=counts,fixed_input_symbolic_reports_integrity_checked=41,archive_code_executed=False,fresh_native_or_solver_execution=False,compiler_correctness_proved=False,whole_ipv4_endpoint_complete=False)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result


if __name__=='__main__':print(json.dumps(accept()))
