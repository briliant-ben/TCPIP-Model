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
import struct
import subprocess
import sys
import time
ROOT=Path(__file__).resolve().parents[2]
PORT=Path(__file__).resolve().parent
sys.path.insert(0,str(ROOT))
sys.path.insert(0,str(PORT))
from ports.native_session import Session
from protocol_lab.codegen import generate,sha
from protocol_lab.codegen.execute import build,commands
from protocol_lab.ir import load,model_files,Machine
from protocol_lab.pipeline.worker import compare_case, reference_case
from protocol_lab.symbolic import crosscheck_trace, replay
from protocol_lab.flow import run_scenario
from capture import records
from exchange import run_exchange
CASES=PORT/'cases.json'
_CFG=json.loads(CASES.read_text())
CONFIG=dict(_CFG)
CONFIG.update(subject_ip=_CFG['subject']['ip'],subject_port=_CFG['subject']['port'],peer_ip=_CFG['peer']['ip'],peer_port=_CFG['peer']['port'])
TOOLS=('ip','unshare','tcpdump','cc')
PEER_SOURCE=(PORT/'server.py').read_bytes()
def require(cond,msg):
    if not cond:
        raise RuntimeError(msg)
def dump(path,obj):
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(obj,indent=2)+chr(10))
def inputs():
    require((ROOT/'protocol_lab').is_dir(),'protocol_lab missing')
    require((ROOT/'spec').is_dir(),'spec missing')
    paths={PORT/'run.py',PORT/'exchange.py',PORT/'capture.py',CASES,ROOT/'ports/native_session.py',ROOT/'requirements-formal.txt',ROOT/CONFIG['model'],ROOT/'spec/tcp-wire-endpoint-oracle.json'}
    paths|={Path(p) for p in model_files(ROOT/CONFIG['model'])}
    paths|={p for p in (ROOT/'protocol_lab').rglob('*.py')}
    paths|={p for p in (ROOT/'protocol_lab').rglob('*.c')}
    paths|={p for p in PORT.rglob('*.py')}
    paths|={p for p in PORT.rglob('*.json')}
    paths|={p for p in PORT.glob('config*')}
    paths|={p for p in PORT.glob('*.toml')}
    paths|={p for p in PORT.glob('*.ini')}
    paths|={p for p in PORT.glob('*.cfg')}
    paths|={p for p in PORT.glob('requirements*')}
    oracle=ROOT/'spec/tcp-wire-endpoint-oracle.json'
    require(oracle.is_file(),'oracle missing')
    oracle_data=json.loads(oracle.read_text())
    pins=oracle_data.get('sources')
    require(isinstance(pins,dict) and pins,'oracle source pins missing')
    for key,digest in pins.items():
        candidates=[ROOT/key,ROOT/'spec/sources'/key,ROOT/'spec'/key]
        pinned=next((p for p in candidates if p.is_file()),None)
        require(pinned is not None,'pinned source missing: '+str(key))
        require(sha(pinned)==digest,'pinned source hash differs: '+str(key))
        paths.add(pinned)
    for p in (ROOT/'spec').rglob('*'):
        if p.is_file():
            paths.add(p)
    for p in sorted(paths):
        require(p.resolve().is_relative_to(ROOT),'source escapes checkout')
        require(p.is_file(),'required source missing: '+str(p))
    return {str(p.relative_to(ROOT)):sha(p) for p in sorted(paths)}
def text(args):
    p=subprocess.run(args,capture_output=True,text=True,timeout=15)
    return dict(returncode=p.returncode,stdout=p.stdout[-4000:],stderr=p.stderr[-4000:])
def hash_tree(root):
    if not root.exists():
        return {}
    return {str(p.relative_to(root)):sha(p) for p in sorted(root.rglob('*')) if p.is_file()}
def tools_info():
    result={}
    for name,args in (('ip',['-V']),('unshare',['--version']),('tcpdump',['--version']),('cc',['--version'])):
        path=shutil.which(name)
        require(path is not None,'missing tool '+name)
        real=Path(path).resolve()
        result[name]=dict(path=str(real),sha256=sha(real),version=text([str(real)]+args))
    py=Path(sys.executable).resolve()
    result['python']=dict(path=str(py),sha256=sha(py),version=text([str(py),'--version']))
    return result
def commit():
    return subprocess.check_output(['git','-c','safe.directory='+str(ROOT),'rev-parse','HEAD'],cwd=ROOT,text=True,timeout=15).strip()
def command(args,out,name,timeout=20):
    p=subprocess.run(args,capture_output=True,text=True,timeout=timeout)
    (out/name).write_text(p.stdout+p.stderr)
    require(p.returncode==0,'Command failed: '+repr(args))
    return dict(command=args,returncode=p.returncode,log=name)
def is_selected(raw):
    return len(raw)>=20 and raw[0]>>4==4 and raw[9]==6
