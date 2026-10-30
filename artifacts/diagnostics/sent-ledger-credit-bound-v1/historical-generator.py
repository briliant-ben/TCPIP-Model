"""Generate a bounded circular segment-credit ledger entirely as IR actions."""
import copy
import json
from build_congestion_model import ROOT, v, o, set_, choose, both, var
from protocol_lab.ir import load

SIZE = 16


def sum_(items):
    result = 0
    for item in items:
        result = o('add', result, item)
    return result


def slot(kind, index):
    return f'cb_{kind}_{index:02}'


def advance(value):
    return choose(o('ge', value, SIZE), o('sub', value, SIZE), value)


def offset(index):
    return choose(o('ge', index, v('cb_head')), o('sub', index, v('cb_head')),
                  o('sub', SIZE + index, v('cb_head')))


def active(index):
    return o('lt', offset(index), v('cb_count'))


def main():
    parent = load(ROOT / 'model/tcp-output-schedule.json')
    variables = {n: var('int', 0) for n in ['cb_head', 'cb_tail', 'cb_count',
        'cb_new_count', 'cb_append_length', 'cb_retired_count', 'cb_step_bytes',
        'cb_live_total', 'cb_partial_prefix', 'cb_emitted_total', 'cb_acked_total',
        'cb_abandoned_total', 'cb_drop_step']}
    variables.update(cb_before_nxt=var('seq32', 0), cb_append_end=var('seq32', 0),
                     cb_is_new=var('bool', False))
    for i in range(SIZE):
        variables[slot('length', i)] = var('int', 0)
        variables[slot('end', i)] = var('seq32', 0)
        variables[slot('done', i)] = var('bool', False)
    requirements = {
        'CB-LEDGER': {'source': 'docs/tcp-sent-ledger.md', 'interpretation':
            'Finite circular ledger of actual first-send data segment lengths and seq32 exclusive ends. At most16 records, SMSS4. Retransmissions, SYN and FIN do not add a record. Existing protocol queues, sequence arithmetic and timers remain authoritative.',
            'kind': 'modeling_choice', 'strength': 'explicit bounded segment provenance'},
        'CB-CREDIT': {'source': 'spec/sources/tcp-sent-ledger.json', 'interpretation':
            'Pinned lwIP2.2.1 tcp_free_acked_segments releases complete original segments; recv_acked is reported through the public sent callback once per input in this <=16-byte scope. This optional service projection retires every whole segment covered by accepted cumulative ACK, not each newly ACKed byte. It is implementation-policy modeling, not a normative TCP callback requirement.',
            'kind': 'modeling_choice', 'strength': 'whole-original-segment sent credit'},
        'CB-ACK': {'source': 'spec/sources/rfc9293.txt', 'interpretation':
            'August2022 sections3.4/3.10.7.4: cumulative sequence-space acknowledgments are inherited unchanged. TCP byte credit and implementation callback credit are different observables. Accepted data ACK credit gates retirement; future/old/duplicate ACKs cannot fabricate callbacks.',
            'kind': 'modeling_choice', 'strength': 'shared sequence/ACK semantics'},
        'CB-SCOPE': {'source': 'docs/tcp-sent-ledger.md', 'interpretation':
            'cb_step_bytes is an explicit IR service observation, not a Python protocol callback. Metadata tracks at most one new-data emission per atomic rule and fails an invariant on overflow. Fixed source/witness replays and real public C callbacks do not prove general TCP, socket semantics, Nagle/SWS or translator/implementation refinement.',
            'kind': 'modeling_choice', 'strength': 'bounded observability scope'}}
    amendments = []
    for rule in parent['transitions']:
        amendment = {'id': rule['id'], 'add_requirements': list(requirements),
            'prepend_actions': [set_('cb_before_nxt', v('snd_nxt')), set_('cb_new_count', 0),
                set_('cb_append_length', 0), set_('cb_append_end', {'seq': 0}),
                set_('cb_is_new', False)], 'edit_actions': []}
        # Capture each emission's original expressions before any following queue
        # mutation. Only a positive payload beginning at pre-rule SND.NXT is new.
        for index, action in enumerate(rule['actions']):
            kind = next(iter(action))
            if kind not in ('emit', 'emit_if') or action[kind]['message'] != 'tcp_data':
                continue
            packet = action[kind]
            size = o('bytes_len', packet['fields']['payload'])
            condition = both(packet.get('when', True), o('ge', size, 1),
                             o('eq', packet['fields']['seq'], v('cb_before_nxt')))
            capture = [set_('cb_is_new', condition),
                set_('cb_new_count', o('add', v('cb_new_count'), choose(v('cb_is_new'), 1, 0))),
                set_('cb_append_length', choose(v('cb_is_new'), size, v('cb_append_length'))),
                set_('cb_append_end', choose(v('cb_is_new'),
                    o('seq_add', packet['fields']['seq'], size), v('cb_append_end')))]
            amendment['edit_actions'].append({'at': index, 'expected': action,
                                               'with': capture + [copy.deepcopy(action)]})
        amendment['edit_actions'].reverse()
        post = []
        for i in range(SIZE):
            post.append(set_(slot('done', i), both(active(i), o('ge', v('cc_acked'), 1),
                o('seq_le', v(slot('end', i)), v('snd_una')))))
        post += [set_('cb_retired_count', sum_(choose(v(slot('done', i)), 1, 0) for i in range(SIZE))),
            set_('cb_step_bytes', sum_(choose(v(slot('done', i)), v(slot('length', i)), 0) for i in range(SIZE)))]
        for i in range(SIZE):
            post += [set_(slot('length', i), choose(v(slot('done', i)), 0, v(slot('length', i)))),
                set_(slot('end', i), choose(v(slot('done', i)), {'seq': 0}, v(slot('end', i))))]
        post += [set_('cb_head', advance(o('add', v('cb_head'), v('cb_retired_count')))),
                 set_('cb_count', o('sub', v('cb_count'), v('cb_retired_count'))),
                 set_('cb_drop_step', choose(o('ge', v('svc_drop_step'), 1),
                     sum_(v(slot('length', i)) for i in range(SIZE)), 0))]
        dropping = o('ge', v('svc_drop_step'), 1)
        for i in range(SIZE):
            post += [set_(slot('length', i), choose(dropping, 0, v(slot('length', i)))),
                set_(slot('end', i), choose(dropping, {'seq': 0}, v(slot('end', i))))]
        for name in ['cb_head', 'cb_tail', 'cb_count']:
            post.append(set_(name, choose(dropping, 0, v(name))))
        for i in range(SIZE):
            inserting = both(o('eq', v('cb_new_count'), 1), o('eq', v('cb_tail'), i))
            post += [set_(slot('length', i), choose(inserting, v('cb_append_length'), v(slot('length', i)))),
                set_(slot('end', i), choose(inserting, v('cb_append_end'), v(slot('end', i))))]
        post += [set_('cb_count', o('add', v('cb_count'), v('cb_new_count'))),
            set_('cb_tail', advance(o('add', v('cb_tail'), v('cb_new_count')))),
            set_('cb_live_total', sum_(v(slot('length', i)) for i in range(SIZE))),
            set_('cb_partial_prefix', o('sub', v('cb_live_total'), o('bytes_len', v('rtx_buf')))),
            set_('cb_emitted_total', o('add', v('cb_emitted_total'), v('cb_append_length'))),
            set_('cb_acked_total', o('add', v('cb_acked_total'), v('cb_step_bytes'))),
            set_('cb_abandoned_total', o('add', v('cb_abandoned_total'), v('cb_drop_step')))]
        amendment['append_actions'] = post
        amendments.append(amendment)
    invariant = lambda name, assertion: {'id': name, 'assert': assertion,
                                         'requirements': list(requirements)}
    invariants = [invariant('CB-INV-CAPACITY', both(
        o('ge', v('cb_head'), 0), o('lt', v('cb_head'), SIZE),
        o('ge', v('cb_tail'), 0), o('lt', v('cb_tail'), SIZE),
        o('ge', v('cb_count'), 0), o('le', v('cb_count'), o('bytes_len', v('rtx_buf'))),
        o('eq', v('cb_tail'), advance(o('add', v('cb_head'), v('cb_count')))),
        o('ge', v('cb_new_count'), 0), o('le', v('cb_new_count'), 1))),
        invariant('CB-INV-MASS', both(o('ge', v('cb_emitted_total'), 0),
            o('ge', v('cb_acked_total'), 0), o('le', v('cb_acked_total'), v('svc_acked_bytes')),
            o('ge', v('cb_abandoned_total'), 0), o('ge', v('cb_step_bytes'), 0),
            o('le', v('cb_step_bytes'), 16), o('ge', v('cb_drop_step'), 0),
            o('eq', v('cb_emitted_total'), o('add', o('add', v('cb_acked_total'), v('cb_abandoned_total')), v('cb_live_total'))),
            o('eq', v('cb_live_total'), sum_(v(slot('length', i)) for i in range(SIZE))))),
        invariant('CB-INV-PARTIAL', both(o('eq', v('cb_partial_prefix'),
            o('sub', v('cb_live_total'), o('bytes_len', v('rtx_buf')))),
            o('ge', v('cb_partial_prefix'), 0), o('le', v('cb_partial_prefix'), 3)))]
    for i in range(SIZE):
        live = active(i)
        invariants.append(invariant(f'CB-INV-SLOT-{i:02}', both(
            o('implies', live, both(o('ge', v(slot('length', i)), 1), o('le', v(slot('length', i)), 4))),
            o('implies', o('not', live), both(o('eq', v(slot('length', i)), 0), o('eq', v(slot('end', i)), {'seq': 0}))),
            o('implies', both(live, o('eq', v('cb_head'), i)), both(
                o('lt', v('cb_partial_prefix'), v(slot('length', i))),
                o('eq', v(slot('end', i)), o('seq_add', v('snd_una'), o('sub', v(slot('length', i)), v('cb_partial_prefix')))))),
            o('implies', both(live, o('ge', offset(i), 1)),
                o('eq', v(slot('end', i)), o('seq_add', v(slot('end', (i - 1) % SIZE)), v(slot('length', i))))))))
    raw = dict(ir_version='0.3', semantics=parent['semantics'], extends='tcp-output-schedule.json',
        protocol='tcp-sent-ledger', scope={'terminal_states': [], 'excluded': [
            'full TCP/socket API, arbitrary segmentation changes, general implementation refinement',
            'callback splitting above65535, internal PCB observation, Linux or kernel proof']},
        variables=variables, requirements=requirements, amend_transitions=amendments, invariants=invariants)
    target = ROOT / 'model/tcp-sent-ledger.json'
    text = json.dumps(raw, indent=2) + '\n'
    if not target.exists() or target.read_text() != text:
        target.write_text(text)


if __name__ == '__main__':
    main()
