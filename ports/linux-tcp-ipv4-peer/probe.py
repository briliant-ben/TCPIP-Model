#!/usr/bin/env python3
"""First-TCP-ingress diagnostic for generated C subject using isolated Linux peer."""
import argparse
import fcntl
import hashlib
import json
import os
from pathlib import Path
import select
import shutil
import struct
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[2]
PORT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(PORT))

from ports.native_session import Session
from ports.tcp_ipv4_probe_support import elapsed_ms, capture_stats, pcap_records, quiet_ok, operation_result, record_error
from protocol_lab.ir import load
from protocol_lab.codegen.execute import commands

TAP_NAME = 'tap0'
SUBJECT_IP = '192.0.2.1'
PEER_IP = '192.0.2.2'
PEER_MAC = '02:00:00:00:00:02'
PEER_PORT = 8080
SERVER_COUNT = 4
QUIET_MS = 100
OVERALL_TIMEOUT_S = 10
QUIET_TIMEOUT_S = 5


def sha256_file(path):
    h = hashlib.sha256()
    with open(path, 'rb') as f:
        for chunk in iter(lambda: f.read(65536), b''):
            h.update(chunk)
    return h.hexdigest()


def run_command(args, out, name):
    p = subprocess.run(args, capture_output=True, text=True, timeout=10)
    (out / name).write_text(p.stdout + p.stderr)
    if p.returncode != 0:
        raise RuntimeError(f"Command failed: {args}")
    return {'command': args, 'returncode': p.returncode, 'log': name}


def preflight(parent_netns):
    if not (sys.platform.startswith('linux') and os.geteuid() == 0):
        raise RuntimeError('Linux root required')
    if not Path('/dev/net/tun').exists():
        raise RuntimeError('/dev/net/tun missing')
    tools = {name: shutil.which(name) for name in ('ip', 'tcpdump')}
    missing = [name for name, path in tools.items() if not path]
    if missing:
        raise RuntimeError(f'Missing tools: {missing}')
    current = os.readlink('/proc/self/ns/net')
    if not current.startswith('net:[') or not parent_netns.startswith('net:[') or current == parent_netns:
        raise RuntimeError('Distinct network namespace required')
    return tools


def configure_peer(tap_fd, out_dir):
    mac = PEER_MAC
    setup_commands = [
        ['ip', 'link', 'set', 'lo', 'up'],
        ['ip', 'link', 'set', TAP_NAME, 'address', mac],
        ['ip', 'addr', 'add', PEER_IP + '/24', 'dev', TAP_NAME],
        ['ip', 'link', 'set', TAP_NAME, 'mtu', '1500', 'up'],
    ]
    return [run_command(cmd, out_dir, f'setup-{i}.log')
            for i, cmd in enumerate(setup_commands)]


def start_server(out_dir):
    server_out = out_dir / 'server'
    server_out.mkdir()
    with (server_out/'stdout.log').open('wb') as stdout, (server_out/'stderr.log').open('wb') as stderr:
        server = subprocess.Popen([sys.executable, str(ROOT/'ports/linux-tcp-wire-peer/server.py'),
            '--out', str(server_out), '--ip', PEER_IP, '--port', str(PEER_PORT), '--count', str(SERVER_COUNT)],
            stdin=subprocess.PIPE, stdout=stdout, stderr=stderr)
    try:
        deadline = time.monotonic() + 5
        events_file = server_out/'server-events.jsonl'
        while time.monotonic() < deadline:
            if server.poll() is not None:
                raise RuntimeError('Server exited before listening')
            if events_file.exists():
                lines = events_file.read_text().splitlines()
                try:
                    if any(json.loads(line).get('event') == 'listening' for line in lines):
                        return server
                except json.JSONDecodeError:
                    pass
            time.sleep(0.02)
        raise RuntimeError('Server readiness timeout')
    except Exception:
        if server.poll() is None:
            server.kill(); server.wait(timeout=5)
        server.stdin.close()
        raise


def start_capture(out_dir):
    log = (out_dir/'capture.log').open('w')
    capture = None
    try:
        capture = subprocess.Popen(['tcpdump', '--immediate-mode', '-Z', 'root', '-U', '-n', '-s', '65535',
            '-i', TAP_NAME, '-w', str(out_dir/'capture.pcap'), 'arp or ip'], stdout=log, stderr=log)
        deadline = time.monotonic() + 5
        while time.monotonic() < deadline:
            if capture.poll() is not None:
                raise RuntimeError('tcpdump failed to start')
            if 'listening on' in (out_dir/'capture.log').read_text():
                return capture, log
            time.sleep(0.02)
        raise RuntimeError('tcpdump readiness timeout')
    except Exception:
        if capture is not None and capture.poll() is None:
            capture.kill(); capture.wait(timeout=5)
        log.close()
        raise