def replay_model(model, scene):
    machine = Machine(model, scene.get('initial', {}))
    for step in scene.get('steps', []):
        if step.get('tick'):
            machine.tick(step['at_ms'])
        else:
            machine.dispatch(step['event'], step.get('fields', {}), step['at_ms'])
    if scene.get('settle_ms') is not None:
        machine.tick(scene['settle_ms'])
    return machine
def stream_check(folder,model,scene,write=True):
    session=json.loads((folder/'session.json').read_text())
    lines=(folder/'native-input.txt').read_text().splitlines()
    rows=[json.loads(r) for r in (folder/'native.stdout').read_text().splitlines()]
    require(session['process_starts']==1 and session['returncode']==0 and session['transport']=='stdin-pipe-stdout-raw-pty','native continuity/returncode changed')
    require(commands(model,scene)==chr(10).join(lines)+chr(10) and lines[0]=='B' and lines.count('B')==1,'native ingress/reset/replay changed')
    require([o['line'] for o in session['operations']]==lines,'native operation transcript changed')
    end=0
    for i,o in enumerate(session['operations']):
        require(o['pid']==session['pid'] and o['row_start']==end and o['sent_monotonic_ns']<=o['reply_monotonic_ns'],'native PID/timeline changed')
        end=o['row_end']
        require(end>o['row_start'] and rows[end-1]['status']==('ready' if i==0 else 'ok'),'native operation failed')
    require(end==len(rows),'unaccounted native output')
    expected = reference_case(model, scene)
    negative = expected.get('error') is not None
    difference = compare_case(expected, rows, session['returncode'], negative)
    if write:
        dump(folder/'reference-difference.json', difference)
    require(isinstance(difference, dict) and difference.get('status') == 'pass', 'native reference difference')
    return rows, session, difference
def verify_symbolic_result(model,scene,witness_result,trusted_trace,smt2_path):
    """Generic verification of symbolic evidence against a concrete scene.

    Binds the witness to the trusted trace (before/after/emitted/event/time)
    for the exact scene, enforces replay match, checks the on-disk SMT2 hash
    and model semantic hash. Raises RuntimeError on any mismatch. Contains no
    protocol-specific logic; operates only on the model and trace records.
    """
    has_contract = scene.get('expect') is not None
    trusted = run_scenario(model, scene) if has_contract else replay_model(model, scene)
    require(trusted.trace == trusted_trace, 'symbolic trusted trace differs from actual scene')
    require(isinstance(witness_result,dict),'symbolic result must be a dict')
    require(witness_result.get('query')=='sat','symbolic query not sat: '+str(witness_result.get('query')))
    require(witness_result.get('status')=='match','symbolic status not match: '+str(witness_result.get('status')))
    require(witness_result.get('backend')=='z3-constrained-trace','symbolic backend mismatch')
    require(witness_result.get('scope')=='fixed_inputs_and_rule_choices','symbolic scope mismatch')
    require(witness_result.get('all_input_safety')=='not_claimed','symbolic all_input_safety must remain unclaimed')
    require(witness_result.get('model_semantic_sha256')==symbolic_model_hash(model),'symbolic model hash differs')
    smt2_path=Path(smt2_path)
    require(smt2_path.is_file(),'symbolic path.smt2 missing')
    require(hashlib.sha256(smt2_path.read_bytes()).hexdigest()==witness_result.get('smt2_sha256'),'symbolic smt2 hash differs')
    witness=witness_result.get('witness')
    require(isinstance(witness,dict) and isinstance(witness.get('steps'),list) and 'initial' in witness,'symbolic witness missing')
    replay_result=replay(model,witness)
    require(replay_result.get('status')=='match','symbolic witness replay not match: '+str(replay_result.get('status')))
    require(witness_result.get('steps')==len(trusted_trace),'symbolic step count differs')
    require(len(witness['steps'])==len(trusted_trace),'symbolic witness step count differs')
    before_state={'state':model['initial_state'],'variables':witness['initial'],'timers':{}}
    for idx,(row,step) in enumerate(zip(trusted_trace,witness['steps'])):
        require(row['before']==before_state,'symbolic scene before differs at step '+str(idx))
        require(row['after']==step['after'],'symbolic scene after differs at step '+str(idx))
        require(row['emitted']==step['emitted'],'symbolic scene emitted differs at step '+str(idx))
        require(row['event']=={'name':step['event'],'fields':step['fields']},'symbolic scene event differs at step '+str(idx))
        require(row['time_ms']==step['at_ms'],'symbolic scene time differs at step '+str(idx))
        before_state=step['after']
    return dict(status='match',compared_steps=len(trusted_trace),replay=replay_result)

