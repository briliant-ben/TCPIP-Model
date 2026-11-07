"""Read-only original-Git verification of four actual server flow jobs."""
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
SOURCE='34e470604d3f3dfed91c17f68026ef786a08d964'
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
    summary=read(HERE/'udp-payload-flow-34e47060-summary.json');archive=HERE/'udp-payload-flow-34e47060-evidence.tar.gz'
    assert archive.stat().st_size==summary['archive_bytes']and sha(archive)==summary['archive_sha256']
    release=read(HERE/'release.json');assert release['source_commit']==summary['source_commit']==SOURCE and len(release['files'])==70
    with tempfile.TemporaryDirectory(prefix='udp-payload-original-git-audit-')as temporary:
        tmp=Path(temporary);data=tmp/'data';seen=set();total=0
        with tarfile.open(archive)as tar:
            for m in tar:
                p=Path(m.name);total+=m.size
                assert m.isfile()and not p.is_absolute()and '..'not in p.parts and '\\'not in m.name and m.name not in seen
                assert m.name.startswith('runs/udp-payload-flow-34e47060/')and m.size<=16*1024*1024 and total<=100*1024*1024
                target=data/p;target.parent.mkdir(parents=True,exist_ok=True);target.write_bytes(tar.extractfile(m).read());seen.add(m.name)
        assert len(seen)==summary['archive_members']==751
        source=tmp/'source';export(release['files'],source);run=data/'runs/udp-payload-flow-34e47060'
        bootstrap=read(run/'bootstrap.json');assert bootstrap['status']=='pass'and bootstrap['source_commit']==SOURCE and len(bootstrap['tasks'])==4
        assert bootstrap['api_calls_made']==0 and bootstrap['network_configuration_changed']is False
        log=(run/'bootstrap.log').read_text();assert all('Ran '+str(n)+' tests'in log for n in (20,9,8,4))and 'FAILED'not in log and 'skipped'not in log
        env=dict(os.environ,PYTHONPATH=str(source),PYTHONDONTWRITEBYTECODE='1');reports=[]
        for i in range(4):
            folder=run/('task-'+str(i));flow=read(folder/'job/flow.json')
            assert all(stage['status']=='pass'for stage in flow['stages'].values())
            p=subprocess.run([sys.executable,'-m','protocol_lab.pipeline','verify',str(folder/'job'),'--workspace',str(source),'--task-sha256',flow['task_sha256']],cwd=source,env=env,capture_output=True,text=True,timeout=30)
            assert p.returncode==0,(p.stdout,p.stderr)
            assert json.loads(p.stdout)==read(folder/'verification.json');reports.append(json.loads(p.stdout))
        flow=read(run/'task-3/job/flow.json');tests=flow['stages']['tests']['data'];reference=flow['stages']['reference']['data']
        assert len(tests['covered_rules'])==4 and not tests['uncovered_rules']and len(tests['cases'])==19
        assert len(tests['positives'])==4 and tests['negative_count']==9 and reference['trace_contract_steps_checked']==13
        failure=read(HERE/'initial-failure.json');initial=HERE/'initial-local-failure.tar.gz'
        assert failure['archive_bytes']==initial.stat().st_size and failure['archive_sha256']==sha(initial)and failure['accepted']is False
        result=dict(status='original_server_four_flow_jobs_accepted',source_commit=SOURCE,git_source_files_checked=70,archive_members=751,specialized_test_methods=41,flow_jobs_reverified=4,udp_payload_cases=19,generated_rule_witnesses=4,independent_seed_cases=6,negative_model_gap_cases=9,literal_trace_contract_steps=13,
                    archive_code_executed=False,fresh_solver_or_native_run_during_audit=False,api_calls_during_deployment=0,udp_wire_or_pcap_evidence=False,whole_ipv4_stack_complete=False)
    (HERE/'acceptance.json').write_text(json.dumps(result,indent=2)+'\n');return result


if __name__=='__main__':print(json.dumps(accept()))
