import copy
import json
from pathlib import Path
import random
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch
from protocol_lab.ir import load,validate,ModelError,Machine,internet_checksum16
from protocol_lab.flow import run_scenario
from protocol_lab.symbolic import Encoding,crosscheck_trace
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,run

ROOT=Path(__file__).resolve().parents[1]


class WireArithmeticTests(unittest.TestCase):
    def setUp(self):
        self.model=load(ROOT/'model/wire-arithmetic.json')
        self.cases=sorted((ROOT/'scenarios/wire-arithmetic').glob('*.json'))

    def test_literal_contracts_and_dual_zero(self):
        for p in self.cases:
            with self.subTest(case=p.name):run_scenario(self.model,json.loads(p.read_text()))
        self.assertEqual(internet_checksum16([]),65535)
        self.assertEqual(internet_checksum16([0,0]),65535)
        self.assertEqual(internet_checksum16([255,255]),0)
        self.assertEqual(internet_checksum16([0,1,242,3,244,245,246,247]),0x220d)

    def test_old_versions_unknown_protocol_ops_and_length_projection_reject(self):
        for version in ('0.1','0.2','0.3'):
            bad=copy.deepcopy(self.model);bad['ir_version']=version
            with self.subTest(version=version),self.assertRaises(ModelError):validate(bad)
        bad=copy.deepcopy(self.model);bad['transitions'][0]['actions'][1]['set']['value']['op']='udp4_checksum_verify'
        with self.assertRaises(ModelError):validate(bad)
        with self.assertRaisesRegex(ModelError,'Length projection'):Encoding(self.model,1,[],byte_encoding='length')
        bad=copy.deepcopy(self.model);bad['semantics']='flat-efsm-atomic-ordered-post-target-v2'
        with self.assertRaisesRegex(ModelError,'atomic ordered'):validate(bad)

    def test_symbolic_packing_for_arbitrary_integers(self):
        import z3 as z
        enc=Encoding(self.model,1,[]);n=z.Int('arbitrary_packing_integer')
        expressions=[enc.expr({'op':op,'args':[{'event':'n'}]},enc.frames[0],{'n':n})for op in ('bytes_pack8_mod','bytes_pack16be_mod')]
        one,two=expressions;s=z.Solver();s.set(timeout=10000)
        s.add(z.Not(z.And(z.Length(one)==1,z.BV2Int(one[0])==n%256,z.Length(two)==2,z.BV2Int(two[0])==(n%65536)/256,z.BV2Int(two[1])==n%256)))
        self.assertEqual(s.check(),z.unsat)

    def test_symbolic_checksum_does_not_call_reference_and_covers_small_vectors(self):
        import z3 as z
        enc=Encoding(self.model,1,[]);rng=random.Random(1071)
        vectors=[([],65535),([255,255],0),([1],0xfeff),([0,1,242,3,244,245,246,247],0x220d)]
        for size in range(2,17):
            data=[rng.randrange(256)for _ in range(size)]
            # Independent byte-weighted summation for the test oracle.
            total=sum(byte*(256 if i%2==0 else 1)for i,byte in enumerate(data))
            while total>65535:total=(total&65535)+(total>>16)
            vectors.append((data,65535-total))
        with patch('protocol_lab.ir.internet_checksum16',side_effect=AssertionError('reference called')):
            for data,expected in vectors:
                term=enc.expr({'op':'bytes_internet_checksum16','args':[{'bytes':data}]},enc.frames[0])
                s=z.Solver();s.set(timeout=10000);s.add(term!=expected)
                self.assertEqual(s.check(),z.unsat,data)

    def test_fixed_input_symbolic_replay_matches_all_literal_contracts(self):
        for p in self.cases:
            with self.subTest(case=p.name):
                reference=run_scenario(self.model,json.loads(p.read_text()))
                self.assertEqual(crosscheck_trace(self.model,reference.trace)['status'],'match')

    def test_recursive_checksum_definition_survives_smt_export(self):
        import z3 as z
        enc=Encoding(self.model,1,[])
        term=enc.expr({'op':'bytes_internet_checksum16','args':[{'bytes':[255,255,255]}]},enc.frames[0])
        original=z.Solver();original.add(term!=255);smt=original.to_smt2()
        self.assertIn('define-funs-rec',smt)
        restored=z.Solver();restored.set(timeout=10000);restored.from_string(smt)
        self.assertEqual(restored.check(),z.unsat)

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_native_literals_and_capacity_boundary(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/wire-arithmetic.json',out/'source')
            self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for i,p in enumerate(self.cases):
                self.assertEqual(run(out/'source',out/'build',p,out/('case-'+str(i)))['status'],'pass')
            for size,expected in ((4096,0),(4095,255)):
                scenario=dict(scenario_version='0.1',id='capacity',initial={},steps=[dict(at_ms=0,event='probe',fields=dict(byte_value=-1,word_value=-1,data=[255]*size))],expect=dict(state='READY',variables=dict(checksum=expected),timers={}))
                p=out/('long-'+str(size)+'.json');p.write_text(json.dumps(scenario))
                self.assertEqual(run(out/'source',out/'build',p,out/('long-run-'+str(size)))['status'],'pass')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_same_length_packing_translation_fault_is_detected(self):
        from protocol_lab.codegen.execute import commands,compare
        from protocol_lab.codegen import render
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);source=render(self.model)
            original='(unsigned char)(v>>8),(unsigned char)(v&255)'
            self.assertIn(original,source)
            source=source.replace(original,'(unsigned char)(v&255),(unsigned char)(v>>8)')
            path=out/'fault.c';path.write_text(source)
            subprocess.run([shutil.which('cc'),'-std=c99',str(path),'-o',str(out/'native')],check=True,capture_output=True)
            case=json.loads((ROOT/'scenarios/wire-arithmetic/odd-carry.json').read_text())
            p=subprocess.run([str(out/'native')],input=commands(self.model,case),text=True,capture_output=True,env={'PATH':''},timeout=10)
            self.assertEqual(p.returncode,0) # length/range invariants still pass
            self.assertEqual(compare(self.model,case,[json.loads(row)for row in p.stdout.splitlines()])['status'],'different')


if __name__=='__main__':unittest.main()
