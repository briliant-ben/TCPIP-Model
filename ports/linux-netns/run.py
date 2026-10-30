"""Linux TCP active-open through packetdrill and independent bounded tcpdump."""
import argparse
import json
import os
from pathlib import Path
import platform
import re
import shlex
import shutil
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[2]
PORT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
from protocol_lab.flow import read, write, digest, run_scenario, verify_sources
from protocol_lab.ir import load, model_files, require
from protocol_lab.packets import normalize_trace, packetdrill, compare
from protocol_lab.capture import normalize
from protocol_lab.symbolic import crosscheck_trace, model_hash
from protocol_lab.profiles import control_packets
import receive


SCENARIOS = {'handshake': 'scenarios/handshake.json', 'syn-loss': 'scenarios/syn-loss.json',
    receive.CASE: 'ports/linux-netns/scenarios/receive-four-zero-octets.json'}


def model_path(scenario):
    return ROOT/('model/tcp-sws.json' if scenario==receive.CASE else 'model/tcp.json')


def projection(scenario):
    return 'tcp-connection-v1' if scenario==receive.CASE else 'active-open-v1'


def driver_policy(expected,scenario):
    return [dict(packet_id=p['packet_id'],role='independent_observation_only'
        if scenario==receive.CASE and p['direction']=='out' and p['flags']=='A'
        else 'tool_stimulus'if p['direction']=='in'else'tool_output_expectation')for p in expected]


def scenario_config(scenario):
    require(scenario in SCENARIOS, 'Unsupported Linux scenario')
    scene=read(ROOT/SCENARIOS[scenario])
    require(scene['id']==scenario, 'Scenario identity changed')
    return scene


def quiet_after_protocol_ms(expected, scenario='handshake'):
    settle=scenario_config(scenario)['settle_ms']
    anchor=scenario_config(scenario)['steps'][-1]['at_ms']if scenario==receive.CASE else expected[-1]['time_ms']
    require(type(settle)is int and max(anchor,expected[-1]['time_ms']) <= settle <= 10000,'Quiet interval outside Linux channel scope')
    return settle-anchor


def execution_script(base, out, quiet_ms):
    """Only device setup and public endpoint bind; preserve every generated expectation."""
    lines = base.splitlines()
    socket = lines.index('0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3')
    # Offload setup precedes the protocol clock origin (first SYN). The first
    # syscall starts relative to setup completion; packet expectations stay exact.
    lines[socket] = '+0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3'
    target = shlex.quote(str(out / 'offload.log'))
    setup = '0 `ethtool -K tun0 tx off tso off gso off gro off > ' + target + ' 2>&1 && ethtool -k tun0 >> ' + target + ' 2>&1`'
    lines.insert(socket, setup)
    index = lines.index('+0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0')
    lines.insert(index + 1, '+0 bind(3, ..., ...) = 0')
    lines.append(f'+{quiet_ms/1000:.3f} getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0')
    marker=shlex.quote(str(out/'quiet-complete')); release=shlex.quote(str(out/'capture-stopped'))
    lines.append('+0 `touch '+marker+' && while test ! -f '+release+'; do sleep 0.01; done`')
    return '\n'.join(lines) + '\n'


def execution_mapping(base, script, mapping):
    original, executed = base.splitlines(), script.splitlines()
    result = []
    for row in mapping:
        line = original[row['line'] - 1]
        require(executed.count(line) == 1, 'Ambiguous generated expectation line')
        result.append(dict(**row, base_line=row['line'], execution_line=executed.index(line) + 1))
    return result


def inputs():
    paths=[]
    for filename in sorted({model_path(name)for name in SCENARIOS}):
        paths+=list(model_files(filename))
        model=load(filename)
        for requirement in model['requirements'].values():
            source=requirement['source']
            if not source.startswith('https://'):
                path=(ROOT/source).resolve()
                require(path.is_relative_to(ROOT)and path.is_file(),'Missing model interpretation source')
                paths.append(path)
    paths += list((ROOT / 'protocol_lab').glob('*.py'))
    paths += [p for p in PORT.rglob('*') if p.is_file() and '__pycache__' not in p.parts]
    paths += [ROOT / n for n in [*SCENARIOS.values(), 'packet-profile.json',
        'requirements-formal.txt', 'spec/sources/manifest.json', '.github/workflows/linux-tcp.yml']]
    paths += list((ROOT / 'spec/sources').glob('*.txt'))
    return {str(p.relative_to(ROOT)): digest(p) for p in paths}