def symbolic_gate(out,model,scene,steps,rows,difference):
    from pathlib import Path as _P
    import hashlib as _h
    _ = steps, rows, difference
    has_contract = any(('expect' in step or 'expect_trace' in step) for step in scene.get('steps', [])) or scene.get('expect') is not None
    if has_contract:
        ref = run_scenario(model, scene)
    else:
        ref = replay_model(model, scene)
    trace = ref.trace
    folder=out/'symbolic'
    result=crosscheck_trace(model,trace,folder)
    require(isinstance(result,dict),'symbolic result missing')
    require(result.get('backend')=='z3-constrained-trace','symbolic backend mismatch')
    require(result.get('scope')=='fixed_inputs_and_rule_choices','symbolic scope mismatch')
    require(result.get('all_input_safety')=='not_claimed','symbolic all_input_safety must remain unclaimed')
    require(result.get('steps')==len(trace),'symbolic step count differs')
    require(result.get('query')=='sat','symbolic query not sat: '+str(result.get('query')))
    require(result.get('status')=='match','symbolic status not match: '+str(result.get('status')))
    with_model_hash=getattr(ref,'model_hash',None)
    _ = with_model_hash
    actual_model_hash=result.get('model_semantic_sha256')
    require(isinstance(actual_model_hash,str) and len(actual_model_hash)==64,'symbolic model_semantic_sha256 missing')
    smt_path=folder/'path.smt2'
    res_path=folder/'result.json'
    require(smt_path.is_file(),'symbolic path.smt2 missing')
    require(res_path.is_file(),'symbolic result.json missing')
    require(_h.sha256(smt_path.read_bytes()).hexdigest()==result.get('smt2_sha256'),'symbolic smt2 hash differs')
    on_disk=json.loads(res_path.read_text())
    require(on_disk==result,'symbolic on-disk result differs')
    replay_result=replay(model,result.get('witness') or {})
    require(replay_result.get('status')=='match','symbolic witness replay not match: '+str(replay_result.get('status')))
    verified=verify_symbolic_result(model,scene,result,trace,smt_path)
    require(verified.get('status')=='match','symbolic verification not match')
    return dict(result=result,replay=replay_result,smt2_sha256=result.get('smt2_sha256'),symbolic=folder,verified=verified)
def evidence(out):
    if not out.exists():
        return {}
    return {str(p.relative_to(out)):dict(size=p.stat().st_size,sha256=sha(p)) for p in sorted(out.rglob('*')) if p.is_file()}
def drain_tun(fd,out,extra,phase):
    """Bounded drain of continuously-readable TUN input after capture stop.

    Single reader; fd assumed nonblocking. Empty readiness or
    BlockingIOError means drain completed now (no claim about future
    absence). EOF means completed. Continuously readable input is bounded
    by a monotonic 100ms budget; expiry yields incomplete (never success).
    Raw bytes are preserved unchanged in unique extra-N.raw files and a
    JSON-safe row is appended to the shared extra list. Returns a
    structured result dict.
    """
    budget_ns=100*1000*1000
    start=time.monotonic_ns()
    records=0
    selected=0
    error=None
    completed=False
    incomplete=False
    while True:
        try:
            ready=select.select([fd],[],[],0)[0]
        except Exception as exc:
            error=str(exc)
            break
        if not ready:
            completed=True
            break
        try:
            raw=os.read(fd,65535)
        except BlockingIOError:
            completed=True
            break
        except Exception as exc:
            error=str(exc)
            break
        if not raw:
            completed=True
            break
        name='extra-'+str(len(extra))+'.raw'
        try:
            (out/name).write_bytes(raw)
            sel=is_selected(raw)
        except Exception as exc:
            error=dict(type=type(exc).__name__,phase='retain',raw_hex=raw.hex())
            break
        if sel:
            selected+=1
        extra.append(dict(file=name,length=len(raw),monotonic_ns=time.monotonic_ns(),selected=sel,phase=phase))
        records+=1
        if time.monotonic_ns()-start>=budget_ns:
            incomplete=True
            break
    return dict(completed=completed,deadline=incomplete,error=error,incomplete=incomplete,selected=selected,records=records)

