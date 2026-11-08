"""Pure offline composition of two already pinned virtual-link input profiles."""
import copy
from protocol_lab.ir import validate
from protocol_lab.symbolic import model_hash
from protocol_lab.compose.lower_component_state import lower_component_state
from protocol_lab.compose.namespace_component import namespace_component

BASE = '71003ad6b3209dea4f215c35ffea254070692e48fe69035b483c248d378ee95b'
CANONICAL = 'ab315577e4149d9fe8f969b335954a00bba29af8c24a3fb870e9ba06873b537e'
TAP = '2d74c588f2aabceff3da6497c5e1d74646288ccc29995c6f002908ca9462dca3'


def build_virtual_endpoint(base, canonical, tap):
    if (model_hash(base), model_hash(canonical), model_hash(tap)) != (BASE, CANONICAL, TAP):
        raise ValueError('Unapproved virtual-link composition inputs')
    old, _ = namespace_component(lower_component_state(canonical, 'control', 'COMPOSED'), 'L')
    new, _ = namespace_component(lower_component_state(tap, 'control', 'COMPOSED'), 'L')
    old_rules = {r['id']: r for r in old['transitions']}
    new_rules = {r['id']: r for r in new['transitions']}
    changed = [name for name in old_rules if old_rules[name]['guard'] != new_rules[name]['guard']]
    if len(changed) != 30: raise ValueError('Expected exactly30 existing UDP/ICMP ingress guards')
    result = copy.deepcopy(base)
    for rule in result['transitions']:
        name = rule['id']
        if name not in changed: continue
        if rule['guard'] != old_rules[name]['guard'] or rule['requirements'] != old_rules[name]['requirements']:
            raise ValueError('Coupled component guard/source differs from pinned canonical input')
        if old_rules[name]['actions'] != new_rules[name]['actions']:
            raise ValueError('Existing virtual-link profile changed protocol actions')
        rule['guard'] = copy.deepcopy(new_rules[name]['guard'])
        rule['requirements'] = copy.deepcopy(new_rules[name]['requirements'])
    for name in ('L.TAP-INTERFACE', 'L.TAP-EXTENT'):
        result['requirements'][name] = copy.deepcopy(new['requirements'][name])
    result['scope']['virtual_link_udp_icmp_rx'] = dict(
        interpretation='Existing pinned UDP/ICMP TAP profile guards, exact IP extent OR canonical padding, no adapter repair; physical TX unchanged',
        component_semantic_sha256=TAP, guards_changed=30,
        source='docs/ipv4-udp-icmp-tap.md', no_physical_Ethernet_or_universal_TAP_claim=True)
    validate(result)
    return result
