"""Byte-only adapter: generated IR C <-> isolated TUN <-> independent Linux UDP."""
import argparse
import fcntl
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import select
import shutil
import socket
import struct
import subprocess
import sys
import time
ROOT=Path(__file__).resolve().parents[2];PORT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT));sys.path.insert(0,str(PORT))
from protocol_lab.codegen import generate,sha
from protocol_lab.codegen.execute import build,commands,compare,write
from protocol_lab.ir import load,require,Uncovered,Conflict,ModelError
from protocol_lab.udp_observe import decode_packet
from capture import records


def inputs():
    paths={PORT/'cases.json',ROOT/'requirements-formal.txt',ROOT/'.github/workflows/linux-udp-peer.yml'}
    paths|={p for p in PORT.rglob('*')if p.is_file()and '__pycache__'not in p.parts}
    paths|={p for p in (ROOT/'protocol_lab').rglob('*')if p.suffix in ('.py','.c')}
    config=json.loads((PORT/'cases.json').read_text())
    paths|={ROOT/config['tx_model'],ROOT/config['rx_model'],*(ROOT/n for n in config['scenarios'])}
    for task in ('flows/udp-wire-transmit.json','flows/udp-wire-receive.json'):
        paths.add(ROOT/task)
        for source in json.loads((ROOT/task).read_text())['sources']:
            path=ROOT/source['path'];require(sha(path)==source['sha256'],'Pinned source changed');paths.add(path)
    return {str(p.relative_to(ROOT)):sha(p)for p in sorted(paths)}


def isolation(parent,current):
    require(parent.startswith('net:[')and current.startswith('net:[')and parent!=current,'Distinct network namespace required')


def command(args,out,name,timeout=10):
    p=subprocess.run(args,capture_output=True,text=True,timeout=timeout)
    (out/name).write_text(p.stdout+p.stderr);require(p.returncode==0,'Command failed: '+str(args))
    return dict(command=args,returncode=p.returncode,log=name)


def native(out,kind,case,scenario):
    folder=out/case/kind;folder.mkdir(parents=True)
    model=load(ROOT/json.loads((PORT/'cases.json').read_text())[kind+'_model'])
    data=commands(model,scenario);(folder/'scenario.json').write_text(json.dumps(scenario,indent=2)+'\n')
    (folder/'native-input.txt').write_text(data)
    executable=out/(kind+'-build')/'protocol-native'
    p=subprocess.run([str(executable)],input=data,capture_output=True,text=True,env={'PATH':''},timeout=10)
    (folder/'native.stdout').write_text(p.stdout);(folder/'native.stderr').write_text(p.stderr)
    write(folder/'process.json',dict(returncode=p.returncode,executable_sha256=sha(executable)))
    observed=[json.loads(line)for line in p.stdout.splitlines()]
    return observed,p.returncode


def egress(observed):
    result=[]
    for row in observed:
        for item in row.get('emitted',[]):
            require(item['message']=='ipv4.tx'and set(item['fields'])=={'packet'},'Unexpected native egress shape')
            result.append(bytes(item['fields']['packet']))
    require(len(result)==1,'Exactly one native datagram required')
    return result[0]


def verify_payload(data,expected):require(data==expected,'Peer payload differs from declared stimulus')


