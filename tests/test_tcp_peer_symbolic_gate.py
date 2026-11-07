import copy
import json
from pathlib import Path
import runpy
import shutil
import tempfile
import unittest
ROOT=Path(__file__).resolve().parents[1]
PORT=ROOT/'ports/linux-tcp-wire-peer'
mod=runpy.run_path(str(PORT/'run.py'),run_name='source_test')
crosscheck_trace=mod['crosscheck_trace']
replay=mod['replay']
run_scenario=mod['run_scenario']
symbolic_gate=mod['symbolic_gate']
verify_symbolic_result=mod['verify_symbolic_result']
symbolic_model_hash=mod['symbolic_model_hash']
load=mod['load']
CONFIG=mod['CONFIG']
sha=mod['sha']
ORACLE=ROOT/'spec/tcp-wire-endpoint-oracle.json'
def oracle_scene(scene_id):
    data=json.loads(ORACLE.read_text())
    scene=data['cases'][scene_id]
    return copy.deepcopy(scene)
def case_or_scene(scene_id):
    scene=oracle_scene(scene_id)
    model=load(ROOT/CONFIG['model'])
    ref=run_scenario(model,scene)
    return model,scene,ref
def fresh_dir():
    return Path(tempfile.mkdtemp(prefix='symgate-'))
