"""Full flow then native-byte PCAP/independent-oracle gate; no network claims."""
import argparse
import json
from pathlib import Path
import sys
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from examples.run_spec_candidate import run_candidate
from protocol_lab.codegen import sha
from protocol_lab.codegen.execute import write
from protocol_lab.codegen.wire_execute import write_raw_pcap
from protocol_lab.ir import value_ok
from protocol_lab.udp_observe import decode_pcap,compare_records


def observe(job,oracle_file,oracle_sha256,out):
    job=Path(job);out=Path(out);oracle_file=Path(oracle_file)
    if sha(oracle_file)!=oracle_sha256:raise ValueError('Oracle differs from caller-approved digest')
    oracle=json.loads(oracle_file.read_text());flow=json.loads((job/'flow.json').read_text())
    if oracle['schema']!='native-udp-transmit-oracle-v1'or flow['task_id']!='udp-ipv4-wire-transmit':raise ValueError('Unsupported task/oracle')
    if flow['input_hashes'].get('workspace/spec/udp-wire-transmit-oracle.json')!=oracle_sha256:raise ValueError('Oracle not bound by original flow task')
    for name,digest in flow['outputs'].items():
        path=(job/name).resolve()
        if not path.is_relative_to(job.resolve())or sha(path)!=digest:raise ValueError('Base flow artifact changed')
    if any(flow['stages'][n]['status']!='pass'for n in ('sources','ir','reference','execute','compare','traceability')):raise ValueError('Base observation gates did not pass')
    inputs={str(oracle_file.resolve()):oracle_sha256,str((job/'flow.json').resolve()):sha(job/'flow.json'),str(Path(__file__).resolve()):sha(__file__)}
    import protocol_lab.udp_observe as decoder
    import protocol_lab.codegen.wire_execute as framer
    for module,relative in ((decoder,'udp_observe.py'),(framer,'codegen/wire_execute.py')):
        digest=sha(module.__file__)
        if flow['input_hashes'].get('tool/'+relative)!=digest:raise ValueError('Observation tool differs from frozen flow source')
        inputs[str(Path(module.__file__).resolve())]=digest
    out.mkdir(exist_ok=False);cases={r['key']:r for r in flow['stages']['tests']['data']['cases']};rows=[];seen=set();total=0
    for actual in flow['stages']['execute']['data']['cases']:
        case=cases[actual['key']];scenario=json.loads((job/case['path']).read_text());packets=[];traceability=[]
        stdout=job/actual['stdout'];inputs[str(stdout.resolve())]=sha(stdout)
        for row in map(json.loads,stdout.read_text().splitlines()):
            if row['status']!='transition':continue
            for message in row['emitted']:
                if message['message']!='ipv4.tx'or set(message['fields'])!={'packet'}or not value_ok(message['fields']['packet'],'bytes'):raise ValueError('Invalid native packet emission')
                packets.append((row['time_ms'],bytes(message['fields']['packet'])))
                traceability.append(dict(transition=row['transition'],requirements=row['requirements'],time_ms=row['time_ms']))
        if actual['negative']and packets:raise ValueError('Rejected command emitted packet')
        pcap=out/(actual['key']+'.pcap');write_raw_pcap(pcap,packets);decoded=decode_pcap(pcap);comparison=None
        if case['origin']=='declared_seed':
            if scenario['id']not in oracle['cases']or scenario['id']in seen:raise ValueError('Missing/duplicate fixed packet oracle')
            seen.add(scenario['id']);comparison=compare_records(oracle['cases'][scenario['id']]['packets'],decoded)
        result=dict(key=actual['key'],origin=case['origin'],status='pass'if comparison is None or comparison['status']=='match'else'fail',decoded=decoded,comparison=comparison,traceability=traceability)
        write(out/(actual['key']+'.json'),result);rows.append(result);total+=len(packets)
    if seen!=set(oracle['cases']):raise ValueError('Unused oracle cases')
    if any(sha(name)!=h for name,h in inputs.items()):raise ValueError('Observation inputs changed')
    report=dict(status='pass'if all(r['status']=='pass'for r in rows)else'fail',native_packet_count=total,fixed_packet_oracles=len(seen),cases=rows,inputs=inputs,
                observation_origin='generated_native_egress_bytes_framed_pcap',reference_packets_used_to_construct_pcap=False,linux_network_evidence=False,physical_network_evidence=False,
                outputs={p.name:sha(p)for p in out.iterdir()if p.is_file()})
    write(out/'observation.json',report);return report


def run(workspace,task,task_sha256,oracle,oracle_sha256,out):
    workspace=Path(workspace).resolve();out=Path(out).resolve()
    oracle_path=(workspace/oracle).resolve()
    if not oracle_path.is_relative_to(workspace):raise ValueError('Oracle escapes candidate workspace')
    client=run_candidate(workspace,Path(task),out,task_sha256)
    observed=observe(out/'job',oracle_path,oracle_sha256,out/'udp-pcap')
    status='fail'if observed['status']!='pass'else'pass'if client['accepted']else'unresolved'if client['assessment']=='unresolved'else'blocked'if client['assessment']=='blocked'else'fail'
    result=dict(status=status,run_id=client['run_id'],flow_accepted=client['accepted'],flow_assessment=client['assessment'],pcap_status=observed['status'],native_packets=observed['native_packet_count'],fixed_oracle_cases=observed['fixed_packet_oracles'],task_sha256=task_sha256,oracle_sha256=oracle_sha256,whole_ipv4_stack_complete=False,linux_network_evidence=False)
    write(out/'udp-flow-result.json',result);return result


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__)
    for n in ('workspace','task','task-sha256','job'):p.add_argument('--'+n)
    for n in ('oracle','oracle-sha256','out'):p.add_argument('--'+n,required=True)
    a=p.parse_args()
    try:
        if a.job:r=observe(a.job,a.oracle,a.oracle_sha256,a.out)
        else:
            if not all((a.workspace,a.task,a.task_sha256)):raise ValueError('Run needs workspace/task/task digest')
            r=run(a.workspace,a.task,a.task_sha256,a.oracle,a.oracle_sha256,a.out)
    except (ValueError,OSError,KeyError)as e:r=dict(status='fail',reason=str(e))
    print(json.dumps(r));raise SystemExit(0 if r['status']=='pass'else 1)
