"""Exact witness materialization; solver constraints remain independent."""
from pathlib import Path
import unittest
from unittest.mock import Mock
import z3
from protocol_lab.ir import load
from protocol_lab.symbolic import Encoding

ROOT=Path(__file__).resolve().parents[1]


class SymbolicWitnessTests(unittest.TestCase):
    def encoding(self):return Encoding(load(ROOT/'model/icmp-echo.json'),1,[],fixed_choices=[0])

    def test_large_evaluated_octets_materialize_without_repeating_original_expression(self):
        enc=self.encoding();expected=[i%256 for i in range(4096)];literal=enc.literal(expected,'bytes');value=z3.Const('uninterpreted_packet',enc.byte_sort)
        solver=z3.Solver();solver.add(value==literal);self.assertEqual(solver.check(),z3.sat)
        model=solver.model();observed=Mock();observed.eval=model.eval;calls=[]
        def evaluate(term,**kwargs):calls.append(term);return model.eval(term,**kwargs)
        observed.eval=evaluate
        self.assertEqual(enc.concrete(observed,value),expected)
        self.assertLessEqual(len(calls),2,'Original symbolic packet must not be reevaluated per octet')

    def test_empty_and_nested_concat_keep_byte_order_and_high_octets(self):
        enc=self.encoding();solver=z3.Solver();self.assertEqual(solver.check(),z3.sat);model=solver.model()
        for parts,expected in [([[],[]],[]),([[255],[0,128],[],[1,254]],[255,0,128,1,254])]:
            sequence=z3.Concat(*[enc.literal(p,'bytes')for p in parts]);self.assertEqual(enc.concrete(model,sequence),expected)