def inside(out,parent):
    require(platform.system()=='Linux' and os.geteuid()==0,'Linux namespace root required')
    actual=os.readlink('/proc/'+str(os.getppid())+'/ns/net')
    current=os.readlink('/proc/self/ns/net')
    require(parent.startswith('net:[') and current.startswith('net:[') and parent!=current and actual==parent,'Distinct network namespace required')
    out.mkdir(parents=True,exist_ok=True)
    meta=dict(platform='Linux',kernel=platform.release(),parent_netns=parent,actual_parent_netns=actual,execution_netns=current,host_network_mutations=False,packet_bytes_rewritten=False,peer='ordinary Linux TCP socket',quiet_ms=CONFIG['quiet_ms'],wire_timing_contract=CONFIG['wire_timing_contract'])
    dump(out/'namespace.json',meta)
    fd=None
    cap=None
    actor=None
    peer=None
    handles=[]
    extra=[]
    report=None
    transport=out/'transport'
    try:
        fd=os.open('/dev/net/tun',os.O_RDWR)
        fcntl.ioctl(fd,0x400454ca,struct.pack('16sH22x',CONFIG['interface'].encode(),0x1001))
        os.set_blocking(fd,False)
        setup=[['ip','link','set','lo','up'],['ip','addr','add',CONFIG['peer_ip']+'/24','dev',CONFIG['interface']],['ip','link','set',CONFIG['interface'],'mtu',str(CONFIG['mtu']),'up'],['ip','route','add',CONFIG['subject_ip']+'/32','dev',CONFIG['interface'],'src',CONFIG['peer_ip']],['ip','addr','show'],['ip','route','show'],['tcpdump','--version']]
        for i,args in enumerate(setup):
            meta.setdefault('commands',[]).append(command(args,out,'setup-'+str(i)+'.log'))
        cap_log=(out/'capture.log').open('w')
        handles.append(cap_log)
        cap_cmd=['tcpdump','--immediate-mode','-Z','root','-U','-n','-s','0','-i',CONFIG['interface'],'-y','RAW','-w',str(out/'capture.pcap'),'tcp']
        meta['capture_command']=cap_cmd
        cap=subprocess.Popen(cap_cmd,stdout=cap_log,stderr=cap_log)
        deadline=time.monotonic()+5
        while 'listening on' not in (out/'capture.log').read_text() and time.monotonic()<deadline:
            require(cap.poll() is None,'capture failed startup')
            time.sleep(0.02)
        require('listening on' in (out/'capture.log').read_text(),'capture readiness timeout')
        meta['capture_ready_monotonic_ns']=time.monotonic_ns()
        peer_py=out/'peer_server.py'
        existing_peer=PORT/'server.py'
        if existing_peer.is_file():
            require(existing_peer.read_bytes()==PEER_SOURCE,'peer server source differs from embedded source')
        peer_py.write_bytes(PEER_SOURCE)
        peer_out=out/'peer'
        peer_out.mkdir()
        peer_stdout=(out/'peer.stdout').open('w')
        peer_stderr=(out/'peer.stderr').open('w')
        handles.extend([peer_stdout,peer_stderr])
        payload=bytes.fromhex(CONFIG['payload_hex'])
        peer=subprocess.Popen([sys.executable,str(peer_py),'--out',str(peer_out),'--ip',CONFIG['peer_ip'],'--port',str(CONFIG['peer_port']),'--count',str(len(payload))],stdin=subprocess.PIPE,stdout=peer_stdout,stderr=peer_stderr)
        deadline=time.monotonic()+5
        while True:
            require(peer.poll() is None,'peer exited before listening')
            events_path=peer_out/'server-events.jsonl'
            if events_path.exists():
                listening=False
                for line in events_path.read_text().splitlines():
                    if line:
                        try:
                            row=json.loads(line)
                        except Exception:
                            continue
                        if row.get('event')=='listening':
                            listening=True
                if listening:
                    break
            require(time.monotonic()<deadline,'peer listening receipt timeout')
            time.sleep(0.02)
        meta['peer_listening_monotonic_ns']=time.monotonic_ns()
        actor=Session(out.parent/'build/protocol-native',out/'native')
        model=load(ROOT/CONFIG['model'])
        result=run_exchange(model,actor,fd,peer,transport,CONFIG)
        require(result.get('final_state')=='TIME-WAIT','finite exchange did not reach TIME-WAIT')
        pending=result.get('clock',{}).get('pending_timers') or []
        require(any(name=='time_wait' for name,_ in pending),'pending time_wait timer required')
        require(result.get('time_wait_awaited') is False,'time_wait_awaited must be false')
        selected=[l for l in result.get('links',[]) if l.get('direction') in ('subject_tx','peer_tx')]
        require(bool(selected),'no selected wire packets')
        deadline=time.monotonic()+max(5.0,CONFIG['quiet_ms']/1000+3)
        last_pcap=None
        stable_since=time.monotonic_ns()
        selected_pairs=((CONFIG['peer_ip'],CONFIG['subject_ip']),(CONFIG['subject_ip'],CONFIG['peer_ip']))
        quiet_observed=None
        while True:
            require(cap.poll() is None and actor.process.poll() is None and peer.poll() is None,'capture/native/peer ended early')
            require(time.monotonic()<deadline,'capture quiet timeout')
            try:
                current=records(out/'capture.pcap')
            except Exception:
                current=[]
            selected_current=[d for d in current if (d['decoded']['source'],d['decoded']['destination']) in selected_pairs]
            if selected_current:
                stamp=selected_current[-1]['timestamp_ns']
                if last_pcap is None or stamp!=last_pcap:
                    last_pcap=stamp
                    stable_since=time.monotonic_ns()
                    quiet_observed=stable_since
            ready=select.select([fd],[],[],0)[0]
            if ready:
                raw=os.read(fd,65535)
                if raw:
                    name='extra-'+str(len(extra))+'.raw'
                    (out/name).write_bytes(raw)
                    row=dict(file=name,length=len(raw),monotonic_ns=time.monotonic_ns(),selected=is_selected(raw))
                    extra.append(row)
                    dump(out/'extra.json',extra)
                    if row['selected']:
                        raise RuntimeError('unsupported finite-harness observation: selected TCP after exchange')
                continue
            if last_pcap is not None and time.time_ns()>=last_pcap+CONFIG['quiet_ms']*1000000:
                break
            time.sleep(0.005)
        meta['quiet_start_monotonic_ns']=quiet_observed if quiet_observed is not None else time.monotonic_ns()
        meta['quiet_end_monotonic_ns']=time.monotonic_ns()
        meta['capture_stop_request_monotonic_ns']=time.monotonic_ns()
        meta['capture_stop_request_realtime_ns']=time.time_ns()
        require(cap.poll() is None and actor.process.poll() is None and peer.poll() is None,'capture/native/peer ended early')
        cap.send_signal(2)
        meta['capture_returncode']=cap.wait(timeout=5)
        meta['capture_exit_monotonic_ns']=time.monotonic_ns()
        require(meta['capture_returncode']==0,'capture failed')
        drained=drain_tun(fd,out,extra,'post_capture')
        dump(out/'extra.json',extra)
        meta['post_capture_drain']=drained
        require(drained['error'] is None,'post-capture drain error: '+str(drained['error']))
        require(not drained['incomplete'],'post-capture drain incomplete')
        require(not drained['selected'],'selected TCP after capture stop')
        require(peer.stdin is not None,'peer stdin missing')
        peer.stdin.close()
        meta['peer_returncode']=peer.wait(timeout=20)
        meta['peer_exit_monotonic_ns']=time.monotonic_ns()
        require(meta['peer_returncode']==0,'peer failed')
        meta['native_close_request_monotonic_ns']=time.monotonic_ns()
        meta['native_returncode']=actor.close()
        meta['native_pid']=actor.process.pid
        actor=None
        os.close(fd)
        fd=None
        decoded=records(out/'capture.pcap')
        links=result.get('links',[])
        selected_pairs=((CONFIG['peer_ip'],CONFIG['subject_ip']),(CONFIG['subject_ip'],CONFIG['peer_ip']))
        selected_decoded=[d for d in decoded if (d['decoded']['source'],d['decoded']['destination']) in selected_pairs]
        selected=[l for l in links if l.get('direction') in ('subject_tx','peer_tx')]
        require(len(selected)==len(selected_decoded),'selected packet count differs')
        for direction,src,dst in (('peer_tx',CONFIG['peer_ip'],CONFIG['subject_ip']),('subject_tx',CONFIG['subject_ip'],CONFIG['peer_ip'])):
            link_hex=[(transport/l['file']).read_bytes().hex() for l in selected if l['direction']==direction]
            cap_hex=[d['hex'] for d in decoded if d['decoded']['source']==src and d['decoded']['destination']==dst]
            require(link_hex==cap_hex,'PCAP/TUN bytes differ for '+direction)
        require(selected_decoded and meta['capture_stop_request_realtime_ns']-selected_decoded[-1]['timestamp_ns']>=CONFIG['quiet_ms']*1000000,'capture timestamp quiet interval too short')
        text_log=(out/'capture.log').read_text()
        drops=re.findall(r'([0-9]+) packets dropped by kernel',text_log)
        require(drops and int(drops[-1])==0,'capture drops')
        events=[json.loads(line) for line in (peer_out/'server-events.jsonl').read_text().splitlines() if line]
        received=[e for e in events if e.get('event')=='received']
        echoed=[e for e in events if e.get('event')=='echo_sent']
        require(received and echoed and received[-1]['hex']==CONFIG['payload_hex'] and echoed[-1]['hex']==CONFIG['payload_hex'],'peer payload/echo contract differs')
        scene=dict(scenario_version='0.2',id='linux-tcp-wire',initial={},steps=result['steps'])
        rows,session,difference=stream_check(out/'native',model,scene)
        require(session['pid']==meta.get('native_pid'),'native PID differs')
        verify_final_snapshot(result, rows[-1]['snapshot'])
        dump(out/'reference-difference.json',difference)
        symbolic=symbolic_gate(out,model,scene,result['steps'],rows,difference)
        report=dict(schema='linux-tcp-wire-peer-v1',status='pass',linux_tcp_peer_evidence=False,isolated_tun_exchange=True,kernel=platform.release(),namespace=meta,capture_packets=len(decoded),steps=len(result['steps']),peer_payload_hex=CONFIG['payload_hex'],api_calls=0,physical_ethernet=False,whole_ipv4_endpoint_complete=False,generated_subject_uses_host_stack=False,packet_bytes_rewritten=False,time_wait_awaited=result.get('time_wait_awaited',False),wire_timing_contract=CONFIG['wire_timing_contract'])
        report['native_reference_difference']=difference
        report['symbolic']=dict(backend=symbolic['result']['backend'],scope=symbolic['result']['scope'],all_input_safety=symbolic['result']['all_input_safety'],query=symbolic['result']['query'],status=symbolic['result']['status'],solver_version=symbolic['result']['solver_version'],model_semantic_sha256=symbolic['result']['model_semantic_sha256'],smt2_sha256=symbolic['smt2_sha256'],steps=symbolic['result']['steps'],replay_status=symbolic['replay']['status'],replay_compared_steps=symbolic['replay'].get('compared_steps'))
        dump(transport/'exchange.json',result)
        dump(out/'exchange.json',result)
        dump(out/'decoded.json',decoded)
        dump(out/'peer-events.json',events)
        dump(out/'extra.json',extra)
        meta['capture_last_drop_count']=int(drops[-1])
    finally:
        if cap is not None and cap.poll() is None:
            meta.setdefault('capture_stop_request_monotonic_ns',time.monotonic_ns())
            meta.setdefault('capture_stop_request_realtime_ns',time.time_ns())
            cap.send_signal(2)
            try:
                meta['capture_returncode']=cap.wait(timeout=5)
            except subprocess.TimeoutExpired:
                cap.kill()
                meta['capture_returncode']=cap.wait(timeout=5)
            meta['capture_exit_monotonic_ns']=time.monotonic_ns()
        if fd is not None:
            try:
                cleanup_drain=drain_tun(fd,out,extra,'cleanup')
            except Exception:
                cleanup_drain=dict(completed=False,deadline=True,error='drain exception',incomplete=True,selected=0,records=0)
            meta['cleanup_drain']=cleanup_drain
            try:
                dump(out/'extra.json',extra)
            except Exception:
                pass
        if peer is not None:
            try:
                if peer.stdin is not None:
                    peer.stdin.close()
            except Exception:
                pass
            if peer.poll() is None:
                try:
                    peer.wait(timeout=20)
                except subprocess.TimeoutExpired:
                    peer.terminate()
                    peer.wait(timeout=5)
            meta['peer_returncode']=peer.returncode
            meta['peer_exit_monotonic_ns']=time.monotonic_ns()
        if actor is not None:
            try:
                meta['native_returncode']=actor.close()
                meta['native_pid']=actor.process.pid
            except Exception:
                pass
        if fd is not None:
            try:
                os.close(fd)
            except OSError:
                pass
        try:
            text_log=(out/'capture.log').read_text()
            drops=re.findall(r'([0-9]+) packets dropped by kernel',text_log)
            meta['capture_last_drop_count']=int(drops[-1]) if drops else None
        except Exception:
            meta['capture_last_drop_count']=None
        meta['resources_closed_monotonic_ns']=time.monotonic_ns()
        dump(out/'namespace.json',meta)
        dump(out/'extra.json',extra)
        for h in handles:
            try:
                h.close()
            except Exception:
                pass
        if report is not None:
            cd=meta.get('cleanup_drain') or {}
            if cd.get('selected') or cd.get('error') is not None or cd.get('incomplete'):
                report=None
        if report is not None:
            dump(out/'report.json',report)
    return report
