import copy
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch
from protocol_lab.ir import load,validate,Machine,ModelError,evaluate
from protocol_lab.symbolic import Encoding,crosscheck_trace
from protocol_lab.flow import run_scenario
from protocol_lab.codegen import generate,render
from protocol_lab.codegen.execute import build,run,commands,compare

ROOT=Path(__file__).resolve().parents[1]


class ByteAccessTests(unittest.TestCase):
    def setUp(self):self.model=load(ROOT/'model/byte-access.json')

    def test_fixed_boundaries_all_octets_and_reference_unbounded_offsets(self):
        for path in (ROOT/'scenarios/byte-access').glob('*.json'):
            with self.subTest(case=path.name):run_scenario(self.model,json.loads(path.read_text()))
        machine=Machine(self.model)
        for offset in (-(1<<128),1<<128):
            machine.dispatch('peek',{'data':[17,255],'offset':offset},0)
            self.assertEqual(machine.values['octet'],0)

    def test_old_version_wrong_types_and_length_projection_reject(self):
        for version in ('0.1','0.2','0.3','0.4'):
            bad=copy.deepcopy(self.model);bad['ir_version']=version
            with self.subTest(version=version),self.assertRaises(ModelError):validate(bad)
        bad=copy.deepcopy(self.model);bad['transitions'][0]['actions'][0]['set']['value']['args'][1]=True
        with self.assertRaises(ModelError):validate(bad)
        with self.assertRaisesRegex(ModelError,'Length projection'):Encoding(self.model,1,[],byte_encoding='length')

    def test_symbolic_range_and_out_of_bounds_for_arbitrary_sequences(self):
        import z3 as z
        enc=Encoding(self.model,1,[]);data=z.Const('arbitrary_bytes',enc.byte_sort);offset=z.Int('arbitrary_offset')
        with patch('protocol_lab.ir.evaluate',side_effect=AssertionError('reference called')):
            actual=enc.expr({'op':'bytes_at_or_zero','args':[{'event':'data'},{'event':'offset'}]},enc.frames[0],dict(data=data,offset=offset))
            for violation in (z.Or(actual<0,actual>255),z.And(z.Or(offset<0,offset>=z.Length(data)),actual!=0)):
                solver=z.Solver();solver.set(timeout=10000);solver.add(violation)
                self.assertEqual(solver.check(),z.unsat)

    def test_fixed_symbolic_content_replay(self):
        for name in ('empty','negative','first','last','past-end','signed-min','signed-max','all-octets'):
            case=json.loads((ROOT/'scenarios/byte-access'/(name+'.json')).read_text());reference=run_scenario(self.model,case)
            self.assertEqual(crosscheck_trace(self.model,reference.trace)['status'],'match')

    def test_ir4_arithmetic_stays_available_in_ir5(self):
        model=load(ROOT/'model/wire-arithmetic.json');model['ir_version']='0.5';validate(model)
        case=json.loads((ROOT/'scenarios/wire-arithmetic/rfc1071-section3.json').read_text())
        reference=run_scenario(model,case);self.assertEqual(reference.values['checksum'],0x220d)
        self.assertEqual(crosscheck_trace(model,reference.trace)['status'],'match')
        if shutil.which('cc'):
            with tempfile.TemporaryDirectory()as temporary:
                out=Path(temporary);path=out/'model.json';path.write_text(json.dumps(model))
                generate(path,out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
                self.assertEqual(run(out/'source',out/'build',ROOT/'scenarios/wire-arithmetic/rfc1071-section3.json',out/'run')['status'],'pass')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_actual_native_access_including_capacity_boundaries(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);generate(ROOT/'model/byte-access.json',out/'source');self.assertEqual(build(out/'source',out/'build')['status'],'pass')
            for i,path in enumerate(sorted((ROOT/'scenarios/byte-access').glob('*.json'))):
                self.assertEqual(run(out/'source',out/'build',path,out/str(i))['status'],'pass')
            for offset,expected in ((4095,255),(4096,0)):
                case=dict(scenario_version='0.1',id='capacity',initial={},steps=[dict(at_ms=0,event='peek',fields=dict(data=[i%256 for i in range(4096)],offset=offset))],expect=dict(state='READY',variables=dict(octet=expected),timers={}))
                path=out/(str(offset)+'.json');path.write_text(json.dumps(case))
                self.assertEqual(run(out/'source',out/'build',path,out/('capacity-'+str(offset)))['status'],'pass')

    @unittest.skipUnless(shutil.which('cc'),'Actual C99 compiler required')
    def test_wrong_valid_index_translation_fails_exact_content(self):
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);source=render(self.model);needle='return a.data[(size_t)offset];';self.assertEqual(source.count(needle),1)
            source=source.replace(needle,'return a.data[(size_t)offset+1];')
            path=out/'fault.c';path.write_text(source);subprocess.run([shutil.which('cc'),'-std=c99',str(path),'-o',str(out/'native')],check=True,capture_output=True)
            case=json.loads((ROOT/'scenarios/byte-access/first.json').read_text())
            process=subprocess.run([str(out/'native')],input=commands(self.model,case),capture_output=True,text=True,env={'PATH':''},timeout=10)
            self.assertEqual(process.returncode,0)
            self.assertEqual(compare(self.model,case,[json.loads(row)for row in process.stdout.splitlines()])['status'],'different')
