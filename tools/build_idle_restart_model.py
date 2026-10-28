"""Generate RFC5681 idle restart as explicit IR; never used at runtime."""
import json
from build_congestion_model import ROOT, v, o, set_, choose, length, both, neg, var
from build_fast_recovery_model import replace
from protocol_lab.ir import load


def main():
    parent = load(ROOT / 'model/tcp-fast-recovery.json')
    variables = {n: var(t, x) for n, t, x in [
        ('idle_data_valid', 'bool', False), ('idle_last_data_ms', 'int', 0),
        ('idle_event_ms', 'int', 0), ('idle_data_emitted', 'bool', False),
        ('idle_restart', 'bool', False), ('idle_elapsed_ms', 'int', 0),
        ('idle_before_cwnd', 'int', 4), ('idle_before_rto', 'int', 1000),
        ('idle_before_threshold', 'int', 16), ('idle_restart_count', 'int', 0)]}
    requirements = {
        'IDLE-RESTART': {'source': 'spec/sources/rfc5681.txt', 'interpretation':
            'September2009 section4.1: SHOULD reduce cwnd to no more than RW=min(IW,cwnd) before transmission when no data sent for an interval strictly exceeding RTO. Apply the exact RW on an explicit queued new-data transmit opportunity, including blocked attempts; clear accumulated CA credit conservatively. Preserve ssthresh. Receive requests and ACKs do not refresh the data-send clock.',
            'kind': 'normative', 'strength': 'finite idle restart before new-data scheduling'},
        'IDLE-HISTORY': {'source': 'docs/tcp-idle-restart.md', 'interpretation':
            'Record only actual nonempty tcp_data emissions at their IR emission point: new data, fast/timeout retransmit and zero-window probes. Pure ACK, SYN, FIN-only, app.send, blocked transmit and clock advance do not refresh. First data has no prior data-send history; connection cleanup clears validity. No host callbacks.',
            'kind': 'modeling_choice', 'strength': 'explicit data-output clock'},
        'IDLE-SOURCE': {'source': 'spec/sources/tcp-idle-restart.json', 'interpretation':
            'Module-local RFC5681 version, sections and raw-byte SHA binding.',
            'kind': 'modeling_choice', 'strength': 'source provenance'},
        'IDLE-SCOPE': {'source': 'docs/tcp-idle-restart.md', 'interpretation':
            'Finite SMSS4/queue16 overlay. Shared current RTO and sequence/history semantics; no independent idle timer, configurable enable switch or automatic transmit. Not RFC7661 congestion-window validation, limited transmit, NewReno/SACK, complete TCP or implementation proof.',
            'kind': 'modeling_choice', 'strength': 'explicit scope'}}
    amendments = []
    connected = ('ESTABLISHED', 'CLOSE-WAIT', 'FIN-WAIT-1', 'FIN-WAIT-2', 'CLOSING', 'LAST-ACK')
    for t in parent['transitions']:
        elapsed = o('sub', {'clock_ms': True}, v('idle_last_data_ms'))
        due = both(v('idle_data_valid'), neg(v('fin_sent')), o('ge', length('snd_buf'), 1),
                   o('lt', v('rto_ms'), elapsed)) if t['event'] == 'app.transmit' else False
        effective = choose(due, o('min', v('cc_initial_window'), v('cc_cwnd')), v('cc_cwnd'))
        pre = [set_('idle_event_ms', {'clock_ms': True}), set_('idle_data_emitted', False),
               set_('idle_elapsed_ms', choose(v('idle_data_valid'), elapsed, 0)),
               set_('idle_before_cwnd', v('cc_cwnd')), set_('idle_before_rto', v('rto_ms')),
               set_('idle_before_threshold', v('cc_ssthresh')), set_('idle_restart', due),
               set_('cc_cwnd', choose(v('idle_restart'), o('min', v('cc_initial_window'), v('cc_cwnd')), v('cc_cwnd'))),
               set_('cc_ca_credit', choose(v('idle_restart'), 0, v('cc_ca_credit'))),
               set_('idle_restart_count', o('add', v('idle_restart_count'), choose(v('idle_restart'), 1, 0)))]
        a = {'id': t['id'], 'prepend_actions': pre, 'add_requirements': list(requirements)}
        if t['event'] == 'app.transmit':
            # Rule selection occurs before actions. All complementary guards
            # must use the same effective window as the following actions.
            a['guard'] = replace(t['guard'], 'cc_cwnd', effective)
        edits = []
        for i, old in enumerate(t['actions']):
            kind = next(iter(old))
            if kind not in ('emit', 'emit_if') or old[kind]['message'] != 'tcp_data':
                continue
            arg = old[kind]
            sent = both(arg.get('when', True), o('ge', o('bytes_len', arg['fields']['payload']), 1))
            edits.append({'at': i, 'expected': old, 'with': [old,
                set_('idle_last_data_ms', choose(sent, {'clock_ms': True}, v('idle_last_data_ms'))),
                set_('idle_data_valid', o('or', v('idle_data_valid'), sent)),
                set_('idle_data_emitted', o('or', v('idle_data_emitted'), sent))]})
        if edits:
            a['edit_actions'] = list(reversed(edits))
        active = t['to'] in connected
        for case in reversed(t.get('target_cases', [])):
            active = choose(case['when'], case['to'] in connected, active)
        a['append_actions'] = [set_('idle_data_valid', choose(active, v('idle_data_valid'), False))]
        if t['from'] == 'CLOSED':
            a['append_actions'].append(set_('idle_restart_count', 0))
        amendments.append(a)
    inv = [
        {'id': 'IDLE-INV-CLOCK', 'assert': both(o('ge', v('idle_last_data_ms'), 0),
            o('le', v('idle_last_data_ms'), v('idle_event_ms')), o('le', v('idle_event_ms'), {'clock_ms': True}),
            o('ge', v('idle_elapsed_ms'), 0), o('ge', v('idle_restart_count'), 0)),
            'requirements': ['IDLE-HISTORY']},
        {'id': 'IDLE-INV-OUTPUT-STAMP', 'assert': o('implies', v('idle_data_emitted'),
            o('eq', v('idle_last_data_ms'), v('idle_event_ms'))), 'requirements': ['IDLE-HISTORY']},
        {'id': 'IDLE-INV-RESTART', 'assert': o('implies', v('idle_restart'), both(
            o('lt', v('idle_before_rto'), v('idle_elapsed_ms')),
            o('eq', v('cc_cwnd'), o('min', v('cc_initial_window'), v('idle_before_cwnd'))),
            o('eq', v('cc_ssthresh'), v('idle_before_threshold')), o('eq', v('cc_ca_credit'), 0))),
            'requirements': ['IDLE-RESTART']}]
    raw = dict(ir_version='0.3', semantics=parent['semantics'], extends='tcp-fast-recovery.json',
        protocol='tcp-idle-restart', scope={'terminal_states': [], 'excluded': [
            'complete TCP and general content/output/timing or implementation refinement proof',
            'limited transmit, NewReno/SACK/ECN and RFC7661 window validation']},
        variables=variables, requirements=requirements, amend_transitions=amendments, invariants=inv)
    target = ROOT / 'model/tcp-idle-restart.json'
    text = json.dumps(raw, indent=2) + '\n'
    if not target.exists() or target.read_text() != text:
        target.write_text(text)


if __name__ == '__main__':
    main()
