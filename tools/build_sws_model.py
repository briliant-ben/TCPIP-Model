"""Emit sender SWS gates and a clock-v3 override timer as declarative IR."""
import copy
import json
from build_congestion_model import ROOT, v, o, set_, both, either, choose, var
from protocol_lab.ir import load

STATES = ['ESTABLISHED', 'CLOSE-WAIT', 'FIN-WAIT-1', 'CLOSING']
NOW = {'clock_ms': True}


def length(name): return o('bytes_len', v(name))
def neg(expr): return o('not', expr)
def maximum(first, second): return choose(o('ge', first, second), first, second)


def eligible(count, queued, usable, maximum, flight, disabled, pushed, ready):
    short = either(o('eq', flight, 0), disabled)
    return both(o('ge', count, 1), o('le', count, queued), o('le', count, usable), either(
        o('eq', count, 4),
        both(short, o('eq', pushed, queued), o('eq', count, queued)),
        both(short, o('ge', o('mul', count, 2), maximum)), ready))


def decisions(count):
    fields = {'count': count, 'queued': length('snd_buf'),
        'usable': maximum(0, o('sub', v('snd_wnd'), length('rtx_buf'))),
        'maximum': maximum(v('sws_max_window'), v('snd_wnd')),
        'flight': length('rtx_buf'), 'disabled': v('nagle_disabled'),
        'pushed': v('sws_push_bytes'), 'ready': v('sws_override_ready'),
        'at_ms': NOW, 'started_ms': v('sws_started_ms'), 'deadline_ms': v('sws_deadline_ms')}
    result = [set_('sws_decision_' + name, value) for name, value in fields.items()]
    result.append(set_('sws_allowed_at_send', eligible(*[v('sws_decision_' + name) for name in
        ['count', 'queued', 'usable', 'maximum', 'flight', 'disabled', 'pushed', 'ready']])))
    return result


def post_connected(rule):
    result = rule['to'] in STATES
    for case in reversed(rule.get('target_cases', [])):
        result = choose(case['when'], case['to'] in STATES, result)
    return result


def finish(rule):
    connected = post_connected(rule)
    pending = both(connected, neg(v('fin_sent')), o('ge', length('snd_buf'), 1))
    progress = o('ge', v('cb_append_length'), 1)
    request = rule['event'] in ['app.transmit', 'app.push', 'app.close'] or (
        rule['event'] == 'net.ack' and 'ACK-VALID' in rule['id'])
    clear = either(neg(pending), progress)
    return [
        set_('sws_sent_count', choose(either(rule['event'] == 'choice.segment', v('lt_emitted')),
            v('cb_append_length'), 0)),
        set_('sws_max_window', choose(connected, maximum(v('sws_max_window'), v('snd_wnd')), 0)),
        set_('sws_push_bytes', choose(pending,
            maximum(0, o('sub', v('sws_push_bytes'), v('cb_append_length'))), 0)),
        set_('sws_requested', both(pending, either(v('sws_requested'), request))),
        set_('sws_override_ready', both(neg(clear), v('sws_override_ready'))),
        {'cancel_if': {'when': clear, 'timer': 'sws'}},
        set_('sws_active', both(neg(clear), v('sws_active'))),
        set_('sws_need_arm', both(pending, v('sws_requested'), neg(v('sws_active')), neg(v('sws_override_ready')))),
        set_('sws_started_ms', choose(v('sws_need_arm'), NOW,
            choose(either(v('sws_active'), v('sws_override_ready')), v('sws_started_ms'), 0))),
        set_('sws_deadline_ms', choose(v('sws_need_arm'), o('add', NOW, v('sws_override_ms')),
            choose(either(v('sws_active'), v('sws_override_ready')), v('sws_deadline_ms'), 0))),
        {'arm_if': {'when': v('sws_need_arm'), 'timer': 'sws', 'delay_ms': v('sws_override_ms')}},
        set_('sws_active', either(v('sws_active'), v('sws_need_arm')))]


def prefix():
    fields = ['count', 'queued', 'usable', 'maximum', 'flight', 'pushed', 'at_ms', 'started_ms', 'deadline_ms']
    return [set_('sws_previous_max', v('sws_max_window')), set_('sws_sent_count', 0),
        set_('sws_allowed_at_send', False)] + [set_('sws_decision_' + n, 0) for n in fields] + [
        set_('sws_decision_disabled', False), set_('sws_decision_ready', False)]


