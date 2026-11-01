import copy
import json
from pathlib import Path
import tempfile
import unittest
from protocol_lab.ir import Machine,Uncovered,load,ModelError
from protocol_lab.flow import run_scenario
from protocol_lab.pipeline.runner import run,verify
from protocol_lab.pipeline.task import sha
import contextlib,io

ROOT=Path(__file__).resolve().parents[1]


class IPv4InputTests(unittest.TestCase):
    def packet(self,**overrides):return {**dict(version=4,ihl=5,total_length=20,available_length=20,ttl=0,header_checksum_valid=True,protocol=6),**overrides}

    def test_received_ttl_zero_and_one_preserve_delivery(self):
        model=load(ROOT/'model/ipv4-input.json')
        for ttl in (0,1):
            with self.subTest(ttl=ttl):
                machine=Machine(model);fields=self.packet();fields['ttl']=ttl
                machine.dispatch('net.ipv4',fields,0)
                self.assertEqual(machine.values['accepted'],1)
                self.assertEqual(machine.trace[-1]['emitted'][0]['fields']['ttl'],ttl)

    def test_declared_options_and_impossible_protocol_are_model_gaps(self):
        for field,value in (('ihl',6),('protocol',256)):
            machine=Machine(load(ROOT/'model/ipv4-input.json'));fields=self.packet();fields[field]=value
            with self.subTest(field=field),self.assertRaises(Uncovered):machine.dispatch('net.ipv4',fields,0)
            self.assertEqual(machine.values['accepted'],0);self.assertEqual(machine.values['discarded'],0)

    def test_unreviewed_modeler_noop_is_rejected_as_a_gap_claim(self):
        raw=json.loads((ROOT/'artifacts/server-deployment-20261101/modeler-response.json').read_text())['response']['ir']
        machine=Machine(raw);fields=self.packet();fields['ihl']=6;machine.dispatch('net.ipv4',fields,0)
        self.assertEqual(machine.trace[-1]['transition'],'IP-GAP-IHL')
        accepted=Machine(load(ROOT/'model/ipv4-input.json'))
        with self.assertRaises(Uncovered):accepted.dispatch('net.ipv4',fields,0)

    def test_independent_reviewer_count_error_is_not_a_valid_oracle(self):
        raw=json.loads((ROOT/'artifacts/server-deployment-20261101/critic-response.json').read_text())['response']['scenarios'][2]
        with self.assertRaisesRegex(ModelError,'Scenario variable mismatch'):run_scenario(load(ROOT/'model/ipv4-input.json'),raw)
        checked=json.loads((ROOT/'scenarios/ipv4-input/contract-2.json').read_text())
        self.assertEqual(run_scenario(load(ROOT/'model/ipv4-input.json'),checked).values['discarded'],4)

    def test_actual_formal_reference_native_flow(self):
        with tempfile.TemporaryDirectory()as tmp:
            task=ROOT/'flows/ipv4-input.json';out=Path(tmp)/'job'
            with contextlib.redirect_stdout(io.StringIO()):r=run(task,ROOT,out,sha(task))
            self.assertEqual(r['assessment'],'verified_event_slice')
            self.assertEqual(len(r['stages']['tests']['data']['cases']),9)
            self.assertEqual(r['stages']['tests']['data']['negative_count'],2)
            self.assertEqual(r['stages']['reference']['data']['trace_contract_steps_checked'],7)
            self.assertEqual(r['stages']['formal']['data']['safety_query'],'unsat')
            self.assertEqual(r['stages']['formal']['data']['overlap_query'],'unsat')
            self.assertEqual(verify(out,ROOT)['assessment'],'verified_event_slice')


if __name__=='__main__':unittest.main()
