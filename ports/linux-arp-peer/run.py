"""Real isolated Linux ARP peer and live generated C; no protocol policy in adapter."""
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
from protocol_lab.ir import load,require,model_files,Uncovered,Conflict,ModelError
from capture import records


def config():return json.loads((PORT/'cases.json').read_text())
def isolation(parent,current):require(parent.startswith('net:[')and current.startswith('net:[')and parent!=current,'Distinct namespace required')
def inputs():
    paths={ROOT/'ports/native_session.py',ROOT/'examples/arp_observe.py',ROOT/'requirements-formal.txt',ROOT/'.github/workflows/linux-arp-peer.yml',ROOT/'flows/arp-endpoint.json'}
    paths|={p for p in PORT.rglob('*')if p.is_file()and '__pycache__'not in p.parts}
    paths|={p for p in(ROOT/'protocol_lab').rglob('*')if p.suffix in ('.py','.c')}
    paths|=set(model_files(ROOT/config()['model']))
    for source in json.loads((ROOT/'flows/arp-endpoint.json').read_text())['sources']:
        p=ROOT/source['path'];require(sha(p)==source['sha256'],'Pinned source changed');paths.add(p)
    require(all(p.resolve().is_relative_to(ROOT)for p in paths),'Source escapes approved root')
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