def is_tcp_ipv4(raw):
    if len(raw) < 14 + 20:
        return False
    if raw[12:14] != b'\x08\x00':
        return False
    return raw[23] == 6  # IP protocol TCP


def save_raw_frame(raw, direction, index, out_dir, subdir='links'):
    d = out_dir / subdir
    d.mkdir(exist_ok=True)
    filename = f'{direction}-{index:04d}.raw'
    path = d / filename
    path.write_bytes(raw)
    return str(path.relative_to(out_dir))


def process_model_operation(rows, tap_fd, origin, out_dir, links, services, logger):
    """Process operation_result and write emitted frames to TAP."""
    result = operation_result(rows)
    if result['status'] == 'error':
        return result
    for frame in result['frames']:
        raw = bytes(frame)
        path = save_raw_frame(raw, 'egress', len(links), out_dir)
        links.append({'direction': 'egress', 'file': path, 'raw': raw.hex(), 'monotonic_ns': time.monotonic_ns()})
        if os.write(tap_fd, raw) != len(raw):
            raise RuntimeError('Incomplete TAP write')
    services.extend(result['services'])
    return result


def read_tap_frame(fd, out_dir, index, processing, observations):
    raw = os.read(fd, 65535)
    stamp = time.monotonic_ns()
    if len(raw) < 14:
        save_raw_frame(raw, 'short', index, out_dir, 'invalid')
        raise RuntimeError('Short frame from TAP')
    ethertype = raw[12:14]
    if ethertype not in (b'\x08\x06', b'\x08\x00'):
        path = save_raw_frame(raw, 'unselected', len(observations), out_dir, 'unselected')
        observations.append({'file': path, 'ethertype': ethertype.hex()})
        return None, stamp
    # Selected frame: always save as ingress and return frame_info
    path = save_raw_frame(raw, 'ingress', index, out_dir)
    frame_info = {'raw': raw, 'file': path, 'monotonic_ns': stamp}
    if not processing:
        # Late observation, still include in selected links but mark not fed
        frame_info['fed'] = False
    else:
        frame_info['fed'] = True
    return frame_info, stamp


