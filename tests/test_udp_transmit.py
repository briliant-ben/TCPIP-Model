import copy
import json
from pathlib import Path
import tempfile
import unittest
from examples.run_udp_transmit import run,observe
from protocol_lab.codegen import sha
from protocol_lab.codegen.wire_execute import write_raw_pcap
from protocol_lab.flow import run_scenario,TraceContractMismatch
from protocol_lab.ir import load,Machine
from protocol_lab.udp_observe import decode_packet,decode_pcap,compare_records

ROOT=Path(__file__).resolve().parents[1]


class UdpTransmitTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temporary=tempfile.TemporaryDirectory(prefix='native-udp-packet-')
        cls.out=Path(cls.temporary.name)/'flow'
        cls.oracle=ROOT/'spec/udp-wire-transmit-oracle.json'
        cls.result=run(ROOT,'flows/udp-wire-transmit.json',sha(ROOT/'flows/udp-wire-transmit.json'),'spec/udp-wire-transmit-oracle.json',sha(cls.oracle),cls.out)

    @classmethod
    def tearDownClass(cls):cls.temporary.cleanup()

    def test_actual_native_full_flow_and_pcap_gate(self):
        self.assertEqual(self.result['status'],'pass',self.result)
        self.assertEqual(self.result['native_packets'],9)
        self.assertEqual(self.result['fixed_oracle_cases'],6)
        self.assertFalse(self.result['linux_network_evidence'])

    def test_literal_packet_contracts_cover_reference_policy(self):
        model=load(ROOT/'model/udp-wire-transmit.json')
        for p in (ROOT/'scenarios/udp-wire-transmit').glob('*.json'):
            with self.subTest(seed=p.name):run_scenario(model,json.loads(p.read_text()))

    def test_independent_decoder_matches_all_fixed_packet_fields(self):
        oracle=json.loads(self.oracle.read_text())
        for case in oracle['cases'].values():
            for packet in case['packets']:self.assertEqual(decode_packet(bytes.fromhex(packet['hex'])),packet['decoded'])

    def test_malformed_checksums_lengths_fragments_and_pcap_reject(self):
        oracle=json.loads(self.oracle.read_text());raw=bytes.fromhex(oracle['cases']['odd-NUL']['packets'][0]['hex'])
        for index in (10,28,3,25,6):
            bad=bytearray(raw);bad[index]^=0x20 if index==6 else 1
            with self.subTest(index=index),self.assertRaises(ValueError):decode_packet(bytes(bad))
        path=Path(self.temporary.name)/'truncated.pcap';write_raw_pcap(path,[(0,raw)]);path.write_bytes(path.read_bytes()[:-1])
        with self.assertRaises(ValueError):decode_pcap(path)

    def test_missing_zero_to_ffff_mapping_fails_literal_oracle(self):
        model=load(ROOT/'model/udp-wire-transmit.json');rule=next(r for r in model['transitions']if r['id']=='TRANSMIT')
        assignment=next(a['set']for a in rule['actions']if 'set'in a and a['set']['var']=='udp_checksum')
        assignment['value']['args'][1]['args'][1]=0
        case=json.loads((ROOT/'scenarios/udp-wire-transmit/zero-mapping.json').read_text())
        with self.assertRaises(TraceContractMismatch):run_scenario(model,case)

    def test_rotated_payload_with_valid_checksums_still_differs(self):
        model=load(ROOT/'model/udp-wire-transmit.json');rule=next(r for r in model['transitions']if r['id']=='TRANSMIT')
        data={'event':'data'};length={'op':'bytes_len','args':[data]}
        rule['actions'][0]['set']['value']={'op':'bytes_concat','args':[{'op':'bytes_slice','args':[data,1,length]},{'op':'bytes_slice','args':[data,0,1]}]}
        case=json.loads((ROOT/'scenarios/udp-wire-transmit/odd-NUL.json').read_text());machine=Machine(model)
        machine.dispatch('app.send',case['steps'][0]['fields'],0)
        raw=bytes(machine.trace[-1]['emitted'][0]['fields']['packet']);decoded=decode_packet(raw)
        observed=[dict(at_ms=0,hex=raw.hex(),decoded=decoded)];expected=json.loads(self.oracle.read_text())['cases']['odd-NUL']['packets']
        self.assertEqual(compare_records(expected,observed)['status'],'different')

    def test_tampered_base_stdout_and_wrong_oracle_digest_reject(self):
        job=self.out/'job';flow=json.loads((job/'flow.json').read_text());entry=flow['stages']['execute']['data']['cases'][0]
        stdout=job/entry['stdout'];original=stdout.read_bytes()
        try:
            stdout.write_bytes(original+b' ')
            with self.assertRaisesRegex(ValueError,'artifact changed'):observe(job,self.oracle,sha(self.oracle),Path(self.temporary.name)/'bad-base')
        finally:stdout.write_bytes(original)
        with self.assertRaisesRegex(ValueError,'approved digest'):observe(job,self.oracle,'0'*64,Path(self.temporary.name)/'bad-oracle')
