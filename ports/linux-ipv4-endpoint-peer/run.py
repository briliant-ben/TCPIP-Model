"""One generated finite IPv4 UDP/ICMP IR subject with isolated Linux peer."""
import argparse
import fcntl
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
from ports.native_session import Session
from protocol_lab.codegen import generate,sha
from protocol_lab.codegen.execute import build,commands,compare,write
from protocol_lab.ir import load,require,model_files
from capture import records
from oracle import assert_echo,expected_reply

TOOLS=('ip','unshare','tcpdump','sysctl','cc','ethtool','ping')

def ping_command(case):
    c=config();return ['ping','-4','-n','-I',c['peer']['ip'],'-M','do','-i',str(c['peer_interval_seconds']),'-W','3','-s',str(case['data_bytes']),'-p',c['pattern'],c['subject']['ip']]



def config():return json.loads((PORT/'cases.json').read_text())
def isolation(parent,current):require(parent.startswith('net:[')and current.startswith('net:[')and parent!=current,'Distinct namespace required')
def inputs():
    cfg=config();paths={ROOT/'ports/native_session.py',ROOT/'examples/arp_observe.py',ROOT/'examples/ethernet_udp_observe.py',ROOT/'requirements-formal.txt',ROOT/'.github/workflows/linux-ipv4-endpoint-peer.yml',ROOT/'examples/icmp_observe.py',ROOT/'tests/test_linux_ipv4_endpoint_peer.py',ROOT/'docs/ipv4-udp-icmp-tap.md',ROOT/'spec/sources/linux-v6.12-tuntap.rst',ROOT/'spec/ipv4-udp-icmp-tap-oracle.json',ROOT/'docs/ipv4-udp-icmp-endpoint.md',ROOT/'spec/ipv4-udp-icmp-endpoint-oracle.json',ROOT/'spec/fixtures/ipv4_udp_icmp_endpoint_v1.py',ROOT/'spec/fixtures/ipv4_udp_icmp_tap_v1.py'}
    paths|={p for p in PORT.rglob('*')if p.is_file()and '__pycache__'not in p.parts}
    paths|={p for p in(ROOT/'protocol_lab').rglob('*')if p.suffix in ('.py','.c')}
    paths|=set(model_files(ROOT/cfg['model']))
    for task in cfg['flows']:
        paths.add(ROOT/task)
        for source in json.loads((ROOT/task).read_text())['sources']:
            p=ROOT/source['path'];require(sha(p)==source['sha256'],'Pinned source changed');paths.add(p)
    for name,digest in json.loads((ROOT/'spec/ipv4-udp-icmp-tap-oracle.json').read_text())['sources'].items():
        p=ROOT/'spec/sources'/name;require(p.resolve().is_relative_to(ROOT/'spec/sources')and sha(p)==digest,'Pinned TAP source changed');paths.add(p)
    require(all(p.resolve().is_relative_to(ROOT)for p in paths),'Source escapes root')
    return {str(p.relative_to(ROOT)):sha(p)for p in sorted(paths)}


def command(args,out,name,timeout=10):
    p=subprocess.run(args,capture_output=True,text=True,timeout=timeout);(out/name).write_text(p.stdout+p.stderr)
    require(p.returncode==0,'Command failed: '+str(args));return dict(command=args,returncode=p.returncode,log=name)


def stream_check(folder,model,scenario):
    session=json.loads((folder/'session.json').read_text());lines=(folder/'native-input.txt').read_text().splitlines()
    rows=[json.loads(r)for r in(folder/'native.stdout').read_text().splitlines()]
    require(session['process_starts']==1 and session['returncode']==0 and session['transport']=='stdin-pipe-stdout-raw-pty','Native process continuity failed')
    require([o['line']for o in session['operations']]==lines and commands(model,scenario)==('\n'.join(lines)+'\n'),'Native ingress/reset/replay changed')
    require(lines.count('B')==1 and lines[0]=='B','Native reset/replay detected')
    end=0
    for i,op in enumerate(session['operations']):
        require(op['pid']==session['pid']and op['row_start']==end and op['sent_monotonic_ns']<=op['reply_monotonic_ns'],'Native session timeline changed')
        end=op['row_end'];require(end>op['row_start']and rows[end-1]['status']==('ready'if i==0 else'ok'),'Native operation did not commit')
    require(end==len(rows),'Native stdout boundary changed');return rows,session