def verify_capture_final(records, selected_raw, stats, stop_request_wall_ns, quiet_ms=100):
    """Validate final capture consistency and quiet period."""
    if not isinstance(records, list) or not records:
        raise ValueError("records must be non-empty list")
    for rec in records:
        if not isinstance(rec, dict) or 'timestamp_ns' not in rec or 'raw' not in rec:
            raise ValueError("records must be dicts with timestamp_ns and raw")
        if not type(rec['timestamp_ns']) is int:
            raise ValueError("timestamp_ns must be int")
        if not isinstance(rec['raw'], bytes):
            raise ValueError("raw must be bytes")
        if len(rec['raw']) < 14:
            raise ValueError("record raw too short")
        ethertype = rec['raw'][12:14]
        if ethertype not in (b'\x08\x06', b'\x08\x00'):
            raise ValueError("record with unexpected ethertype")
    if not selected_raw:
        raise ValueError("selected_raw must not be empty")
    if not all(isinstance(x, bytes) for x in selected_raw):
        raise ValueError("selected_raw must be list of bytes")
    if not isinstance(stats, dict) or 'captured' not in stats or 'received' not in stats or 'dropped' not in stats:
        raise ValueError("stats missing keys")
    if not all(type(stats[k]) is int for k in ('captured', 'received', 'dropped')):
        raise ValueError("stats values must be ints")
    if any(stats[k] < 0 for k in ('captured', 'received', 'dropped')):
        raise ValueError('Negative capture statistics')
    if stats['dropped'] != 0:
        raise RuntimeError("tcpdump dropped packets")
    if stats['captured'] != len(records):
        raise RuntimeError(f"stats captured {stats['captured']} but records {len(records)}")
    if len(selected_raw) != len(records):
        raise RuntimeError("selected_raw count does not match records count")
    for i, (sel, rec) in enumerate(zip(selected_raw, records)):
        if sel != rec['raw']:
            raise RuntimeError(f"selected_raw mismatch at index {i}")
    if not quiet_ok(records, stop_request_wall_ns, quiet_ms):
        raise RuntimeError("quiet period not satisfied")
    return {"selected_count": len(selected_raw), "record_count": len(records),
            "captured": stats['captured'], "received": stats['received'], "dropped": stats['dropped']}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--out', type=Path, required=True)
    parser.add_argument('--model', type=Path, required=True)
    parser.add_argument('--executable', type=Path, required=True)
    parser.add_argument('--parent-netns', required=True)
    args = parser.parse_args()
    out = args.out.resolve()
    out.mkdir(parents=True, exist_ok=False)
    report = dict(status='not_run', error=None, secondary_errors=[],
                  first_ingress_admitted=False, full_TCP_exchange_complete=False,
                  whole_ipv4_endpoint_complete=False, physical_ethernet=False)
    actor = capture = server = cap_log = fd = None
    origin = None
    links, observations, services, operations = [], [], [], []
    scene = dict(scenario_version='0.2', id='live-composed-first-tcp-ingress', initial={}, steps=[])
    ns = dict(kernel=os.uname().release, parent=args.parent_netns, commands=[])
    paths = dict(model=args.model.resolve(), executable=args.executable.resolve(),
                 helper=ROOT/'ports/tcp_ipv4_probe_support.py', probe=Path(__file__).resolve(),
                 session=ROOT/'ports/native_session.py', server=ROOT/'ports/linux-tcp-wire-peer/server.py',
                 abi=ROOT/'protocol_lab/codegen/execute.py', reference=ROOT/'protocol_lab/ir.py')
    initial_hashes = {}
    preflight_complete = False
    stopped = False

    def fail(category, error):
        record_error(report, category, str(error))

    def alive():
        if any(p is None or p.poll() is not None for p in (capture, server, actor.process)):
            raise RuntimeError('Capture, peer and subject must remain alive until capture stop request')

    def receive(processing):
        info, stamp = read_tap_frame(fd, out, len(links), processing, observations)
        if info is None:
            return None
        raw = info['raw']
        links.append(dict(direction='ingress', file=info['file'], raw=raw.hex(),
                          monotonic_ns=stamp, fed=processing))
        return raw

    def operation(step):
        step = dict(step, at_ms=elapsed_ms(origin, time.monotonic_ns()))
        line = commands(model, dict(initial={}, steps=[step])).splitlines()[1]
        scene['steps'].append(step)
        rows = actor.operation(line)
        operations.append(dict(line=line, step=step, pid=actor.process.pid,
                               row_end=len(actor.rows), snapshot=actor.snapshot))
        result = process_model_operation(rows, fd, origin, out, links, services, operations)
        if result['status'] == 'error':
            fail(result['category'], result['failure'])
        return result

    def stop_capture():
        nonlocal stopped
        if capture is None or stopped:
            return
        stopped = True
        if capture.poll() is not None:
            fail('capture_invalid', 'Capture exited before stop request')
            return
        try:
            alive()
        except Exception as error:
            fail('capture_invalid', error)
        ns['capture_stop_request_monotonic_ns'] = time.monotonic_ns()
        ns['capture_stop_request_wall_ns'] = time.time_ns()
        capture.send_signal(2)
        try:
            code = capture.wait(timeout=5)
        except subprocess.TimeoutExpired:
            capture.kill()
            code = capture.wait(timeout=5)
            fail('capture_invalid', 'Capture failed to stop after SIGINT; killed')
        ns['capture_returncode'] = code
        ns['capture_stopped_monotonic_ns'] = time.monotonic_ns()
        if code != 0:
            fail('capture_invalid', 'Capture nonzero exit: ' + str(code))

    try:
        tools = preflight(args.parent_netns)
        ns['execution_netns'] = os.readlink('/proc/self/ns/net')
        ns['actual_parent_netns'] = os.readlink('/proc/' + str(os.getppid()) + '/ns/net')
        if ns['actual_parent_netns'] != args.parent_netns:
            raise RuntimeError('Actual parent namespace differs from supplied proof')
        initial_hashes = {name: sha256_file(path) for name, path in paths.items()}
        report['source_hashes_before'] = initial_hashes
        for name, path in tools.items():
            version_args = ['-V'] if name == 'ip' else ['--version']
            ns.setdefault('tools', {})[name] = dict(path=path, sha256=sha256_file(Path(path).resolve()),
                result=run_command([path] + version_args, out, 'version-' + name + '.log'))
        preflight_complete = True
        fd = os.open('/dev/net/tun', os.O_RDWR)
        fcntl.ioctl(fd, 0x400454CA, struct.pack('16sH22x', TAP_NAME.encode(), 0x1002))
        ns['commands'] = configure_peer(fd, out)
        server = start_server(out)
        capture, cap_log = start_capture(out)
        model = load(args.model)
        actor = Session(args.executable.resolve(), out/'native')
        origin = time.monotonic_ns()
        ns.update(clock_origin_monotonic_ns=origin, native_pid=actor.process.pid)
        operation(dict(event='T.app.connect', fields={}))
        deadline = time.monotonic() + OVERALL_TIMEOUT_S
        while report['error'] is None and not report['first_ingress_admitted']:
            alive()
            if time.monotonic() >= deadline:
                fail('driver_failure', 'Timeout before first TCP ingress')
                break
            timers = actor.snapshot['timers']
            now = elapsed_ms(origin, time.monotonic_ns())
            if timers and min(timers.values()) <= now:
                operation(dict(tick=True))
                continue
            timeout = min(0.05, max(0, deadline-time.monotonic()))
            if timers:
                timeout = min(timeout, max(0, (min(timers.values())-now)/1000))
            if fd in select.select([fd], [], [], timeout)[0]:
                raw = receive(True)
                if raw is not None:
                    result = operation(dict(event='net.frame', fields=dict(frame=list(raw))))
                    if result['status'] == 'ok' and is_tcp_ipv4(raw):
                        report['first_ingress_admitted'] = True
        # A model rejection still receives a complete, independently validated
        # observation window. Late frames are retained, never fed or rewritten.
        quiet_limit = time.monotonic() + QUIET_TIMEOUT_S
        while True:
            alive()
            if time.monotonic() >= quiet_limit:
                fail('capture_invalid', 'Bounded quiet observation timed out')
                break
            if fd in select.select([fd], [], [], 0.01)[0]:
                receive(False)
            try:
                records = pcap_records((out/'capture.pcap').read_bytes())
            except (ValueError, FileNotFoundError):
                continue  # A live writer may not have flushed a complete record.
            alive()
            if quiet_ok(records, time.time_ns(), QUIET_MS):
                break
        stop_capture()
        if cap_log:
            cap_log.close()
            cap_log = None
        try:
            records = pcap_records((out/'capture.pcap').read_bytes())
            stats = capture_stats((out/'capture.log').read_text())
            ns['capture_validation'] = verify_capture_final(records,
                [bytes.fromhex(item['raw']) for item in links], stats,
                ns['capture_stop_request_wall_ns'], QUIET_MS)
            ns['capture_sha256'] = sha256_file(out/'capture.pcap')
        except (ValueError, RuntimeError, OSError) as error:
            fail('capture_invalid', error)
    except Exception as error:
        # Preserve earlier model_gap/conflict/invariant as primary error.
        fail('blocked_preflight' if not preflight_complete else 'driver_failure', error)
    finally:
        # Each cleanup is bounded; final outcome is computed only afterwards.
        try:
            stop_capture()
        except Exception as error:
            fail('cleanup_failure', 'capture: ' + str(error))
            if capture is not None and capture.poll() is None:
                try:
                    capture.kill(); capture.wait(timeout=5)
                except Exception as kill_error:
                    fail('cleanup_failure', 'capture kill: ' + str(kill_error))
        if cap_log is not None:
            try:
                cap_log.close()
            except Exception as error:
                fail('cleanup_failure', 'capture log: ' + str(error))
        if server is not None:
            try:
                # This diagnostic intentionally stops before the data exchange;
                # terminate the waiting peer only after independent capture ends.
                if server.poll() is None:
                    server.terminate()
                    try:
                        server.wait(timeout=2)
                    except subprocess.TimeoutExpired:
                        server.kill(); server.wait(timeout=2)
                if server.stdin:
                    server.stdin.close()
                ns['server_returncode'] = server.returncode
                ns['server_termination'] = 'diagnostic-stop-after-capture'
            except Exception as error:
                fail('cleanup_failure', 'server: ' + str(error))
        if actor is not None:
            try:
                ns['native_returncode'] = actor.close()
                if ns['native_returncode'] != 0:
                    fail('driver_failure', 'Native exit was not zero')
                session = json.loads((out/'native/session.json').read_text())
                if session['process_starts'] != 1 or session['pid'] != actor.process.pid:
                    fail('driver_failure', 'Native process continuity failed')
                ns['session_sha256'] = sha256_file(out/'native/session.json')
            except Exception as error:
                fail('cleanup_failure', 'native: ' + str(error))
        if fd is not None:
            try:
                os.close(fd)
            except Exception as error:
                fail('cleanup_failure', 'TAP: ' + str(error))
        try:
            if initial_hashes:
                final = {name: sha256_file(path) for name, path in paths.items()}
                report['source_hashes_after'] = final
                if final != initial_hashes:
                    fail('driver_failure', 'Source changed during diagnostic')
            for name, data in [('links', links), ('observations', observations),
                               ('services', services), ('operations', operations),
                               ('scenario', scene), ('namespace', ns)]:
                (out/(name+'.json')).write_text(json.dumps(data, indent=2)+'\n')
            report['status'] = 'first_ingress_diagnostic_pass' if (report['error'] is None
                and not report['secondary_errors'] and report['first_ingress_admitted']) else 'failed_or_blocked'
            (out/'report.json').write_text(json.dumps(report, indent=2)+'\n')
        except Exception as error:
            fail('driver_failure', 'Final evidence: '+str(error))
            report['status'] = 'failed_or_blocked'
            (out/'report.json').write_text(json.dumps(report, indent=2)+'\n')
    return 0 if report['status'] == 'first_ingress_diagnostic_pass' else 1


if __name__ == '__main__':
    sys.exit(main())
