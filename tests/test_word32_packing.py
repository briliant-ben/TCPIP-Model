"""IR0.6 word packing: independent full-byte, solver and native boundaries."""
import copy
import json
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from protocol_lab.ir import load, validate, ModelError, Machine
from protocol_lab.flow import run_scenario
from protocol_lab.symbolic import Encoding, crosscheck_trace
from protocol_lab.codegen import generate, render
from protocol_lab.codegen.execute import build, run, commands, compare
from protocol_lab.sequence_induction import prove

ROOT = Path(__file__).resolve().parents[1]


def scenario(values):
    steps = []
    for value in values:
        # Independent standard-library unsigned integer encoding.
        packed = list((value % (1 << 32)).to_bytes(4, 'big'))
        steps.append(dict(at_ms=0, event='pack', fields={'value': value},
                          expect_trace=[dict(at_ms=0, emitted=[dict(
                              message='word32.result', fields={'packed': packed})])]))
    return dict(scenario_version='0.2', id='position-vectors', initial={},
                steps=steps, expect=dict(state='READY', variables={'packed': packed}, timers={}))


class Word32PackingTests(unittest.TestCase):
    def setUp(self):
        self.model = load(ROOT / 'model/word32-contract.json')
        self.cases = sorted((ROOT / 'scenarios/word32-contract').glob('*.json'))

    def test_literals_and_arbitrary_reference_integer_modulo(self):
        for path in self.cases:
            with self.subTest(case=path.name):
                run_scenario(self.model, json.loads(path.read_text()))
        values = [-(1 << 200) - 0x12345678, (1 << 200) + 0x12345678]
        run_scenario(self.model, scenario(values))

    def test_old_versions_bad_types_unknown_ops_and_unsupported_backends_reject(self):
        for version in ('0.1', '0.2', '0.3', '0.4', '0.5'):
            bad = copy.deepcopy(self.model)
            bad['ir_version'] = version
            with self.subTest(version=version), self.assertRaises(ModelError):
                validate(bad)
        for argument in (True, {'seq': 0}, {'bytes': []}):
            bad = copy.deepcopy(self.model)
            bad['transitions'][0]['actions'][0]['set']['value']['args'] = [argument]
            with self.assertRaises(ModelError):
                validate(bad)
        bad = copy.deepcopy(self.model)
        bad['transitions'][0]['actions'][0]['set']['value']['op'] = 'tcp32_pack'
        with self.assertRaisesRegex(ModelError, 'Unsupported operator'):
            validate(bad)
        with self.assertRaisesRegex(ModelError, 'Length projection'):
            Encoding(self.model, 1, [], byte_encoding='length')
        # Reject even a0.6 model without the new operator; no partial projection.
        no_pack = copy.deepcopy(self.model)
        no_pack['transitions'][0]['actions'][0]['set']['value'] = {'bytes': [0, 0, 0, 0]}
        with self.assertRaisesRegex(ModelError, 'Length projection'):
            Encoding(no_pack, 1, [], byte_encoding='length')
        with self.assertRaisesRegex(ModelError, 'IR0.4/0.5'):
            prove(self.model)
        bad = copy.deepcopy(self.model)
        bad['semantics'] = 'flat-efsm-atomic-ordered-post-target-v2'
        with self.assertRaisesRegex(ModelError, 'atomic ordered'):
            validate(bad)

    def test_arbitrary_integer_symbolic_positions_do_not_call_reference(self):
        import z3 as z
        enc = Encoding(self.model, 1, [])
        n = z.Int('arbitrary_word32_integer')
        with patch('protocol_lab.ir.evaluate', side_effect=AssertionError('Reference used')):
            packed = enc.expr({'op': 'bytes_pack32be_mod', 'args': [{'event': 'value'}]},
                              enc.frames[0], {'value': n})
            # Three exact obligations compose without a monolithic mixed
            # div/mod query: sequence positions, Int2BV modulo, and unsigned
            # concatenation weight. No assumption is added about n or bytes.
            positions = z.And(z.Length(packed) == 4, *[
                packed[index] == z.Extract(shift+7, shift, z.Int2BV(n, 32))
                for index, shift in enumerate((24, 16, 8, 0))])
            octets = [z.BitVec('independent_octet_'+str(i), 8) for i in range(4)]
            word = z.Concat(*octets)
            weighted = sum(z.BV2Int(octet) * (1 << shift)
                           for octet, shift in zip(octets, (24, 16, 8, 0)))
            properties = [positions,
                          z.BV2Int(z.Int2BV(n, 32)) == n % (1 << 32),
                          z.BV2Int(word) == weighted]
            for property in properties:
                solver = z.Solver()
                solver.set(timeout=10000)
                solver.add(z.Not(property))
                self.assertEqual(solver.check(), z.unsat)
                # A fresh context reloads exactly the exported query.
                context = z.Context()
                restored = z.Solver(ctx=context)
                restored.set(timeout=10000)
                restored.from_string(solver.to_smt2())
                self.assertEqual(restored.check(), z.unsat)

    def test_all_octets_at_all_positions_and_signed64_endpoints(self):
        values = [octet << shift for shift in (24, 16, 8, 0) for octet in range(256)]
        values += [-(1 << 63), -(1 << 63) + 1, (1 << 63) - 2, (1 << 63) - 1,
                   -1, -(1 << 32), -(1 << 32) - 1, 1 << 32, 0x80000000, 0xffffffff]
        case = scenario(values)
        run_scenario(self.model, case)
        if shutil.which('cc'):
            with tempfile.TemporaryDirectory() as temporary:
                root = Path(temporary)
                generate(ROOT / 'model/word32-contract.json', root / 'source')
                self.assertEqual(build(root / 'source', root / 'build')['status'], 'pass')
                path = root / 'vectors.json'
                path.write_text(json.dumps(case))
                self.assertEqual(run(root / 'source', root / 'build', path, root / 'run')['status'], 'pass')

    def test_literal_fixed_input_symbolic_content_replay(self):
        for path in self.cases:
            with self.subTest(case=path.name):
                reference = run_scenario(self.model, json.loads(path.read_text()))
                self.assertEqual(crosscheck_trace(self.model, reference.trace)['status'], 'match')

    def test_existing_ir5_operators_remain_supported_in_ir6(self):
        model = load(ROOT / 'model/byte-access.json')
        model['ir_version'] = '0.6'
        validate(model)
        case = json.loads((ROOT / 'scenarios/byte-access/last.json').read_text())
        reference = run_scenario(model, case)
        self.assertEqual(crosscheck_trace(model, reference.trace)['status'], 'match')
        model = load(ROOT / 'model/wire-arithmetic.json')
        model['ir_version'] = '0.6'
        case = json.loads((ROOT / 'scenarios/wire-arithmetic/rfc1071-section3.json').read_text())
        reference = run_scenario(model, case)
        self.assertEqual(reference.values['checksum'], 0x220d)
        self.assertEqual(crosscheck_trace(model, reference.trace)['status'], 'match')

    @unittest.skipUnless(shutil.which('cc'), 'Actual C99 compiler required')
    def test_wrong_endian_translation_keeps_length_but_fails_byte_oracle(self):
        source = render(self.model)
        needle = '(unsigned char)(v>>24),(unsigned char)(v>>16),(unsigned char)(v>>8),(unsigned char)(v&255)'
        self.assertEqual(source.count(needle), 1)
        source = source.replace(needle, '(unsigned char)(v&255),(unsigned char)(v>>8),(unsigned char)(v>>16),(unsigned char)(v>>24)')
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            path = root / 'wrong.c'
            path.write_text(source)
            subprocess.run([shutil.which('cc'), '-std=c99', str(path), '-o', str(root / 'native')],
                           check=True, capture_output=True)
            case = json.loads((ROOT / 'scenarios/word32-contract/asymmetric.json').read_text())
            result = subprocess.run([str(root / 'native')], input=commands(self.model, case),
                                    text=True, capture_output=True, env={'PATH': ''}, timeout=10)
            self.assertEqual(result.returncode, 0)  # Same-length invariant still passes.
            self.assertEqual(compare(self.model, case, [json.loads(row) for row in result.stdout.splitlines()])['status'], 'different')

    @unittest.skipUnless(shutil.which('cc'), 'Actual C99 compiler required')
    def test_changed_generated_source_is_not_accepted_as_native_evidence(self):
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            generate(ROOT / 'model/word32-contract.json', root / 'source')
            source = root / 'source/protocol.c'
            source.write_text(source.read_text() + '\n/* changed source */\n')
            with self.assertRaisesRegex(ValueError, 'source hash changed'):
                build(root / 'source', root / 'build')
