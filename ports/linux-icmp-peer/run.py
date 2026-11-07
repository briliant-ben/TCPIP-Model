"""Byte-only live IR C <-> isolated TUN <-> independent iputils/Linux ICMP."""
import argparse
import fcntl
import json
import os
from pathlib import Path
import platform
import re
import select
import shutil
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
from oracle import expected_reply,assert_echo

TOOLS=('ip','unshare','tcpdump','sysctl','cc','ethtool','ping')

def config():return json.loads((PORT/'cases.json').read_text())
def isolation(parent,current):require(parent.startswith('net:[')and current.startswith('net:[')and parent!=current,'Distinct network namespace required')
def inputs():
    paths={ROOT/'ports/native_session.py',ROOT/'examples/icmp_observe.py',ROOT/'requirements-formal.txt',ROOT/'.github/workflows/linux-icmp-peer.yml',ROOT/'flows/icmp-echo.json'}
    paths|={p for p in PORT.rglob('*')if p.is_file()and '__pycache__'not in p.parts}
    paths|={p for p in(ROOT/'protocol_lab').rglob('*')if p.suffix in ('.py','.c')};paths|=set(model_files(ROOT/config()['model']))
    for s in json.loads((ROOT/'flows/icmp-echo.json').read_text())['sources']:
        p=ROOT/s['path'];require(sha(p)==s['sha256'],'Pinned source changed');paths.add(p)
    require(all(p.resolve().is_relative_to(ROOT)for p in paths),'Source escapes checkout')
    return {str(p.relative_to(ROOT)):sha(p)for p in sorted(paths)}

def command(args,out,name,timeout=10):
    p=subprocess.run(args,capture_output=True,text=True,timeout=timeout);(out/name).write_text(p.stdout+p.stderr)
    require(p.returncode==0,'Command failed: '+str(args));return dict(command=args,returncode=p.returncode,log=name)

def ping_command(case):
    c=config()
    return ['ping','-4','-n','-I',c['peer_ip'],'-M','do','-i',str(c['peer_interval_seconds']),'-W','3','-s',str(case['data_bytes']),'-p',c['pattern'],c['subject_ip']]

def stream_check(folder,model,scene):
    session=json.loads((folder/'session.json').read_text());lines=(folder/'native-input.txt').read_text().splitlines();rows=[json.loads(r)for r in(folder/'native.stdout').read_text().splitlines()]
    require(session['process_starts']==1 and session['returncode']==0 and session['transport']=='stdin-pipe-stdout-raw-pty','Native continuity/returncode changed')
    require(commands(model,scene)=='\n'.join(lines)+'\n'and lines[0]=='B'and lines.count('B')==1,'Native ingress/reset/replay changed')
    require([o['line']for o in session['operations']]==lines,'Native operation transcript changed');end=0
    for i,o in enumerate(session['operations']):
        require(o['pid']==session['pid']and o['row_start']==end and o['sent_monotonic_ns']<=o['reply_monotonic_ns'],'Native PID/timeline changed')
        end=o['row_end'];require(end>o['row_start']and rows[end-1]['status']==('ready'if i==0 else'ok'),'Native operation failed')
    require(end==len(rows),'Unaccounted native output');return rows,session

def symbolic_trace_check(symbolic,model,scene):
    # Reference reconstruction only; never invoke solver/archived executable here.
    from protocol_lab.flow import run_scenario
    trace=run_scenario(model,scene).trace;w=symbolic['witness']
    require(len(w['steps'])==len(trace)and w['initial']==trace[0]['before']['variables'],'Peer symbolic initial/step count changed')
    for step,row in zip(w['steps'],trace,strict=True):
        require(step['fields']==row['event']['fields']and step['event']==row['event']['name']and step['at_ms']==row['time_ms']and step['transition']==row['transition']and step['after']==row['after']and step['emitted']==row['emitted'],'Peer symbolic witness differs from actual ingress/reference trace')

