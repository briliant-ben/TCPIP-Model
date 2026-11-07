"""Observe native IPv4 bytes, wrap them without re-encoding and independently decode.

Virtual link only: this is generated-implementation evidence, never Linux TCP or
physical-network evidence. Python supplies stimuli and records bytes; C decodes
incoming packets and derives all outgoing TCP fields from generated IR actions.
"""
import argparse
import copy
import json
from pathlib import Path
import struct
import subprocess
from . import sha
from .execute import commands,compare,write
from ..ir import load
from ..flow import run_scenario
from ..packets import ipv4_tcp,normalize_trace,compare as packet_compare
from ..capture import normalize


def write_raw_pcap(path,records):
    data=bytearray(struct.pack('<IHHIIII',0xa1b2c3d4,2,4,0,0,65535,101))
    for at,raw in records:
        sec,ms=divmod(at,1000)
        data.extend(struct.pack('<IIII',sec,ms*1000,len(raw),len(raw)));data.extend(raw)
    Path(path).write_bytes(data)


def run(generation,compiled,scenario_file,out):
    generation=Path(generation).resolve();compiled=Path(compiled).resolve();scenario_file=Path(scenario_file).resolve();out=Path(out).resolve()
    if out.exists():raise ValueError('Fresh wire observation directory required')
    g=json.loads((generation/'generation.json').read_text());c=json.loads((compiled/'compile.json').read_text())
    if 'wire_binding'not in g:raise ValueError('Wire-enabled generation required')
    inputs={**g['inputs'],str(generation/'generation.json'):sha(generation/'generation.json'),str(generation/'protocol.c'):g['outputs']['protocol.c'],
            str(compiled/'compile.json'):sha(compiled/'compile.json'),str(compiled/'protocol-native'):c.get('executable_sha256'),
            str(scenario_file):sha(scenario_file),str(Path(__file__).resolve()):sha(__file__)}
    for name in ('capture.py','packets.py','flow.py','codegen/execute.py'):
        path=Path(__file__).resolve().parents[1]/name;inputs[str(path)]=sha(path)
    def check():
        if c['status']!='pass'or c['generation_sha256']!=sha(generation/'generation.json')or c['generated_source_sha256']!=g['outputs']['protocol.c']:raise ValueError('Invalid compilation binding')
        if any(sha(n)!=h for n,h in inputs.items()):raise ValueError('Wire execution source/evidence changed')
    check();binding=g['wire_binding'];model=load(g['model_file']);scenario=json.loads(scenario_file.read_text())
    # Stimulus encoder has a fixed documented test tuple; reject mismatched binding.
    if binding['local']!={'ip':'192.0.2.1','port':40000}or binding['peer']!={'ip':'192.0.2.2','port':8080}:raise ValueError('Scenario stimulus adapter requires documented test endpoints')
    lines=[];operations=[]
    for line in commands(model,scenario).splitlines():
        parts=line.split()
        if parts[0]=='D'and parts[2]==binding['input_event']:
            at=int(parts[1]);fields=dict(zip(model['events'][parts[2]]['fields'],map(int,parts[3:])))
            raw=ipv4_tcp(dict(direction='in',flags='SA',seq=fields['seq'],ack=fields['ack'],window=65535),0)
            lines.extend(['T '+str(at),'P '+str(at)+' '+raw.hex()]);operations.extend([None,(at,raw)])
        else:
            lines.append(line)
            if parts[0]!='I':operations.append(None)
    data='\n'.join(lines)+'\n';out.mkdir(parents=True);(out/'native-input.txt').write_text(data)
    p=subprocess.run([str(compiled/'protocol-native')],input=data,capture_output=True,text=True,timeout=30)
    (out/'native.stdout').write_text(p.stdout);(out/'native.stderr').write_text(p.stderr)
    egress=0;invalid_observation=None
    try:
        observed=[json.loads(line)for line in p.stdout.splitlines()];records=[];group=[];index=0;egress=0
        for row in observed:
            group.append(row)
            if row['status']in ('ready','ok','error'):
                if index>=len(operations):raise ValueError('Extra native response')
                incoming=operations[index]
                if incoming is not None:records.append(incoming)
                for item in group:
                    if item['status']=='wire_packet':
                        if item['direction']!='out':raise ValueError('Unexpected native wire direction')
                        records.append((item['time_ms'],bytes.fromhex(item['ipv4_hex'])));egress+=1
                group=[];index+=1
        if group or index!=len(operations):raise ValueError('Missing native command response')
        write_raw_pcap(out/'native-virtual-link.pcap',records)
        event_diff=compare(model,scenario,observed)
        adapter_case=copy.deepcopy(scenario)
        adapter_case.setdefault('environment',{}).setdefault('drop_outgoing',[])
        expected=normalize_trace(run_scenario(model,scenario),adapter_case)
        packets,metadata=normalize(out/'native-virtual-link.pcap',binding,expected,origin='unverified',checksum_policy='strict',projection='active-open-v1')
        write(out/'decoded.json',dict(packets=packets,metadata=metadata))
        difference=packet_compare(expected,packets,tolerance_ms=0)
        # Compare raw sequence/ACK values too: normalization may align ISS origins,
        # which must not hide an encoder that consistently shifts emitted sequences.
        from ..capture import decode
        raw_packets=[]
        for record in decode(out/'native-virtual-link.pcap'):
            tcp=record['tcp']
            raw_packets.append(dict(direction='out'if record['src']==binding['local']['ip']else'in',
                                    flags={2:'S',18:'SA',16:'A'}[tcp[13]],
                                    seq=int.from_bytes(tcp[4:8],'big'),ack=int.from_bytes(tcp[8:12],'big'),
                                    time_ms=record['timestamp_ns']/1000000,window=int.from_bytes(tcp[14:16],'big')))
        absolute=packet_compare(expected,raw_packets,tolerance_ms=0)
        for i,(want,got)in enumerate(zip(expected,raw_packets)):
            if want['window']!=got['window']:absolute['differences'].append(dict(kind='window',index=i,expected=want['window'],observed=got['window']))
        absolute['status']='mismatch'if absolute['differences']else'match'
        write(out/'difference.json',dict(events=event_diff,wire=difference,absolute_wire=absolute))
    except (ValueError,KeyError,TypeError,OverflowError,struct.error)as error:
        invalid_observation=str(error)
        event_diff=difference=absolute=dict(status='invalid',reason=invalid_observation)
        write(out/'difference.json',dict(status='invalid_observation',reason=invalid_observation))
    check()
    result=dict(schema='spec-flow-stage-v1',stage='wire_execute_compare',status='pass'if p.returncode==0 and not p.stderr and event_diff['status']=='match'and difference['status']=='match'and absolute['status']=='match'else'fail',
                inputs=inputs,scenario=scenario['id'],native_returncode=p.returncode,native_egress_packets=egress,
                observation_kind='generated_native_ipv4_virtual_link',pcap_origin='stimulus ingress plus unchanged C-produced egress bytes',
                pcap_evidence=(out/'native-virtual-link.pcap').exists(),linux_tcp_network_evidence=False,physical_network_evidence=False,
                scope=binding['scope'],whole_goal_complete=False)
    result['classification']=None if result['status']=='pass'else'invalid_observation'if invalid_observation else'implementation_difference'
    if invalid_observation:result['reason']=invalid_observation
    result['outputs']={f.name:sha(f)for f in out.iterdir()if f.is_file()};write(out/'execution.json',result);return result


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('generation');parser.add_argument('--compiled',required=True);parser.add_argument('--scenario',required=True);parser.add_argument('--out',required=True)
    a=parser.parse_args()
    try:result=run(a.generation,a.compiled,a.scenario,a.out)
    except (ValueError,KeyError,OSError,subprocess.TimeoutExpired)as error:result=dict(schema='spec-flow-stage-v1',stage='wire_execute_compare',status='rejected',reason=str(error))
    print(json.dumps(result));raise SystemExit(0 if result['status']=='pass'else 1)