def reference(out, scenario='handshake'):
    model = load(model_path(scenario)); scene = scenario_config(scenario)
    if scenario==receive.CASE:
        machine=run_scenario(model,scene);expected=control_packets(machine,scene)
        script,mapping=receive.render(scene,expected)
        return model,machine,expected,script,mapping
    drops=[] if scenario=='handshake' else ['e0001:out:0']
    require(scene['environment']['drop_outgoing']==drops,'Unsupported loss setup')
    machine = run_scenario(model, scene); expected = normalize_trace(machine, scene)
    flags=['S','SA','A'] if scenario=='handshake' else ['S','S','SA','A']
    require([p['flags'] for p in expected]==flags,'Unexpected finite active-open packet sequence')
    require([p['packet_id'] for p in expected if p['dropped_after_egress']]==drops,'Loss marker differs from source')
    script, mapping = packetdrill(expected)
    return model, machine, expected, script, mapping


def validate_observation(expected,observed,scenario):
    if scenario!=receive.CASE:
        require(len(observed)>=len(expected),'Active-open capture incomplete')
        return
    # Full-window capture can expose fewer ACKs than the model. That is a valid
    # Difference, not evidence invalidity. Bind delivered stimuli independently.
    keys=('direction','flags','seq','ack','window','payload')
    fields=lambda packets:[{k:p[k]for k in keys}for p in packets if p['direction']=='in']
    require(fields(observed)==fields(expected),'Captured receive stimuli differ from the declared input')


def preflight():
    return dict(platform=platform.system(), kernel=platform.release(), euid=os.geteuid(),
        tun=Path('/dev/net/tun').exists(),
        tools={name: shutil.which(name) for name in ['unshare','ip','tcpdump','ethtool','sysctl']})


def require_isolation(parent, current):
    require(parent.startswith('net:[') and current.startswith('net:[') and parent != current,
        'Refuse network setup without a distinct network namespace')


def command(args, log, timeout=10, required=True):
    try:
        process = subprocess.run(args, capture_output=True, text=True, timeout=timeout)
    except subprocess.TimeoutExpired as error:
        chunks = [x.decode(errors='replace') if isinstance(x,bytes) else x or '' for x in [error.stdout,error.stderr]]
        log.write_text(''.join(chunks)+'\nCommand timeout\n')
        raise
    log.write_text(process.stdout + process.stderr)
    if required: require(process.returncode == 0, 'Command failed: ' + str(args))
    return process


def stage(out, name): write(out/'phase.json',dict(phase=name))


def failure_kind(phase, error):
    if phase=='observation':
        unsupported=['TCP control flags outside this active-open slice',
            'TCP payload is outside this active-open slice',
            'Payload on SYN/FIN/RST is outside this data slice']
        return 'model_uncovered_capture_shape' if any(text in str(error) for text in unsupported) else 'invalid_capture_evidence'
    if phase=='capture_validation':return 'invalid_capture_evidence'
    return 'linux_execution_attempt_failed' if phase=='packetdrill_execution' else 'environment_or_setup_failure'


