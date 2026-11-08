"""Actual reference trace ABI used by the live observation verifier."""
import importlib.util
import json
from pathlib import Path
import unittest
from protocol_lab.ir import load
from protocol_lab.pipeline.worker import reference_case
from protocol_lab.symbolic import crosscheck_trace
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('tcp_live_verifier', ROOT/'ports/linux-tcp-ipv4-peer/verify.py')
verifier=importlib.util.module_from_spec(spec);spec.loader.exec_module(verifier)


class FormalTraceContract(unittest.TestCase):
    def test_public_formal_api_gets_original_before_snapshots_not_difference_projection(self):
        model=load(ROOT/'model/tcp.json');scene=json.loads((ROOT/'scenarios/handshake.json').read_text())
        projected=reference_case(model,scene)['trace']
        raw=verifier.formal_trace_for_inputs(model,scene)
        self.assertTrue(raw)
        self.assertNotIn('before',projected[0])
        self.assertIn('before',raw[0])
        for actual, expected in zip(raw,projected):
            self.assertEqual({k:actual[k]for k in expected},expected)
        result=crosscheck_trace(model,raw)
        self.assertEqual((result['query'],result['status']),('sat','match'))
