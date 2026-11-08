"""Frozen independent synthetic vectors; never live network evidence."""
import copy
import json
from pathlib import Path
import unittest
from ports.tcp_ipv4_service_observer import service_records, ipv4_frame
ROOT=Path(__file__).resolve().parents[1]


class ObserverContracts(unittest.TestCase):
    def test_frozen_udp_and_echo_shapes_empty_odd_and_mtu(self):
        config=json.loads((ROOT/'ports/linux-tcp-ipv4-peer/services.json').read_text())
        fixture=json.loads((ROOT/'spec/tcp-ipv4-service-wire-oracle.json').read_text())
        result=service_records(fixture['links'],config)
        self.assertEqual((result['UDP_exchanges'],result['ICMP_echo_exchanges']),(3,3))
        for index in [0,2,4,6,8,10]:
            bad=copy.deepcopy(fixture['links']);raw=bytearray.fromhex(bad[index]['raw']);raw[-1]^=1;bad[index]['raw']=raw.hex()
            with self.assertRaises(ValueError):service_records(bad,config)
        with self.assertRaises(ValueError):service_records(fixture['links'][:-1],config)

    def test_independent_observed_tcp_checksum_and_extent(self):
        fixture=json.loads((ROOT/'spec/tcp-ipv4-virtual-link-oracle.json').read_text())
        raw=bytes(fixture['cases'][0]['frame'])
        self.assertEqual(len(ipv4_frame(raw,'ingress')),44)
        damaged=bytearray(raw);damaged[-1]^=1
        with self.assertRaises(ValueError):ipv4_frame(bytes(damaged),'ingress')
        with self.assertRaises(ValueError):ipv4_frame(raw[:-1],'ingress')
