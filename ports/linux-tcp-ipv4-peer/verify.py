"""Recheck a live native transcript without re-executing the subject binary.

Only the final optional fixed-input Z3 check invokes a solver. Captured input is
never repaired; reference matching and peer receipt are separate checks.
"""
import argparse
import hashlib
import json
from pathlib import Path
import sys
ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT));sys.path.insert(0, str(Path(__file__).resolve().parent))
from protocol_lab.ir import load, Machine
from protocol_lab.codegen.execute import commands
from protocol_lab.pipeline.worker import reference_case, compare_case, apply
from protocol_lab.symbolic import crosscheck_trace
from ports.tcp_ipv4_application_port import verify_tcp_peer_events
from ports.tcp_ipv4_probe_support import pcap_records, capture_stats
from probe import verify_capture_final


def formal_trace_for_inputs(model, scene):
    # The pipeline Difference deliberately projects away `before`. Z3's public
    # constrained-trace API needs the original reference execution, including it.
    machine = Machine(model, scene.get('initial', {}))
    for step in scene['steps']:
        apply(machine, step)
    if 'settle_ms' in scene:
        machine.tick(scene['settle_ms'])
    return machine.trace


def verify(model_file, folder, out, formal=False):
    out.mkdir(parents=True, exist_ok=False)
    read = lambda name: json.loads((folder/name).read_text())
    report, ns, session = read('report.json'), read('namespace.json'), read('native/session.json')
    scene, links = read('scenario.json'), read('links.json')
    model = load(model_file)
    if report['error'] is not None or report['secondary_errors']:
        raise ValueError('Live run was not accepted')
    if report['source_hashes_before'] != report['source_hashes_after']:
        raise ValueError('Source changed during live execution')
    if report['source_hashes_before']['model'] != hashlib.sha256(model_file.read_bytes()).hexdigest():
        raise ValueError('Verifier model differs from live model')
    if session['process_starts'] != 1 or session['pid'] != ns['native_pid'] or session['returncode'] != 0:
        raise ValueError('Native continuity/exit invalid')
    data = (folder/'native/native-input.txt').read_text()
    if data != commands(model, scene) or [o['line'] for o in session['operations']] != data.splitlines():
        raise ValueError('Native commands differ from original scenario')
    lines = data.splitlines()
    if lines[0] != 'B' or lines.count('B') != 1 or any(o['pid'] != session['pid'] for o in session['operations']):
        raise ValueError('Subject reset, replay or PID changed')
    rows = [json.loads(line) for line in (folder/'native/native.stdout').read_text().splitlines()]
    end = 0
    for i, operation in enumerate(session['operations']):
        if operation['row_start'] != end or operation['row_end'] <= end or operation['sent_monotonic_ns'] > operation['reply_monotonic_ns']:
            raise ValueError('Native operation boundary invalid')
        end = operation['row_end']
        if end > len(rows) or rows[end-1]['status'] != ('ready' if i == 0 else 'ok'):
            raise ValueError('Native operation did not commit')
    if end != len(rows): raise ValueError('Unbound native output')
    selected = [bytes.fromhex(item['raw']) for item in links]
    if any((folder/item['file']).read_bytes() != raw for item, raw in zip(links, selected)):
        raise ValueError('Raw link file differs from transcript')
    capture = (folder/'capture.pcap').read_bytes()
    if hashlib.sha256(capture).hexdigest() != ns['capture_sha256']:
        raise ValueError('Capture hash changed')
    capture_result = verify_capture_final(pcap_records(capture), selected,
        capture_stats((folder/'capture.log').read_text()), ns['capture_stop_request_wall_ns'])
    expected = reference_case(model, scene)
    difference = compare_case(expected, rows, 0, False)
    (out/'difference.json').write_text(json.dumps(difference, indent=2)+'\n')
    if difference['status'] != 'pass': raise ValueError('Reference/native Difference failed')
    if report['status'] == 'full_tcp_peer_pass':
        if not report['full_TCP_exchange_complete'] or ns['server_returncode'] != 0:
            raise ValueError('Full TCP receipt invalid')
        events = [json.loads(line) for line in (folder/'server/server-events.jsonl').read_text().splitlines()]
        verify_tcp_peer_events(events, closed=True)
    elif report['status'] != 'first_ingress_diagnostic_pass':
        raise ValueError('Unknown live assessment')
    constrained = None
    if formal:
        constrained = crosscheck_trace(model, formal_trace_for_inputs(model, scene), out/'symbolic')
        if constrained['query'] != 'sat' or constrained['status'] != 'match':
            raise ValueError('Actual fixed-input Z3 correspondence did not pass')
    result = dict(status='finite_native_observation_verified', live_status=report['status'],
        native_pid=session['pid'], transitions=len(expected['trace']), capture=capture_result,
        reference_native='pass', fixed_input_Z3='sat_match' if constrained else 'not_run',
        subject_binary_reexecuted=False, all_input_or_compiler_proof=False,
        whole_ipv4_endpoint_complete=False)
    (out/'result.json').write_text(json.dumps(result, indent=2)+'\n')
    return result


if __name__ == '__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--model',type=Path,required=True)
    p.add_argument('--live',type=Path,required=True);p.add_argument('--out',type=Path,required=True)
    p.add_argument('--formal',action='store_true');a=p.parse_args()
    print(json.dumps(verify(a.model,a.live,a.out,a.formal)))
