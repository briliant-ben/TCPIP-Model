"""Component scopes and query reconstruction must survive rehashed-artifact faults."""
import copy
import tempfile
from pathlib import Path
import unittest
from formal.component_induction import prove, verify, digest
from protocol_lab.flow import read, write
from protocol_lab.ir import CLOCK_SEMANTICS, ModelError, load


def op(name, *args): return {'op': name, 'args': list(args)}
def v(name): return {'var': name}
def set_(name, value): return {'set': {'var': name, 'value': value}}


def models(folder, bad=False):
    number = {'event': 'n'}
    parent = dict(ir_version='0.3', semantics=CLOCK_SEMANTICS, protocol='toy-queue',
        states=['S'], initial_state='S', scope={'terminal_states': []},
        variables={n: {'type': 'int', 'initial': 0} for n in ['pending', 'written']},
        events={n: {'origin': 'application', 'fields': {'n': 'int'}} for n in ['app.write', 'app.flush']},
        messages={}, timers={}, requirements={'R': {'source': 'docs/semantics.md', 'interpretation': 'Synthetic checker test only'}},
        invariants=[{'id': 'P', 'assert': op('and', op('ge', v('pending'), 0), op('ge', v('written'), 0)), 'requirements': ['R']}],
        transitions=[dict(id='WRITE', event='app.write', **{'from': 'S', 'to': 'S'}, guard=op('ge', number, 0),
            actions=[set_('pending', op('add', v('pending'), number)), set_('written', op('add', v('written'), number))], requirements=['R']),
            dict(id='FLUSH', event='app.flush', **{'from': 'S', 'to': 'S'},
                guard=op('and', op('ge', number, 0), op('le', number, v('pending'))),
                actions=[set_('pending', op('sub', v('pending'), number))], requirements=['R'])])
    child = dict(ir_version='0.3', semantics=CLOCK_SEMANTICS, extends='parent.json', protocol='toy-ledger',
        variables={'emitted': {'type': 'int', 'initial': 0}},
        amend_transitions=[{'id': 'FLUSH', 'append_actions': [set_('emitted', op('add', v('emitted'),
            op('mul', number, 2) if bad else number))]}],
        invariants=[{'id': 'B', 'assert': op('le', op('add', v('emitted'), v('pending')), v('written')), 'requirements': ['R']}])
    write(folder / 'parent.json', parent); write(folder / 'child.json', child)
    return load(folder / 'child.json'), load(folder / 'parent.json')


class ComponentInductionTests(unittest.TestCase):
    def test_property_only_scope_and_every_target_clock_initial_are_verified(self):
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp); model, parent = models(folder)
            result = prove(model, parent, 'B', folder / 'proof')
            self.assertEqual(result['status'], 'conditional_component_preservation_pass')
            self.assertEqual(len(result['queries']), 4)
            self.assertEqual(result['assumed_pre_invariants'], ['P', 'B'])
            self.assertIn('whole-model induction', result['does_not_prove'])
            self.assertEqual(verify(model, parent, 'B', folder / 'proof')['status'], 'valid_conditional_component_preservation')

    def test_incorrect_double_credit_produces_arbitrary_prestate_counterexample(self):
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp); model, parent = models(folder, bad=True)
            result = prove(model, parent, 'B', folder / 'proof')
            self.assertEqual(result['status'], 'component_obligation_failure')
            row = next(r for r in result['queries'] if r['label'] == 'FLUSH -> S')
            self.assertEqual(row['query'], 'sat')
            self.assertEqual(row['classification'], 'arbitrary_prestate_component_failure_not_reachability_proof')

    def test_rehashed_query_scope_and_missing_query_are_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp); model, parent = models(folder); out = folder / 'proof'
            original = prove(model, parent, 'B', out)
            changed = copy.deepcopy(original); changed['does_not_prove'] = []
            write(out / 'result.json', changed)
            with self.assertRaisesRegex(ModelError, 'scope changed'): verify(model, parent, 'B', out)
            changed = copy.deepcopy(original); changed['queries'].pop()
            write(out / 'result.json', changed)
            with self.assertRaises(ValueError): verify(model, parent, 'B', out)
            changed = copy.deepcopy(original); target = out / changed['queries'][0]['file']
            target.write_text('(assert false)\n(check-sat)\n'); changed['queries'][0]['sha256'] = digest(target)
            write(out / 'result.json', changed)
            with self.assertRaisesRegex(ModelError, 'reconstructed component semantics'):
                verify(model, parent, 'B', out)

    def test_changed_parent_basis_cannot_be_substituted(self):
        with tempfile.TemporaryDirectory() as tmp:
            folder = Path(tmp); model, parent = models(folder); parent['invariants'][0]['assert'] = True
            with self.assertRaisesRegex(ModelError, 'unchanged subset'):
                prove(model, parent, 'B', folder / 'proof')


if __name__ == '__main__': unittest.main(verbosity=2)
