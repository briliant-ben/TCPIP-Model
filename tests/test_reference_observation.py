"""Passive observation preserves the independently checked scenario execution."""
import copy
import json
from pathlib import Path
import unittest
from protocol_lab.flow import run_scenario,TraceContractMismatch
from protocol_lab.ir import load,ModelError
from protocol_lab.pipeline.worker import reference_case,KEYS
ROOT=Path(__file__).resolve().parents[1]

class ReferenceObservation(unittest.TestCase):
    def model(self):return load(ROOT/'model/word32-contract.json')
    def scenario(self):
        return dict(scenario_version='0.2',id='literal-two-packs-and-tick',steps=[
            dict(at_ms=0,event='pack',fields={'value':0},expect_trace=[{'at_ms':0,'emitted':[{'message':'word32.result','fields':{'packed':[0,0,0,0]}}]}]),
            dict(at_ms=0,event='pack',fields={'value':1},expect_trace=[{'at_ms':0,'emitted':[{'message':'word32.result','fields':{'packed':[0,0,0,1]}}]}]),
            dict(at_ms=5,tick=True,expect_trace=[])],settle_ms=10,
            expect={'state':'READY','variables':{'packed':[0,0,0,1]},'timers':{}})
    def project(self,m,s):
        snapshots=[];machine=run_scenario(m,s,snapshots=snapshots)
        return dict(initial=snapshots[0],operations=snapshots[1:],error=None,
                    trace=[{k:r[k]for k in KEYS}for r in machine.trace],final=machine.snapshot())

    def test_identical_old_projection_same_time_noop_and_settle(self):
        m=self.model();s=self.scenario();observed=self.project(m,s)
        self.assertEqual(observed,reference_case(m,s))
        self.assertEqual(len(observed['operations']),4)
        self.assertEqual(observed['operations'][1]['variables']['packed'],[0,0,0,1])
        self.assertEqual(observed['operations'][2],observed['operations'][3])
        self.assertEqual(run_scenario(m,s).snapshot(),observed['final'])

    def test_snapshots_do_not_alias_machine_state(self):
        snaps=[];machine=run_scenario(self.model(),self.scenario(),snapshots=snaps)
        snaps[-1]['variables']['packed'][0]=255
        self.assertEqual(machine.values['packed'],[0,0,0,1])
        self.assertEqual(snaps[0]['variables']['packed'],[0,0,0,0])

    def test_literal_trace_and_final_expectations_still_reject(self):
        for mode in ('trace','variables','timers'):
            with self.subTest(mode=mode):
                s=self.scenario()
                if mode=='trace':s['steps'][0]['expect_trace'][0]['emitted'][0]['fields']['packed']=[255]*4
                elif mode=='variables':s['expect']['variables']['packed']=[255]*4
                else:s['expect']['timers']={'invented':1}
                with self.assertRaises(ModelError):run_scenario(self.model(),s,snapshots=[])

    def test_bad_capture_container_rejected(self):
        for value in ({},(),[{'stale':True}]):
            with self.subTest(container=repr(value)),self.assertRaises(ModelError):
                run_scenario(self.model(),self.scenario(),snapshots=value)

    def test_real_timer_scenario_projection_unchanged(self):
        m=load(ROOT/'model/tcp.json');s=json.loads((ROOT/'scenarios/syn-loss.json').read_text())
        actual=self.project(m,s);self.assertEqual(actual,reference_case(m,s))
        self.assertTrue(any(r['event']['name']=='timer.syn_rto'for r in actual['trace']))

if __name__=='__main__':unittest.main()
