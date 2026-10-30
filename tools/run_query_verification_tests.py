"""Run fresh query-proof unit tests with commit/input/environment evidence.

This does not verify retained host-specific proof bundles or execute a protocol
implementation/network/kernel. Real query checkpoints have separate acceptance.
"""
import argparse
import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import time
import unittest

ROOT=Path(__file__).resolve().parents[1]
sys.path[:0]=[str(ROOT),str(ROOT/'formal')]
import query_lemmas as g

PATTERNS=('test_query_lemmas.py','test_finite_specialization.py','test_modular_piecewise.py',
          'test_conditional_ssa.py','test_modular_normalization.py','test_tactic_recheck.py',
          'test_query_partition.py','test_seq32_contract.py','test_rocq_scalar_binding.py','test_data_semantics.py')


def main():
    parser=argparse.ArgumentParser(description=__doc__);parser.add_argument('--out',required=True,type=Path)
    out=parser.parse_args().out.resolve()
    if out.exists():raise ValueError('Preserve previous report; use a fresh output')
    spec=importlib.util.spec_from_file_location('frozen_query_test_inputs',ROOT/'tools/run_frozen_regression.py')
    frozen=importlib.util.module_from_spec(spec);spec.loader.exec_module(frozen)
    suite=unittest.TestSuite();loader=unittest.TestLoader()
    for pattern in PATTERNS:
        if not (ROOT/'tests'/pattern).is_file():raise ValueError('Missing selected regression source: '+pattern)
        selected=loader.discover(str(ROOT/'tests'),pattern=pattern)
        if not selected.countTestCases():raise ValueError('Empty selected test suite: '+pattern)
        suite.addTests(selected)
    before=frozen.inputs()
    for file,digest in g.versions().items():before['formal/'+file]=digest
    for pattern in PATTERNS:before['tests/'+pattern]=frozen.digest(ROOT/'tests'/pattern)
    before['tools/run_query_verification_tests.py']=frozen.digest(__file__)
    before['.github/workflows/query-verification.yml']=frozen.digest(ROOT/'.github/workflows/query-verification.yml')
    environment=frozen.environment();commit=subprocess.check_output(['git','rev-parse','HEAD'],cwd=ROOT,text=True).strip()
    out.mkdir(parents=True)
    frozen.write(out/'inputs.json',before)
    identifiers=list(frozen.cases(suite));frozen.write(out/'test-ids.json',identifiers)
    frozen.write(out/'started.json',dict(status='running',git_commit=commit,environment=environment,
        tests_discovered=len(identifiers),input_manifest_sha256=frozen.digest(out/'inputs.json')))
    start=time.monotonic();result=unittest.TextTestRunner(verbosity=2).run(suite)
    changed=[path for path,digest in before.items()if not (ROOT/path).is_file()or frozen.digest(ROOT/path)!=digest]
    environment_changed=frozen.environment()!=environment
    status='invalidated_inputs_changed'if changed else'invalidated_environment_changed'if environment_changed else'failed'if not result.wasSuccessful()else'passed_with_skips'if result.skipped else'passed'
    report=dict(status=status,git_commit=commit,source_epoch_authority='inputs.json hashes; Git commit alone does not describe uncommitted local helper sources',seconds=time.monotonic()-start,tests_discovered=len(identifiers),
        tests_run=result.testsRun,failures=len(result.failures),errors=len(result.errors),skipped=len(result.skipped),
        changed_dependencies=changed,environment_changed=environment_changed,environment=environment,
        input_manifest_sha256=frozen.digest(out/'inputs.json'),test_ids_sha256=frozen.digest(out/'test-ids.json'),
        solver_binary_sha256=g.c.sha(g.c.solver_binary()),
        retained_host_specific_artifacts_verified=False,protocol_implementation_executed=False,
        kernel_checked=False,full_protocol_proved=False,
        scope='selected unit tests with newly generated query certificates; not full discovery, retained-Mac evidence replay, kernel or Linux protocol evidence')
    frozen.write(out/'result.json',report);print(json.dumps(report),flush=True)
    return 0 if status=='passed'else 1


if __name__=='__main__':raise SystemExit(main())
