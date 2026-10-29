"""A partially credited head plus16 unacked bytes can release19 callback bytes."""
from pathlib import Path
import sys
ROOT = Path(__file__).resolve().parents[3]
sys.path.insert(0, str(ROOT))
from protocol_lab.ir import Machine, ModelError, load
from protocol_lab.flow import write
HERE = Path(__file__).resolve().parent


def steps():
    def s(t, e, **f): return dict(at_ms=t, event=e, fields=f)
    result = [s(0, 'app.connect'), s(10, 'net.synack', seq=9000, ack=1001, window=16),
        s(20, 'app.send', data=[0, 128, 255, 7]), s(21, 'app.transmit'),
        s(21, 'choice.segment', count=4), s(30, 'net.ack', seq=9001, ack=1004, window=16),
        s(31, 'app.send', data=list(range(15))), s(31, 'app.transmit')]
    result += [s(31, 'choice.segment', count=1) for _ in range(15)]
    result += [s(40, 'net.ack', seq=9001, ack=1020, window=16)]
    return result


def replay(model):
    machine = Machine(model, {'cc_initial_window': 16, 'cc_cwnd': 16})
    for step in steps():
        try:
            machine.dispatch(step['event'], step['fields'], step['at_ms'])
        except ModelError as error:
            return machine, dict(status='model_invariant_failure', error=str(error), failed_step=step)
    return machine, dict(status='reference_pass', callback_bytes=machine.values['cb_step_bytes'])


if __name__ == '__main__':
    machine, result = replay(load(ROOT / 'model/tcp-sent-ledger.json'))
    assert result['status'] == 'model_invariant_failure' and 'CB-INV-MASS' in result['error'], result
    assert (machine.values['cb_count'], machine.values['cb_live_total'], machine.values['cb_partial_prefix']) == (16, 19, 3)
    write(HERE / 'old-observation.json', dict(result=result, pre_state=machine.snapshot(),
        initial={'cc_initial_window': 16, 'cc_cwnd': 16}, steps=steps()))
    print('Reachable callback19 rejected by prototype callback<=16 invariant; live19/unacked16/partial3')