def inside(out,parent):
    require(platform.system()=='Linux'and os.geteuid()==0,'Linux namespace root required')
    actual=os.readlink('/proc/'+str(os.getppid())+'/ns/net');isolation(parent,os.readlink('/proc/self/ns/net'));require(actual==parent,'Parent namespace changed')
    cfg=config();fd=None;capture=None;actor=None;peer=None;pings=[];handles=[];trials=[]
    ns=dict(platform='Linux',kernel=platform.release(),parent_netns=parent,actual_parent_netns=actual,execution_netns=os.readlink('/proc/self/ns/net'),host_network_mutations=False,packet_bytes_rewritten=False,peer='Linux kernel ARP/UDP echo socket and iputils Echo',commands=[],quiet_ms=cfg['quiet_ms'],capture_packet_limit=None)
    write(out/'namespace.json',ns);links=[];ignored=[];events=[];received=[];service=[]
    scene=dict(scenario_version='0.2',id='linux-live-finite-ipv4-endpoint',initial={},steps=[])
    try:
        fd=os.open('/dev/net/tun',os.O_RDWR);device=cfg['interface'];fcntl.ioctl(fd,0x400454ca,struct.pack('16sH22x',device.encode(),0x1002))
        mac=':'.join(cfg['peer']['mac'][i:i+2]for i in range(0,12,2))
        setup=[['ip','link','set','lo','up'],['ip','link','set',device,'address',mac],['ip','addr','add',cfg['peer']['ip']+'/24','dev',device],['ip','link','set',device,'mtu',str(cfg['mtu']),'up'],['ethtool','-K',device,'tx','off','tso','off','gso','off','gro','off'],['ethtool','-k',device],['ip','addr','show'],['ip','route','show'],['ip','-j','neigh','show','dev',device],['tcpdump','--version'],['ping','-V'],['sysctl','net.ipv4.ip_default_ttl','net.ipv4.ip_no_pmtu_disc','net.ipv4.conf.'+device+'.arp_ignore','net.ipv4.conf.'+device+'.arp_notify']]
        for i,args in enumerate(setup):ns['commands'].append(command(args,out,'setup-'+str(i)+'.log'))
        peer=socket.socket(socket.AF_INET,socket.SOCK_DGRAM);peer.bind((cfg['peer']['ip'],cfg['peer']['port']));ns['peer_bound_monotonic_ns']=time.monotonic_ns()
        capcmd=['tcpdump','--immediate-mode','-Z','root','-U','-n','-s','65535','-i',device,'-w',str(out/'capture.pcap'),'arp or udp or icmp'];ns['capture_command']=capcmd
        with(out/'capture.log').open('w')as log:
            capture=subprocess.Popen(capcmd,stdout=log,stderr=log);limit=time.monotonic()+5
            while 'listening on'not in(out/'capture.log').read_text()and time.monotonic()<limit:
                require(capture.poll()is None,'Capture failed to start');time.sleep(0.02)
            require('listening on'in(out/'capture.log').read_text(),'Capture readiness timeout');ns['capture_ready_monotonic_ns']=time.monotonic_ns()
            model=load(ROOT/cfg['model']);actor=Session(out.parent/'build/protocol-native',out/'native');origin=time.monotonic_ns();ns['clock_origin_monotonic_ns']=origin
            def now():return (time.monotonic_ns()-origin)//1000000
            def deliver(rows):
                if rows[-1]['status']=='error':
                    reason=rows[-1]['failure'];category='model_gap'if reason=='uncovered_event'else'rule_conflict'if reason=='rule_conflict'else'invariant_failure'if reason.startswith('invariant:')else'backend_or_input_failure'
                    raise RuntimeError(category+': '+reason)
                require(rows[-1]['status']=='ok','Native operation did not commit')
                for row in rows:
                    for item in row.get('emitted',[]):
                        if item['message']=='ethernet.tx':
                            require(set(item['fields'])=={'frame'},'Unexpected wire shape');raw=bytes(item['fields']['frame']);path='link-'+str(len(links))+'.raw';(out/path).write_bytes(raw)
                            links.append(dict(direction='subject_tx',file=path,monotonic_ns=time.monotonic_ns()));require(os.write(fd,raw)==len(raw),'Incomplete TAP injection')
                        else:service.append(item)
            def operation(step):
                sample=time.monotonic_ns();step['at_ms']=(sample-origin)//1000000;line=commands(model,dict(initial={},steps=[step])).splitlines()[1]
                rows=actor.operation(line);scene['steps'].append(step);events.append(dict(step=len(scene['steps'])-1,pid=actor.process.pid,sampled_monotonic_ns=sample,reply_monotonic_ns=time.monotonic_ns()));deliver(rows)
            def receive_link():
                raw=os.read(fd,65535);stamp=time.monotonic_ns();require(len(raw)>=14,'Short TAP header')
                if raw[12:14]not in (b'\x08\x06',b'\x08\0'):
                    path='unselected-'+str(len(ignored))+'.raw';(out/path).write_bytes(raw);ignored.append(dict(file=path,ethertype=raw[12:14].hex()));return
                path='link-'+str(len(links))+'.raw';(out/path).write_bytes(raw);links.append(dict(direction='peer_tx',file=path,monotonic_ns=stamp));operation(dict(event='net.frame',fields=dict(frame=list(raw))))
            for item in cfg['payloads']:
                before_service=len(service);before_links=len(links);operation(dict(event='app.send',fields=dict(data=list(bytes.fromhex(item['hex'])))))
                limit=time.monotonic()+4;accepted=False;echo_sent=False
                while time.monotonic()<limit:
                    due=min(actor.snapshot['timers'].values(),default=now()+1000);wait=max(0,min(0.1,(due-now())/1000));ready=select.select([fd,peer],[],[],wait)[0]
                    if fd in ready:receive_link()
                    if peer in ready:
                        require(not echo_sent,'Unexpected duplicate UDP peer delivery');payload,address=peer.recvfrom(65535);stamp=time.monotonic_ns()
                        received.append(dict(id=item['id'],hex=payload.hex(),source_ip=address[0],source_port=address[1],monotonic_ns=stamp));require(payload.hex()==item['hex'],'Peer payload mismatch')
                        sent=peer.sendto(payload,address);require(sent==len(payload),'Incomplete peer echo');received[-1].update(echo_bytes=sent,echo_monotonic_ns=time.monotonic_ns());echo_sent=True
                    if not ready and due<=now():operation(dict(tick=True))
                    if echo_sent and any(e['message']=='udp.rx'for e in service[before_service:]):accepted=True;break
                require(accepted,'Independent UDP echo/subject delivery timeout')
                if item is not cfg['payloads'][0]:require(len(links)==before_links+2,'Cached send emitted unexpected ARP/frame')
            for item in cfg['echoes']:
                stdout=(out/(item['id']+'.stdout')).open('w');stderr=(out/(item['id']+'.stderr')).open('w');handles.extend([stdout,stderr]);cmd=ping_command(item)
                ping=subprocess.Popen(cmd,stdin=subprocess.DEVNULL,stdout=stdout,stderr=stderr,env=dict(os.environ,LC_ALL='C'));pings.append(ping);trials.append(dict(case=item['id'],command=cmd,pid=ping.pid,started_monotonic_ns=time.monotonic_ns()))
                before=len(links);deadline=time.monotonic()+4
                while len(links)<before+2:
                    require(all(p.poll()is None for p in pings),'Ping closed before capture');remaining=deadline-time.monotonic();require(remaining>0 and select.select([fd],[],[],remaining)[0],'ICMP request timeout');receive_link()
            ns['last_selected_monotonic_ns']=time.monotonic_ns();quiet_end=ns['last_selected_monotonic_ns']+cfg['quiet_ms']*1000000
            while time.monotonic_ns()<quiet_end:
                require(actor.process.poll()is None and all(p.poll()is None for p in pings),'Subject/peer ended during quiet')
                ready=select.select([fd,peer],[],[],max(0,min(0.01,(quiet_end-time.monotonic_ns())/1000000000)))[0]
                if fd in ready:receive_link()
                if peer in ready:raise ValueError('Unexpected duplicate UDP delivery during quiet window')
            ns['capture_stop_request_monotonic_ns']=time.monotonic_ns();require(capture.poll()is None and actor.process.poll()is None and all(p.poll()is None for p in pings),'Capture/subject/peer ended early');capture.send_signal(2);ns['capture_returncode']=capture.wait(timeout=5);ns['capture_exit_monotonic_ns']=time.monotonic_ns()
        for ping,trial in zip(pings,trials,strict=True):
            trial['stop_request_monotonic_ns']=time.monotonic_ns();ping.send_signal(2);trial['returncode']=ping.wait(timeout=5);trial['exit_monotonic_ns']=time.monotonic_ns()
        # Expected state is constructed after live exchange from independent
        # peer/configuration facts, never used as subject input or output.
        last=next(step['at_ms']for step in reversed(scene['steps'])if step.get('event')=='net.frame'and bytes(step['fields']['frame'])[12:14]==b'\x08\x06')
        scene['expect']=dict(state='RESOLVED',variables=dict(peer_mac=list(bytes.fromhex(cfg['peer']['mac'])),pending_packet=[],rxudp_payload=list(bytes.fromhex(cfg['payloads'][-1]['hex'])),rxudp_disposition='deliver',echo_disposition='reply'),timers=dict(cache=last+cfg['expected_cache_ttl_ms']))
        ns['native_returncode']=actor.close();ns['native_pid']=actor.process.pid;ns['native_closed_monotonic_ns']=time.monotonic_ns();actor=None
    finally:
        if capture is not None and capture.poll()is None:capture.send_signal(2);capture.wait(timeout=5)
        for ping in pings:
            if ping.poll()is None:ping.terminate();ping.wait(timeout=5)
        if actor is not None:actor.close()
        for h in handles:h.close()
        if peer is not None:peer.close();ns['peer_closed_monotonic_ns']=time.monotonic_ns()
        if fd is not None:os.close(fd)
        ns['resources_closed_monotonic_ns']=time.monotonic_ns();write(out/'namespace.json',ns)
        for name,data in [('scenario',scene),('links',links),('services',service),('unselected',ignored),('events',events),('received',received),('trials',trials)]:write(out/(name+'.json'),data)