def inside(out,parent,mode):
    require(platform.system()=='Linux'and os.geteuid()==0,'Linux namespace root required')
    actual=os.readlink('/proc/'+str(os.getppid())+'/ns/net');isolation(parent,os.readlink('/proc/self/ns/net'));require(actual==parent,'Parent namespace argument changed')
    cfg=config();require(mode in cfg['modes'],'Unknown mode');fd=None;capture=None;actor=None;probe=None
    ns=dict(platform='Linux',kernel=platform.release(),mode=mode,parent_netns=parent,actual_parent_netns=actual,execution_netns=os.readlink('/proc/self/ns/net'),host_network_mutations=False,packet_bytes_rewritten=False,peer='Linux kernel ARP',commands=[],quiet_ms=cfg['quiet_ms'],capture_packet_limit=None)
    write(out/'namespace.json',ns)
    try:
        fd=os.open('/dev/net/tun',os.O_RDWR);device=cfg['interface']
        fcntl.ioctl(fd,0x400454ca,struct.pack('16sH22x',device.encode(),0x1002)) # IFF_TAP|IFF_NO_PI, nonpersistent
        mac=':'.join(cfg['peer']['mac'][i:i+2]for i in range(0,12,2))
        setup=[['ip','link','set','lo','up'],['ip','link','set',device,'address',mac],['ip','addr','add',cfg['peer']['ip']+'/24','dev',device],['ip','link','set',device,'mtu',str(cfg['mtu']),'up'],['ip','addr','show'],['ip','route','show'],['ip','-j','neigh','show','dev',device],['tcpdump','--version'],['sysctl','net.ipv4.conf.'+device+'.arp_ignore','net.ipv4.conf.'+device+'.arp_notify']]
        for i,args in enumerate(setup):ns['commands'].append(command(args,out,'setup-'+str(i)+'.log'))
        capcmd=['tcpdump','--immediate-mode','-Z','root','-U','-n','-s','65535','-i',device,'-w',str(out/'capture.pcap'),'arp'];ns['capture_command']=capcmd
        with(out/'capture.log').open('w')as log:
            capture=subprocess.Popen(capcmd,stdout=log,stderr=log)
            limit=time.monotonic()+5
            while 'listening on'not in(out/'capture.log').read_text()and time.monotonic()<limit:
                require(capture.poll()is None,'Capture failed to start');time.sleep(0.02)
            require('listening on'in(out/'capture.log').read_text(),'Capture readiness timeout')
            ns['capture_ready_monotonic_ns']=time.monotonic_ns()
            model=load(ROOT/cfg['model']);actor=Session(out.parent/'build/protocol-native',out/'native')
            origin=time.monotonic_ns();ns['clock_origin_monotonic_ns']=origin
            scene=dict(scenario_version='0.1',id='linux-arp-'+mode,initial={},steps=[],expect=dict(state='RESOLVED',variables=dict(peer_mac=list(bytes.fromhex(cfg['peer']['mac']))),timers={}))
            links=[];ignored=[];service=[];events=[]
            def deliver(rows):
                if rows[-1]['status']=='error':
                    reason=rows[-1]['failure'];category='model_gap'if reason=='uncovered_event'else'rule_conflict'if reason=='rule_conflict'else'invariant_failure'if reason.startswith('invariant:')else'backend_or_input_failure'
                    raise RuntimeError(category+': '+reason)
                require(rows[-1]['status']=='ok','Invalid native terminal row')
                for row in rows:
                    for item in row.get('emitted',[]):
                        if item['message']=='ethernet.tx':
                            require(set(item['fields'])=={'frame'},'Unexpected wire emission shape');raw=bytes(item['fields']['frame'])
                            path='link-'+str(len(links))+'.raw';(out/path).write_bytes(raw)
                            links.append(dict(direction='subject_tx',file=path,monotonic_ns=time.monotonic_ns()))
                            require(os.write(fd,raw)==len(raw),'Incomplete TAP injection')
                        else:
                            require(item['message']in ('neighbor.resolved','neighbor.failed'),'Unknown service emission');service.append(item)
            def operation(step):
                sample=time.monotonic_ns();step['at_ms']=(sample-origin)//1000000
                line=commands(model,dict(initial={},steps=[step])).splitlines()[1]
                rows=actor.operation(line);scene['steps'].append(step);events.append(dict(step=len(scene['steps'])-1,pid=actor.process.pid,sampled_monotonic_ns=sample,reply_monotonic_ns=time.monotonic_ns()));deliver(rows)
            def now():return (time.monotonic_ns()-origin)//1000000
            if mode=='active':operation(dict(at_ms=0,event='app.resolve',fields=dict(ip=list(socket.inet_aton(cfg['peer']['ip'])))))
            else:
                probe=socket.socket(socket.AF_INET,socket.SOCK_DGRAM);probe.bind((cfg['peer']['ip'],8081))
                ns['probe_send_bytes']=probe.sendto(b'arp-probe',(cfg['subject']['ip'],9)) # Stimulus only; queued IPv4 is outside selected ARP channel.
            limit=time.monotonic()+4;resolved=False
            while time.monotonic()<limit:
                due=min(actor.snapshot['timers'].values(),default=now()+1000)
                wait=max(0,min(0.1,(due-now())/1000))
                ready=select.select([fd],[],[],wait)[0]
                if ready:
                    raw=os.read(fd,65535);stamp=time.monotonic_ns()
                    require(len(raw)>=14,'Short TAP Ethernet header')
                    if raw[12:14]!=b'\x08\x06':
                        path='unselected-'+str(len(ignored))+'.raw';(out/path).write_bytes(raw);ignored.append(dict(file=path,ethertype=raw[12:14].hex()));continue
                    path='link-'+str(len(links))+'.raw';(out/path).write_bytes(raw);links.append(dict(direction='peer_tx',file=path,monotonic_ns=stamp))
                    operation(dict(at_ms=now(),event='net.frame',fields=dict(frame=list(raw))))
                elif due<=now():operation(dict(at_ms=now(),tick=True))
                if actor.snapshot['state']=='RESOLVED':resolved=True;break
            require(resolved,'ARP resolution did not complete')
            ns['resolved_monotonic_ns']=time.monotonic_ns()
            if mode=='active':
                before=len(links);operation(dict(at_ms=now(),event='app.resolve',fields=dict(ip=list(socket.inet_aton(cfg['peer']['ip'])))))
                require(len(links)==before,'Cache hit unexpectedly transmitted')
            else:
                neighbor_limit=time.monotonic()+1;attempt=0
                while True:
                    name='neighbor-'+str(attempt)+'.json';command(['ip','-j','neigh','show',cfg['subject']['ip'],'dev',device],out,name)
                    observed=json.loads((out/name).read_text());(out/'neighbor.json').write_text((out/name).read_text());attempt+=1
                    if any(n.get('lladdr','').replace(':','')==cfg['subject']['mac']for n in observed):break
                    require(time.monotonic()<neighbor_limit,'Kernel neighbor confirmation timeout');time.sleep(0.02)
                ns['neighbor_read_attempts']=attempt
            # Observe the entire quiet interval, retaining any further selected frames (strict count gate follows).
            quiet_end=time.monotonic_ns()+cfg['quiet_ms']*1000000
            while time.monotonic_ns()<quiet_end:
                if select.select([fd],[],[],max(0,min(0.01,(quiet_end-time.monotonic_ns())/1000000000)))[0]:
                    raw=os.read(fd,65535);require(len(raw)>=14,'Short TAP frame')
                    if raw[12:14]==b'\x08\x06':
                        path='link-'+str(len(links))+'.raw';(out/path).write_bytes(raw);links.append(dict(direction='peer_tx',file=path,monotonic_ns=time.monotonic_ns()));operation(dict(at_ms=now(),event='net.frame',fields=dict(frame=list(raw))))
                    else:
                        path='unselected-'+str(len(ignored))+'.raw';(out/path).write_bytes(raw);ignored.append(dict(file=path,ethertype=raw[12:14].hex()))
            ns['capture_stop_request_monotonic_ns']=time.monotonic_ns();require(capture.poll()is None,'Capture ended early');capture.send_signal(2);ns['capture_returncode']=capture.wait(timeout=5);ns['capture_exit_monotonic_ns']=time.monotonic_ns()
        operation(dict(at_ms=now(),tick=True))
        last_frame=next(step['at_ms']for step in reversed(scene['steps'])if step.get('event')=='net.frame')
        scene['expect']['variables']['cache_ttl_ms']=cfg['expected_cache_ttl_ms']
        scene['expect']['timers']=dict(cache=last_frame+cfg['expected_cache_ttl_ms']);write(out/'scenario.json',scene);write(out/'links.json',links);write(out/'services.json',service);write(out/'unselected.json',ignored);write(out/'events.json',events)
        ns['native_returncode']=actor.close();ns['native_pid']=actor.process.pid;actor=None
    finally:
        if capture is not None and capture.poll()is None:capture.send_signal(2);capture.wait(timeout=5)
        if actor is not None:actor.close()
        if probe is not None:probe.close()
        if fd is not None:os.close(fd)
        ns['resources_closed_monotonic_ns']=time.monotonic_ns();write(out/'namespace.json',ns)


