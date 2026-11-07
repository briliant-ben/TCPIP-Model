"""RFC6864 atomic-ID extension; all wire fixtures remain synthetic here."""
import copy
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from protocol_lab.ir import load,Machine,Uncovered
from protocol_lab.flow import run_scenario,TraceContractMismatch
from protocol_lab.symbolic import crosscheck_trace
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,run
from protocol_lab.udp_observe import decode_packet
ROOT=Path(__file__).resolve().parents[1]


class AtomicReceiveTests(unittest.TestCase):
    def setUp(self):self.model=load(ROOT/'model/udp-wire-receive-atomic.json')

    def test_literal_oracle_old_id_zero_regressions_and_repeated_id_delivery(self):
        for folder in ('udp-wire-receive','udp-atomic-receive'):
            for p in (ROOT/'scenarios'/folder).glob('*.json'):
                with self.subTest(case=p.name):run_scenario(self.model,json.loads(p.read_text()))
        scene=json.loads((ROOT/'scenarios/udp-atomic-receive/same-id-twice.json').read_text())
        self.assertEqual(sum(len(r['emitted'])for r in run_scenario(self.model,scene).trace),2)

    def test_old_profile_and_non_atomic_inputs_are_not_silently_relabelled(self):
        oracle=json.loads((ROOT/'spec/udp-atomic-receive-oracle.json').read_text())
        with self.assertRaises(Uncovered):Machine(load(ROOT/'model/udp-wire-receive.json')).dispatch('net.packet',{'packet':list(bytes.fromhex(oracle['cases']['id-one']['hex']))},0)
        for raw in oracle['model_gaps'].values():
            with self.assertRaises(Uncovered):Machine(self.model).dispatch('net.packet',{'packet':list(bytes.fromhex(raw))},0)
        for c in oracle['cases'].values():
            if c['disposition']=='deliver':self.assertTrue(decode_packet(bytes.fromhex(c['hex']))['df'])

    def test_only_guards_and_provenance_change_actions_invariants_preserved(self):
        old=load(ROOT/'model/udp-wire-receive.json')
        self.assertEqual(old['invariants'],self.model['invariants'])
        for a,b in zip(old['transitions'],self.model['transitions'],strict=True):
            self.assertEqual(a['actions'],b['actions']);self.assertEqual(a['id'],b['id'])
        case=json.loads((ROOT/'scenarios/udp-atomic-receive/id-checksum-still-required.json').read_text())
        machine=run_scenario(self.model,case);self.assertEqual(machine.values['disposition'],'drop_ip_checksum')
        good=copy.deepcopy(case);good['expect']['variables']['disposition']='deliver'
        with self.assertRaises(ValueError):run_scenario(self.model,good)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_native_and_independent_fixed_input_symbolic_cases(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/udp-wire-receive-atomic.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for p in (ROOT/'scenarios/udp-atomic-receive').glob('*.json'):
                with self.subTest(case=p.name):
                    self.assertEqual(run(out/'source',out/'build',p,out/p.stem)['status'],'pass')
                    reference=run_scenario(self.model,json.loads(p.read_text()));self.assertEqual(crosscheck_trace(self.model,reference.trace)['status'],'match')
