"""Emit finite Limited Transmit JSON AST, never called by the executor."""
import copy
import json
from build_congestion_model import ROOT, v, o, set_, choose, length, both, either, neg, var
from build_fast_recovery_model import replace
from protocol_lab.ir import load


def conditional(action, gate):
    kind, arg = next(iter(action.items()))
    if kind == 'set':
        return set_(arg['var'], choose(gate, arg['value'], v(arg['var'])))
    if kind in ('emit', 'emit_if', 'arm', 'arm_if', 'cancel_if'):
        arg = copy.deepcopy(arg)
        arg['when'] = both(gate, arg.get('when', True))
        return {kind if kind.endswith('_if') else kind + '_if': arg}
    if kind == 'cancel':
        return {'cancel_if': {'when': gate, 'timer': arg}}
    raise ValueError('Unsupported copied data action: ' + kind)


def main():
    parent = load(ROOT / 'model/tcp-idle-restart.json')
    template = next(t for t in parent['transitions'] if t['id'] == 'D-FLUSH-MORE')
    start = next(i for i, a in enumerate(template['actions']) if 'set' in a and a['set']['var'] == 'take')
    end = next(i for i, a in enumerate(template['actions'][start:], start) if 'set' in a and a['set']['var'] == 'snd_nxt')
    core = copy.deepcopy(template['actions'][start:end + 1])
    assert core[0]['set']['var'] == 'take' and core[-1]['set']['var'] == 'snd_nxt'
    assert sum('emit' in a and a['emit']['message'] == 'tcp_data' for a in core) == 1
    assert not any('arm' in a or 'arm_if' in a for a in core), 'Existing-flight send must preserve RTO deadline'
    variables = {n: var(t, x) for n, t, x in [
        ('lt_eligible', 'bool', False), ('lt_emitted', 'bool', False), ('lt_take', 'int', 0),
        ('lt_epoch_bytes', 'int', 0), ('lt_epoch_packets', 'int', 0),
        ('lt_before_bytes', 'int', 0), ('lt_before_cwnd', 'int', 4),
        ('lt_before_nxt', 'seq32', 1000), ('lt_before_flight', 'int', 0),
        ('lt_before_window', 'int', 8), ('lt_loss_flight', 'int', 0)]}
    requirements = {
        'LT-SEND': {'source': 'spec/sources/rfc3042.txt', 'interpretation':
            'January2001 section2 and RFC5681 September2009 section3.2 step1: each of the first two qualifying duplicate ACKs sends at most one SMSS of queued new data when rwnd allows and FlightSize remains <=cwnd+2SMSS. cwnd MUST NOT grow for these sends. No SACK is negotiated in this finite model.',
            'kind': 'normative', 'strength': 'automatic finite duplicate-clocked new data'},
        'LT-THRESHOLD': {'source': 'spec/sources/rfc5681.txt', 'interpretation':
            'Section3.2 step2: exclude actual Limited Transmit bytes of the current no-UNA-advance duplicate epoch from the third-duplicate loss threshold basis. Epoch clears on UNA advance, recovery entry, actual congestion RTO, persist or cleanup. Record the basis explicitly even when queue16/SMSS4 makes both numerical thresholds clamp to 8.',
            'kind': 'normative', 'strength': 'explicit threshold input exclusion'},
        'LT-SOURCE': {'source': 'spec/sources/tcp-limited-transmit.json', 'interpretation':
            'Official RFC3042/RFC5681 texts, versions and sections bound by raw SHA256.',
            'kind': 'modeling_choice', 'strength': 'source provenance'},
        'LT-SCOPE': {'source': 'docs/tcp-limited-transmit.md', 'interpretation':
            'SMSS4/combined queue16, pure accepted non-SACK ACKs. Reuse shared new-data actions, byte timestamps, RTT/Karn and pending ACK cancellation. Existing-flight LT does not restart the RTO deadline. Automatic LT declines an idle interval >current RTO; explicit idle restart remains available. No post-FIN data, SACK/NewReno, general byte/output/timing or implementation proof.',
            'kind': 'modeling_choice', 'strength': 'bounded composition'}}
    amendments = []
    connected = ('ESTABLISHED', 'CLOSE-WAIT', 'FIN-WAIT-1', 'FIN-WAIT-2', 'CLOSING', 'LAST-ACK')
    for t in parent['transitions']:
        pre = [set_('lt_eligible', False), set_('lt_emitted', False), set_('lt_take', 0),
               set_('lt_before_bytes', v('lt_epoch_bytes')), set_('lt_before_cwnd', v('cc_cwnd')),
               set_('lt_before_nxt', v('snd_nxt')), set_('lt_before_flight', length('rtx_buf')),
               set_('lt_before_window', v('snd_wnd')),
               set_('lt_loss_flight', o('sub', length('rtx_buf'), v('lt_epoch_bytes')))]
        amendment = {'id': t['id'], 'prepend_actions': pre, 'add_requirements': list(requirements)}
        edits = []
        for i, action in enumerate(t['actions']):
            if ('set' in action and action['set']['var'] == 'cc_ssthresh'
                    and action['set']['value'].get('op') == 'ite'
                    and action['set']['value']['args'][0] == v('fr_entered')):
                edits.append({'at': i, 'expected': action, 'with': [replace(action, 'fr_before_flight', v('lt_loss_flight'))]})
        assert len(edits) == 1, 'Expected one explicit fast-recovery threshold decision'
        amendment['edit_actions'] = edits
        active = t['to'] in connected
        for case in reversed(t.get('target_cases', [])):
            active = choose(case['when'], case['to'] in connected, active)
        clear = either(neg(active), v('fr_entered'), v('fr_exited'), v('cc_loss'),
                       v('persist_active'), o('eq', length('rtx_buf'), 0),
                       neg(o('eq', v('snd_una'), v('fr_before_una'))))
        post = [set_('lt_epoch_bytes', choose(clear, 0, v('lt_epoch_bytes'))),
                set_('lt_epoch_packets', choose(clear, 0, v('lt_epoch_packets')))]
        if t['event'] == 'net.ack' and 'ACK-VALID' in t['id'] and t['from'] in connected:
            eligible = both(v('fr_duplicate'), o('ge', v('fr_dupacks'), 1), o('le', v('fr_dupacks'), 2),
                neg(v('fr_active')), neg(v('fin_sent')), neg(v('persist_active')),
                o('ge', length('snd_buf'), 1), o('ge', length('rtx_buf'), 1),
                o('ge', o('sub', v('snd_wnd'), length('rtx_buf')), 1),
                o('ge', o('sub', o('add', v('cc_cwnd'), 8), length('rtx_buf')), 1),
                o('le', o('sub', {'clock_ms': True}, v('idle_last_data_ms')), v('rto_ms')))
            amount = o('min', 4, o('min', length('snd_buf'), o('min',
                o('sub', v('snd_wnd'), length('rtx_buf')),
                o('sub', o('add', v('cc_cwnd'), 8), length('rtx_buf')))))
            post += [set_('lt_eligible', eligible), set_('lt_take', choose(v('lt_eligible'), amount, 0))]
            copied = copy.deepcopy(core)
            copied[0] = set_('take', v('lt_take'))
            post.extend(conditional(action, v('lt_eligible')) for action in copied)
            post += [set_('lt_emitted', v('lt_eligible')),
                     set_('lt_epoch_bytes', o('add', v('lt_epoch_bytes'), v('lt_take'))),
                     set_('lt_epoch_packets', o('add', v('lt_epoch_packets'), choose(v('lt_emitted'), 1, 0)))]
        amendment['append_actions'] = post
        amendments.append(amendment)
    inv = [
        {'id': 'LT-INV-EPOCH', 'assert': both(o('ge', v('lt_epoch_bytes'), 0),
            o('le', v('lt_epoch_bytes'), 8), o('le', v('lt_epoch_bytes'), length('rtx_buf')),
            o('ge', v('lt_epoch_packets'), 0), o('le', v('lt_epoch_packets'), 2),
            o('le', v('lt_epoch_packets'), v('fr_dupacks')),
            o('ge', v('lt_epoch_bytes'), v('lt_epoch_packets')),
            o('le', v('lt_epoch_bytes'), o('mul', v('lt_epoch_packets'), 4)),
            o('ge', v('lt_loss_flight'), 0)), 'requirements': ['LT-THRESHOLD']},
        {'id': 'LT-INV-SEND', 'assert': o('implies', v('lt_emitted'), both(
            v('fr_duplicate'), o('ge', v('fr_dupacks'), 1), o('le', v('fr_dupacks'), 2),
            neg(v('fr_active')), neg(v('fin_sent')), o('ge', v('lt_take'), 1), o('le', v('lt_take'), 4),
            o('eq', v('cc_cwnd'), v('lt_before_cwnd')),
            o('eq', length('rtx_buf'), o('add', v('lt_before_flight'), v('lt_take'))),
            o('le', length('rtx_buf'), v('snd_wnd')),
            o('le', length('rtx_buf'), o('add', v('cc_cwnd'), 8)),
            o('eq', v('snd_nxt'), o('seq_add', v('lt_before_nxt'), v('lt_take'))))),
            'requirements': ['LT-SEND']},
        {'id': 'LT-INV-THRESHOLD-BASIS', 'assert': o('implies', v('fr_entered'),
            o('eq', v('lt_loss_flight'), o('sub', v('fr_before_flight'), v('lt_before_bytes')))),
            'requirements': ['LT-THRESHOLD']}]
    raw = dict(ir_version='0.3', semantics=parent['semantics'], extends='tcp-idle-restart.json',
        protocol='tcp-limited-transmit', scope={'terminal_states': [], 'excluded': [
            'complete TCP and general byte/output/timing or implementation refinement proof',
            'SACK/NewReno/ECN and automatic new-data emission on post-third duplicate ACKs',
            'numerically different pre/post exclusion thresholds beyond the finite queue16 capacity']},
        variables=variables, requirements=requirements, amend_transitions=amendments, invariants=inv)
    target = ROOT / 'model/tcp-limited-transmit.json'
    text = json.dumps(raw, indent=2) + '\n'
    if not target.exists() or target.read_text() != text:
        target.write_text(text)


if __name__ == '__main__':
    main()
