"""Generate a basic RFC9293 Nagle policy, including the LT send path."""
import copy
import json
from build_congestion_model import ROOT, v, o, set_, both, either, var
from protocol_lab.ir import load


def main():
    parent = load(ROOT / 'model/tcp-sent-ledger.json')
    requirements = {
        'NAGLE-BASIC': {'source': 'spec/sources/rfc9293.txt', 'interpretation':
            'August2022 section3.7.4 SHLD-7: with unacknowledged data, buffer new short segments until outstanding data is acknowledged or a full Eff.snd.MSS segment can be sent. This basic policy has fixed effective send MSS4 and applies to explicit choices and automatic Limited Transmit. Retransmission and persist probing retain parent semantics.',
            'kind': 'normative', 'strength': 'bounded basic Nagle interpretation'},
        'NAGLE-OPTION': {'source': 'spec/sources/rfc9293.txt', 'interpretation':
            'Section3.7.4 MUST-17: app.nodelay(enabled) toggles the per-connection disable flag in ESTABLISHED/CLOSE-WAIT. This finite API does not itself grant output; a subsequent transmit or accepted ACK grants the existing opportunity. Opening a new connection resets the flag to enabled Nagle.',
            'kind': 'modeling_choice', 'strength': 'explicit finite application option'},
        'NAGLE-SCOPE': {'source': 'docs/tcp-nagle.md', 'interpretation':
            'Basic RFC coalescing only, not complete sender SWS avoidance, lwIP unsent-node/FIN/memory-pressure/fast-recovery variations, dynamic MSS, or a general Linux/lwIP conformance claim. Old source profiles and Differences stay unchanged.',
            'kind': 'modeling_choice', 'strength': 'policy and implementation distinctions'}}
    variables = {n: var(t, value) for n, t, value in [
        ('nagle_disabled', 'bool', False), ('nagle_before_disabled', 'bool', False),
        ('nagle_before_flight', 'int', 0), ('nagle_first_bytes', 'int', 0)]}
    amendments = []
    choices = lt_paths = 0
    for rule in parent['transitions']:
        amendment = dict(id=rule['id'], add_requirements=list(requirements),
            prepend_actions=[set_('nagle_before_disabled', v('nagle_disabled')),
                set_('nagle_before_flight', o('bytes_len', v('rtx_buf')))],
            append_actions=[set_('nagle_first_bytes', v('cb_append_length'))])
        if rule['event'] == 'choice.segment':
            amendment['and_guard'] = either(v('nagle_disabled'),
                o('eq', o('bytes_len', v('rtx_buf')), 0), o('eq', {'event': 'count'}, 4))
            choices += 1
        edits = []
        for index, action in enumerate(rule['actions']):
            if 'set' not in action or action['set']['var'] != 'lt_eligible' or action['set']['value'] is False:
                continue
            amount = rule['actions'][index + 1]
            assert amount['set']['var'] == 'lt_take', 'Changed LT action order'
            expression = amount['set']['value']
            assert expression['op'] == 'ite' and expression['args'][0] == v('lt_eligible') and expression['args'][2] == 0
            eligible = either(v('nagle_disabled'), o('eq', expression['args'][1], 4))
            edits.append(dict(at=index, expected=action,
                with_=[set_('lt_eligible', both(action['set']['value'], eligible))]))
            lt_paths += 1
        if edits:
            # Loader edits precede prepend_actions; positions refer to parent.
            amendment['edit_actions'] = [{('with' if k == 'with_' else k): val for k, val in e.items()} for e in edits]
        if rule['event'] in ['app.connect', 'app.listen']:
            amendment['append_actions'].append(set_('nagle_disabled', False))
        amendments.append(amendment)
    assert choices == 8 and lt_paths == 9, 'Review changed parent sending paths'
    option_rules = []
    for rule in parent['transitions']:
        if rule['event'] != 'app.send' or 'SEND-EMPTY' not in rule['id']:
            continue
        assert '"event"' not in json.dumps(rule['actions']), 'Option template has hidden event dependency'
        option = copy.deepcopy(rule)
        option.update(id='NAGLE-OPTION-' + rule['from'], event='app.nodelay', guard=True)
        option['requirements'] += list(requirements)
        option['actions'] = [set_('nagle_before_disabled', v('nagle_disabled')),
            set_('nagle_before_flight', o('bytes_len', v('rtx_buf')))] + option['actions'] + [
            set_('nagle_first_bytes', 0), set_('nagle_disabled', {'event': 'enabled'})]
        option_rules.append(option)
    assert len(option_rules) == 2
    raw = dict(ir_version='0.3', semantics=parent['semantics'], extends='tcp-sent-ledger.json',
        protocol='tcp-nagle', scope={'terminal_states': [], 'excluded': [
            'complete sender SWS/override timer, lwIP queue-node variations, dynamic MSS',
            'universal implementation refinement, full TCP, Linux evidence']},
        events={'app.nodelay': {'origin': 'application', 'fields': {'enabled': 'bool'}}},
        variables=variables, requirements=requirements, amend_transitions=amendments,
        transitions=option_rules, invariants=[
            {'id': 'NAGLE-INV-NEW-DATA', 'assert': o('implies', both(
                o('gt', v('nagle_first_bytes'), 0), o('gt', v('nagle_before_flight'), 0),
                o('not', v('nagle_before_disabled'))), o('eq', v('nagle_first_bytes'), 4)),
             'requirements': ['NAGLE-BASIC']},
            {'id': 'NAGLE-INV-COUNTS', 'assert': both(o('ge', v('nagle_before_flight'), 0),
                o('le', v('nagle_before_flight'), 16), o('ge', v('nagle_first_bytes'), 0),
                o('le', v('nagle_first_bytes'), 4)), 'requirements': ['NAGLE-BASIC']}])
    target = ROOT / 'model/tcp-nagle.json'
    data = json.dumps(raw, indent=2) + '\n'
    if not target.exists() or target.read_text() != data:
        target.write_text(data)


if __name__ == '__main__':
    main()
