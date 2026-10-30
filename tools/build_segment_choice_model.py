"""Emit declared finite segment choices, not a runtime protocol callback."""
import copy
import json
from build_congestion_model import ROOT, v, o, set_, both, var
from protocol_lab.ir import load


def substitute(expression, environment):
    if type(expression) is dict:
        if set(expression) == {'var'} and expression['var'] in environment:
            # Stored expressions already refer to the original prestate.
            # Do not substitute their same-name original variables again.
            return copy.deepcopy(environment[expression['var']])
        return {k: substitute(x, environment) for k, x in expression.items()}
    if type(expression) is list:
        return [substitute(x, environment) for x in expression]
    return expression


def main():
    parent = load(ROOT / 'model/tcp-limited-transmit.json')
    req = {
        'CHOICE-SEGMENT': {'source': 'spec/sources/rfc9293.txt', 'interpretation':
            'August2022 section3.7: MSS is an upper segment-text bound, not a requirement to fill every packet. This developer overlay permits a declared positive prefix count up to the existing new-data take limit. The same receiver/congestion/queue/FIN guards remain in force.',
            'kind': 'normative', 'strength': 'finite segmentation scheduling choice'},
        'CHOICE-SOURCE': {'source': 'spec/sources/tcp-segment-choice.json', 'interpretation':
            'Pinned normative RFC version/sections and raw SHA for this scheduling relation.',
            'kind': 'modeling_choice', 'strength': 'source provenance'},
        'CHOICE-SCOPE': {'source': 'docs/tcp-segment-choice.md', 'interpretation':
            'choice.segment(count) is an explicit model scheduling decision, not a socket API or observed network input. Only admitted positive new-data opportunities are defined. Original app.transmit remains canonical. No automatic acceptance of a PCAP, public-call alignment, general allowed-output relation, retransmission/clock-policy alternative or full TCP claim.',
            'kind': 'modeling_choice', 'strength': 'explicit admissibility and exclusions'}}
    variables = {n: var(t, x) for n, t, x in [
        ('choice_used', 'bool', False), ('choice_count', 'int', 0),
        ('choice_limit', 'int', 0), ('choice_before_nxt', 'seq32', 1000),
        ('choice_before_flight', 'int', 0)]}
    clones = []
    for rule in parent['transitions']:
        if rule['event'] != 'app.transmit':
            continue
        indices = [i for i, a in enumerate(rule['actions']) if 'set' in a and a['set']['var'] == 'take']
        if not indices:
            continue
        assert len(indices) == 1
        index = indices[0]
        environment = {}
        for action in rule['actions'][:index]:
            assert set(action) == {'set'}, 'Unsupported pre-send effect; refuse rather than omit it'
            arg = action['set']
            environment[arg['var']] = substitute(arg['value'], environment)
        limit = substitute(rule['actions'][index]['set']['value'], environment)
        clone = copy.deepcopy(rule)
        clone['id'] = 'CHOICE-' + rule['id']
        clone['event'] = 'choice.segment'
        count = {'event': 'count'}
        clone['guard'] = both(rule['guard'], o('ge', count, 1), o('le', count, limit))
        clone['requirements'] += list(req)
        clone['actions'][index] = set_('take', count)
        clone['actions'] = [set_('choice_used', True), set_('choice_count', count),
            set_('choice_limit', limit), set_('choice_before_nxt', v('snd_nxt')),
            set_('choice_before_flight', o('bytes_len', v('rtx_buf')))] + clone['actions']
        clones.append(clone)
    assert len(clones) == 8, 'Parent scheduling rules changed; review every clone'
    inv = [
        {'id': 'CHOICE-INV-BOUNDS', 'assert': both(o('ge', v('choice_count'), 0),
            o('le', v('choice_count'), 4), o('ge', v('choice_limit'), 0), o('le', v('choice_limit'), 4)),
            'requirements': ['CHOICE-SEGMENT']},
        {'id': 'CHOICE-INV-ADMISSIBLE', 'assert': o('implies', v('choice_used'), both(
            o('ge', v('choice_count'), 1), o('le', v('choice_count'), v('choice_limit')),
            o('eq', v('take'), v('choice_count')), o('eq', v('cc_new_sent'), v('choice_count')),
            o('le', v('choice_count'), v('cc_send_budget')),
            o('eq', v('snd_nxt'), o('seq_add', v('choice_before_nxt'), v('choice_count'))),
            o('eq', o('bytes_len', v('rtx_buf')), o('add', v('choice_before_flight'), v('choice_count'))))),
            'requirements': ['CHOICE-SEGMENT']}]
    raw = dict(ir_version='0.3', semantics=parent['semantics'], extends='tcp-limited-transmit.json',
        protocol='tcp-segment-choice', scope={'terminal_states': [], 'excluded': [
            'invalid choice requests, blocked/FIN-only choice opportunities and API-call alignment',
            'automatic PCAP acceptance or general allowed-output, retransmission and timing relation',
            'complete TCP or universal byte/output/timing/translation/implementation proof']},
        events={'choice.segment': {'origin': 'application', 'fields': {'count': 'int'}}},
        variables=variables, requirements=req,
        amend_transitions=[{'id': t['id'], 'prepend_actions': [set_('choice_used', False)]}
                           for t in parent['transitions']], transitions=clones, invariants=inv)
    target = ROOT / 'model/tcp-segment-choice.json'
    text = json.dumps(raw, indent=2) + '\n'
    if not target.exists() or target.read_text() != text:
        target.write_text(text)


if __name__ == '__main__':
    main()