def verify_final_snapshot(result, snapshot):
    require(snapshot.get('state') == result.get('final_state') == 'TIME-WAIT',
            'final native state differs')
    clock = result.get('clock', {})
    require(clock.get('final_snapshot') == snapshot, 'final native snapshot differs')
    timers = sorted(snapshot.get('timers', {}).items(), key=lambda item: (item[1], item[0]))
    require(clock.get('pending_timers') in (timers, [list(item) for item in timers]),
            'pending timers differ from native snapshot')
    require(any(name == 'time_wait' for name, _ in timers), 'native time_wait missing')
    require(result.get('time_wait_awaited') is False, 'time_wait incorrectly claimed elapsed')

def verify(out):
    out=Path(out)
    require((out/'provenance.json').is_file(),'provenance missing')
    prov=json.loads((out/'provenance.json').read_text())
    require(inputs()==prov['input_hashes'],'source hashes differ')
    net=out/'network'
    require((net/'capture.pcap').is_file(),'capture missing')
    decoded=records(net/'capture.pcap')
    log=(net/'capture.log').read_text()
    drops=re.findall(r'([0-9]+) packets dropped by kernel',log)
    require(drops and int(drops[-1])==0,'capture drops')
    meta=json.loads((net/'namespace.json').read_text())
    require(meta.get('parent_netns')!=meta.get('execution_netns'),'namespace proof missing')
    require(meta.get('actual_parent_netns')==meta.get('parent_netns'),'namespace parent proof differs')
    require(meta.get('capture_returncode')==0,'capture returncode nonzero')
    require(meta.get('native_returncode')==0,'native returncode nonzero')
    require(meta.get('peer_returncode')==0,'peer returncode nonzero')
    selected_pairs=((CONFIG['peer_ip'],CONFIG['subject_ip']),(CONFIG['subject_ip'],CONFIG['peer_ip']))
    selected_decoded=[d for d in decoded if (d['decoded']['source'],d['decoded']['destination']) in selected_pairs]
    require(selected_decoded and meta['capture_stop_request_realtime_ns']-selected_decoded[-1]['timestamp_ns']>=CONFIG['quiet_ms']*1000000,'quiet interval too short')
    result=json.loads((net/'exchange.json').read_text())
    require(result.get('final_state')=='TIME-WAIT','final state not TIME-WAIT')
    pending=result.get('clock',{}).get('pending_timers') or []
    require(any(name=='time_wait' for name,_ in pending),'pending time_wait timer missing')
    require(result.get('time_wait_awaited') is False,'time_wait_awaited must be false')
    session=json.loads((net/'native/session.json').read_text())
    timeline=[meta.get('capture_ready_monotonic_ns'),meta.get('peer_listening_monotonic_ns'),session.get('started_monotonic_ns'),result.get('origin_monotonic_ns'),meta.get('quiet_start_monotonic_ns'),meta.get('capture_stop_request_monotonic_ns'),meta.get('capture_exit_monotonic_ns'),meta.get('peer_exit_monotonic_ns'),meta.get('native_close_request_monotonic_ns'),meta.get('resources_closed_monotonic_ns')]
    require(all(isinstance(v,int) for v in timeline),'timeline field missing')
    require(timeline==sorted(timeline),'timeline out of order')
    selected=[l for l in result.get('links',[]) if l.get('direction') in ('subject_tx','peer_tx')]
    require(len(selected)==len(selected_decoded),'selected packet count differs')
    for direction,src,dst in (('peer_tx',CONFIG['peer_ip'],CONFIG['subject_ip']),('subject_tx',CONFIG['subject_ip'],CONFIG['peer_ip'])):
        link_hex=[(net/'transport'/l['file']).read_bytes().hex() for l in selected if l['direction']==direction]
        cap_hex=[d['hex'] for d in selected_decoded if d['decoded']['source']==src and d['decoded']['destination']==dst]
        require(link_hex==cap_hex,'PCAP/TUN bytes differ for '+direction)
    scene=dict(scenario_version='0.2',id='linux-tcp-wire',initial={},steps=result['steps'])
    rows,session,difference=stream_check(net/'native',load(ROOT/CONFIG['model']),scene,write=False)
    retained_path=net/'native/reference-difference.json'
    require(retained_path.is_file(),'retained reference difference missing')
    retained=json.loads(retained_path.read_text())
    require(retained==difference,'retained reference difference differs')
    require(session['pid']==meta.get('native_pid'),'native PID differs')
    verify_final_snapshot(result, rows[-1]['snapshot'])
    events=[json.loads(line) for line in (net/'peer'/'server-events.jsonl').read_text().splitlines() if line]
    received=[e for e in events if e.get('event')=='received']
    echoed=[e for e in events if e.get('event')=='echo_sent']
    require(received and echoed and received[-1]['hex']==CONFIG['payload_hex'] and echoed[-1]['hex']==CONFIG['payload_hex'],'peer payload/echo contract differs')
    extra_path=net/'extra.json'
    if extra_path.is_file():
        extras=json.loads(extra_path.read_text())
        require(not any(row.get('selected') for row in extras),'selected extra TUN traffic present')
    require((net/'symbolic').is_dir(),'symbolic folder missing')
    sym_smt=net/'symbolic/path.smt2'
    sym_res=net/'symbolic/result.json'
    require(sym_smt.is_file(),'symbolic path.smt2 missing')
    require(sym_res.is_file(),'symbolic result.json missing')
    sym_result=json.loads(sym_res.read_text())
    loaded_model=load(ROOT/CONFIG['model'])
    trusted=replay_model(loaded_model,scene)
    verify_symbolic_result(loaded_model,scene,sym_result,trusted.trace,sym_smt)
    report=json.loads((out/'report.json').read_text())
    require(report.get('status')=='pass','report status not pass')
    declared=report.get('file_hashes')
    require(isinstance(declared,dict) and declared,'file_hashes missing')
    actual={str(p.relative_to(out)):sha(p) for p in out.rglob('*') if p.is_file() and p!=out/'report.json'}
    require(actual==declared,'file hash closure differs')
    return dict(status='verified',capture_packets=len(selected_decoded),difference=difference,source_hashes_match=True,file_hashes=len(declared))