def symbolic_trace_check(symbolic,model,scene):
    from protocol_lab.flow import run_scenario
    trace=run_scenario(model,scene).trace;w=symbolic['witness'];require(len(w['steps'])==len(trace)and w['initial']==trace[0]['before']['variables'],'Fixed-input witness initial/count changed')
    for step,row in zip(w['steps'],trace,strict=True):
        require(step['fields']==row['event']['fields']and step['event']==row['event']['name']and step['at_ms']==row['time_ms']and step['transition']==row['transition']and step['after']==row['after']and step['emitted']==row['emitted'],'Actual ingress fixed-input witness differs')


def assess_case(out,save=True):
    cfg=config();ns=json.loads((out/'namespace.json').read_text());scene=json.loads((out/'scenario.json').read_text());model=load(ROOT/cfg['model']);isolation(ns['parent_netns'],ns['execution_netns'])
    require(ns['actual_parent_netns']==ns['parent_netns']and not ns['host_network_mutations']and not ns['packet_bytes_rewritten'],'Namespace/scope changed')
    require('--immediate-mode'in ns['capture_command']and '-c'not in ns['capture_command']and ns['capture_packet_limit']is None and ns['capture_command'][-1]=='arp or udp or icmp','Capture limited/buffered/filtered differently')
    require(ns['peer_bound_monotonic_ns']<=ns['capture_ready_monotonic_ns']<=ns['clock_origin_monotonic_ns']<=ns['last_selected_monotonic_ns']<=ns['capture_stop_request_monotonic_ns']<=ns['capture_exit_monotonic_ns']<=ns['native_closed_monotonic_ns']<=ns['peer_closed_monotonic_ns']<=ns['resources_closed_monotonic_ns'],'Lifecycle changed')
    require(ns['quiet_ms']==cfg['quiet_ms']and ns['capture_stop_request_monotonic_ns']-ns['last_selected_monotonic_ns']>=cfg['quiet_ms']*1000000,'Quiet capture shortened');require(ns['native_returncode']==ns['capture_returncode']==0,'Native/capture failed')
    stats={name:re.findall(r'(\d+) packets '+name,(out/'capture.log').read_text())for name in ('captured','received by filter','dropped by kernel')};require(all(stats.values())and int(stats['dropped by kernel'][-1])==0,'Missing stats/capture drops')
    selected=[step for step in scene['steps']if not step.get('tick')];expected_order=['app.send','net.frame','net.frame']+['app.send','net.frame']*3+['net.frame']*3
    require(scene['initial']=={}and [s['event']for s in selected]==expected_order,'Actual event order changed')
    sends=[s for s in selected if s['event']=='app.send'];require([bytes(s['fields']['data']).hex()for s in sends]==[p['hex']for p in cfg['payloads']],'Declared payload order changed')
    frames=[s for s in selected if s['event']=='net.frame'];expected_state=dict(state='RESOLVED',variables=dict(peer_mac=list(bytes.fromhex(cfg['peer']['mac'])),pending_packet=[],rxudp_payload=list(bytes.fromhex(cfg['payloads'][-1]['hex'])),rxudp_disposition='deliver',echo_disposition='reply'),timers=dict(cache=frames[0]['at_ms']+cfg['expected_cache_ttl_ms']))
    require(scene['expect']==expected_state,'Expected state/cache/queue changed')
    rows,session=stream_check(out/'native',model,scene);require(session['pid']==ns['native_pid'],'Native PID changed');events=json.loads((out/'events.json').read_text());require(len(events)==len(scene['steps'])==len(session['operations'])-1,'Clock ledger size changed')
    require(ns['capture_ready_monotonic_ns']<=session['started_monotonic_ns']<=session['operations'][0]['reply_monotonic_ns']<=ns['clock_origin_monotonic_ns'],'Startup/clock changed')
    for i,(step,event,operation)in enumerate(zip(scene['steps'],events,session['operations'][1:],strict=True)):
        require(event['step']==i and event['pid']==session['pid']and ns['clock_origin_monotonic_ns']<=event['sampled_monotonic_ns']<=operation['sent_monotonic_ns']<=operation['reply_monotonic_ns']<=event['reply_monotonic_ns'],'Clock/dispatch changed');require(step['at_ms']==(event['sampled_monotonic_ns']-ns['clock_origin_monotonic_ns'])//1000000,'Logical clock detached from monotonic sample')
    diff=compare(model,scene,rows);require(diff['status']=='match','Reference/native difference');links=json.loads((out/'links.json').read_text());captured=records(out/'capture.pcap');require(len(links)==len(captured)==16,'Unexpected selected packet count')
    require(int(stats['captured'][-1])==int(stats['received by filter'][-1])==len(captured),'Capture/filter/PCAP count differs');require([r['hex']for r in captured]==[(out/r['file']).read_bytes().hex()for r in links],'Capture/TAP bytes differ')
    require([r['direction']for r in links]==['subject_tx','peer_tx']*5+['peer_tx','subject_tx']*3,'ARP/UDP/Echo transaction order changed')
    wire=[bytes(e['fields']['frame']).hex()for row in rows for e in row.get('emitted',[])if e['message']=='ethernet.tx'];require(wire==[(out/r['file']).read_bytes().hex()for r in links if r['direction']=='subject_tx'],'Injected bytes differ from native')
    require([bytes(s['fields']['frame']).hex()for s in frames]==[(out/r['file']).read_bytes().hex()for r in links if r['direction']=='peer_tx'],'Native ingress rewritten')
    for i,opcode in enumerate((1,2)):
        d=captured[i]['decoded'];require(d['kind']=='arp','Expected kernel ARP transaction');d=d['fields'];source=cfg['subject']if i==0 else cfg['peer'];target=cfg['peer']if i==0 else cfg['subject']
        require(d['opcode']==opcode and d['sender_ip']==source['ip']and d['sender_mac']==d['source']==source['mac']and d['target_ip']==target['ip']and d['destination']==('ffffffffffff'if i==0 else target['mac']),'ARP identity fields differ')
        if i:require(d['target_mac']==target['mac'],'ARP reply target differs')
    received=json.loads((out/'received.json').read_text());require(len(received)==4,'UDP receive count differs')
    for i,(item,got)in enumerate(zip(cfg['payloads'],received,strict=True)):
        for reply,frame in enumerate(captured[2+2*i:4+2*i]):
            d=frame['decoded'];require(d['kind']=='udp','Expected IPv4 UDP frame');source=cfg['peer']if reply else cfg['subject'];target=cfg['subject']if reply else cfg['peer'];ip=d['fields']
            require(d['source']==source['mac']and d['destination']==target['mac'],'UDP Ethernet identity differs')
            require((ip['src'],ip['dst'],ip['source_port'],ip['destination_port'],ip['ttl'],ip['df'],ip['tos'],ip['payload_hex'])==(source['ip'],target['ip'],source['port'],target['port'],64,True,0,item['hex'])and ip['udp_checksum']!=0,'UDP/IP fixed-profile fields differ')
            if not reply:require(ip['identification']==0 and not any(bytes.fromhex(d['padding_hex'])),'Subject UDP ID/padding differs')
        require((got['id'],got['hex'],got['source_ip'],got['source_port'],got['echo_bytes'])==(item['id'],item['hex'],cfg['subject']['ip'],cfg['subject']['port'],len(bytes.fromhex(item['hex'])))and ns['clock_origin_monotonic_ns']<=got['monotonic_ns']<=got['echo_monotonic_ns']<=ns['last_selected_monotonic_ns'],'Linux UDP receive/echo differs')
    trials=json.loads((out/'trials.json').read_text());require(len(trials)==len(cfg['echoes'])==3,'Echo trial count differs')
    for i,(item,trial)in enumerate(zip(cfg['echoes'],trials,strict=True)):
        require(trial['case']==item['id']and trial['command']==ping_command(item)and trial['returncode']==0,'Ping command/exit differs')
        require(ns['clock_origin_monotonic_ns']<=trial['started_monotonic_ns']<=events[-3+i]['sampled_monotonic_ns']and ns['capture_exit_monotonic_ns']<=trial['stop_request_monotonic_ns']<=trial['exit_monotonic_ns']<=ns['native_closed_monotonic_ns'],'Ping lifetime differs')
        require(re.search(r'1 packets transmitted, 1 received, 0% packet loss',(out/(item['id']+'.stdout')).read_text())is not None,'Independent ping did not confirm one reply')
        request=bytes.fromhex(captured[10+2*i]['hex']);reply=bytes.fromhex(captured[11+2*i]['hex']);request_ip=request[14:14+struct.unpack('!H',request[16:18])[0]];reply_ip=reply[14:14+struct.unpack('!H',reply[16:18])[0]]
        require(request[:12]==bytes.fromhex(cfg['subject']['mac']+cfg['peer']['mac'])and reply[:12]==bytes.fromhex(cfg['peer']['mac']+cfg['subject']['mac']),'Echo Ethernet identity differs');assert_echo(request_ip,reply_ip)
        expected=bytes.fromhex(cfg['peer']['mac']+cfg['subject']['mac']+'0800')+expected_reply(request_ip);expected+=b'\0'*max(0,60-len(expected));require(reply==expected,'Exact independent Ethernet Echo oracle differs')
        require(len(request_ip)==28+item['data_bytes'],'Declared Echo length differs')
        if item['data_bytes']<=5:require(request_ip[28:]==bytes.fromhex(cfg['pattern'])[:item['data_bytes']],'Small literal Echo payload differs')
    service=[e for row in rows for e in row.get('emitted',[])if e['message']!='ethernet.tx'];expected_service=[dict(message='neighbor.resolved',fields=dict(ip=list(socket.inet_aton(cfg['peer']['ip'])),mac=list(bytes.fromhex(cfg['peer']['mac']))))]+[dict(message='udp.rx',fields=dict(data=list(bytes.fromhex(p['hex']))))for p in cfg['payloads']]
    require(service==json.loads((out/'services.json').read_text())==expected_service,'ARP/UDP service differs')
    if save:write(out/'decoded.json',captured);write(out/'difference.json',diff)
    else:require(json.loads((out/'decoded.json').read_text())==captured and json.loads((out/'difference.json').read_text())==diff,'Saved decoding/Difference changed')
    return dict(status='pass',packets=16,udp_roundtrips=4,icmp_roundtrips=3,process_starts=1,arp_queue_flush=True,tcp_implemented=False)


def run(out):
    out.mkdir(parents=True,exist_ok=False);before=inputs();tools={n:shutil.which(n)for n in TOOLS}
    pre=dict(platform=platform.system(),kernel=platform.release(),euid=os.geteuid(),tun=Path('/dev/net/tun').exists(),tools=tools);write(out/'preflight.json',pre);write(out/'report.json',dict(status='not_run',linux_peer_evidence=False))
    require(pre['platform']=='Linux'and pre['euid']==0 and pre['tun']and all(tools.values()),'Linux root/TAP/tools unavailable; this channel alone blocked')
    generate(ROOT/config()['model'],out/'generated');require(build(out/'generated',out/'build')['status']=='pass','Native build failed');case=out/'network';case.mkdir()
    command(['unshare','--net','--',sys.executable,str(PORT/'run.py'),'--inside',os.readlink('/proc/self/ns/net'),'--out',str(case)],case,'namespace-driver.log',timeout=60);cases=assess_case(case)
    from protocol_lab.flow import run_scenario
    from protocol_lab.symbolic import crosscheck_trace
    model=load(ROOT/config()['model']);scene=json.loads((case/'scenario.json').read_text());symbolic=crosscheck_trace(model,run_scenario(model,scene).trace,case/'symbolic');require(symbolic['status']=='match'and symbolic['query']=='sat','Actual-input Z3 unresolved/different');symbolic_trace_check(symbolic,model,scene)
    require(inputs()==before,'Inputs changed during execution')
    result=dict(schema='linux-live-ipv4-endpoint-peer-v1',status='pass',linux_peer_evidence=True,kernel=pre['kernel'],cases=cases,execution_source_root=str(ROOT),execution_output_dir=str(out),source_commit=subprocess.check_output(['git','-c','safe.directory='+str(ROOT),'rev-parse','HEAD'],cwd=ROOT,text=True).strip(),tool_hashes={str(Path(n).resolve()):sha(Path(n).resolve())for n in [sys.executable,*tools.values()]},input_hashes=before,api_calls=0,physical_ethernet=False,whole_ipv4_endpoint_complete=False,generated_subject_uses_host_stack=False,packet_bytes_rewritten=False,integrity_is_not_authenticity=True)
    result['file_hashes']={str(p.relative_to(out)):sha(p)for p in out.rglob('*')if p.is_file()and p.name!='report.json'};write(out/'report.json',result);return result


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',type=Path,required=True);p.add_argument('--inside');a=p.parse_args();out=a.out.resolve()
    try:
        if a.inside:inside(out,a.inside)
        else:print(json.dumps(run(out)))
    except Exception as error:
        out.mkdir(parents=True,exist_ok=True);write(out/('namespace-failure.json'if a.inside else'failure.json'),dict(status='failed_or_blocked',type=type(error).__name__,reason=str(error),linux_ipv4_endpoint_acceptance=False));raise
