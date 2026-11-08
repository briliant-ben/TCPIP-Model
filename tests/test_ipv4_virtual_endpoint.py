import copy
from pathlib import Path
import unittest
from protocol_lab.ir import load
from protocol_lab.symbolic import model_hash
from tools.ipv4_endpoint_virtual_link import build_virtual_endpoint
ROOT=Path(__file__).resolve().parents[1]


class VirtualEndpointBuilder(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.base=load(ROOT/'model/tcp-ipv4-virtual-link.json')
        cls.canonical=load(ROOT/'model/ipv4-udp-icmp-endpoint.json')
        cls.tap=load(ROOT/'model/ipv4-udp-icmp-tap.json')
    def test_exact30_existing_guard_profiles_no_tcp_arp_action_or_timer_change(self):
        old_hash=model_hash(self.base)
        result=build_virtual_endpoint(self.base,self.canonical,self.tap)
        expected=load(ROOT/'model/ipv4-endpoint-virtual-link.json')
        self.assertEqual(result,expected)
        self.assertEqual(model_hash(self.base),old_hash)
        changed=[]
        for old,new in zip(self.base['transitions'],result['transitions']):
            if old!=new:
                changed.append(new['id']);self.assertTrue(new['id'].startswith(('L.UDPRX-','L.ECHO-')))
                a,b=copy.deepcopy(old),copy.deepcopy(new)
                a.pop('guard');b.pop('guard');a.pop('requirements');b.pop('requirements');self.assertEqual(a,b)
        self.assertEqual(len(changed),30)
        for key in self.base:
            if key not in ('transitions','scope','requirements'):self.assertEqual(self.base[key],result[key])
    def test_unknown_input_hash_rejected(self):
        bad=copy.deepcopy(self.tap);bad['protocol']+='-changed'
        with self.assertRaises(ValueError):build_virtual_endpoint(self.base,self.canonical,bad)
