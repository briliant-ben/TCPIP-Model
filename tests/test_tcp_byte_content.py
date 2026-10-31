"""Actual TCP byte-observer binding, reference faults and independent step gates."""
import copy
import importlib.util
import json
from pathlib import Path
import sys
import tempfile
import unittest
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import byte_observer as observer
import content_step as step
import content_recheck as replay
from protocol_lab.ir import Machine,ModelError,load


def ready(model):
    m=Machine(model);m.dispatch('app.connect')
    m.dispatch('net.synack',dict(seq=9000,ack=1001,window=16),10)
    return m


class TCPByteContentTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.base=load(ROOT/'model/tcp-sws.json');cls.observed=load(ROOT/'model/tcp-byte-content.json')

    def test_all_inherited_rules_erased_and_every_selected_wire_site_bound(self):
        r=observer.check(self.base,self.observed)
        self.assertEqual(r['inherited_rules_checked'],209)
        self.assertEqual(len(r['selected_rules']),14)
        self.assertIn('CHOICE-CL-D-FLUSH-FIRST-FIN-WAIT-1',r['selected_rules'])

    def test_changed_guard_or_snapshot_is_rejected(self):
        for kind in ('guard','snapshot'):
            m=copy.deepcopy(self.observed);r=next(r for r in m['transitions']if r['id']=='D-QUEUE')
            if kind=='guard':r['guard']=True
            else:r['actions'][1]['set']['value']={'var':'rtx_buf'}
            with self.assertRaises(ValueError):observer.check(self.base,m)

    def test_payload_observer_cannot_hide_changed_wire_content(self):
        m=copy.deepcopy(self.observed);r=next(r for r in m['transitions']if r['id']=='CHOICE-D-FLUSH-FIRST')
        a=next(a for a in r['actions']if 'emit'in a and a['emit']['message']=='tcp_data')
        a['emit']['fields']['payload']={'bytes':[255]}
        # Also change the base: erasure alone would now pass. Exact wire binding
        # must independently reject the stale observer expression.
        base=copy.deepcopy(self.base);b=next(r for r in base['transitions']if r['id']=='CHOICE-D-FLUSH-FIRST')
        next(a for a in b['actions']if 'emit'in a and a['emit']['message']=='tcp_data')['emit']['fields']['payload']={'bytes':[255]}
        with self.assertRaisesRegex(ValueError,'Payload observer'):observer.check(base,m)

    def test_reference_queue_send_partial_ack_and_retransmission_content(self):
        m=ready(self.observed);data=[0,255,17,3,9,42]
        m.dispatch('app.send',dict(data=data),20)
        self.assertEqual(m.values['snd_buf'],data)
        m.dispatch('app.transmit',time_ms=21);m.dispatch('choice.segment',dict(count=4),21)
        self.assertEqual(m.values['bc_wire'],data[:4]);self.assertEqual(m.values['snd_buf'],data[4:])
        m.dispatch('net.ack',dict(seq=9001,ack=1003,window=16),30)
        self.assertEqual(m.values['bc_removed'],data[:2]);self.assertEqual(m.values['rtx_buf'],data[2:4])
        m.tick(221);m.tick(m.timers['rtx'])
        self.assertEqual(m.trace[-1]['transition'],'S-RETRANSMIT-WINDOW')
        self.assertEqual(m.values['bc_wire'],data[2:4]);self.assertEqual(m.values['rtx_buf'],data[2:4])

    def test_wrong_byte_order_is_detected_beyond_length_properties(self):
        m=ready(copy.deepcopy(self.observed));m.dispatch('app.send',dict(data=[0,255]),20)
        r=next(r for r in m.model['transitions']if r['id']=='D-QUEUE')
        a=next(a for a in r['actions']if 'set'in a and a['set']['var']=='snd_buf')
        a['set']['value']['args'].reverse()
        with self.assertRaisesRegex(ModelError,'BC-QUEUE'):m.dispatch('app.send',dict(data=[17]),21)

    def test_generic_full_byte_query_reconstructs_and_rehashed_fault_rejects(self):
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'source';r=step.check(ROOT/'model/tcp-byte-content.json',['D-QUEUE'],['BC-QUEUE'],out)
            self.assertEqual(r['status'],'selected_content_steps_verified')
            fresh=replay.recheck(out,Path(tmp)/'fresh')
            self.assertEqual(fresh['results'][0]['properties'][0]['query'],'unsat')
            path=out/'D-QUEUE/BC-QUEUE.smt2'
            path.write_text('(assert false)\n(check-sat)\n')
            r['files']['D-QUEUE/BC-QUEUE.smt2']=step.sha(path)
            step.write(out/'result.json',r)
            with self.assertRaisesRegex(ValueError,'complete source query differs'):
                replay.recheck(out,Path(tmp)/'rehashed-fault')

    def test_unknown_selection_and_false_source_property_never_pass(self):
        with tempfile.TemporaryDirectory(dir=ROOT/'artifacts')as tmp:
            folder=Path(tmp)
            with self.assertRaisesRegex(ValueError,'Unknown selected'):
                step.check(ROOT/'model/bytes-contract.json',['MISSING'],['BYTE-RECOMBINE'],folder/'bad-selection')
            m=json.loads((ROOT/'model/bytes-contract.json').read_text())
            m['transitions'][0]['actions'][-1]['set']['value']={'bytes':[255]}
            source=folder/'fault.json';source.write_text(json.dumps(m))
            r=step.check(source,['PROBE'],['BYTE-RECOMBINE'],folder/'false-property')
            self.assertEqual(r['status'],'property_counterexample')

if __name__=='__main__':unittest.main()