def inside(out, parent, scenario='handshake'):
    require(platform.system() == 'Linux' and os.geteuid() == 0, 'Linux root namespace child required')
    actual_parent = os.readlink('/proc/' + str(os.getppid()) + '/ns/net')
    require(parent == actual_parent, 'Namespace parent argument differs from the actual live parent')
    current = os.readlink('/proc/self/ns/net'); require_isolation(parent, current)
    stage(out,'namespace_setup')
    records = []
    for args in [['ip','link','set','lo','up'], ['sysctl','-w','net.ipv4.tcp_ecn=0'],
                 ['sysctl','-w','net.ipv4.tcp_timestamps=0']]:
        log = out / ('namespace-command-' + str(len(records)) + '.log')
        result = command(args, log); records.append(dict(command=args, returncode=result.returncode, log=log.name))
    command(['sysctl','net.ipv4.tcp_ecn','net.ipv4.tcp_timestamps','net.ipv4.tcp_sack',
        'net.ipv4.tcp_window_scaling','net.ipv4.tcp_syn_retries'],out/'sysctl.log')
    command(['tcpdump','--version'],out/'tcpdump-version.log')
    tool = read(out / 'tool-build.json')
    profile = read(ROOT / 'packet-profile.json')
    local, peer = profile['local'], profile['peer']
    packet_command = [tool['binary'],'--ip_version=ipv4','--local_ip='+local['ip'],
        '--remote_ip='+peer['ip'],'--netmask_ip=255.255.255.0','--gateway_ip=192.0.2.254',
        '--bind_port='+str(local['port']),'--connect_port='+str(peer['port']),
        '--tolerance_usecs=50000','--tolerance_percent=12.5',str(out/'test.pkt')]
    # No packet-count cap: observe the complete declared quiet interval. A file barrier
    # keeps the socket open until tcpdump has stopped, excluding tool-exit cleanup only.
    bpf = 'tcp and host '+local['ip']+' and host '+peer['ip']+' and port '+str(local['port'])+' and port '+str(peer['port'])
    capture_command = ['tcpdump','-Z','root','-U','-n','-i','any','-y','LINUX_SLL',
        '-w',str(out/'capture.pcap'),bpf]
    marker=out/'quiet-complete'; release=out/'capture-stopped'
    require(not marker.exists() and not release.exists(),'Use fresh output: old capture barriers are retained')
    context=dict(platform='Linux',kernel=platform.release(),parent_netns=parent,parent_pid=os.getppid(),
        actual_parent_netns=actual_parent,execution_netns=current,commands=records,
        packetdrill_command=packet_command,capture_command=capture_command,
        capture_scope='all_selected_packets_through_scenario_settle_before_socket_cleanup',
        capture_packet_limit=None,scenario_id=scenario,declared_settle_ms=scenario_config(scenario)['settle_ms'],
        packetdrill_tolerance_us=50000,packetdrill_tolerance_percent=12.5,oracle_tolerance_ms=0,host_network_mutations=False)
    executed=None
    with (out/'capture.log').open('w') as capture_log:
        stage(out,'capture_start')
        capture = subprocess.Popen(capture_command,stdout=capture_log,stderr=capture_log)
        try:
            limit = time.monotonic() + 5
            while time.monotonic() < limit and 'listening on' not in (out/'capture.log').read_text():
                require(capture.poll() is None, 'Independent capture failed to start')
                time.sleep(0.02)
            require('listening on' in (out/'capture.log').read_text(), 'Capture readiness timeout')
            context['capture_ready_monotonic_ns']=time.monotonic_ns()
            stage(out,'packetdrill_execution')
            with (out/'execution.log').open('w') as execution_log:
                context['packetdrill_start_monotonic_ns']=time.monotonic_ns()
                executed=subprocess.Popen(packet_command,stdout=execution_log,stderr=execution_log)
                limit=time.monotonic()+20
                while not marker.exists() and executed.poll()is None and time.monotonic()<limit:
                    require(capture.poll()is None,'Independent capture ended before quiet-window completion')
                    time.sleep(0.01)
                complete=marker.exists()
                context['quiet_interval_complete']=complete
                if complete:
                    context['quiet_barrier_epoch_ns']=marker.stat().st_mtime_ns
                    context['quiet_barrier_monotonic_ns']=time.monotonic_ns()
                capture.send_signal(2); code=capture.wait(timeout=5)
                context['capture_exit_monotonic_ns']=time.monotonic_ns()
                # Release only after capture is closed, so socket cleanup cannot race it.
                release.write_text(str(context['capture_exit_monotonic_ns'])+'\n')
                executed.wait(timeout=5)
            context.update(packetdrill_returncode=executed.returncode,capture_returncode=code)
            write(out/'namespace.json',context)
            require(executed.returncode == 0, 'packetdrill execution contract failed')
            require(complete,'Declared quiet-window observation did not finish')
            require(code == 0, 'Independent capture did not complete')
            stage(out,'capture_validation')
            dropped=re.findall(r'(\d+) packets dropped by kernel',(out/'capture.log').read_text())
            require(dropped and int(dropped[-1])==0,'Independent capture reports packet drops')
        finally:
            if capture.poll() is None:
                capture.send_signal(2); capture.wait(timeout=5)
            if executed is not None and executed.poll()is None:
                release.touch(); executed.terminate()
                try:executed.wait(timeout=5)
                except subprocess.TimeoutExpired:executed.kill();executed.wait(timeout=5)


