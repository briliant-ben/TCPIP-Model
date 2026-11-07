"""Independent interleaving bytes and rejection contracts for offline union."""
import copy
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from protocol_lab.ir import load
from protocol_lab.compose.namespace_component import namespace_component
from protocol_lab.compose.lower_component_state import lower_component_state
from protocol_lab.compose.disjoint_union import merge_disjoint_components
from protocol_lab.flow import run_scenario
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,run

ROOT=Path(__file__).resolve().parents[1]

class DisjointUnionTests(unittest.TestCase):
    def components(self):
        source=load(ROOT/'model/word32-contract.json')
        source['scope']['ordinary_labels']=['rational','clock','post']
        source['variables']['rational_label']={'type':'string','initial':'post'}
        return [namespace_component(lower_component_state(source,'control','GLOBAL'),p)[0] for p in ('first','second')]

    def test_two_components_preserve_literal_octets_and_legal_strings_in_native_c(self):
        parts=self.components();frozen=copy.deepcopy(parts);model=merge_disjoint_components(parts,'word-interleaving')
        self.assertEqual(parts,frozen)
        scene=dict(scenario_version='0.2',id='independent-two-words',initial={},steps=[
            dict(at_ms=0,event='first.pack',fields={'value':0x12345678},expect_trace=[dict(at_ms=0,emitted=[dict(message='first.word32.result',fields={'packed':[18,52,86,120]})])]),
            dict(at_ms=1,event='second.pack',fields={'value':65535},expect_trace=[dict(at_ms=1,emitted=[dict(message='second.word32.result',fields={'packed':[0,0,255,255]})])])],expect=dict(state='GLOBAL',variables={'first.packed':[18,52,86,120],'second.packed':[0,0,255,255],'first.rational_label':'post','second.rational_label':'post'},timers={}))
        run_scenario(model,scene)
        if not shutil.which('cc'):self.skipTest('C compiler unavailable')
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);p=out/'model.json';p.write_text(json.dumps(model));s=out/'scenario.json';s.write_text(json.dumps(scene))
            generate(p,out/'generated');self.assertEqual(build(out/'generated',out/'build')['status'],'pass');self.assertEqual(run(out/'generated',out/'build',s,out/'native')['status'],'pass')

    def test_duplicate_or_unsupported_semantics_reject_without_mutation(self):
        for kind in ('duplicate','extension','rational'):
            parts=self.components()
            if kind=='duplicate':parts.append(copy.deepcopy(parts[0]))
            elif kind=='extension':parts[0]['unknown_semantics']={}
            else:parts[0]['variables']['unsupported']={'type':'rational','initial':{'n':1,'d':2}}
            before=copy.deepcopy(parts)
            with self.assertRaises(ValueError):merge_disjoint_components(parts,'negative')
            self.assertEqual(parts,before)
