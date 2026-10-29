"""Replay exact external inputs plus declared choice.* events; no TCP logic."""
import copy
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from protocol_lab.ir import Machine, require


def replay_inputs(model, source, witness):
    """Replay a candidate and report the unchanged canonical oracle separately.

    This function alone accepts no observation. Callers must retain canonical
    failures and independently verify a declared output projection.
    """
    require(type(witness) is dict and set(witness) == {'witness_version', 'steps'}
            and witness['witness_version'] == '0.1', 'Unsupported witness envelope')
    require(type(witness['steps']) is list and len(witness['steps']) <= 256, 'Witness step bound exceeded')
    require('settle_ms' not in source, 'Explicit source clock steps required; settle_ms unsupported')
    machine = Machine(model, source.get('initial', {}))
    source_index = 0
    audit = []
    for decision in witness['steps']:
        require(type(decision) is dict, 'Witness decision must be an object')
        start = len(machine.trace)
        if set(decision) == {'source_step'}:
            index = decision['source_step']
            require(type(index) is int and index == source_index and index < len(source['steps']),
                    'Source steps must be consumed exactly once in order')
            step = source['steps'][index]
            if set(step) == {'at_ms', 'tick'} and step['tick'] is True:
                machine.tick(step['at_ms'])
            else:
                require(set(step) == {'at_ms', 'event', 'fields'},
                        'Unsupported source step/inline output contract')
                require(not step['event'].startswith('choice.'), 'Source cannot inject witness choices')
                machine.dispatch(step['event'], copy.deepcopy(step['fields']), step['at_ms'])
            source_index += 1
            audit.append(dict(kind='source', source_step=index, trace_start=start, trace_end=len(machine.trace)))
        else:
            require(set(decision) == {'at_ms', 'event', 'fields'}, 'Unsupported witness decision')
            event = decision['event']
            require(type(event) is str and event.startswith('choice.') and event in model['events']
                    and model['events'][event]['origin'] == 'application', 'Undeclared/non-choice witness event')
            machine.dispatch(event, copy.deepcopy(decision['fields']), decision['at_ms'])
            audit.append(dict(kind='choice', event=event, at_ms=decision['at_ms'],
                              trace_start=start, trace_end=len(machine.trace)))
    require(source_index == len(source['steps']), 'Witness omitted source steps')
    expected = source['expect']
    mismatches = []
    if machine.state != expected['state']:
        mismatches.append(dict(field='state', expected=expected['state'], actual=machine.state))
    if machine.timers != expected['timers']:
        mismatches.append(dict(field='timers', expected=expected['timers'], actual=machine.timers))
    for name, value in expected.get('variables', {}).items():
        if machine.values.get(name) != value:
            mismatches.append(dict(field=name, expected=value, actual=machine.values.get(name)))
    return machine, audit, dict(status='mismatch' if mismatches else 'match', differences=mismatches)


def replay_schedule(model, source, witness):
    """Strict canonical-final contract entry point, retaining default behavior."""
    machine, audit, canonical = replay_inputs(model, source, witness)
    require(canonical['status'] == 'match', 'Witness final canonical contract differs: ' + str(canonical))
    return machine, audit
