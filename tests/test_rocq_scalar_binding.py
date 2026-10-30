"""Source/constructor binding only; these tests do not run Rocq's kernel."""
import copy
import importlib.util
import json
from pathlib import Path
import tempfile
import unittest
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('scalar_ir_codegen',ROOT/'formal/rocq-scalar/compile.py')
c=importlib.util.module_from_spec(spec);spec.loader.exec_module(c)
from protocol_lab.ir import Machine,ModelError


class RocqScalarBindingTests(unittest.TestCase):
    def setUp(self):self.model=json.loads((ROOT/'model/seq32-contract.json').read_text())

    def test_all_seven_ordered_assignments_and_two_properties_roundtrip(self):
        result=c.verify_text(self.model,c.render(self.model))
        self.assertEqual(result['actions'],7);self.assertEqual(result['invariants'],2)

    def test_wrong_lookup_or_missing_domain_binding_is_rejected(self):
        text=c.render(self.model)
        for bad in (text.replace('(EField 0%nat)','(EField 1%nat)',1),
                    text.replace('[0%nat; 1%nat]','[0%nat]'),
                    text.replace('(EVar 4%nat)','(EVar 99%nat)',1)):
            with self.assertRaisesRegex(ValueError,'does not match|outside source'):c.verify_text(self.model,bad)

    def test_reordered_source_is_distinct_and_remains_a_semantic_fault(self):
        changed=copy.deepcopy(self.model);actions=changed['transitions'][0]['actions'];actions[3],actions[4]=actions[4],actions[3]
        text=c.render(changed);c.verify_text(changed,text)
        with self.assertRaisesRegex(ValueError,'does not match'):c.verify_text(self.model,text)
        with self.assertRaisesRegex(ModelError,'Invariant failed'):
            Machine(changed).dispatch('probe',dict(left=0,right=1,offset=1),0)

    def test_hidden_axiom_or_extra_generated_definition_is_rejected(self):
        for extra in ('Axiom injected : False.\n','Definition hidden := 0.\n'):
            with self.assertRaisesRegex(ValueError,'unexpected definitions'):c.verify_text(self.model,c.render(self.model)+extra)

    def test_unsupported_guard_type_and_action_are_not_silently_omitted(self):
        guard=copy.deepcopy(self.model);guard['transitions'][0]['guard']=False
        typed=copy.deepcopy(self.model);typed['variables']['flag']={'type':'bool','initial':False}
        extended=copy.deepcopy(self.model);extended['transitions'][0]['target_cases']=[{'when':True,'to':'READY'}]
        for model in (guard,typed,extended):
            with self.assertRaises(ValueError):c.render(model)

    def test_initial_values_and_negative_integer_literals_are_bound(self):
        model=copy.deepcopy(self.model);model['variables']['offset']['initial']=-17
        model['transitions'][0]['actions'][2]['set']['value']=-19
        text=c.render(model);self.assertIn('(- 17)',text);c.verify_text(model,text)
        with self.assertRaisesRegex(ValueError,'does not match'):c.verify_text(model,text.replace('(- 17)','(- 18)'))

    def test_accepted_generated_module_cannot_be_overwritten(self):
        with tempfile.TemporaryDirectory()as tmp:
            c.generate(ROOT/'model/seq32-contract.json',tmp)
            with self.assertRaisesRegex(ValueError,'Fresh output'):c.generate(ROOT/'model/seq32-contract.json',tmp)


if __name__=='__main__':unittest.main()