def inside(out,parent):
    require(platform.system()=='Linux'and os.geteuid()==0,'Linux namespace root required')
    actual=os.readlink('/proc/'+str(os.getppid())+'/ns/net');isolation(parent,os.readlink('/proc/self/ns/net'))
    require(actual==parent,'Parent network namespace argument changed')
    cfg=json.loads((PORT/'cases.json').read_text());logs=[];fd=None;peer=None;capture=None
    namespace=dict(platform='Linux',kernel=platform.release(),parent_netns=parent,actual_parent_netns=actual,
        execution_netns=os.readlink('/proc/self/ns/net'),host_network_mutations=False,peer='Linux kernel UDP socket',
        generated_subject_uses_host_stack=False,packet_bytes_rewritten=False,commands=logs,wire_timing_contract=cfg['wire_timing_contract'],quiet_ms=cfg['quiet_ms'])
    write(out/'namespace.json',namespace)
    try:
        fd=os.open('/dev/net/tun',os.O_RDWR)
        fcntl.ioctl(fd,0x400454ca,struct.pack('16sH22x',b'irudp0',0x1001)) # IFF_TUN|IFF_NO_PI; no persistence/VNET header
        for i,args in enumerate([
            ['ip','link','set','lo','up'],['ip','addr','add',cfg['peer']['ip']+'/32','dev','irudp0'],
            ['ip','link','set','irudp0','mtu',str(cfg['mtu']),'up'],
            ['ip','route','add',cfg['subject']['ip']+'/32','dev','irudp0','src',cfg['peer']['ip']],
            ['ethtool','-K','irudp0','tx','off','tso','off','gso','off','gro','off'],['ethtool','-k','irudp0'],
            ['ip','addr','show'],['ip','route','show'],['tcpdump','--version'],
            ['sysctl','net.ipv4.ip_default_ttl','net.ipv4.ip_no_pmtu_disc']]):
            logs.append(command(args,out,'setup-'+str(i)+'.log'))
        peer=socket.socket(socket.AF_INET,socket.SOCK_DGRAM);peer.settimeout(3)
        peer.bind((cfg['peer']['ip'],cfg['peer']['port']))
        capture_command=['tcpdump','-Z','root','-U','-n','-s','65535','-i','irudp0','-y','RAW','-w',str(out/'capture.pcap'),'udp']
        namespace['capture_command']=capture_command;namespace['capture_packet_limit']=None
        with(out/'capture.log').open('w')as log:
            capture=subprocess.Popen(capture_command,stdout=log,stderr=log)
            deadline=time.monotonic()+5
            while 'listening on'not in(out/'capture.log').read_text()and time.monotonic()<deadline:
                require(capture.poll()is None,'Capture failed to start');time.sleep(0.02)
            require('listening on'in(out/'capture.log').read_text(),'Capture readiness timeout')
            namespace['capture_ready_monotonic_ns']=time.monotonic_ns();trials=[];ignored=[]
            for index,path in enumerate(cfg['scenarios']):
                case='case-'+str(index);scene=json.loads((ROOT/path).read_text())
                require(len(scene['steps'])==1 and scene['steps'][0]['event']=='app.send','One declared send per trial required')
                expected=bytes(scene['steps'][0]['fields']['data']);tx,code=native(out,'tx',case,scene)
                require(code==0,'Native transmit failed');raw=egress(tx)
                (out/case/'tx.raw').write_bytes(raw);namespace['last_inject_monotonic_ns']=time.monotonic_ns()
                require(os.write(fd,raw)==len(raw),'Incomplete TUN injection')
                delivered,address=peer.recvfrom(65535)
                require(address==(cfg['subject']['ip'],cfg['subject']['port']),'Peer received wrong source endpoint')
                verify_payload(delivered,expected);sent=peer.sendto(delivered,address)
                require(sent==len(delivered),'Incomplete peer datagram send')
                deadline=time.monotonic()+3
                while True:
                    remaining=deadline-time.monotonic();require(remaining>0,'Peer raw reply timeout')
                    require(select.select([fd],[],[],remaining)[0],'Peer raw reply timeout')
                    reply=os.read(fd,65535)
                    if reply and reply[0]>>4==6:
                        name='ignored-'+str(len(ignored))+'.raw';(out/name).write_bytes(reply);ignored.append(dict(file=name,reason='unselected_ipv6'));continue
                    break
                (out/case/'rx.raw').write_bytes(reply)
                rxscene=dict(scenario_version='0.2',id=case,initial={},steps=[dict(at_ms=cfg['logical_event_time_ms'],event='net.packet',fields=dict(packet=list(reply)),expect_trace=[dict(at_ms=0,emitted=[dict(message='udp.rx',fields=dict(data=list(expected)))])])],expect=dict(state='READY',variables=dict(payload=list(expected),disposition='deliver'),timers={}))
                rx,rxcode=native(out,'rx',case,rxscene)
                decoded=decode_packet(reply)
                require((decoded['src'],decoded['source_port'],decoded['dst'],decoded['destination_port'])==
                    (cfg['peer']['ip'],cfg['peer']['port'],cfg['subject']['ip'],cfg['subject']['port']),'Wrong raw reply endpoints')
                verify_payload(bytes.fromhex(decoded['payload_hex']),expected)
                trials.append(dict(case=case,scenario=path,peer_received_hex=delivered.hex(),peer_source=list(address),peer_send_bytes=sent,
                    tx_returncode=code,rx_returncode=rxcode,rx_decoded=decoded))
                namespace['last_reply_read_monotonic_ns']=time.monotonic_ns()
            namespace['ignored_tun_frames']=ignored;write(out/'trials.json',trials)
            time.sleep(cfg['quiet_ms']/1000);require(capture.poll()is None,'Capture ended early')
            namespace['capture_stop_request_monotonic_ns']=time.monotonic_ns();capture.send_signal(2);code=capture.wait(timeout=5)
            namespace['capture_returncode']=code;namespace['capture_exit_monotonic_ns']=time.monotonic_ns()
            require(code==0,'Independent capture failed')
        write(out/'namespace.json',namespace)
    finally:
        if capture is not None and capture.poll()is None:capture.send_signal(2);capture.wait(timeout=5)
        if peer is not None:peer.close()
        if fd is not None:os.close(fd)
        namespace['socket_and_tun_closed_monotonic_ns']=time.monotonic_ns();write(out/'namespace.json',namespace)


