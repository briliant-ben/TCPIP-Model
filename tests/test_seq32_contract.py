"""Declared IR scalar laws, including wrap and unbounded signed displacement."""
import copy
from pathlib import Path
import sys
import tempfile
import unittest
ROOT=Path(__file__).resolve().parents[1]
sys.path.insert(0,str(ROOT/'formal'))
import modular_normalization as norm
from protocol_lab.ir import load,Machine
from protocol_lab.symbolic import Encoding,crosscheck_trace,replay
import z3


class Seq32ContractTests(unittest.TestCase):
    def test_reference_and_independent_fixed_trace_at_wrap_and_large_offsets(self):
        cases=[(0,2**32-1,-1),(2**32-1,0,1),(2**31,0,-2**70+3),(0,2**31,2**70+7)]
        for a,b,offset in cases:
            with self.subTest(a=a,b=b,offset=offset):
                model=load(ROOT/'model/seq32-contract.json');machine=Machine(model)
                machine.dispatch('probe',dict(left=a,right=b,offset=offset),0)
                self.assertEqual(machine.values['roundtrip'],b)
                self.assertEqual(machine.values['restored'],a)
                self.assertEqual(crosscheck_trace(model,machine.trace)['status'],'match')

    def test_all_input_domains_have_verified_modular_query_normalization(self):
        with tempfile.TemporaryDirectory()as tmp:
            model=load(ROOT/'model/seq32-contract.json')
            enc=Encoding(model,1,(),sequence_encoding='modular-int')
            enc.solver.add(z3.Int('choice_0')==0,z3.Not(z3.And(*[enc.expr(i['assert'],enc.frames[1])for i in model['invariants']])))
            source=Path(tmp)/'source.smt2';source.write_text(enc.solver.to_smt2());out=Path(tmp)/'normalized'
            result=norm.produce(source,out);self.assertGreater(result['rewrite_count'],0)
            norm.verify(out)
            self.assertEqual(norm.cli(out/'normalized.smt2',Path(tmp)/'solver.log')['query'],'unsat')

    def test_reversed_distance_and_wrong_inverse_have_replayable_failures(self):
        for inverse in (False,True):
            with self.subTest(inverse=inverse):
                model=copy.deepcopy(load(ROOT/'model/seq32-contract.json'))
                if inverse:model['transitions'][0]['actions'][-1]['set']['value']['args'][1]={'var':'offset'}
                else:model['transitions'][0]['actions'][3]['set']['value']['args'].reverse()
                # Search may remain unknown; exhibit a legal typed counterexample.
                enc=Encoding(model,1,(),fixed_choices=[0])
                for name,value in dict(left=0,right=1,offset=1).items():
                    enc.solver.add(enc.events[0]['probe'][name]==enc.literal(value,model['events']['probe']['fields'][name]))
                enc.solver.add(z3.Not(z3.And(*[enc.expr(i['assert'],enc.frames[1])for i in model['invariants']])))
                self.assertEqual(enc.solve(),z3.sat)
                result=replay(model,enc.witness(enc.solver.model()))
                self.assertEqual(result['status'],'runtime_rejected')
                expected='SEQ32-INVERSE-DISPLACEMENT'if inverse else'SEQ32-ROUNDTRIP'
                self.assertIn('Invariant failed: '+expected,result['error'])


if __name__=='__main__':unittest.main()
