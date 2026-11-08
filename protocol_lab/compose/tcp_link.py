import copy
from protocol_lab.ir import validate


def _replace_packet_leaf(obj):
    """Recursively replace leaf {'event':'packet'} with IP payload slice expression."""
    if isinstance(obj, dict):
        if set(obj.keys()) == {'event'} and obj.get('event') == 'packet':
            ip_total = {
                'op': 'add',
                'args': [
                    {'op': 'mul', 'args': [256, {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 16]}]},
                    {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 17]}
                ]
            }
            return {
                'op': 'bytes_slice',
                'args': [{'event': 'frame'}, 14, ip_total]
            }
        else:
            return {k: _replace_packet_leaf(v) for k, v in obj.items()}
    elif isinstance(obj, list):
        return [_replace_packet_leaf(item) for item in obj]
    else:
        return obj


def _make_and(conds):
    if not conds:
        return {'op': 'eq', 'args': [{'var': 'L.control'}, {'var': 'L.control'}]}
    result = conds[0]
    for c in conds[1:]:
        result = {'op': 'and', 'args': [result, c]}
    return result


def _make_or(conds):
    if not conds:
        return {'op': 'eq', 'args': [{'var': 'L.control'}, {'var': 'L.control'}]}
    result = conds[0]
    for c in conds[1:]:
        result = {'op': 'or', 'args': [result, c]}
    return result


def _tcp_frame_envelope_guard():
    """Return a pure binary-AND AST enforcing the declared complete Ethernet TCP ingress envelope."""
    frame_len = {'op': 'bytes_len', 'args': [{'event': 'frame'}]}
    conds = [
        {'op': 'ge', 'args': [frame_len, 60]},
        {'op': 'le', 'args': [frame_len, 1514]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 0, 6]},
            {'bytes': [2, 0, 0, 0, 0, 1]}
        ]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 6, 6]},
            {'bytes': [2, 0, 0, 0, 0, 2]}
        ]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 12, 2]},
            {'bytes': [8, 0]}
        ]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 14]}, 69]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 15]}, 0]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 20]}, 64]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 21]}, 0]},
        {'op': 'ge', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 22]}, 1]},
        {'op': 'le', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 22]}, 255]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 23]}, 6]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 26, 4]},
            {'bytes': [192, 0, 2, 2]}
        ]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 30, 4]},
            {'bytes': [192, 0, 2, 1]}
        ]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 34, 4]},
            {'bytes': [31, 144, 156, 64]}
        ]}
    ]
    ip_total = {
        'op': 'add',
        'args': [
            {'op': 'mul', 'args': [256, {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 16]}]},
            {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 17]}
        ]
    }
    conds.extend([
        {'op': 'ge', 'args': [ip_total, 40]},
        {'op': 'le', 'args': [ip_total, 1500]},
        {'op': 'eq', 'args': [
            frame_len,
            {
                'op': 'ite',
                'args': [
                    {'op': 'le', 'args': [ip_total, 46]},
                    60,
                    {'op': 'add', 'args': [14, ip_total]}
                ]
            }
        ]}
    ])
    return _make_and(conds)