def assess(out,save=True):
    cfg=json.loads((PORT/'cases.json').read_text());namespace=json.loads((out/'namespace.json').read_text())
    isolation(namespace['parent_netns'],namespace['execution_netns'])
    require(namespace['actual_parent_netns']==namespace['parent_netns']and not namespace['host_network_mutations']
        and not namespace['generated_subject_uses_host_stack']and not namespace['packet_bytes_rewritten'],'Isolation/provenance changed')
    require(namespace['capture_packet_limit']is None and '-c'not in namespace['capture_command'],'Capture limited')
    require(namespace['capture_ready_monotonic_ns']<=namespace['last_inject_monotonic_ns']<=namespace['last_reply_read_monotonic_ns']
        <=namespace['capture_stop_request_monotonic_ns']<=namespace['capture_exit_monotonic_ns']<=namespace['socket_and_tun_closed_monotonic_ns'],'Capture lifecycle invalid')
    require(namespace['capture_returncode']==0,'Capture did not finish')
    require(namespace['quiet_ms']==cfg['quiet_ms']and namespace['capture_stop_request_monotonic_ns']-namespace['last_reply_read_monotonic_ns']>=cfg['quiet_ms']*1000000,'Quiet capture interval shortened')
    drops=re.findall(r'(\d+) packets dropped by kernel',(out/'capture.log').read_text());require(drops and int(drops[-1])==0,'Capture drops invalidate observations')
    captured=records(out/'capture.pcap');trials=json.loads((out/'trials.json').read_text());expected_raw=[];differences=[]
    require(len(trials)==len(cfg['scenarios']),'Incomplete peer trials')
    for index,trial in enumerate(trials):
        require(trial['case']=='case-'+str(index)and trial['scenario']==cfg['scenarios'][index],'Trial/scenario identity changed')
        source_scene=json.loads((ROOT/trial['scenario']).read_text())
        stimulus=bytes(source_scene['steps'][0]['fields']['data'])
        verify_payload(bytes.fromhex(trial['peer_received_hex']),stimulus)
        require(trial['peer_source']==[cfg['subject']['ip'],cfg['subject']['port']]and trial['peer_send_bytes']==len(stimulus),'Peer socket observation changed')
        folder=out/trial['case'];expected_raw.extend([(folder/'tx.raw').read_bytes().hex(),(folder/'rx.raw').read_bytes().hex()])
        for kind in ('tx','rx'):
            scene=json.loads((folder/kind/'scenario.json').read_text());model=load(ROOT/cfg[kind+'_model'])
            if kind=='tx':require(scene==source_scene,'Transmit stimulus changed')
            require(commands(model,scene)==(folder/kind/'native-input.txt').read_text(),'Native input differs from saved ingress')
            observed=[json.loads(r)for r in(folder/kind/'native.stdout').read_text().splitlines()]
            process=json.loads((folder/kind/'process.json').read_text())
            require(process['executable_sha256']==sha(out/(kind+'-build')/'protocol-native'),'Executable binding changed')
            try:diff=compare(model,scene,observed)
            except Uncovered as error:diff=dict(status='model_gap',error=str(error))
            except Conflict as error:diff=dict(status='rule_conflict',error=str(error))
            except ModelError as error:diff=dict(status='invariant_failure'if 'Invariant failed'in str(error)else'reference_contract_failure',error=str(error))
            if process['returncode']!=0 and diff['status']in ('match','different'):diff=dict(status='implementation_difference',native_returncode=process['returncode'],reference=diff)
            if diff['status']!='match':differences.append(dict(case=trial['case'],kind=kind,difference=diff))
            if kind=='tx':require(egress(observed).hex()==expected_raw[-2],'Injected bytes differ from generated C egress')
            else:
                require(bytes(scene['steps'][0]['fields']['packet']).hex()==expected_raw[-1],'Receive ingress bytes rewritten')
                emitted=[e for r in observed for e in r.get('emitted',[])]
                if diff['status']=='match':require(emitted==[dict(message='udp.rx',fields=dict(data=list(bytes.fromhex(trial['peer_received_hex']))))],'Native receive delivery differs from peer bytes')
            if save:write(folder/kind/'difference.json',diff)
            else:require(json.loads((folder/kind/'difference.json').read_text())==diff,'Saved native Difference changed')
    require([r['hex']for r in captured]==expected_raw,'Independent capture differs from original TX/TUN reply bytes')
    difference=dict(status='match'if not differences else'unresolved',differences=differences)
    if save:write(out/'decoded.json',captured);write(out/'difference.json',difference)
    else:require(json.loads((out/'decoded.json').read_text())==captured and json.loads((out/'difference.json').read_text())==difference,'Saved capture/Difference changed')
    return dict(status='pass'if not differences else'unresolved',classification=None if not differences else differences[0]['difference']['status'],roundtrips=len(trials),captured_packets=len(captured),differences=differences,
        observation='real isolated Linux kernel UDP peer and independent tcpdump; generated IR C is subject',
        project_server_deployed=False,whole_ipv4_endpoint_complete=False,wire_timing_contract=cfg['wire_timing_contract'])


