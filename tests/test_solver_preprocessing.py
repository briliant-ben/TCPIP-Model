"""Explicit exact-v1 solver preprocessing, SAT model conversion, and verifier policy binding tests."""
from pathlib import Path
import copy, json, tempfile, unittest
from unittest.mock import Mock
import z3
from protocol_lab.ir import CLOCK_SEMANTICS, load, ModelError
from protocol_lab.symbolic import Encoding, check, replay
from protocol_lab.pipeline.task import load_task, inputs, freeze_inputs, read, write, sha
from protocol_lab.pipeline import runner

ROOT=Path(__file__).resolve().parents[1]
MODEL=ROOT/'model/icmp-echo.json'
FLOW=ROOT/'flows/icmp-echo.json'

def tiny_model(overlap=False, invariant=False):
    model=json.loads('{"ir_version": "0.1", "protocol": "solver-witness-fixture", "semantics": "flat-efsm-atomic-ordered-v1", "scope": {"terminal_states": [], "excluded": []}, "states": ["S0", "S1"], "initial_state": "S0", "variables": {"x": {"type": "int", "initial": 0}}, "events": {"go": {"origin": "application", "fields": {}}}, "timers": {}, "messages": {}, "requirements": {"TEST": {"source": "tests/test_solver_preprocessing.py", "interpretation": "Initiallyx0; go setsx1. Independent scalar witness test fixture.", "kind": "modeling_choice", "strength": "test"}}, "transitions": [{"id": "SET1", "from": "S0", "to": "S1", "event": "go", "guard": true, "requirements": ["TEST"], "actions": [{"set": {"var": "x", "value": 1}}]}], "invariants": [{"id": "KEEP0", "requirements": ["TEST"], "assert": {"op": "eq", "args": [{"var": "x"}, 0]}}]}')
    if not invariant:
        model["invariants"][0]["assert"]={"op":"ge","args":[{"var":"x"},0]}
    if overlap:
        other=copy.deepcopy(model["transitions"][0]); other["id"]="SECOND"; other["actions"][0]["set"]["value"]=2; model["transitions"].append(other)
    return model

def retained(out, workspace, task_file):
    import shutil
    raw=read(ROOT/"flows/tcp-active-open.json")
    raw["id"]="solver-preprocess-real-pipeline"
    raw["formal"]["solver_preprocess"]="exact-v1"
    names={raw["model"],raw["exploration"],*raw["seeds"],*(v["path"] for v in raw["sources"])}
    for name in names:
        destination=workspace/name; destination.parent.mkdir(parents=True,exist_ok=True); shutil.copyfile(ROOT/name,destination)
    write(task_file,raw)
    result=runner.run(task_file,workspace,out)
    if result["assessment"]!="verified_event_slice":
        raise AssertionError("Actual pipeline did not pass: "+str(result["assessment"]))
    return out