def couple_tcp(model):
    """
    Couple preassembled link and TCP components into a finite offline IR model.
    """
    if not isinstance(model, dict):
        raise ValueError('model must be a dict')
    if model.get('states') != ['COMPOSED']:
        raise ValueError('expected singleton COMPOSED state')

    new_model = copy.deepcopy(model)

    # Add owner variable
    new_model.setdefault('variables', {})['ip_pending_owner'] = {
        'type': 'string',
        'initial': 'none'
    }

        # Update existing UDP pending packet owner transitions
    for _tr in new_model['transitions']:
        if 'actions' not in _tr:
            continue
        _new_actions = []
        for _act in _tr['actions']:
            _new_actions.append(_act)
            if isinstance(_act, dict) and _act.get('set') and _act['set'].get('var') == 'L.pending_packet':
                _val = _act['set'].get('value')
                if isinstance(_val, dict) and set(_val.keys()) == {'bytes'} and _val['bytes'] == []:
                    _new_actions.append({'set': {'var': 'ip_pending_owner', 'value': 'none'}})
                elif isinstance(_val, dict) and set(_val.keys()) == {'var'} and _val['var'] == 'L.packet':
                    _new_actions.append({'set': {'var': 'ip_pending_owner', 'value': 'UDP'}})
                else:
                    raise ValueError(f'unsupported L.pending_packet value shape: {_val}')
        _tr['actions'] = _new_actions
    # Add owner invariant
    if 'invariants' not in new_model:
        new_model['invariants'] = []
    new_model['invariants'].append({
        'id': 'IP-PENDING-OWNER',
        'requirements': ['CROSS-IP-LINK'],
        'assert': _make_and([
            _make_or([
                {'op': 'eq', 'args': [{'var': 'ip_pending_owner'}, 'none']},
                _make_or([
                    {'op': 'eq', 'args': [{'var': 'ip_pending_owner'}, 'UDP']},
                    {'op': 'eq', 'args': [{'var': 'ip_pending_owner'}, 'TCP']}
                ])
            ]),
            {'op': 'eq', 'args': [
                {'op': 'eq', 'args': [{'var': 'ip_pending_owner'}, 'none']},
                {'op': 'eq', 'args': [{'op': 'bytes_len', 'args': [{'var': 'L.pending_packet'}]}, 0]}
            ]}
        ])
    })

    # Add requirement entries
    new_model.setdefault('requirements', {})
    new_model['requirements']['CROSS-IP-LINK'] = {
        'source': 'docs/tcp-ipv4-endpoint.md',
        'kind': 'modeling_choice',
        'interpretation': 'finite explicit automatic ARP and shared latest raw IP pending slot; not an RFC mandated queue policy'
    }
    new_model['requirements']['TCP-IP-FRAME-DROP'] = {
        'source': 'docs/tcp-ipv4-endpoint.md',
        'kind': 'modeling_choice',
        'interpretation': 'explicit drop for bounds-only malformed TCP IP total length, declared finite policy'
    }

    # Transform T.net.packet to L.net.frame
    new_transitions = []
    for tr in new_model.get('transitions', []):
        if tr.get('event') == 'T.net.packet':
            new_tr = copy.deepcopy(tr)
            new_tr['event'] = 'L.net.frame'
            if 'guard' in new_tr:
                new_tr['guard'] = _replace_packet_leaf(new_tr['guard'])
                new_tr['guard'] = _make_and([new_tr['guard'], _tcp_frame_envelope_guard()])
            else:
                new_tr['guard'] = _tcp_frame_envelope_guard()
            if 'actions' in new_tr:
                new_tr['actions'] = _replace_packet_leaf(new_tr['actions'])
            if 'requirements' not in new_tr:
                new_tr['requirements'] = []
            if 'CROSS-IP-LINK' not in new_tr['requirements']:
                new_tr['requirements'].append('CROSS-IP-LINK')
            new_transitions.append(new_tr)
        else:
            new_transitions.append(tr)
    new_model['transitions'] = new_transitions

    # Transform T.ipv4.tx emissions into ARP-aware Ethernet emissions
    new_transitions = []
    for tr in new_model['transitions']:
        # Find T.ipv4.tx emit in actions
        actions = tr.get('actions', [])
        emit_indices = [i for i, act in enumerate(actions)
                        if isinstance(act, dict)
                        and act.get('emit')
                        and act['emit'].get('message') == 'T.ipv4.tx']
        if not emit_indices:
            new_transitions.append(tr)
            continue
        if len(emit_indices) != 1:
            raise ValueError('T.ipv4.tx transition must contain exactly one T.ipv4.tx emit')
        emit_idx = emit_indices[0]
        emit_action = actions[emit_idx]
        if not isinstance(emit_action, dict) or 'emit' not in emit_action or not isinstance(emit_action['emit'], dict) or 'fields' not in emit_action['emit'] or not isinstance(emit_action['emit']['fields'], dict):
            raise ValueError('invalid T.ipv4.tx emit shape')
        if set(emit_action['emit']['fields'].keys()) != {'packet'}:
            raise ValueError('invalid T.ipv4.tx emit fields')
        original_packet_expr = emit_action['emit']['fields']['packet']
        pre_actions = copy.deepcopy(actions[:emit_idx])
        post_actions = copy.deepcopy(actions[emit_idx + 1:])
        if 'guard' not in tr:
            raise ValueError('T.ipv4.tx transition missing guard')
        base_guard = tr['guard']

        # ARP request frame expression (copied from L.UDP-SEND-EMPTY arp_start_suffix)
        arp_emit_frame = {
            'op': 'bytes_concat',
            'args': [
                {'op': 'bytes_concat', 'args': [
                    {'op': 'bytes_concat', 'args': [
                        {'op': 'bytes_concat', 'args': [
                            {'op': 'bytes_concat', 'args': [
                                {'op': 'bytes_concat', 'args': [
                                    {'op': 'bytes_concat', 'args': [
                                        {'bytes': [255, 255, 255, 255, 255, 255]},
                                        {'bytes': [2, 0, 0, 0, 0, 1]}
                                    ]},
                                    {'bytes': [8, 6, 0, 1, 8, 0, 6, 4, 0, 1]}
                                ]},
                                {'bytes': [2, 0, 0, 0, 0, 1]}
                            ]},
                            {'bytes': [192, 0, 2, 1]}
                        ]},
                        {'bytes': [0, 0, 0, 0, 0, 0]}
                    ]},
                    {'bytes': [192, 0, 2, 2]}
                ]},
                {'bytes': [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]}
            ]
        }

        # EMPTY clone
        guard_empty = {'op': 'and', 'args': [
            base_guard,
            {'op': 'eq', 'args': [{'var': 'L.control'}, 'EMPTY']}
        ]}
        actions_empty = copy.deepcopy(pre_actions)
        actions_empty.append({'set': {'var': 'L.pending_packet', 'value': original_packet_expr}})
        actions_empty.append({'set': {'var': 'ip_pending_owner', 'value': 'TCP'}})
        actions_empty.append({'set': {'var': 'L.retry_count', 'value': 0}})
        actions_empty.append({'emit': {'message': 'L.ethernet.tx', 'fields': {'frame': arp_emit_frame}}})
        actions_empty.append({'arm': {'timer': 'L.query', 'delay_ms': 1000}})
        actions_empty.append({'set': {'var': 'L.control', 'value': 'PENDING'}})
        actions_empty.extend(copy.deepcopy(post_actions))
        new_transitions.append({
            'id': tr['id'] + '-EMPTY',
            'from': 'COMPOSED',
            'to': 'COMPOSED',
            'event': tr['event'],
            'guard': guard_empty,
            'actions': actions_empty,
            'requirements': copy.deepcopy(tr.get('requirements', [])) + ([] if 'CROSS-IP-LINK' in copy.deepcopy(tr.get('requirements', [])) else ['CROSS-IP-LINK'])
        })

        # PENDING clone
        guard_pending = {'op': 'and', 'args': [
            base_guard,
            {'op': 'eq', 'args': [{'var': 'L.control'}, 'PENDING']}
        ]}
        actions_pending = copy.deepcopy(pre_actions)
        actions_pending.append({'set': {'var': 'L.pending_packet', 'value': original_packet_expr}})
        actions_pending.append({'set': {'var': 'ip_pending_owner', 'value': 'TCP'}})
        actions_pending.extend(copy.deepcopy(post_actions))
        new_transitions.append({
            'id': tr['id'] + '-PENDING',
            'from': 'COMPOSED',
            'to': 'COMPOSED',
            'event': tr['event'],
            'guard': guard_pending,
            'actions': actions_pending,
            'requirements': copy.deepcopy(tr.get('requirements', [])) + ([] if 'CROSS-IP-LINK' in copy.deepcopy(tr.get('requirements', [])) else ['CROSS-IP-LINK'])
        })

        # RESOLVED clone
        guard_resolved = {'op': 'and', 'args': [
            base_guard,
            {'op': 'eq', 'args': [{'var': 'L.control'}, 'RESOLVED']}
        ]}
        dest_mac_expr = {'var': 'L.peer_mac'}
        local_mac_expr = {'bytes': [2, 0, 0, 0, 0, 1]}
        ether_type_expr = {'bytes': [8, 0]}
        zero_buffer = {'bytes': [0] * 46}
        packet_len_expr = {'op': 'bytes_len', 'args': [original_packet_expr]}
        pad_length_expr = {
            'op': 'ite',
            'args': [
                {'op': 'le', 'args': [packet_len_expr, 45]},
                {'op': 'sub', 'args': [46, packet_len_expr]},
                0
            ]
        }
        padding_expr = {
            'op': 'bytes_slice',
            'args': [zero_buffer, 0, pad_length_expr]
        }
        frame_expr = {'op': 'bytes_concat', 'args': [{'op': 'bytes_concat', 'args': [{'op': 'bytes_concat', 'args': [{'op': 'bytes_concat', 'args': [dest_mac_expr, local_mac_expr]}, ether_type_expr]}, original_packet_expr]}, padding_expr]}
        actions_resolved = copy.deepcopy(pre_actions)
        actions_resolved.append({'emit': {'message': 'L.ethernet.tx', 'fields': {'frame': frame_expr}}})
        actions_resolved.extend(copy.deepcopy(post_actions))
        new_transitions.append({
            'id': tr['id'] + '-RESOLVED',
            'from': 'COMPOSED',
            'to': 'COMPOSED',
            'event': tr['event'],
            'guard': guard_resolved,
            'actions': actions_resolved,
            'requirements': copy.deepcopy(tr.get('requirements', [])) + ([] if 'CROSS-IP-LINK' in copy.deepcopy(tr.get('requirements', [])) else ['CROSS-IP-LINK'])
        })
    new_model['transitions'] = new_transitions

    # Split L.QUERY-FAIL-QUEUED by owner
    new_transitions = []
    for tr in new_model['transitions']:
        if tr.get('id') != 'L.QUERY-FAIL-QUEUED':
            new_transitions.append(tr)
            continue

        # UDP version
        udp_tr = copy.deepcopy(tr)
        udp_tr['guard'] = {'op': 'and', 'args': [
            tr['guard'],
            {'op': 'eq', 'args': [{'var': 'ip_pending_owner'}, 'UDP']}
        ]}
        new_actions = []
        for act in udp_tr['actions']:
            new_actions.append(act)
            if isinstance(act, dict) and act.get('set') and act['set'].get('var') == 'L.pending_packet':
                new_actions.append({'set': {'var': 'ip_pending_owner', 'value': 'none'}})
        udp_tr['actions'] = new_actions
        if 'CROSS-IP-LINK' not in udp_tr['requirements']:
            udp_tr['requirements'].append('CROSS-IP-LINK')
        udp_tr['id'] = 'L.QUERY-FAIL-QUEUED-UDP'
        new_transitions.append(udp_tr)

        # TCP version: remove udp.send_failed emit, keep others
        tcp_tr = copy.deepcopy(tr)
        tcp_tr['guard'] = {'op': 'and', 'args': [
            tr['guard'],
            {'op': 'eq', 'args': [{'var': 'ip_pending_owner'}, 'TCP']}
        ]}
        filtered_actions = [act for act in tcp_tr['actions']
                            if not (isinstance(act, dict) and act.get('emit') and act['emit'].get('message') == 'L.udp.send_failed')]
        new_actions = []
        for act in filtered_actions:
            new_actions.append(act)
            if isinstance(act, dict) and act.get('set') and act['set'].get('var') == 'L.pending_packet':
                new_actions.append({'set': {'var': 'ip_pending_owner', 'value': 'none'}})
        tcp_tr['actions'] = new_actions
        if 'CROSS-IP-LINK' not in tcp_tr['requirements']:
            tcp_tr['requirements'].append('CROSS-IP-LINK')
        tcp_tr['id'] = 'L.QUERY-FAIL-QUEUED-TCP'
        new_transitions.append(tcp_tr)

    new_model['transitions'] = new_transitions

    # Add conditional clear of pending TCP packet/owner on transitions ending in CLOSED
    new_transitions = []
    for tr in new_model['transitions']:
        actions = tr.get('actions', [])
        closes = any(isinstance(act, dict) and act.get('set') and act['set'].get('var') == 'T.control' and act['set'].get('value') == 'CLOSED'
                     for act in actions)
        if not closes:
            new_transitions.append(tr)
            continue

        condition = {'op': 'eq', 'args': [{'var': 'ip_pending_owner'}, 'TCP']}
        clear_packet_action = {
            'set': {
                'var': 'L.pending_packet',
                'value': {
                    'op': 'ite',
                    'args': [condition, {'bytes': []}, {'var': 'L.pending_packet'}]
                }
            }
        }
        clear_owner_action = {
            'set': {
                'var': 'ip_pending_owner',
                'value': {
                    'op': 'ite',
                    'args': [condition, 'none', {'var': 'ip_pending_owner'}]
                }
            }
        }
        new_actions = [clear_packet_action, clear_owner_action] + actions
        new_tr = copy.deepcopy(tr)
        new_tr['actions'] = new_actions
        if 'requirements' not in new_tr or not isinstance(new_tr['requirements'], list):
            new_tr['requirements'] = []
        if 'CROSS-IP-LINK' not in new_tr['requirements']:
            new_tr['requirements'].append('CROSS-IP-LINK')
        new_transitions.append(new_tr)
    new_model['transitions'] = new_transitions

    # Add explicit drop rule for malformed TCP IP total length
    frame_len_expr = {'op': 'bytes_len', 'args': [{'event': 'frame'}]}
    ip_total_expr = {
        'op': 'add',
        'args': [
            {'op': 'mul', 'args': [256, {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 16]}]},
            {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 17]}
        ]
    }
    malformed_cond = {'op': 'and', 'args': [
        {'op': 'le', 'args': [ip_total_expr, 1500]},
        _make_or([
            {'op': 'le', 'args': [ip_total_expr, 39]},
            {'op': 'ge', 'args': [ip_total_expr, {'op': 'sub', 'args': [frame_len_expr, 13]}]}
        ])
    ]}

    conditions = [
        {'op': 'ge', 'args': [frame_len_expr, 60]},
        {'op': 'le', 'args': [frame_len_expr, 1514]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 0, 6]},
            {'bytes': [2, 0, 0, 0, 0, 1]}
        ]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 6, 6]},
            {'bytes': [2, 0, 0, 0, 0, 2]}
        ]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 12, 2]},
            {'bytes': [8, 0]}
        ]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 14]}, 0x45]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 15]}, 0]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 20]}, 0x40]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 21]}, 0]},
        {'op': 'ge', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 22]}, 1]},
        {'op': 'le', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 22]}, 255]},
        {'op': 'eq', 'args': [{'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 23]}, 6]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 26, 4]},
            {'bytes': [192, 0, 2, 2]}
        ]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 30, 4]},
            {'bytes': [192, 0, 2, 1]}
        ]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 34, 2]},
            {'bytes': [31, 144]}
        ]},
        {'op': 'eq', 'args': [
            {'op': 'bytes_slice', 'args': [{'event': 'frame'}, 36, 2]},
            {'bytes': [156, 64]}
        ]},
        malformed_cond
    ]
    drop_guard = _make_and(conditions)
    drop_transition = {
        'id': 'T.WIRE-DROP-IP-LENGTH-MALFORMED',
        'from': 'COMPOSED',
        'to': 'COMPOSED',
        'event': 'L.net.frame',
        'guard': drop_guard,
        'actions': [
            {'set': {'var': 'T.wire_disposition', 'value': 'drop_ip_length'}}
        ],
        'requirements': ['TCP-IP-FRAME-DROP', 'CROSS-IP-LINK']
    }
    new_model['transitions'].append(drop_transition)

    # Validate
    validate(new_model)
    return new_model