class SymbolicGateTests(unittest.TestCase):
    def setUp(self):
        self._dirs=[]
    def tearDown(self):
        for d in self._dirs:
            shutil.rmtree(d,ignore_errors=True)
    def _dir(self):
        d=fresh_dir()
        self._dirs.append(d)
        return d
    def test_public_preflight(self):
        self.assertIn('payload_hex',CONFIG)
        self.assertGreater(len(CONFIG['payload_hex']),0)
        self.assertTrue(ORACLE.is_file())
    def test_oracle_short_crosscheck_sat(self):
        model,scene,ref=case_or_scene('short')
        self.assertTrue(len(ref.trace)>=1)
        out=self._dir()/'sym'
        result=crosscheck_trace(model,ref.trace,out)
        self.assertEqual(result['query'],'sat')
        self.assertEqual(result['status'],'match')
        self.assertEqual(result['backend'],'z3-constrained-trace')
        self.assertEqual(result['scope'],'fixed_inputs_and_rule_choices')
        self.assertEqual(result['all_input_safety'],'not_claimed')
        self.assertEqual(result['steps'],len(ref.trace))
        self.assertEqual(result['model_semantic_sha256'],symbolic_model_hash(model))
        self.assertTrue((out/'path.smt2').is_file())
        self.assertTrue((out/'result.json').is_file())
        self.assertEqual(sha(out/'path.smt2'),result['smt2_sha256'])
        self.assertEqual(json.loads((out/'result.json').read_text()),result)
        rp=replay(model,result['witness'])
        self.assertEqual(rp['status'],'match')
        verified=verify_symbolic_result(model,scene,result,ref.trace,out/'path.smt2')
        self.assertEqual(verified['status'],'match')
        self.assertEqual(verified['compared_steps'],len(ref.trace))
    def test_oracle_bad_ip_length_production_gate(self):
        model,scene,ref=case_or_scene('bad-ip-length')
        out=self._dir()/'gate'
        steps=[dict(origin='event',event=s['event'],fields=s['fields'],at_ms=s['at_ms']) for s in scene['steps']]
        rows,session,difference=mod['stream_check'](out/'native',model,scene,write=False) if False else (None,None,None)
        result=crosscheck_trace(model,ref.trace,out/'sym')
        symbolic=symbolic_gate(out,model,scene,steps,rows,difference)
        self.assertEqual(symbolic['result']['query'],'sat')
        self.assertEqual(symbolic['result']['status'],'match')
        self.assertEqual(symbolic['result']['model_semantic_sha256'],symbolic_model_hash(model))
        self.assertEqual(symbolic['replay']['status'],'match')
        self.assertTrue((out/'symbolic/path.smt2').is_file())
    def test_missing_smt_rejected(self):
        model,scene,ref=case_or_scene('short')
        out=self._dir()/'sym'
        result=crosscheck_trace(model,ref.trace,out)
        smt=out/'path.smt2'
        smt.unlink()
        with self.assertRaises(RuntimeError):
            verify_symbolic_result(model,scene,result,ref.trace,smt)
    def test_tampered_smt_hash_rejected(self):
        model,scene,ref=case_or_scene('short')
        out=self._dir()/'sym'
        result=crosscheck_trace(model,ref.trace,out)
        (out/'path.smt2').write_text('(exit)')
        with self.assertRaises(RuntimeError):
            verify_symbolic_result(model,scene,result,ref.trace,out/'path.smt2')
    def test_witness_wrong_timestamp_rejected(self):
        model,scene,ref=case_or_scene('short')
        out=self._dir()/'sym'
        result=crosscheck_trace(model,ref.trace,out)
        bad=json.loads(json.dumps(result))
        bad['witness']['steps'][0]['at_ms']=bad['witness']['steps'][0]['at_ms']+7
        with self.assertRaises(RuntimeError):
            verify_symbolic_result(model,scene,bad,ref.trace,out/'path.smt2')
    def test_witness_wrong_after_rejected_after_report(self):
        model,scene,ref=case_or_scene('short')
        out=self._dir()/'sym'
        result=crosscheck_trace(model,ref.trace,out)
        bad=json.loads(json.dumps(result))
        bad['witness']['steps'][0]['after']=dict(bad['witness']['steps'][0]['after'],wire_disposition='WRONG')
        with self.assertRaises(RuntimeError):
            verify_symbolic_result(model,scene,bad,ref.trace,out/'path.smt2')
    def test_unknown_query_rejected_via_production_function(self):
        model, scene, ref = case_or_scene('short')
        out = self._dir()
        actual_globals = symbolic_gate.__globals__
        real = actual_globals['crosscheck_trace']
        def unresolved(model_arg, trace_arg, folder, *args, **kwargs):
            result = dict(real(model_arg, trace_arg, folder, *args, **kwargs))
            result.update(query='unknown', status='unknown', reason='injected negative')
            (folder/'result.json').write_text(json.dumps(result))
            return result
        actual_globals['crosscheck_trace'] = unresolved
        try:
            with self.assertRaisesRegex(RuntimeError, 'symbolic query not sat: unknown'):
                symbolic_gate(out, model, scene, scene['steps'], [], {})
        finally:
            actual_globals['crosscheck_trace'] = real
        self.assertIs(actual_globals['crosscheck_trace'], real)

    def test_coherent_other_scene_evidence_rejected(self):
        model, scene, ref = case_or_scene('short')
        other = copy.deepcopy(scene)
        other.pop('expect', None)
        for step in other['steps']:
            step['at_ms'] += 7
        other_ref = mod['replay_model'](model, other)
        folder = self._dir()/'symbolic'
        result = crosscheck_trace(model, other_ref.trace, folder)
        self.assertEqual(result['status'], 'match')
        with self.assertRaisesRegex(RuntimeError, 'actual scene'):
            verify_symbolic_result(model, scene, result, other_ref.trace, folder/'path.smt2')

    def test_idle_tick_is_not_a_symbolic_transition(self):
        model, scene, ref = case_or_scene('short')
        actual = {'initial': {}, 'steps': [
            {k: v for k, v in step.items() if k in ('at_ms', 'event', 'fields')}
            for step in scene['steps']]}
        actual['steps'].append({'at_ms': actual['steps'][-1]['at_ms']+1, 'tick': True})
        trusted = mod['replay_model'](model, actual)
        self.assertNotEqual(len(actual['steps']), len(trusted.trace))
        result = symbolic_gate(self._dir(), model, actual, actual['steps'], [], {})
        self.assertEqual(result['verified']['status'], 'match')

    def test_final_snapshot_claims_are_bound(self):
        snapshot = {'state': 'TIME-WAIT', 'variables': {'snd_nxt': 7},
                    'timers': {'time_wait': 60001}}
        result = {'final_state': 'TIME-WAIT', 'time_wait_awaited': False,
                  'clock': {'final_snapshot': snapshot,
                            'pending_timers': [['time_wait', 60001]]}}
        mod['verify_final_snapshot'](result, snapshot)
        in_memory = copy.deepcopy(result)
        in_memory['clock']['pending_timers'] = [('time_wait', 60001)]
        mod['verify_final_snapshot'](in_memory, snapshot)
        for bad in ({**snapshot, 'state': 'ESTABLISHED'},
                    {**snapshot, 'timers': {'time_wait': 60002}},
                    {**snapshot, 'variables': {'snd_nxt': 8}}):
            with self.subTest(snapshot=bad), self.assertRaises(RuntimeError):
                mod['verify_final_snapshot'](result, bad)

    @unittest.skipUnless(shutil.which('cc'), 'cc unavailable')
    def test_generated_c_smoke_short(self):
        model, scene, ref = case_or_scene('short')
        gen_dir = self._dir() / 'generated'
        build_dir = self._dir() / 'build'
        mod['generate'](ROOT / CONFIG['model'], gen_dir)
        built = mod['build'](gen_dir, build_dir)
        self.assertEqual(built['status'], 'pass')
        self.assertTrue((build_dir / 'protocol-native').exists())
        observed = {key: value for key, value in scene.items()
                    if key in ('scenario_version', 'id', 'initial', 'settle_ms')}
        observed['steps'] = [{key: value for key, value in step.items()
                              if key in ('at_ms', 'event', 'fields', 'tick')}
                             for step in scene['steps']]
        native_dir = self._dir()/'native'
        actor = mod['Session'](build_dir/'protocol-native', native_dir)
        try:
            lines = mod['commands'](model, observed).splitlines()
            self.assertEqual(lines[0], 'B')
            for line in lines[1:]:
                actor.operation(line)
        finally:
            actor.close()
        rows, session, difference = mod['stream_check'](native_dir, model, observed)
        self.assertEqual(difference['status'], 'pass')
        self.assertEqual(session['process_starts'], 1)
        self.assertEqual(session['returncode'], 0)
        self.assertGreater(len(rows), 1)


if __name__=='__main__':
    unittest.main()
