"""Independent state representation and source-policy rejection contracts."""
import copy
from pathlib import Path
import unittest
from protocol_lab.ir import load, Machine
from protocol_lab.compose.lower_component_state import lower_component_state
ROOT=Path(__file__).resolve().parents[1]
class ComponentStateLoweringTests(unittest.TestCase):
    def test_state_predicate_cancel_delay_and_original_metadata_preserved(self):
        old=load(ROOT/'model/arp-endpoint.json');frozen=copy.deepcopy(old)
        old['transitions'][0]['guard']={'op':'and','args':[{'state':old['transitions'][0]['from']},old['transitions'][0]['guard']]}
        original=copy.deepcopy(old);new=lower_component_state(old,'control','GLOBAL')
        self.assertEqual(old,original);self.assertEqual(new['states'],['GLOBAL'])
        self.assertEqual(new['transitions'][0]['guard']['args'][1]['args'][0],{'op':'eq','args':[{'var':'control'},old['transitions'][0]['from']]})
        for a,b in zip(old['transitions'],new['transitions']):
            self.assertEqual(b['actions'][:-1],a['actions'])
            self.assertEqual(b['actions'][-1],{'set':{'var':'control','value':a['to']}})
        with self.assertRaises(ValueError):Machine(new,{'control':'INVALID'})
        self.assertEqual(frozen['variables'],old['variables'])
    def test_unsupported_version_terminal_and_collisions_reject_without_mutation(self):
        for variant in ('version','terminal','collision'):
            old=load(ROOT/'model/word32-contract.json')
            if variant=='version':old['ir_version']='0.4'
            elif variant=='terminal':old['scope']['terminal_states']=['READY']
            else:old['variables']['control']={'type':'string','initial':'READY'}
            frozen=copy.deepcopy(old)
            with self.assertRaises(ValueError):lower_component_state(old,'control','GLOBAL')
            self.assertEqual(old,frozen)