def run(out, scenario='handshake'):
    out.mkdir(parents=True,exist_ok=True)
    before = inputs(); env = preflight()
    write(out/'preflight.json',env)
    write(out/'report.json',dict(status='not_run',preflight=env,linux_execution=False))
    require(env['platform'] == 'Linux' and env['euid'] == 0 and env['tun']
        and all(env['tools'].values()), 'Linux root/TUN/tools required; this channel alone is unavailable')
    stage(out,'reference')
    tool = read(out/'tool-build.json'); pin = read(PORT/'upstream.json')
    require(tool['commit'] == pin['commit'] and not tool['modified_upstream_code'], 'Packetdrill source pin changed')
    require(digest(Path(tool['binary'])) == tool['binary_sha256'], 'Packetdrill binary hash changed')
    for name, sha in tool['file_hashes'].items(): require(digest(out/name) == sha, 'Tool build artifact changed')
    model, machine, expected, base, mapping = reference(out,scenario)
    write(out/'source-validation.json',verify_sources())
    write(out/'trace.json',machine.trace); write(out/'expected.json',expected)
    write(out/'script-map.json',mapping)
    write(out/'driver-policy.json',driver_policy(expected,scenario))
    script = execution_script(base,out,quiet_after_protocol_ms(expected,scenario))
    write(out/'execution-map.json',execution_mapping(base,script,mapping))
    (out/'base-generated.pkt').write_text(base); (out/'test.pkt').write_text(script)
    symbolic = crosscheck_trace(model,machine.trace,out/'symbolic')
    require(symbolic['status'] == 'match', 'Reference independent fixed-query failed')
    parent = os.readlink('/proc/self/ns/net')
    invocation = ['unshare','--net','--',sys.executable,str(PORT/'run.py'),'--inside',parent,'--scenario',scenario,'--out',str(out)]
    stage(out,'namespace_launch')
    child = command(invocation,out/'namespace-driver.log',timeout=40,required=False)
    require(child.returncode == 0, 'Isolated Linux execution failed; logs retained')
    namespace = read(out/'namespace.json'); require_isolation(parent,namespace['execution_netns'])
    stage(out,'observation')
    observed, metadata = normalize(out/'capture.pcap',read(ROOT/'packet-profile.json'),expected,
        origin='external_capture',checksum_policy='strict',projection=projection(scenario))
    validate_observation(expected,observed,scenario)
    window_ms=(namespace['quiet_barrier_epoch_ns']-metadata['time_origin_ns'])/1000000
    require(window_ms>=namespace['declared_settle_ms'],'Quiet observation shorter than source scenario')
    difference = compare(expected,observed,tolerance_ms=0,projection=projection(scenario))
    write(out/'observed.json',observed); write(out/'metadata.json',metadata); write(out/'difference.json',difference)
    require(inputs() == before, 'Linux evidence inputs changed during execution')
    stage(out,'complete')
    names = ['preflight.json','phase.json','tool-build.json','source-validation.json','trace.json','expected.json','script-map.json','driver-policy.json','execution-map.json','base-generated.pkt',
        'test.pkt','namespace-driver.log','namespace.json','execution.log','capture.log','capture.pcap','offload.log',
        'sysctl.log','tcpdump-version.log','namespace-command-0.log','namespace-command-1.log','namespace-command-2.log',
        'quiet-complete','capture-stopped','observed.json','metadata.json','difference.json','symbolic/result.json','symbolic/path.smt2'] + list(tool['file_hashes'])
    result = dict(status='linux_execution_with_projection_'+difference['status'],linux_execution=True,
        host_tcp_stack=True,implementation='Linux kernel TCP',kernel=env['kernel'],projection=projection(scenario),
        oracle_tolerance_ms=0,packetdrill_tolerance_us=50000,packetdrill_tolerance_percent=12.5,scenario_id=scenario,
        loss_mechanism='no peer response to first SYN; observed at egress' if scenario=='syn-loss' else 'none',
        scope=('one four-zero-octet incoming segment; full flags/SEQ/ACK/window/payload/time projection; no application read or internal buffer claim'
            if scenario==receive.CASE else 'one '+scenario+' active-open; options/window/payload not projected')
            +'; declared settle '+str(scenario_config(scenario)['settle_ms'])+'ms',
        observed_window_ms=window_ms,
        model_semantic_sha256=model_hash(model),input_hashes=before,tool_binary_sha256=tool['binary_sha256'],
        execution_output_dir=str(out),
        input_script_sha256=digest(out/'test.pkt'),source_commit=pin['commit'],namespace_invocation=invocation,
        file_hashes={n:digest(out/n) for n in names},upstream_modified=False,full_tcp_complete=False,
        trusted_components=['Linux kernel/toolchain and VM provenance','packetdrill syscall/injection driver',
            'independent tcpdump capture','IR reference/SMT encoder','PCAP parser/normalizer/comparator'],
        integrity_is_not_authenticity=True)
    write(out/'report.json',result); print(result['status'])


if __name__ == '__main__':
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out',type=Path,default=ROOT/'artifacts/linux-netns')
    parser.add_argument('--inside'); parser.add_argument('--execute',action='store_true')
    parser.add_argument('--scenario',choices=SCENARIOS,default='handshake')
    args=parser.parse_args(); out=args.out.resolve()
    require(out.is_relative_to(ROOT/'artifacts'),'Output outside artifacts')
    if args.inside: inside(out,args.inside,args.scenario)
    elif args.execute:
        try: run(out,args.scenario)
        except Exception as error:
            phase=read(out/'phase.json')['phase'] if (out/'phase.json').exists() else 'preflight'
            kind=failure_kind(phase,error)
            write(out/'failure.json',dict(status=kind,phase=phase,error_type=type(error).__name__,error=str(error),
                linux_execution_evidence=False,synthetic_substitution=False))
            raise
    else: print(json.dumps(dict(status='preflight_only_not_linux_evidence',preflight=preflight())))