def assess_case(out,mode,save=True):
    cfg=config();ns=json.loads((out/'namespace.json').read_text());scene=json.loads((out/'scenario.json').read_text());model=load(ROOT/cfg['model'])
    isolation(ns['parent_netns'],ns['execution_netns'])
    require(ns['actual_parent_netns']==ns['parent_netns']and ns['mode']==mode and not ns['host_network_mutations']and not ns['packet_bytes_rewritten'],'Namespace/scope changed')
    require('--immediate-mode'in ns['capture_command']and '-c'not in ns['capture_command']and ns['capture_packet_limit']is None,'Capture limited or buffered')
    require(ns['capture_ready_monotonic_ns']<=ns['clock_origin_monotonic_ns']<=ns['resolved_monotonic_ns']<=ns['capture_stop_request_monotonic_ns']<=ns['capture_exit_monotonic_ns']<=ns['resources_closed_monotonic_ns'],'Lifecycle order changed')
    require(ns['quiet_ms']==cfg['quiet_ms']and ns['capture_stop_request_monotonic_ns']-ns['resolved_monotonic_ns']>=cfg['quiet_ms']*1000000,'Quiet capture shortened')
    require(ns['native_returncode']==ns['capture_returncode']==0,'Native/capture execution failed')
    drops=re.findall(r'(\d+) packets dropped by kernel',(out/'capture.log').read_text());require(drops and int(drops[-1])==0,'Capture drops')
    expected_events=['app.resolve','net.frame','app.resolve']if mode=='active'else['net.frame']
    require(scene['initial']=={}and [step['event']for step in scene['steps']if not step.get('tick')]==expected_events,'Scenario/reset identity changed')
    for step in scene['steps']:
        if step.get('event')=='app.resolve':require(step['fields']=={'ip':list(socket.inet_aton(cfg['peer']['ip']))},'Query target changed')
    frames=[step for step in scene['steps']if step.get('event')=='net.frame']
    require(len(frames)==1 and scene['expect']['timers']=={'cache':frames[0]['at_ms']+cfg['expected_cache_ttl_ms']},'Expected cache deadline changed')
    rows,session=stream_check(out/'native',model,scene);require(session['pid']==ns['native_pid'],'Process identity changed')
    events=json.loads((out/'events.json').read_text());require(len(events)==len(scene['steps'])==len(session['operations'])-1,'Clock ledger size changed')
    require(ns['capture_ready_monotonic_ns']<=session['started_monotonic_ns']<=session['operations'][0]['reply_monotonic_ns']<=ns['clock_origin_monotonic_ns'],'Native startup/clock origin changed')
    for i,(step,event,operation)in enumerate(zip(scene['steps'],events,session['operations'][1:],strict=True)):
        require(event['step']==i and event['pid']==session['pid']and ns['clock_origin_monotonic_ns']<=event['sampled_monotonic_ns']<=operation['sent_monotonic_ns']<=operation['reply_monotonic_ns']<=event['reply_monotonic_ns'],'Clock/dispatch order changed')
        require(step['at_ms']==(event['sampled_monotonic_ns']-ns['clock_origin_monotonic_ns'])//1000000,'Native logical clock detached from monotonic input')
    diff=compare(model,scene,rows);require(diff['status']=='match','Reference/native difference')
    links=json.loads((out/'links.json').read_text());captured=records(out/'capture.pcap')
    require(len(links)==len(captured)==2,'Unexpected selected ARP packet count')
    require([r['hex']for r in captured]==[(out/r['file']).read_bytes().hex()for r in links],'Independent capture/TAP bytes differ')
    wire=[bytes(e['fields']['frame']).hex()for row in rows for e in row.get('emitted',[])if e['message']=='ethernet.tx']
    require(wire==[(out/r['file']).read_bytes().hex()for r in links if r['direction']=='subject_tx'],'Injected bytes differ from native C')
    ingress=[bytes(step['fields']['frame']).hex()for step in scene['steps']if step.get('event')=='net.frame']
    require(ingress==[(out/r['file']).read_bytes().hex()for r in links if r['direction']=='peer_tx'],'Native ingress rewritten')
    expected_dirs=['subject_tx','peer_tx']if mode=='active'else['peer_tx','subject_tx'];require([r['direction']for r in links]==expected_dirs,'ARP transaction order changed')
    expected_ops=[1,2]
    for row,link,opcode in zip(captured,links,expected_ops,strict=True):
        d=row['decoded'];source=cfg['subject']if link['direction']=='subject_tx'else cfg['peer'];target=cfg['peer']if link['direction']=='subject_tx'else cfg['subject']
        require(d['opcode']==opcode and d['sender_ip']==source['ip']and d['sender_mac']==d['source']==source['mac']and d['target_ip']==target['ip'],'ARP fields differ from link identities')
        require(d['destination']==('ffffffffffff'if opcode==1 else target['mac']),'ARP destination differs')
        if opcode==2:require(d['target_mac']==target['mac'],'ARP reply target differs')
    service=[e for row in rows for e in row.get('emitted',[])if e['message']!='ethernet.tx']
    expected_service=[dict(message='neighbor.resolved',fields=dict(ip=list(socket.inet_aton(cfg['peer']['ip'])),mac=list(bytes.fromhex(cfg['peer']['mac']))))]*(2 if mode=='active'else 0)
    require(service==expected_service==json.loads((out/'services.json').read_text()),'Resolution/cache-hit service differs')
    if mode=='passive':
        neighbors=json.loads((out/'neighbor.json').read_text());require(any(n['dst']==cfg['subject']['ip']and n.get('lladdr','').replace(':','')==cfg['subject']['mac']for n in neighbors),'Kernel did not learn subject MAC')
    if save:write(out/'decoded.json',captured);write(out/'difference.json',diff)
    else:require(json.loads((out/'decoded.json').read_text())==captured and json.loads((out/'difference.json').read_text())==diff,'Saved decoding/Difference changed')
    return dict(mode=mode,status='pass',packets=2,process_starts=1,cache_hit_verified=mode=='active',kernel_neighbor_verified=mode=='passive')


def run(out):
    out.mkdir(parents=True,exist_ok=False);before=inputs();tools={n:shutil.which(n)for n in ('ip','unshare','tcpdump','sysctl','cc')}
    pre=dict(platform=platform.system(),kernel=platform.release(),euid=os.geteuid(),tun=Path('/dev/net/tun').exists(),tools=tools);write(out/'preflight.json',pre);write(out/'report.json',dict(status='not_run',linux_peer_evidence=False))
    require(pre['platform']=='Linux'and pre['euid']==0 and pre['tun']and all(tools.values()),'Linux root/TAP/tools unavailable; this channel alone blocked')
    generate(ROOT/config()['model'],out/'generated');require(build(out/'generated',out/'build')['status']=='pass','Native build failed')
    parent=os.readlink('/proc/self/ns/net');cases=[]
    for mode in config()['modes']:
        case=out/mode;case.mkdir();command(['unshare','--net','--',sys.executable,str(PORT/'run.py'),'--inside',parent,'--mode',mode,'--out',str(case)],case,'namespace-driver.log',timeout=60);cases.append(assess_case(case,mode))
    require(inputs()==before,'Inputs changed during execution')
    result=dict(schema='linux-live-arp-peer-v1',status='pass',linux_peer_evidence=True,kernel=pre['kernel'],cases=cases,execution_source_root=str(ROOT),execution_output_dir=str(out),source_commit=subprocess.check_output(['git','-c','safe.directory='+str(ROOT),'rev-parse','HEAD'],cwd=ROOT,text=True).strip(),tool_hashes={str(Path(n).resolve()):sha(Path(n).resolve())for n in [sys.executable,*tools.values()]},input_hashes=before,api_calls=0,physical_ethernet=False,whole_ipv4_endpoint_complete=False,generated_subject_uses_host_stack=False,packet_bytes_rewritten=False,integrity_is_not_authenticity=True)
    result['file_hashes']={str(p.relative_to(out)):sha(p)for p in out.rglob('*')if p.is_file()and p.name!='report.json'};write(out/'report.json',result);return result


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',type=Path,required=True);p.add_argument('--inside');p.add_argument('--mode',choices=('active','passive'));a=p.parse_args();out=a.out.resolve()
    try:
        if a.inside:inside(out,a.inside,a.mode)
        else:print(json.dumps(run(out)))
    except Exception as error:
        out.mkdir(parents=True,exist_ok=True);write(out/('namespace-failure.json'if a.inside else'failure.json'),dict(status='failed_or_blocked',type=type(error).__name__,reason=str(error),linux_arp_acceptance=False));raise
