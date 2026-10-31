"""Full-content source binding and reference faults; not a Rocq kernel run."""
import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('byte_codegen', ROOT/'formal/rocq-bytes/compile.py')
c = importlib.util.module_from_spec(spec); spec.loader.exec_module(c)
from protocol_lab.ir import Machine, ModelError

class RocqBytesBindingTests(unittest.TestCase):
    def setUp(self): self.model = json.loads((ROOT/'model/bytes-contract.json').read_text())

    def test_ordered_full_content_contract_roundtrip(self):
        r = c.verify_text(self.model,c.render(self.model))
        self.assertEqual((r['actions'],r['invariants']),(4,1))

    def test_arbitrary_content_negative_and_out_of_range_offsets(self):
        for buffer in ([],[255,0,17],[3]*20):
            for data in ([],[0,255,1],[2]*30):
                for offset in (-100,-1,0,1,3,16,100):
                    m=copy.deepcopy(self.model);m['variables']['buffer']['initial']=buffer
                    machine=Machine(m);machine.dispatch('probe',dict(data=data,offset=offset),0)
                    self.assertEqual(machine.values['restored'],buffer+data)
                    self.assertEqual(machine.values['prefix'],(buffer+data)[:max(0,offset)])
                    self.assertEqual(machine.values['suffix'],(buffer+data)[max(0,offset):])

    def test_wrong_count_and_order_have_reference_counterexamples(self):
        for kind in ('count','order'):
            m=copy.deepcopy(self.model);a=m['transitions'][0]['actions']
            if kind=='count':a[2]['set']['value']['args'][2]=0
            else:a[0],a[1]=a[1],a[0]
            c.verify_text(m,c.render(m))
            with self.assertRaisesRegex(ModelError,'Invariant failed'):
                Machine(m).dispatch('probe',dict(data=[0,255],offset=1),0)
            with self.assertRaisesRegex(ValueError,'does not match'):
                c.verify_text(self.model,c.render(m))

    def test_field_domain_and_index_tampering_rejected(self):
        text=c.render(self.model)
        for bad in (text.replace('(IField 1%nat)','(BField 1%nat)',1),
                    text.replace('(BVar 1%nat)','(BVar 99%nat)',1),
                    text.replace('compiled_int_fields : list nat := [1%nat]','compiled_int_fields : list nat := []')):
            with self.assertRaises(ValueError):c.verify_text(self.model,bad)

    def test_extra_code_and_omitted_semantics_rejected(self):
        for extra in ('Axiom hidden : False.\n','Definition ignored := 0.\n'):
            with self.assertRaises(ValueError):c.verify_text(self.model,c.render(self.model)+extra)
        for field,value in (('guard',False),('target_cases',[{'when':True,'to':'READY'}])):
            m=copy.deepcopy(self.model);m['transitions'][0][field]=value
            with self.assertRaises(ValueError):c.render(m)
        m=copy.deepcopy(self.model);m['variables']['buffer']['type']='string'
        with self.assertRaises(ValueError):c.render(m)

    def test_byte_literals_and_initial_values_bound(self):
        m=copy.deepcopy(self.model);m['variables']['buffer']['initial']=[0,255,17]
        m['transitions'][0]['actions'][0]['set']['value']={'bytes':[255,0]}
        text=c.render(m);c.verify_text(m,text)
        with self.assertRaises(ValueError):c.verify_text(m,text.replace('[255; 0]','[0; 255]'))

    def test_fresh_generated_output_required(self):
        with tempfile.TemporaryDirectory() as tmp:
            c.generate(ROOT/'model/bytes-contract.json',tmp)
            with self.assertRaisesRegex(ValueError,'Fresh output'):c.generate(ROOT/'model/bytes-contract.json',tmp)

if __name__=='__main__':unittest.main()
