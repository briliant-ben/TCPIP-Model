"""Explicit zero-time output opportunities; all TCP state changes remain IR."""
import copy
import json
from build_congestion_model import ROOT, v, o, set_, choose, both, either, var
from protocol_lab.ir import load


def main():
    parent = load(ROOT / 'model/tcp-segment-choice.json')
    requirements = {
        'SCHED-OPPORTUNITY': {'source': 'spec/sources/rfc9293.txt', 'interpretation':
            'August2022 sections3.7/3.9.1.2: byte-stream application calls do not dictate packet boundaries. This explicit finite policy treats a public transmit request as a zero-time scheduling opportunity, with no mandatory data output in the public step itself. Positive count choices use the existing data actions and budgets.',
            'kind': 'modeling_choice', 'strength': 'finite input/output scheduling interpretation'},
        'SCHED-ACK': {'source': 'spec/sources/rfc9293.txt', 'interpretation':
            'Section3.10.7.4: after the existing valid pure-ACK processing, queued output may become possible. Only declared ACK-VALID rules grant this policy opportunity; invalid/future ACKs do not. Existing automatic LT/fast/control output is retained, not synthesized by the witness checker.',
            'kind': 'modeling_choice', 'strength': 'declared accepted-ACK opportunity'},
        'SCHED-SOURCE': {'source': 'spec/sources/tcp-output-schedule.json', 'interpretation':
            'Pinned RFC version, selected sections and raw SHA for this bounded relation.',
            'kind': 'modeling_choice', 'strength': 'source provenance'},
        'SCHED-SERVICE': {'source': 'docs/tcp-output-schedule.md', 'interpretation':
            'Explicit lifetime application-byte accounting: accepted writes, cumulative data ACK credit and abandoned queued bytes conserve accepted=acked+abandoned+send queue+retransmit queue. Public callbacks are compared only within a declared callback granularity scope, not as internal TCP state observations.',
            'kind': 'modeling_choice', 'strength': 'declarative service projection counters'},
        'SCHED-SCOPE': {'source': 'docs/tcp-output-schedule.md', 'interpretation':
            'Explicit choice events must occur at the granting event time. Every original source step is consumed once in order by a separate generic witness checker. A matching candidate establishes only finite same-input wire/final-state correspondence under this policy, not actual hidden implementation call causality, Nagle/SWS, timing-policy or universal refinement.',
            'kind': 'modeling_choice', 'strength': 'finite alignment scope'}}
    variables = {n: var(t, value) for n, t, value in [
        ('sched_open', 'bool', False), ('sched_at_ms', 'int', 0),
        ('sched_cause', 'int', 0), ('sched_bytes', 'int', 0), ('sched_packets', 'int', 0)]}
    variables.update({name: var('int', 0) for name in ['svc_before_total', 'svc_accept_step',
        'svc_ack_step', 'svc_drop_step', 'svc_written_bytes', 'svc_acked_bytes', 'svc_abandoned_bytes']})
    amendments = []
    for t in parent['transitions']:
        a = {'id': t['id'], 'add_requirements': list(requirements)}
        total = o('add', o('bytes_len', v('snd_buf')), o('bytes_len', v('rtx_buf')))
        service_pre = [set_('svc_before_total', total)]
        if t['event'] == 'choice.segment':
            a['prepend_actions'] = service_pre
            a['and_guard'] = both(v('sched_open'), o('eq', {'clock_ms': True}, v('sched_at_ms')))
            a['append_actions'] = [set_('sched_bytes', o('add', v('sched_bytes'), {'event': 'count'})),
                                   set_('sched_packets', o('add', v('sched_packets'), 1))]
        else:
            pre = service_pre + [set_('sched_open', False), set_('sched_cause', 0),
                   set_('sched_bytes', 0), set_('sched_packets', 0)]
            grant = t['event'] == 'app.transmit' or (t['event'] == 'net.ack' and 'ACK-VALID' in t['id'])
            post = [set_('sched_open', True), set_('sched_cause', 1 if t['event'] == 'app.transmit' else 2),
                    set_('sched_at_ms', {'clock_ms': True})] if grant else []
            indices = [i for i, action in enumerate(t['actions'])
                       if 'set' in action and action['set']['var'] == 'take']
            if t['event'] == 'app.transmit' and indices:
                assert len(indices) == 1
                prefix = copy.deepcopy(t['actions'][:indices[0]])
                assert all(set(action) == {'set'} for action in prefix), 'Non-assignment prefix needs explicit semantics'
                # A flush grants an opportunity; the actual choice performs
                # idle restart. Executing it here too would shrink twice and
                # increment the restart counter for one real send twice.
                idle = [action for action in prefix if action['set']['var'] == 'idle_restart']
                assert len(idle) == 1, 'Expected one explicit idle restart decision'
                idle[0]['set']['value'] = False
                # Retain other metadata initialization, not a send effect or
                # an unconditional FIRST-send timer arm without actual bytes.
                replacement = pre + prefix + [set_('take', 0)] + post
                a['edit_actions'] = [{'at': 0, 'expected': t['actions'][0], 'with': replacement}]
                a['edit_actions'] += [{'at': len(replacement), 'expected': action, 'with': []}
                                     for action in t['actions'][1:]]
            else:
                a['prepend_actions'] = pre
                a['append_actions'] = post
        accepted = o('sub', total, v('svc_before_total'))
        dropped = o('sub', o('sub', o('add', v('svc_before_total'), v('svc_accept_step')), v('svc_ack_step')), total)
        account = [set_('svc_accept_step', choose(o('ge', accepted, 0), accepted, 0) if t['event'] == 'app.send' else 0),
                   set_('svc_ack_step', v('cc_acked')),
                   set_('svc_drop_step', choose(o('ge', dropped, 0), dropped, 0)),
                   set_('svc_written_bytes', o('add', v('svc_written_bytes'), v('svc_accept_step'))),
                   set_('svc_acked_bytes', o('add', v('svc_acked_bytes'), v('svc_ack_step'))),
                   set_('svc_abandoned_bytes', o('add', v('svc_abandoned_bytes'), v('svc_drop_step')))]
        a['append_actions'] = a.get('append_actions', []) + account
        amendments.append(a)
    invariants = [
        {'id': 'SCHED-INV-CAPACITY', 'assert': both(o('ge', v('sched_packets'), 0),
            o('le', v('sched_packets'), v('sched_bytes')),
            o('le', v('sched_bytes'), o('mul', v('sched_packets'), 4)),
            o('le', o('add', v('sched_bytes'), o('bytes_len', v('snd_buf'))), 16)),
            'requirements': ['SCHED-OPPORTUNITY']},
        {'id': 'SCHED-INV-GRANT', 'assert': both(o('ge', v('sched_at_ms'), 0),
            o('le', v('sched_at_ms'), {'clock_ms': True}),
            o('implies', v('sched_open'), either(o('eq', v('sched_cause'), 1), o('eq', v('sched_cause'), 2)))),
            'requirements': ['SCHED-OPPORTUNITY', 'SCHED-ACK']},
        {'id': 'SCHED-INV-CHOICE-EPOCH', 'assert': o('implies', v('choice_used'), both(
            v('sched_open'), o('eq', v('sched_at_ms'), v('idle_event_ms')))),
            'requirements': ['SCHED-OPPORTUNITY']},
        {'id': 'SCHED-INV-SERVICE-BALANCE', 'assert': both(
            o('ge', v('svc_written_bytes'), 0), o('ge', v('svc_acked_bytes'), 0), o('ge', v('svc_abandoned_bytes'), 0),
            o('eq', v('svc_written_bytes'), o('add', o('add', v('svc_acked_bytes'), v('svc_abandoned_bytes')),
                o('add', o('bytes_len', v('snd_buf')), o('bytes_len', v('rtx_buf')))))),
            'requirements': ['SCHED-SERVICE']},
        {'id': 'SCHED-INV-ACK-CREDIT', 'assert': both(o('eq', v('svc_ack_step'), v('cc_acked')),
            o('ge', v('svc_accept_step'), 0), o('ge', v('svc_ack_step'), 0), o('ge', v('svc_drop_step'), 0)),
            'requirements': ['SCHED-SERVICE']}]
    raw = dict(ir_version='0.3', semantics=parent['semantics'], extends='tcp-segment-choice.json',
        protocol='tcp-output-schedule', scope={'terminal_states': [], 'excluded': [
            'actual hidden call causality, Nagle/SWS and general timing-policy conformance',
            'universal byte/output/time/translator/implementation refinement or complete TCP']},
        variables=variables, requirements=requirements, amend_transitions=amendments, invariants=invariants)
    target = ROOT / 'model/tcp-output-schedule.json'
    text = json.dumps(raw, indent=2) + '\n'
    if not target.exists() or target.read_text() != text:
        target.write_text(text)


if __name__ == '__main__': main()
