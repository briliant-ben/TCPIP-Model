"""Independent finite Limited Transmit observations using the frozen stream driver."""
import argparse
import importlib.util
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
PORT = Path(__file__).resolve().parent
spec = importlib.util.spec_from_file_location('lwip_recovery_stream', ROOT / 'ports/lwip-stream/run.py')
stream = importlib.util.module_from_spec(spec)
spec.loader.exec_module(stream)
# A private module instance shares the transport/evidence machinery, never its
# protocol oracle. No upstream TCP code, packet normalization or comparator changes.
stream.MODEL = ROOT / 'model/tcp-limited-transmit.json'
stream.SCOPE = ('one active connection; <=16 written octets, <=64 peer text octets, '
                '<=64 events, <=200ms; scripted first/second duplicate ACK new-data opportunities; '
                'default model IW4 versus upstream initial-window policy; '
                'no RTO, Linux, internal cwnd observation or general conformance proof')
original_inputs = stream.inputs


def inputs():
    result = original_inputs()
    paths = [*PORT.rglob('*.py'), *PORT.rglob('*.json'), PORT / 'README.md',
             ROOT / 'spec/sources/tcp-limited-transmit.json',
             ROOT / 'docs/tcp-limited-transmit.md']
    result.update({str(p.relative_to(ROOT)): stream.digest(p) for p in paths})
    return result


stream.inputs = inputs


def bound(path):
    path = Path(path).resolve()
    stream.require(path.parent == PORT / 'scenarios' and path.suffix == '.json',
                   'Scenario must be a bound limited-transmit input')
    return path


def run(out, scenario):
    path = bound(scenario)
    # Keep PORT fixed for C build/include/input binding. The stream entry point
    # guards its own directory, so perform equivalent validation here and call
    # its complete implementation directly; classify failures explicitly.
    try:
        return stream._run(out, path)
    except (ValueError, OSError, stream.subprocess.SubprocessError) as error:
        out = Path(out)
        stage = stream.read(out / 'report.json').get('phase', 'input_validation') if (out / 'report.json').exists() else 'input_validation'
        status = {'input_validation': 'unsupported_stimulus', 'source_integrity': 'source_integrity_failure', 'compiler': 'environment_failure', 'reference': 'model_failure', 'symbolic': 'formal_replay_failure', 'execution': 'execution_failure', 'observation': 'observation_invalid', 'input_integrity': 'stale_inputs'}[stage]
        if stage == 'reference' and str(error).startswith('Invariant failed:'):
            status = 'model_invariant_failure'
        if isinstance(error, stream.Uncovered): status = 'model_uncovered'
        if isinstance(error, stream.Conflict): status = 'model_rule_conflict'
        stream.write(out / 'report.json', dict(status=status, phase=stage, error_type=type(error).__name__, error=str(error), linux_execution=False, full_stack_validated=False))
        raise


def verify(out, scenario):
    return stream.verify(out, bound(scenario))


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--scenario', type=Path, default=PORT / 'scenarios/two-opportunities.json')
    parser.add_argument('--out', type=Path, default=ROOT / 'artifacts/lwip-limited-transmit/two-opportunities')
    parser.add_argument('--verify', action='store_true')
    args = parser.parse_args()
    result = verify(args.out, args.scenario) if args.verify else run(args.out, args.scenario)
    print(json.dumps(result if args.verify else {k: result[k] for k in ('status', 'comparison', 'summary')}))
    sys.exit(0 if args.verify or result['comparison'] == 'match' else 1)
