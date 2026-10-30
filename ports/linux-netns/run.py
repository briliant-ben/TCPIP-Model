"""Linux TCP active-open through packetdrill and independent bounded tcpdump."""
import argparse
import json
import os
from pathlib import Path
import platform
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


def execution_script(base, out):
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
    paths = list(model_files(ROOT / 'model/tcp.json'))
    paths += list((ROOT / 'protocol_lab').glob('*.py'))
    paths += [p for p in PORT.rglob('*') if p.is_file() and '__pycache__' not in p.parts]
    paths += [ROOT / n for n in ['scenarios/handshake.json', 'packet-profile.json',
        'requirements-formal.txt', 'spec/sources/manifest.json', '.github/workflows/linux-tcp.yml']]
    paths += list((ROOT / 'spec/sources').glob('*.txt'))
    return {str(p.relative_to(ROOT)): digest(p) for p in paths}


def reference(out):
    model = load(ROOT / 'model/tcp.json'); scene = read(ROOT / 'scenarios/handshake.json')
    require(scene['id'] == 'handshake' and scene['environment']['drop_outgoing'] == [], 'Unsupported Linux scenario')
    machine = run_scenario(model, scene); expected = normalize_trace(machine, scene)
    require(len(expected) == 3 and [p['flags'] for p in expected] == ['S','SA','A'], 'Only first three-packet active-open supported')
    script, mapping = packetdrill(expected)
    return model, machine, expected, script, mapping


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


def inside(out, parent):
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
        '--tolerance_usecs=50000',str(out/'test.pkt')]
    # The model terminates at ESTABLISHED. Capture stops independently at its three-packet boundary,
    # before tool-exit socket cleanup; unexpected packets within that boundary are not discarded.
    bpf = 'tcp and host '+local['ip']+' and host '+peer['ip']+' and port '+str(local['port'])+' and port '+str(peer['port'])
    capture_command = ['tcpdump','-Z','root','-U','-n','-i','any','-y','LINUX_SLL','-c','3',
        '-w',str(out/'capture.pcap'),bpf]
    with (out/'capture.log').open('w') as capture_log:
        stage(out,'capture_start')
        capture = subprocess.Popen(capture_command,stdout=capture_log,stderr=capture_log)
        try:
            limit = time.monotonic() + 5
            while time.monotonic() < limit and 'listening on' not in (out/'capture.log').read_text():
                require(capture.poll() is None, 'Independent capture failed to start')
                time.sleep(0.02)
            require('listening on' in (out/'capture.log').read_text(), 'Capture readiness timeout')
            stage(out,'packetdrill_execution')
            executed = command(packet_command,out/'execution.log',timeout=20,required=False)
            try: code = capture.wait(timeout=5)
            except subprocess.TimeoutExpired:
                capture.send_signal(2); code = capture.wait(timeout=5)
            write(out/'namespace.json',dict(platform='Linux',kernel=platform.release(),parent_netns=parent,
                parent_pid=os.getppid(),actual_parent_netns=actual_parent,
                execution_netns=current,commands=records,packetdrill_command=packet_command,
                packetdrill_returncode=executed.returncode,capture_command=capture_command,
                capture_returncode=code,capture_scope='first_three_selected_handshake_packets_model_terminal_ESTABLISHED',
                packetdrill_tolerance_us=50000,oracle_tolerance_ms=0,host_network_mutations=False))
            require(executed.returncode == 0, 'packetdrill execution contract failed')
            require(code == 0, 'Independent capture did not complete')
        finally:
            if capture.poll() is None:
                capture.send_signal(2); capture.wait(timeout=5)


def run(out):
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
    model, machine, expected, base, mapping = reference(out)
    write(out/'source-validation.json',verify_sources())
    write(out/'trace.json',machine.trace); write(out/'expected.json',expected)
    write(out/'script-map.json',mapping)
    script = execution_script(base,out)
    write(out/'execution-map.json',execution_mapping(base,script,mapping))
    (out/'base-generated.pkt').write_text(base); (out/'test.pkt').write_text(script)
    symbolic = crosscheck_trace(model,machine.trace,out/'symbolic')
    require(symbolic['status'] == 'match', 'Reference independent fixed-query failed')
    parent = os.readlink('/proc/self/ns/net')
    invocation = ['unshare','--net','--',sys.executable,str(PORT/'run.py'),'--inside',parent,'--out',str(out)]
    stage(out,'namespace_launch')
    child = command(invocation,out/'namespace-driver.log',timeout=40,required=False)
    require(child.returncode == 0, 'Isolated Linux execution failed; logs retained')
    namespace = read(out/'namespace.json'); require_isolation(parent,namespace['execution_netns'])
    stage(out,'observation')
    observed, metadata = normalize(out/'capture.pcap',read(ROOT/'packet-profile.json'),expected,
        origin='external_capture',checksum_policy='strict',projection='active-open-v1')
    require(len(observed) == 3, 'Handshake capture coverage differs')
    difference = compare(expected,observed,tolerance_ms=0,projection='active-open-v1')
    write(out/'observed.json',observed); write(out/'metadata.json',metadata); write(out/'difference.json',difference)
    require(inputs() == before, 'Linux evidence inputs changed during execution')
    stage(out,'complete')
    names = ['preflight.json','phase.json','tool-build.json','source-validation.json','trace.json','expected.json','script-map.json','execution-map.json','base-generated.pkt',
        'test.pkt','namespace-driver.log','namespace.json','execution.log','capture.log','capture.pcap','offload.log',
        'sysctl.log','tcpdump-version.log','namespace-command-0.log','namespace-command-1.log','namespace-command-2.log',
        'observed.json','metadata.json','difference.json','symbolic/result.json','symbolic/path.smt2'] + list(tool['file_hashes'])
    result = dict(status='linux_execution_with_projection_'+difference['status'],linux_execution=True,
        host_tcp_stack=True,implementation='Linux kernel TCP',kernel=env['kernel'],projection='active-open-v1',
        oracle_tolerance_ms=0,packetdrill_tolerance_us=50000,scope='one active-open terminal handshake; options/window/payload not projected',
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
    args=parser.parse_args(); out=args.out.resolve()
    require(out.is_relative_to(ROOT/'artifacts'),'Output outside artifacts')
    if args.inside: inside(out,args.inside)
    elif args.execute:
        try: run(out)
        except Exception as error:
            phase=read(out/'phase.json')['phase'] if (out/'phase.json').exists() else 'preflight'
            kind='invalid_capture_evidence' if phase=='observation' else (
                'linux_execution_attempt_failed' if phase=='packetdrill_execution' else 'environment_or_setup_failure')
            write(out/'failure.json',dict(status=kind,phase=phase,error_type=type(error).__name__,error=str(error),
                linux_execution_evidence=False,synthetic_substitution=False))
            raise
    else: print(json.dumps(dict(status='preflight_only_not_linux_evidence',preflight=preflight())))