def symbolic_model_hash(model):
    import hashlib as _h
    return _h.sha256(json.dumps(model,sort_keys=True,separators=(',',':')).encode()).hexdigest()
def run(out):
    out.mkdir(parents=True,exist_ok=False)
    prov=dict(schema='linux-tcp-wire-provenance-v1',stage='initial',source_commit=None,input_hashes=None,tools=None,generated_hashes={},build_hashes={},elf_sha256=None,unavailable=dict(inputs='pending',tools='pending',generated='pending',build='pending',elf='pending'))
    dump(out/'provenance.json',prov)
    before=inputs()
    prov.update(stage='inputs',input_hashes=before,unavailable={**prov['unavailable'],'inputs':'available'})
    dump(out/'provenance.json',prov)
    pre=dict(platform=platform.system(),kernel=platform.release(),euid=os.geteuid(),tun=Path('/dev/net/tun').exists(),tools={n:shutil.which(n) for n in TOOLS})
    dump(out/'preflight.json',pre)
    prov.update(stage='preflight',preflight=pre)
    dump(out/'provenance.json',prov)
    try:
        prov.update(tools=tools_info(),stage='tools',unavailable={**prov['unavailable'],'tools':'available'})
    except Exception as error:
        prov.update(stage='tools_failed',tools=None,tools_error=type(error).__name__+': '+str(error),unavailable={**prov['unavailable'],'tools':'unavailable'})
        dump(out/'provenance.json',prov)
        raise
    dump(out/'provenance.json',prov)
    require(pre['platform']=='Linux' and pre['euid']==0 and pre['tun'] and all(pre['tools'].values()),'environment: Linux root TUN/tools unavailable')
    generate(ROOT/CONFIG['model'],out/'generated')
    prov.update(stage='generated',generated_hashes=hash_tree(out/'generated'),unavailable={**prov['unavailable'],'generated':'available'})
    dump(out/'provenance.json',prov)
    built=build(out/'generated',out/'build')
    prov.update(stage='build',build=built,build_hashes=hash_tree(out/'build'),unavailable={**prov['unavailable'],'build':'available'})
    dump(out/'provenance.json',prov)
    require(built['status']=='pass','native build failed')
    prov['source_commit']=commit()
    elf=out/'build/protocol-native'
    require(elf.exists(),'ELF missing')
    prov['elf_sha256']=sha(elf)
    prov['stage']='elf'
    prov['unavailable']['elf']='available'
    dump(out/'provenance.json',prov)
    folder=out/'network'
    folder.mkdir()
    verify=dict(before=before)
    try:
        command(['unshare','--net','--',sys.executable,str(PORT/'run.py'),'--inside',os.readlink('/proc/self/ns/net'),'--out',str(folder)],out,'namespace-driver.log',timeout=90)
        report=json.loads((folder/'report.json').read_text())
    finally:
        after=inputs()
        verify.update(after=after,match=before==after)
        dump(out/'source-verification.json',verify)
        if before!=after:
            raise RuntimeError('input changed during execution')
    report['outer']=dict(execution_source_root=str(ROOT),execution_output_dir=str(out),provenance=prov,source_verification=verify)
    report_path=out/'report.json'
    report['file_hashes']={str(p.relative_to(out)):sha(p) for p in out.rglob('*') if p.is_file() and p!=report_path}
    dump(report_path,report)
    return report