def run(out):
    out.mkdir(parents=True,exist_ok=False);before=inputs()
    preflight=dict(platform=platform.system(),kernel=platform.release(),euid=os.geteuid(),tun=Path('/dev/net/tun').exists(),tools={n:shutil.which(n)for n in ('ip','unshare','tcpdump','ethtool','sysctl','cc')})
    write(out/'preflight.json',preflight);write(out/'report.json',dict(status='not_run',linux_peer_evidence=False))
    require(preflight['platform']=='Linux'and preflight['euid']==0 and preflight['tun']and all(preflight['tools'].values()),'Linux root/TUN/tools unavailable; this channel alone blocked')
    cfg=json.loads((PORT/'cases.json').read_text())
    for kind in ('tx','rx'):
        generate(ROOT/cfg[kind+'_model'],out/(kind+'-source'));require(build(out/(kind+'-source'),out/(kind+'-build'))['status']=='pass','Native build failed')
    parent=os.readlink('/proc/self/ns/net')
    invocation=['unshare','--net','--',sys.executable,str(PORT/'run.py'),'--inside',parent,'--out',str(out)]
    command(invocation,out,'namespace-driver.log',timeout=60);assessment=assess(out)
    require(before==inputs(),'Inputs changed during peer execution')
    files={str(p.relative_to(out)):sha(p)for p in out.rglob('*')if p.is_file()and p.name!='report.json'}
    report=dict(schema='linux-ir-udp-peer-v1',**assessment,linux_peer_evidence=True,kernel=preflight['kernel'],input_hashes=before,file_hashes=files,
        namespace_invocation=invocation,execution_source_root=str(ROOT),execution_output_dir=str(out),source_commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip(),tool_hashes={str(Path(p).resolve()):sha(Path(p).resolve())for p in [sys.executable,*preflight['tools'].values()]},upstream_modified=False,packet_bytes_rewritten=False,api_calls=0,integrity_is_not_authenticity=True)
    write(out/'report.json',report);return report


if __name__=='__main__':
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',type=Path,default=ROOT/'artifacts/linux-udp-peer');parser.add_argument('--inside')
    args=parser.parse_args();out=args.out.resolve()
    try:
        if args.inside:inside(out,args.inside)
        else:
            report=run(out);print(json.dumps(report));raise SystemExit(0 if report['status']=='pass'else 1)
    except Exception as error:
        out.mkdir(parents=True,exist_ok=True);write(out/('namespace-failure.json'if args.inside else'failure.json'),dict(status='failed_or_blocked',classification='environment'if 'unavailable; this channel'in str(error)else'peer_execution_or_evidence_failure',type=type(error).__name__,reason=str(error),linux_peer_acceptance=False));raise