def inside(out,parent):
    require(platform.system()=='Linux'and os.geteuid()==0,'Linux namespace root required')
    actual=os.readlink('/proc/'+str(os.getppid())+'/ns/net');isolation(parent,os.readlink('/proc/self/ns/net'));require(actual==parent,'Parent namespace changed')
    c=config();fd=None;capture=None;actor=None;peers=[];handles=[]
    ns=dict(platform='Linux',kernel=platform.release(),parent_netns=parent,actual_parent_netns=actual,execution_netns=os.readlink('/proc/self/ns/net'),host_network_mutations=False,packet_bytes_rewritten=False,peer='iputils ping with Linux IPv4',commands=[],quiet_ms=c['quiet_ms'],capture_packet_limit=None,wire_timing_contract=c['wire_timing_contract'])
    write(out/'namespace.json',ns)
    links=[];ignored=[];events=[];trials=[];scene=dict(scenario_version='0.2',id='linux-live-icmp',initial={},steps=[])
    try:
        fd=os.open('/dev/net/tun',os.O_RDWR);dev=c['interface'];fcntl.ioctl(fd,0x400454ca,struct.pack('16sH22x',dev.encode(),0x1001))
        setup=[['ip','link','set','lo','up'],['ip','addr','add',c['peer_ip']+'/32','dev',dev],['ip','link','set',dev,'mtu',str(c['mtu']),'up'],['ip','route','add',c['subject_ip']+'/32','dev',dev,'src',c['peer_ip']],['ethtool','-K',dev,'tx','off','tso','off','gso','off','gro','off'],['ethtool','-k',dev],['ip','addr','show'],['ip','route','show'],['tcpdump','--version'],['ping','-V'],['sysctl','net.ipv4.ip_default_ttl','net.ipv4.ip_no_pmtu_disc']]
        for i,args in enumerate(setup):ns['commands'].append(command(args,out,'setup-'+str(i)+'.log'))
        cmd=['tcpdump','--immediate-mode','-Z','root','-U','-n','-s','65535','-i',dev,'-y','RAW','-w',str(out/'capture.pcap'),'icmp'];ns['capture_command']=cmd
        with(out/'capture.log').open('w')as log:
            capture=subprocess.Popen(cmd,stdout=log,stderr=log);deadline=time.monotonic()+5
            while 'listening on'not in(out/'capture.log').read_text()and time.monotonic()<deadline:
                require(capture.poll()is None,'Capture failed startup');time.sleep(0.02)
            require('listening on'in(out/'capture.log').read_text(),'Capture readiness timeout');ns['capture_ready_monotonic_ns']=time.monotonic_ns()
            actor=Session(out.parent/'build/protocol-native',out/'native');origin=time.monotonic_ns();ns['clock_origin_monotonic_ns']=origin
            def pump(raw):
                stamp=time.monotonic_ns();require(len(raw)>=1,'Empty TUN record')
                if raw[0]>>4==6 or (raw[0]>>4==4 and len(raw)>=20 and raw[9]!=1):
                    name='unselected-'+str(len(ignored))+'.raw';(out/name).write_bytes(raw);ignored.append(dict(file=name,reason='outside_selected_ipv4_icmp'));return False
                name='link-'+str(len(links))+'.raw';(out/name).write_bytes(raw);links.append(dict(direction='peer_tx',file=name,monotonic_ns=stamp))
                sample=time.monotonic_ns();step=dict(at_ms=(sample-origin)//1000000,event='net.packet',fields=dict(packet=list(raw)));line=commands(load(ROOT/c['model']),dict(initial={},steps=[step])).splitlines()[1]
                rows=actor.operation(line);scene['steps'].append(step);events.append(dict(step=len(scene['steps'])-1,pid=actor.process.pid,sampled_monotonic_ns=sample,reply_monotonic_ns=time.monotonic_ns()))
                if rows[-1]['status']=='error':
                    reason=rows[-1]['failure'];kind='model_gap'if reason=='uncovered_event'else'rule_conflict'if reason=='rule_conflict'else'invariant_failure'if reason.startswith('invariant:')else'backend_or_input_failure'
                    raise RuntimeError(kind+': '+reason)
                emitted=[e for row in rows for e in row.get('emitted',[])]
                for e in emitted:
                    require(e['message']=='ipv4.tx'and set(e['fields'])=={'packet'},'Unexpected native wire/service output')
                    reply=bytes(e['fields']['packet']);name='link-'+str(len(links))+'.raw';(out/name).write_bytes(reply);links.append(dict(direction='subject_tx',file=name,monotonic_ns=time.monotonic_ns()));require(os.write(fd,reply)==len(reply),'Incomplete TUN injection')
                require(len(emitted)==1,'Expected one C reply to selected Echo probe');ns['last_selected_monotonic_ns']=time.monotonic_ns();return True
            for case in c['cases']:
                stdout=(out/(case['id']+'.stdout')).open('w');stderr=(out/(case['id']+'.stderr')).open('w');handles.extend([stdout,stderr]);cmd=ping_command(case)
                peer=subprocess.Popen(cmd,stdin=subprocess.DEVNULL,stdout=stdout,stderr=stderr,env=dict(os.environ,LC_ALL='C'));peers.append(peer)
                trials.append(dict(case=case['id'],command=cmd,pid=peer.pid,started_monotonic_ns=time.monotonic_ns()))
                deadline=time.monotonic()+3
                while True:
                    require(all(p.poll()is None for p in peers),'Peer exited before capture stop')
                    remaining=deadline-time.monotonic();require(remaining>0 and select.select([fd],[],[],remaining)[0],'Peer raw request timeout')
                    if pump(os.read(fd,65535)):break
            quiet_end=time.monotonic_ns()+c['quiet_ms']*1000000
            while time.monotonic_ns()<quiet_end:
                require(actor.process.poll()is None and all(p.poll()is None for p in peers),'Native/peer closed before quiet boundary')
                if select.select([fd],[],[],max(0,min(0.01,(quiet_end-time.monotonic_ns())/1000000000)))[0]:pump(os.read(fd,65535))
            ns['capture_stop_request_monotonic_ns']=time.monotonic_ns();require(capture.poll()is None and actor.process.poll()is None and all(p.poll()is None for p in peers),'Capture/native/peer ended early')
            capture.send_signal(2);ns['capture_returncode']=capture.wait(timeout=5);ns['capture_exit_monotonic_ns']=time.monotonic_ns()
        for peer,trial in zip(peers,trials,strict=True):
            trial['stop_request_monotonic_ns']=time.monotonic_ns();peer.send_signal(2);trial['returncode']=peer.wait(timeout=5);trial['exit_monotonic_ns']=time.monotonic_ns()
        ns['native_close_request_monotonic_ns']=time.monotonic_ns();ns['native_returncode']=actor.close();ns['native_pid']=actor.process.pid;actor=None
        # Only now construct independent expected traces. Never feed oracle bytes to live C/TUN.
        for step in scene['steps']:
            reply=expected_reply(bytes(step['fields']['packet']));step['expect_trace']=[dict(at_ms=step['at_ms'],emitted=[dict(message='ipv4.tx',fields=dict(packet=list(reply)))])]
        scene['expect']=dict(state='READY',variables=dict(disposition='reply',reply=list(expected_reply(bytes(scene['steps'][-1]['fields']['packet'])))),timers={})
        write(out/'scenario.json',scene)
    finally:
        if capture is not None and capture.poll()is None:capture.send_signal(2);capture.wait(timeout=5)
        for peer in peers:
            if peer.poll()is None:peer.terminate();peer.wait(timeout=5)
        if actor is not None:actor.close()
        for h in handles:h.close()
        if fd is not None:os.close(fd)
        ns['resources_closed_monotonic_ns']=time.monotonic_ns();write(out/'namespace.json',ns);write(out/'trials.json',trials);write(out/'links.json',links);write(out/'unselected.json',ignored);write(out/'events.json',events)

def assess_case(out,save=True):
    c=config();ns=json.loads((out/'namespace.json').read_text());scene=json.loads((out/'scenario.json').read_text());model=load(ROOT/c['model']);trials=json.loads((out/'trials.json').read_text())
    isolation(ns['parent_netns'],ns['execution_netns']);require(ns['actual_parent_netns']==ns['parent_netns']and not ns['host_network_mutations']and not ns['packet_bytes_rewritten'],'Namespace/scope changed')
    require('--immediate-mode'in ns['capture_command']and '-c'not in ns['capture_command']and ns['capture_packet_limit']is None,'Capture limited/buffered')
    require(ns['capture_ready_monotonic_ns']<=ns['clock_origin_monotonic_ns']<=ns['last_selected_monotonic_ns']<=ns['capture_stop_request_monotonic_ns']<=ns['capture_exit_monotonic_ns']<=ns['resources_closed_monotonic_ns'],'Capture lifecycle order differs')
    require(ns['quiet_ms']==c['quiet_ms']and ns['capture_stop_request_monotonic_ns']-ns['last_selected_monotonic_ns']>=c['quiet_ms']*1000000,'Quiet capture shortened')
    require(ns['capture_exit_monotonic_ns']<=ns['native_close_request_monotonic_ns']<=ns['resources_closed_monotonic_ns'],'C closed before capture')
    require(ns['capture_returncode']==ns['native_returncode']==0,'Capture/native failed')
    text=(out/'capture.log').read_text();drops=re.findall(r'(\d+) packets dropped by kernel',text);require(drops and int(drops[-1])==0,'Capture drops')
    require(scene['initial']=={}and len(scene['steps'])==len(trials)==len(c['cases'])==3 and all(s.get('event')=='net.packet'for s in scene['steps']),'Ingress case/reset shape changed')
    rows,session=stream_check(out/'native',model,scene);require(session['pid']==ns['native_pid']and ns['capture_ready_monotonic_ns']<=session['started_monotonic_ns']<=session['operations'][0]['reply_monotonic_ns']<=ns['clock_origin_monotonic_ns'],'Native startup changed')
    events=json.loads((out/'events.json').read_text());require(len(events)==3 and len(session['operations'])==4,'Missing/extra live commands')
    for i,(step,event,o)in enumerate(zip(scene['steps'],events,session['operations'][1:],strict=True)):
        require(event['step']==i and event['pid']==session['pid']and ns['clock_origin_monotonic_ns']<=event['sampled_monotonic_ns']<=o['sent_monotonic_ns']<=o['reply_monotonic_ns']<=event['reply_monotonic_ns'],'Dispatch clock/PID differs')
        require(step['at_ms']==(event['sampled_monotonic_ns']-ns['clock_origin_monotonic_ns'])//1000000,'IR time detached from monotonic sampling')
    diff=compare(model,scene,rows);require(diff['status']=='match','Reference/native difference')
    links=json.loads((out/'links.json').read_text());captured=records(out/'capture.pcap');require(len(links)==len(captured)==6,'Unexpected selected packet count')
    require([r['hex']for r in captured]==[(out/r['file']).read_bytes().hex()for r in links],'Independent PCAP/TUN bytes differ')
    require([r['direction']for r in links]==['peer_tx','subject_tx']*3,'Transaction wire order differs')
    wire=[bytes(e['fields']['packet']).hex()for row in rows for e in row.get('emitted',[])if e['message']=='ipv4.tx']
    require(wire==[(out/r['file']).read_bytes().hex()for r in links if r['direction']=='subject_tx'],'Injected bytes differ from C')
    require([bytes(s['fields']['packet']).hex()for s in scene['steps']]==[(out/r['file']).read_bytes().hex()for r in links if r['direction']=='peer_tx'],'Native ingress rewritten')
    result=[]
    for i,(case,trial)in enumerate(zip(c['cases'],trials,strict=True)):
        require(trial['case']==case['id']and trial['command']==ping_command(case)and trial['returncode']==0,'Ping invocation/exit changed')
        require(ns['clock_origin_monotonic_ns']<=trial['started_monotonic_ns']<=events[i]['sampled_monotonic_ns']and ns['capture_exit_monotonic_ns']<=trial['stop_request_monotonic_ns']<=trial['exit_monotonic_ns']<=ns['resources_closed_monotonic_ns'],'Peer lifetime changed')
        log=(out/(case['id']+'.stdout')).read_text();require(re.search(r'1 packets transmitted, 1 received, 0% packet loss',log)is not None,'Peer did not confirm exactly one Echo reply')
        request=bytes.fromhex(captured[2*i]['hex']);reply=bytes.fromhex(captured[2*i+1]['hex']);assert_echo(request,reply)
        require(len(request)==28+case['data_bytes'],'Declared probe data length differs')
        if case['data_bytes']<=5:require(request[28:]==bytes.fromhex(c['pattern'])[:case['data_bytes']],'Small literal peer payload differs')
        result.append(dict(case=case['id'],status='pass',data_bytes=case['data_bytes'],peer_confirmed=True))
    if save:write(out/'decoded.json',captured);write(out/'difference.json',diff)
    else:require(json.loads((out/'decoded.json').read_text())==captured and json.loads((out/'difference.json').read_text())==diff,'Saved decoding/Difference changed')
    return result

def run(out):
    out.mkdir(parents=True,exist_ok=False);before=inputs();tools={n:shutil.which(n)for n in TOOLS};pre=dict(platform=platform.system(),kernel=platform.release(),euid=os.geteuid(),tun=Path('/dev/net/tun').exists(),tools=tools)
    write(out/'preflight.json',pre);write(out/'report.json',dict(status='not_run',linux_peer_evidence=False))
    require(pre['platform']=='Linux'and pre['euid']==0 and pre['tun']and all(tools.values()),'Linux root/TUN/ping/tools unavailable; only this channel blocked')
    generate(ROOT/config()['model'],out/'generated');require(build(out/'generated',out/'build')['status']=='pass','Native build failed')
    folder=out/'network';folder.mkdir();command(['unshare','--net','--',sys.executable,str(PORT/'run.py'),'--inside',os.readlink('/proc/self/ns/net'),'--out',str(folder)],folder,'namespace-driver.log',timeout=60)
    cases=assess_case(folder)
    # Only after live process/capture completion: independent exact fixed-input Z3.
    from protocol_lab.flow import run_scenario
    from protocol_lab.symbolic import crosscheck_trace
    model=load(ROOT/config()['model']);scene=json.loads((folder/'scenario.json').read_text())
    symbolic=crosscheck_trace(model,run_scenario(model,scene).trace,folder/'symbolic')
    require(symbolic['status']=='match'and symbolic['query']=='sat','Actual peer fixed-input Z3 unresolved/different')
    require(inputs()==before,'Input changed during execution')
    report=dict(schema='linux-live-icmp-peer-v1',status='pass',linux_peer_evidence=True,kernel=pre['kernel'],cases=cases,execution_source_root=str(ROOT),execution_output_dir=str(out),source_commit=subprocess.check_output(['git','-c','safe.directory='+str(ROOT),'rev-parse','HEAD'],cwd=ROOT,text=True).strip(),tool_hashes={str(Path(n).resolve()):sha(Path(n).resolve())for n in [sys.executable,*tools.values()]},input_hashes=before,api_calls=0,physical_ethernet=False,whole_ipv4_endpoint_complete=False,generated_subject_uses_host_stack=False,packet_bytes_rewritten=False,integrity_is_not_authenticity=True)
    report['file_hashes']={str(p.relative_to(out)):sha(p)for p in out.rglob('*')if p.is_file()and p.name!='report.json'};write(out/'report.json',report);return report

if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--out',type=Path,required=True);p.add_argument('--inside');a=p.parse_args();out=a.out.resolve()
    try:
        if a.inside:inside(out,a.inside)
        else:print(json.dumps(run(out)))
    except Exception as error:
        out.mkdir(parents=True,exist_ok=True);write(out/('namespace-failure.json'if a.inside else'failure.json'),dict(status='failed_or_blocked',type=type(error).__name__,reason=str(error),linux_icmp_acceptance=False));raise
