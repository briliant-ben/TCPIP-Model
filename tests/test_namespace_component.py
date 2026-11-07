"""Actual frozen protocol contracts for the DeepSeek offline namespace helper."""
import copy
import json
from pathlib import Path
import shutil
import tempfile
import unittest
from protocol_lab.ir import load,Machine,validate
from protocol_lab.flow import run_scenario
from protocol_lab.compose.namespace_component import namespace_component
from protocol_lab.codegen import generate
from protocol_lab.codegen.execute import build,run

ROOT=Path(__file__).resolve().parents[1]

class NamespaceComponentTests(unittest.TestCase):
    def test_field_and_literal_collision_is_preserved_with_real_native_bytes(self):
        old=load(ROOT/'model/word32-contract.json');old['events']['pack']['fields']={'packed':'int'}
        old['transitions'][0]['actions'][0]['set']['value']['args']=[{'event':'packed'}]
        old['variables']['literal']={'type':'string','initial':'packed'};frozen=copy.deepcopy(old)
        for prefix in ('one','other'):
            new,tables=namespace_component(old,prefix);validate(new);self.assertEqual(old,frozen)
            self.assertEqual(new['events'][prefix+'.pack']['fields'],{'packed':'int'})
            self.assertEqual(new['variables'][prefix+'.literal']['initial'],'packed')
            self.assertEqual(tables['variables']['packed'],prefix+'.packed')
            scene=dict(scenario_version='0.2',id='independent-word-vector',initial={},steps=[dict(at_ms=0,event=prefix+'.pack',fields={'packed':0x12345678},expect_trace=[dict(at_ms=0,emitted=[dict(message=prefix+'.word32.result',fields={'packed':[18,52,86,120]})])])],expect=dict(state='READY',variables={prefix+'.packed':[18,52,86,120],prefix+'.literal':'packed'},timers={}))
            run_scenario(new,scene)
            if prefix=='one'and shutil.which('cc'):
                with tempfile.TemporaryDirectory()as temporary:
                    out=Path(temporary);p=out/'model.json';p.write_text(json.dumps(new));s=out/'scene.json';s.write_text(json.dumps(scene))
                    generate(p,out/'generated');self.assertEqual(build(out/'generated',out/'build')['status'],'pass');self.assertEqual(run(out/'generated',out/'build',s,out/'execution')['status'],'pass')
    def test_all_frozen_arp_timers_frames_and_state_values_project_exactly(self):
        old=load(ROOT/'model/arp-endpoint.json');new,tables=namespace_component(old,'component')
        self.assertEqual(new['timers']['component.cache'],{'event':'component.timer.cache'})
        for path in sorted((ROOT/'scenarios/arp-endpoint').glob('*.json')):
            with self.subTest(case=path.name):
                scene=json.loads(path.read_text());reference=run_scenario(old,scene);machine=Machine(new,{'component.'+n:v for n,v in scene.get('initial',{}).items()})
                for step in scene['steps']:
                    if step.get('tick'):machine.tick(step['at_ms'])
                    else:machine.dispatch('component.'+step['event'],step.get('fields',{}),step['at_ms'])
                if 'settle_ms'in scene:machine.tick(scene['settle_ms'])
                self.assertEqual(len(machine.trace),len(reference.trace))
                for a,b in zip(reference.trace,machine.trace):
                    self.assertEqual(b['transition'],'component.'+a['transition']);self.assertEqual(b['time_ms'],a['time_ms'])
                    self.assertEqual(b['after']['state'],a['after']['state']);self.assertEqual(b['after']['variables'],{'component.'+n:v for n,v in a['after']['variables'].items()});self.assertEqual(b['after']['timers'],{'component.'+n:v for n,v in a['after']['timers'].items()})
                    self.assertEqual(b['emitted'],[dict(message='component.'+e['message'],fields=e['fields'])for e in a['emitted']])
    def test_unknown_source_operator_is_rejected_without_mutating_input(self):
        old=load(ROOT/'model/word32-contract.json');old['transitions'][0]['guard']={'op':'callback','args':[]};frozen=copy.deepcopy(old)
        with self.assertRaises(ValueError):namespace_component(old,'component')
        self.assertEqual(old,frozen)
