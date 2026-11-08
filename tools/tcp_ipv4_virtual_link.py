"""Pinned offline IR transformation; never part of protocol execution."""
import copy
from protocol_lab.ir import validate
from protocol_lab.symbolic import model_hash

CONTRACT = {'base_semantic_sha256': 'd70dab238d34ba667ac356f1c7119c09f49ddb9fc62ea5b6aa1d0aa53d74a0b1', 'old_frame_ge': {'op': 'ge', 'args': [{'op': 'bytes_len', 'args': [{'event': 'frame'}]}, 60]}, 'old_frame_eq': {'op': 'eq', 'args': [{'op': 'bytes_len', 'args': [{'event': 'frame'}]}, {'op': 'ite', 'args': [{'op': 'le', 'args': [{'op': 'add', 'args': [{'op': 'mul', 'args': [256, {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 16]}]}, {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 17]}]}, 46]}, 60, {'op': 'add', 'args': [14, {'op': 'add', 'args': [{'op': 'mul', 'args': [256, {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 16]}]}, {'op': 'bytes_at_or_zero', 'args': [{'event': 'frame'}, 17]}]}]}]}]}, 'required_new_requirement': {'source': 'docs/tcp-ipv4-virtual-link.md', 'section': 'Specification and observation / Acceptance boundary', 'interpretation': 'Finite virtual Ethernet receive service boundary admits exact IPv4 extent or canonical padding; physical TX padding and every other protocol guard/action are unchanged.'}, 'scope_key': 'virtual_link_rx', 'scope_value': {'interface': 'virtual Ethernet service frames; no physical FCS claim', 'frame_lengths': '14+IPv4total or max(60,14+IPv4total)', 'ip_total_min': 40, 'ip_total_max': 1500, 'frame_min': 54, 'frame_max': 1514, 'physical_transmit_padding_unchanged': True}}


def _contains(node, atom):
    if node == atom:
        return True
    if isinstance(node, dict):
        return any(_contains(v, atom) for v in node.values())
    if isinstance(node, list):
        return any(_contains(v, atom) for v in node)
    return False


def build_virtual_link(model):
    if model_hash(model) != CONTRACT['base_semantic_sha256']:
        raise ValueError('Unapproved base model')
    ge, eq = CONTRACT['old_frame_ge'], CONTRACT['old_frame_eq']
    new_ge = copy.deepcopy(ge)
    new_ge['args'][1] = 54
    bare_eq = {'op': 'eq', 'args': [eq['args'][0], eq['args'][1]['args'][2]]}
    new_eq = {'op': 'or', 'args': [eq, bare_eq]}

    def rewrite(node):
        if node == ge:
            return copy.deepcopy(new_ge)
        if node == eq:
            return copy.deepcopy(new_eq)
        if isinstance(node, dict):
            return {k: rewrite(v) for k, v in node.items()}
        if isinstance(node, list):
            return [rewrite(v) for v in node]
        return node

    result = copy.deepcopy(model)
    changed = []
    for rule in result['transitions']:
        if (rule['id'][:2] == 'T.' and rule['event'] == 'L.net.frame'
                and _contains(rule['guard'], ge) and _contains(rule['guard'], eq)):
            rule['guard'] = rewrite(rule['guard'])
            rule['requirements'].append('VIRTUAL-ETHERNET-RX')
            changed.append(rule['id'])
    if len(changed) != 194:
        raise ValueError('Expected exactly 194 pinned TCP ingress rules')
    result['requirements']['VIRTUAL-ETHERNET-RX'] = copy.deepcopy(CONTRACT['required_new_requirement'])
    result['scope'][CONTRACT['scope_key']] = copy.deepcopy(CONTRACT['scope_value'])
    validate(result)
    return result
