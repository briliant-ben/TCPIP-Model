import copy
import json
from pathlib import Path
import unittest
from protocol_lab.flow import run_scenario,TraceContractMismatch
from protocol_lab.ir import load,Machine,Uncovered

ROOT=Path(__file__).resolve().parents[1]


class UdpPayloadTests(unittest.TestCase):
    def setUp(self):
        self.model=load(ROOT/'model/udp-payload.json')
        self.scenarios=[json.loads(p.read_text())for p in sorted((ROOT/'scenarios/udp-payload').glob('*.json'))]

    def test_controller_reviewed_literal_byte_contracts(self):
        self.assertEqual(len(self.scenarios),6)
        self.assertEqual(sum(len(s['steps'])for s in self.scenarios),13)
        for scenario in self.scenarios:
            with self.subTest(scenario=scenario['id']):run_scenario(self.model,scenario)

    def test_invalid_receive_metadata_is_uncovered_and_atomic(self):
        base=dict(source_port=1,destination_port=8080,length=10,checksum=1,sum_valid=True,data=[0,255])
        cases=[dict(base,**{name:value})for name in ('source_port','destination_port','length','checksum')for value in (-1,65536)]
        cases.append(dict(base,length=4105,data=[17]*4097))
        for fields in cases:
            with self.subTest(changed={k:v for k,v in fields.items()if k!='data'}):
                machine=Machine(self.model);before=machine.snapshot()
                with self.assertRaises(Uncovered):machine.dispatch('net.datagram',fields,0)
                self.assertEqual(machine.snapshot(),before)

    def test_same_length_content_shift_fails_independent_literal_oracle(self):
        bad=copy.deepcopy(self.model)
        delivery=next(r for r in bad['transitions']if r['id']=='NET-DELIVER')
        delivery['actions'][0]['set']['value']['args'][1]=1
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,self.scenarios[0])

    def test_disabled_default_checksum_fails_independent_literal_oracle(self):
        bad=copy.deepcopy(self.model);bad['variables']['checksums_enabled']['initial']=False
        with self.assertRaises(TraceContractMismatch):run_scenario(bad,self.scenarios[0])


if __name__=='__main__':unittest.main()
