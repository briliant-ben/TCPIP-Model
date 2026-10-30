"""Independent observations of the finite sender SWS policy."""
import argparse
import importlib.util
import json
from pathlib import Path
import shutil
import sys

ROOT = Path(__file__).resolve().parents[2]
PORT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT))
spec = importlib.util.spec_from_file_location('service_timer_adapter', ROOT / 'ports/lwip-timers/run.py')
timer = importlib.util.module_from_spec(spec); spec.loader.exec_module(timer)
from tools.replay_schedule import replay_schedule

stream = timer.stream
stream.PORT = PORT
stream.MODEL = ROOT / 'model/tcp-sws.json'
stream.SCOPE = ('one active connection; <=16 written bytes, <=64 peer bytes/events, <=12000ms; '
    '1ms public timeout dispatch; exact-source declared send choices; public sent callback time/count; '
    'sender SWS fixed-MSS4 policy; no PUSH/PSH or hidden queue observation; no internal PCB state, upstream change, Linux or general refinement')
require = stream.require
original_receiver = stream.receiver_difference
original_equivalence = stream.query_equivalence


def query_equivalence(original, regenerated):
    answer = original_equivalence(original, regenerated)
    if answer['status'] != 'unsat':
        identity = stream.digest(Path(original))[:16] + '-' + stream.digest(Path(regenerated))[:16]
        out = ROOT / 'artifacts/lwip-sws/query-rechecks' / identity
        out.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(original, out / 'original.smt2')
        shutil.copyfile(regenerated, out / 'regenerated.smt2')
        stream.write(out / 'result.json', dict(answer=answer,
            file_hashes={n: stream.digest(out / n) for n in ['original.smt2', 'regenerated.smt2']},
            checker_source_sha256=stream.digest(ROOT / 'ports/lwip-stream/run.py'),
            scope='inconclusive or differing equivalence; no pass is inferred'))
    return answer


def validate_service_lock(lock):
    require(lock == stream.read(ROOT / 'spec/sources/tcp-sent-ledger.json'), 'Service source lock changed')
    require(lock['implementation']['commit'] == '77dcd25a72509eb83f72b033d219b1d40cd8eb95'
            and lock['implementation']['release'] == 'lwIP2.2.1', 'Service implementation version changed')
    for name, sha in lock['sha256'].items():
        require(stream.digest(ROOT / name) == sha, 'Service primary-source bytes changed')


def validate_sws_lock(lock):
    require(lock == stream.read(ROOT / 'spec/sources/tcp-sws.json'), 'SWS source lock changed')
    require(lock['specification'] == {'rfc': 9293, 'version': 'August2022', 'sections': ['3.7.4', '3.8.6.2.1']}, 'Unsupported SWS specification')
    for name, sha in lock['sha256'].items(): require(stream.digest(ROOT / name) == sha, 'SWS source bytes changed')


def inputs():
    validate_sws_lock(stream.read(PORT / 'sws-sources.json'))
    timer.validate_source_lock(stream.read(PORT / 'sources.json'))
    validate_service_lock(stream.read(PORT / 'service-sources.json'))
    result = timer.original_inputs()
    for name in ['ports/lwip-stream/run.py', 'ports/lwip-timers/run.py', 'tools/replay_schedule.py']:
        result[name] = stream.digest(ROOT / name)
    return result


def validate_summary(summary, scene):
    require(type(summary) is dict and 'sent_events' in summary, 'Missing public sent events')
    timer.validate_summary({k: v for k, v in summary.items() if k != 'sent_events'}, scene)
    events = summary['sent_events']
    require(type(events) is list and len(events) <= 64, 'Invalid sent event list')
    previous = -1
    for event in events:
        require(type(event) is dict and set(event) == {'time_ms', 'bytes'}, 'Invalid sent event shape')
        require(type(event['time_ms']) is int and previous <= event['time_ms'] <= summary['end_ms'], 'Invalid sent event time')
        require(type(event['bytes']) is int and 1 <= event['bytes'] <= 16, 'Invalid sent event bytes')
        previous = event['time_ms']
    require(sum(e['bytes'] for e in events) == summary['acknowledged_bytes'], 'Sent event sum changed')


def reference(model, scene):
    witness = stream.read(PORT / 'witnesses' / (scene['id'] + '.json'))
    machine, _ = replay_schedule(model, scene, witness)
    return machine


def service_difference(trace, summary):
    projection = stream.read(PORT / 'projection.json')
    require(projection == {'trace_variable': 'cb_step_bytes', 'summary_field': 'sent_events',
                           'value_field': 'bytes', 'omit_zero': True}, 'Unsupported service projection')
    expected = []
    for row in trace:
        value = row['after']['variables'][projection['trace_variable']]
        require(type(value) is int and value >= 0, 'Invalid IR service observation')
        if value:
            expected.append({'time_ms': row['time_ms'], projection['value_field']: value})
    actual = summary[projection['summary_field']]
    receiver = original_receiver(trace, summary)
    sent = dict(status='match' if expected == actual else 'mismatch', expected=expected, observed=actual,
                scope='exact callback boundaries, byte credit, order and time; no tolerance')
    return dict(status='match' if receiver['status'] == sent['status'] == 'match' else 'mismatch',
                receiver=receiver, sent=sent, scope='separate unread receive and declared sent-credit service projections')


stream.inputs = inputs
stream.validate_summary = validate_summary
stream.run_scenario = reference
stream.receiver_difference = service_difference
stream.query_equivalence = query_equivalence


def scenario_path(path):
    path = Path(path).resolve()
    require(path.parent == PORT / 'scenarios' and path.suffix == '.json', 'Unbound service scenario path')
    require(stream.read(path)['id'] == path.stem, 'Service scene identity differs from path')
    return path


def run(out, scene):
    return stream.run(out, scenario_path(scene))


def verify(out, scene):
    return stream.verify(out, scenario_path(scene))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--scenario', type=Path, default=PORT / 'scenarios/tiny-override.json')
    parser.add_argument('--out', type=Path, default=ROOT / 'artifacts/lwip-sws/tiny-override')
    parser.add_argument('--verify', action='store_true')
    args = parser.parse_args()
    result = verify(args.out, args.scenario) if args.verify else run(args.out, args.scenario)
    print(json.dumps(result if args.verify else {k: result[k] for k in ['status', 'comparison', 'summary']}))
    sys.exit(0 if args.verify or result['comparison'] == 'match' else 1)