class SolverPreprocessingTests(unittest.TestCase):
    def test_default_none_unchanged_and_unsupported_policy_rejected(self):
        enc=Encoding(tiny_model(),1,[],fixed_choices=[0])
        self.assertEqual(enc.solver_preprocess,'none')
        self.assertEqual(enc.solver_tactics,())
        self.assertIsInstance(enc.solver,z3.Solver)
        with self.assertRaises(ModelError):
            Encoding(tiny_model(),1,[],fixed_choices=[0],solver_preprocess='bogus')
        with self.assertRaises(ModelError):
            Encoding(tiny_model(),1,[],byte_encoding='length',solver_preprocess='exact-v1')

    def test_sat_model_converter_reconstructs_invariant_counterexample(self):
        model=tiny_model(invariant=True)
        enc=Encoding(model,1,[],fixed_choices=[0],solver_preprocess='exact-v1')
        inv=enc.expr(model['invariants'][0]['assert'], enc.frames[1])
        enc.solver.add(z3.Not(inv))
        self.assertEqual(enc.solve(),z3.sat)
        witness=enc.witness(enc.solver.model())
        self.assertEqual(witness['steps'][0]['after']['variables']['x'],1)
        result=replay(model,witness)
        self.assertEqual(result['status'],'runtime_rejected')
        self.assertEqual(result['step'],0)

    def test_exact_witness_replay_uses_reconstructed_variables(self):
        model=tiny_model()
        enc=Encoding(model,1,[],fixed_choices=[0],solver_preprocess='exact-v1')
        self.assertEqual(enc.solve(),z3.sat)
        witness=enc.witness(enc.solver.model())
        self.assertIn('initial',witness)
        self.assertEqual(witness['steps'][0]['after']['variables']['x'],1)
        self.assertEqual(replay(model,witness)['status'],'match')

    def test_rule_overlap_exists_and_conflict_witness_replays_as_runtime_rejected(self):
        model=tiny_model(overlap=True)
        query=Encoding(model,1,[],solver_preprocess='exact-v1')
        query.solver.add(z3.Or(*query.conflicts))
        self.assertEqual(query.solve(),z3.sat)
        witness_enc=Encoding(model,1,[],fixed_choices=[0],solver_preprocess='exact-v1')
        witness_enc.solver.add(z3.Or(*witness_enc.conflicts))
        self.assertEqual(witness_enc.solve(),z3.sat)
        result=replay(model,witness_enc.witness(witness_enc.solver.model()))
        self.assertEqual(result['status'],'runtime_rejected')
        self.assertEqual(result['step'],0)

    def test_recursive_checksum_definition_survives_preprocessing(self):
        model=load(MODEL)
        enc=Encoding(model,1,[],fixed_choices=[0],solver_preprocess='exact-v1')
        names=[n for n,v in model['variables'].items() if v['type']=='bytes']
        self.assertTrue(names)
        term=enc.expr({"op":"bytes_internet_checksum16","args":[{"var":names[0]}]}, enc.frames[0])
        enc.solver.add(term>=0)
        smt=enc.solver.to_smt2()
        self.assertIn('define-funs-rec',smt)
        self.assertIn("ir4_ones_sum16_checksum_instance", smt)
        self.assertIn("(bvadd", smt)
        enc.solver.add(term==65535)
        self.assertEqual(enc.solve(),z3.sat)
        self.assertEqual(enc.solver.model().eval(term).as_long(),65535)

    def test_forced_unknown_and_z3_exception_remain_unknown(self):
        enc=Encoding(tiny_model(),1,[],fixed_choices=[0],solver_preprocess='exact-v1')
        enc.solver.check=Mock(return_value=z3.unknown)
        enc.solver.reason_unknown=Mock(return_value='forced-unknown')
        self.assertEqual(enc.solve(),z3.unknown)
        self.assertEqual(enc.reason_unknown(),'forced-unknown')
        enc.solver.check=Mock(side_effect=z3.Z3Exception('forced-exception'))
        self.assertEqual(enc.solve(),z3.unknown)
        self.assertIn('forced-exception',enc.reason_unknown())

    def test_actual_icmp_all_input_depth2_60s_exact_v1(self):
        model=load(MODEL)
        report=check(model,2,[],solver_timeout_ms=60000,solver_preprocess='exact-v1')
        self.assertEqual(report['depth'],2)
        self.assertEqual(report['solver_timeout_ms'],60000)
        self.assertEqual(report['solver_preprocess'],'exact-v1')
        self.assertEqual(report['solver_tactics'],['propagate-values','solve-eqs','simplify','smt'])
        self.assertEqual(len(report['invariants']),2)
        self.assertEqual(report['status'],'bounded_pass')
        self.assertEqual(report["safety_query"],"unsat")
        self.assertEqual(report["overlap_query"],"unsat")

    def test_task_policy_admission_and_v4_rejection(self):
        task=json.loads(FLOW.read_text())
        with tempfile.NamedTemporaryFile(mode='w+',suffix='.json',dir=ROOT) as file:
            def admit(value):
                file.seek(0); file.truncate(); json.dump(value,file); file.flush(); return load_task(file.name,ROOT)
            self.assertEqual(admit(copy.deepcopy(task))['formal']['solver_preprocess'],'exact-v1')
            bad=copy.deepcopy(task); bad['formal']['solver_preprocess']='bogus'
            with self.assertRaises(ValueError): admit(bad)
            v4=copy.deepcopy(task); v4['schema']='spec-flow-task-v4'; v4['formal']={'strategy':'sequence-invariant-induction','solver_preprocess':'exact-v1'}
            with self.assertRaises(ValueError): admit(v4)

    def _rehash(self, out):
        flow=read(out/'flow.json')
        flow['outputs']={p.relative_to(out).as_posix():sha(p) for p in sorted(out.rglob('*')) if p.is_file() and p!=out/'flow.json'}
        write(out/'flow.json',flow)

    def _mutate_formal(self, out, mutator):
        q=read(out/'stages/formal/queries/result.json')
        mutator(q)
        write(out/'stages/formal/queries/result.json',q)
        s=read(out/'stages/formal/result.json')
        mutator(s['data'])
        write(out/'stages/formal/result.json',s)
        flow=read(out/'flow.json')
        mutator(flow['stages']['formal']['data'])
        write(out/'flow.json',flow)
        self._rehash(out)

    def test_rehashed_policy_tamper_is_rejected_by_verifier(self):
        self._assert_tamper_rejected('solver_preprocess',lambda d:d.update(solver_preprocess='none'))

    def test_rehashed_tactics_tamper_is_rejected_by_verifier(self):
        self._assert_tamper_rejected('solver_tactics',lambda d:d.update(solver_tactics=[]))

    def test_rehashed_source_tamper_is_rejected_by_verifier(self):
        self._assert_tamper_rejected('solver_preprocess_source',lambda d:d.update(solver_preprocess_source='z3.Solver()'))

    def test_missing_tactics_metadata_is_rejected(self):
        self._assert_tamper_rejected("solver_tactics",lambda d:d.pop("solver_tactics"))

    def test_missing_source_metadata_is_rejected(self):
        self._assert_tamper_rejected("solver_preprocess_source",lambda d:d.pop("solver_preprocess_source"))

    def _assert_tamper_rejected(self, field, mutator):
        with tempfile.TemporaryDirectory(dir=ROOT) as tmp:
            workspace=Path(tmp)/'workspace'; workspace.mkdir()
            task_file=workspace/'flow.json'
            out=Path(tmp)/'run'
            retained(out,workspace,task_file)
            self.assertEqual(runner.verify(out,workspace)['status'],'retained_evidence_consistent')
            baseline=read(out/'stages/formal/queries/result.json')
            self.assertEqual(baseline.get('solver_preprocess'),'exact-v1')
            self._mutate_formal(out,mutator)
            with self.assertRaises(ValueError) as caught:
                runner.verify(out,workspace)
            self.assertIn('solver',str(caught.exception).lower())

if __name__=='__main__':
    unittest.main()
