import copy
import unittest
from pathlib import Path
from protocol_lab.ir import load
from protocol_lab.symbolic import model_hash
from tools.tcp_ipv4_virtual_link import build_virtual_link


class VirtualLinkBuilderTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.base = load(Path(__file__).resolve().parents[1]/'model/tcp-ipv4-endpoint.json')

    def test_only_pinned_rules_change_and_input_stays_immutable(self):
        before = model_hash(self.base)
        new = build_virtual_link(self.base)
        self.assertEqual(model_hash(self.base), before)
        changed = []
        for old, rule in zip(self.base['transitions'], new['transitions']):
            if old != rule:
                changed.append(rule['id'])
                self.assertEqual(rule['event'], 'L.net.frame')
                a, b = copy.deepcopy(old), copy.deepcopy(rule)
                a.pop('guard'); b.pop('guard')
                b['requirements'].remove('VIRTUAL-ETHERNET-RX')
                self.assertEqual(a, b)
        self.assertEqual(len(changed), 194)
        for key in self.base:
            if key not in ('transitions', 'requirements', 'scope'):
                self.assertEqual(new[key], self.base[key])
        self.assertEqual(len(new['transitions']), 335)
        self.assertTrue(new['scope']['virtual_link_rx']['physical_transmit_padding_unchanged'])

    def test_unapproved_model_is_rejected(self):
        bad = copy.deepcopy(self.base)
        bad['protocol'] += '-changed'
        with self.assertRaises(ValueError):
            build_virtual_link(bad)