def main():
    parent = load(ROOT / 'model/tcp-nagle.json')
    requirements = {
        'SWS-SEND': {'source': 'spec/sources/rfc9293.txt', 'interpretation':
            'August2022 section3.8.6.2.1 MUST-38 and recommended send rules: fixed MSS4, Fs=1/2, maximum accepted send window per connection. A selected normal new-data prefix must be full MSS, all queued pushed data, at least half the maximum window, or timeout-authorized. The latter still obeys receiver/congestion budgets and the independent parent Nagle gate.',
            'kind': 'normative', 'strength': 'finite sender SWS interpretation'},
        'SWS-TIMEOUT': {'source': 'docs/tcp-sws.md', 'interpretation':
            'Separate override timer configurable100..1000ms, default200. First pending transmit/accepted-ACK/push/close request starts the epoch. More writes or repeat requests do not postpone it. Expiry grants a zero-time choice opportunity and retained readiness, never directly sends; actual first-send progress starts the next remaining-queue epoch. Cleanup cancels. Probes/retransmissions keep parent behavior.',
            'kind': 'modeling_choice', 'strength': 'explicit timer ownership/clock policy'},
        'SWS-PUSH': {'source': 'docs/tcp-sws.md', 'interpretation':
            'app.push marks only the current queued prefix, not later writes, and grants a finite send opportunity in ESTABLISHED/CLOSE-WAIT. Closing marks its queued prefix similarly. This is application coalescing intent; wire PSH is outside the present message schema.',
            'kind': 'modeling_choice', 'strength': 'explicit bounded push prefix'},
        'SWS-SCOPE': {'source': 'spec/sources/tcp-sws.json', 'interpretation':
            'Pinned RFC version/source hashes and declared policy. No dynamic MSS, window scaling, wire PSH, lwIP special send-queue variations, Linux evidence or universal implementation refinement.',
            'kind': 'modeling_choice', 'strength': 'scope and provenance'}}
    defaults = {'sws_override_ms': 200, 'sws_max_window': 0, 'sws_previous_max': 0,
        'sws_push_bytes': 0, 'sws_started_ms': 0, 'sws_deadline_ms': 0, 'sws_sent_count': 0}
    defaults.update({'sws_decision_' + n: 0 for n in
        ['count', 'queued', 'usable', 'maximum', 'flight', 'pushed', 'at_ms', 'started_ms', 'deadline_ms']})
    variables = {n: var('int', value) for n, value in defaults.items()}
    variables.update({n: var('bool', False) for n in ['sws_active', 'sws_override_ready', 'sws_requested',
        'sws_need_arm', 'sws_allowed_at_send', 'sws_decision_disabled', 'sws_decision_ready']})
    amendments = []; choices = lt_paths = 0
    for rule in parent['transitions']:
        pre = prefix()
        if rule['event'] == 'app.close' and rule['from'] in STATES:
            pre.append(set_('sws_push_bytes', length('snd_buf')))
        amendment = dict(id=rule['id'], prepend_actions=pre, append_actions=finish(rule), add_requirements=list(requirements))
        if rule['event'] == 'choice.segment':
            count = {'event': 'count'}
            pre.extend(decisions(count))
            amendment['and_guard'] = eligible(count, length('snd_buf'),
                maximum(0, o('sub', v('snd_wnd'), length('rtx_buf'))), v('sws_max_window'),
                length('rtx_buf'), v('nagle_disabled'), v('sws_push_bytes'), v('sws_override_ready'))
            choices += 1
        for index, action in enumerate(rule['actions']):
            if 'set' not in action or action['set']['var'] != 'lt_eligible' or action['set']['value'] is False:
                continue
            following = rule['actions'][index + 1]
            assert following['set']['var'] == 'lt_take' and following['set']['value']['op'] == 'ite'
            amount = following['set']['value']['args'][1]
            replacement = decisions(choose(action['set']['value'], amount, 0)) + [
                set_('lt_eligible', both(action['set']['value'], v('sws_allowed_at_send')))]
            amendment['edit_actions'] = [{'at': index, 'expected': action, 'with': replacement}]
            lt_paths += 1
        amendments.append(amendment)
    assert choices == 8 and lt_paths == 9, 'Review parent sending paths'
    template = copy.deepcopy(next(t for t in parent['transitions'] if t['id'] == 'D-SEND-EMPTY'))
    notice = {'emit': {'message': 'application', 'fields': {'code': 'empty_send'}}}
    assert template['actions'].count(notice) == 1 and '"event"' not in json.dumps(template['actions'])
    template['actions'].remove(notice)
    rules = []
    for state in STATES:
        rule = copy.deepcopy(template)
        rule.update(id='SWS-EXPIRE-' + state, event='timer.sws', **{'from': state, 'to': state},
            guard=both(v('sws_active'), v('sws_requested'), neg(v('fin_sent')),
                o('ge', length('snd_buf'), 1), o('eq', NOW, v('sws_deadline_ms'))))
        rule['requirements'] += list(requirements)
        rule['actions'] = prefix() + rule['actions'] + [
            set_('sws_active', False), set_('sws_override_ready', True),
            set_('sched_open', True), set_('sched_at_ms', NOW), set_('sched_cause', 1)] + finish(rule)
        rules.append(rule)
    for state in STATES[:2]:
        rule = copy.deepcopy(template)
        rule.update(id='SWS-PUSH-' + state, event='app.push', guard=True, **{'from': state, 'to': state})
        rule['requirements'] += list(requirements)
        rule['actions'] = prefix() + [set_('sws_push_bytes', length('snd_buf'))] + rule['actions'] + [
            set_('sched_open', True), set_('sched_at_ms', NOW), set_('sched_cause', 1)] + finish(rule)
        rules.append(rule)
    connected = either(*[{'state': s} for s in STATES])
    waiting = either(v('sws_active'), v('sws_override_ready'))
    chosen = [v('sws_decision_' + n) for n in ['count', 'queued', 'usable', 'maximum', 'flight', 'disabled', 'pushed', 'ready']]
    invariant = both(
        o('ge', v('sws_override_ms'), 100), o('le', v('sws_override_ms'), 1000),
        o('ge', v('sws_max_window'), 0), o('le', v('sws_max_window'), 65535),
        o('implies', connected, both(o('ge', v('sws_max_window'), v('snd_wnd')),
            o('ge', v('sws_max_window'), v('sws_previous_max')))),
        o('implies', neg(connected), o('eq', v('sws_max_window'), 0)),
        o('ge', v('sws_push_bytes'), 0), o('le', v('sws_push_bytes'), length('snd_buf')),
        o('eq', v('sws_active'), {'timer_active': 'sws'}),
        neg(both(v('sws_active'), v('sws_override_ready'))), o('eq', v('sws_requested'), waiting),
        o('implies', waiting, both(connected, neg(v('fin_sent')), o('ge', length('snd_buf'), 1),
            o('ge', v('sws_started_ms'), 0), o('le', v('sws_started_ms'), NOW),
            o('eq', v('sws_deadline_ms'), o('add', v('sws_started_ms'), v('sws_override_ms'))))),
        o('implies', neg(waiting), both(o('eq', v('sws_started_ms'), 0), o('eq', v('sws_deadline_ms'), 0))),
        o('implies', v('sws_override_ready'), o('le', v('sws_deadline_ms'), NOW)),
        o('ge', v('sws_sent_count'), 0), o('le', v('sws_sent_count'), 4),
        o('implies', o('ge', v('sws_sent_count'), 1), both(v('sws_allowed_at_send'),
            o('eq', v('sws_decision_count'), v('sws_sent_count')), eligible(*chosen))),
        o('implies', v('sws_decision_ready'), both(o('ge', v('sws_decision_started_ms'), 0),
            o('eq', v('sws_decision_deadline_ms'), o('add', v('sws_decision_started_ms'), v('sws_override_ms'))),
            o('le', v('sws_decision_deadline_ms'), v('sws_decision_at_ms')))),
        o('le', v('sws_decision_at_ms'), NOW))
    raw = dict(ir_version='0.3', semantics=parent['semantics'], extends='tcp-nagle.json', protocol='tcp-sws',
        scope={'terminal_states': [], 'excluded': ['dynamic MSS/window scaling/wire PSH and lwIP-specific queue variants',
            'universal IR/interpreter/translator/implementation correspondence or full TCP/Linux evidence']},
        events={'timer.sws': {'origin': 'timer', 'fields': {}}, 'app.push': {'origin': 'application', 'fields': {}}},
        timers={'sws': {'event': 'timer.sws'}}, variables=variables, requirements=requirements,
        amend_transitions=amendments, transitions=rules,
        invariants=[{'id': 'SWS-INV', 'assert': invariant, 'requirements': list(requirements)}])
    text = json.dumps(raw, indent=2) + '\n'
    path = ROOT / 'model/tcp-sws.json'
    if not path.exists() or path.read_text() != text: path.write_text(text)


if __name__ == '__main__': main()