if __name__=='__main__':
    p=argparse.ArgumentParser()
    p.add_argument('--out',type=Path,required=True)
    p.add_argument('--inside')
    p.add_argument('--verify',action='store_true')
    a=p.parse_args()
    out=a.out.resolve()
    if a.inside and out.exists() and (not out.is_dir() or any(out.iterdir())):
        raise SystemExit('refusing nonempty inside output: '+str(out))
    if out.exists() and not (a.inside or a.verify):
        raise SystemExit('refusing existing output: '+str(out))
    try:
        if a.verify:
            print(json.dumps(verify(out)))
        elif a.inside:
            inside(out,a.inside)
        else:
            print(json.dumps(run(out)))
    except Exception as error:
        if a.verify:
            raise
        out.mkdir(parents=True,exist_ok=True)
        name='namespace-failure.json' if a.inside else 'failure.json'
        primary=None
        primary_path=None
        for evidence_path in (out/'transport/evidence.json',out/'network/transport/evidence.json'):
            if evidence_path.is_file():
                try:
                    primary=json.loads(evidence_path.read_text()).get('kind')
                    primary_path=str(evidence_path.relative_to(out))
                except Exception:
                    primary=None
                break
        prov_path=out/'provenance.json'
        if prov_path.is_file():
            try:
                prov=json.loads(prov_path.read_text())
                prov['stage']='failed'
                prov['complete']=False
                prov['failure']=dict(type=type(error).__name__,reason=str(error))
                dump(prov_path,prov)
            except Exception:
                pass
        failure_path=out/name
        record=dict(status='failed_or_blocked',type=type(error).__name__,reason=str(error),primary_evidence_kind=primary,primary_evidence_path=primary_path,linux_tcp_acceptance=False,evidence=evidence(out))
        dump(failure_path,record)
        record['file_hashes']={str(p.relative_to(out)):sha(p) for p in out.rglob('*') if p.is_file() and p!=failure_path}
        dump(failure_path,record)
        raise
