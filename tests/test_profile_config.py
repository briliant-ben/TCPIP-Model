"""Execution configuration must be explicit and cannot relabel proof evidence."""
import copy
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest
from unittest.mock import patch

from protocol_lab.claims import build
from protocol_lab.flow import ROOT,read
from protocol_lab.ir import ModelError
from protocol_lab.profile_config import profile_group_size
from protocol_lab.profiles import run_profile
from protocol_lab.refinement import checker_sources,refine
import test_refinement as fixtures


class ProfileConfigTests(unittest.TestCase):
    def test_positive_integer_and_enabled_only_settings(self):
        self.assertEqual(profile_group_size({}),8)
        self.assertEqual(profile_group_size({'inductive_refinement':True,'inductive_refinement_group_size':1}),1)
        for value in (True,False,0,-1,1.0,'1',None):
            with self.subTest(value=value),self.assertRaises(ModelError):
                profile_group_size({'inductive_refinement':True,'inductive_refinement_group_size':value})
        for enabled in (False,None,1,'yes'):
            with self.subTest(enabled=enabled),self.assertRaises(ModelError):
                profile_group_size({'inductive_refinement':enabled,'inductive_refinement_group_size':1})

    def test_invalid_settings_fail_before_a_profile_build_is_started(self):
        with tempfile.TemporaryDirectory()as tmp:
            out=Path(tmp)/'must-not-exist'
            with self.assertRaisesRegex(ModelError,'requires enabled'):
                run_profile({'id':'invalid','inductive_refinement_group_size':1},out)
            self.assertFalse(out.exists())

    def test_optional_solver_is_not_imported_by_configuration_or_reference_profile(self):
        code="import sys,tempfile; from protocol_lab.profiles import run_profile; from protocol_lab.flow import read,ROOT; p=read(ROOT/'profiles.json')['profiles'][0]; t=tempfile.TemporaryDirectory(); run_profile(p,t.name); assert 'z3' not in sys.modules"
        result=subprocess.run([sys.executable,'-S','-c',code],cwd=ROOT,capture_output=True,text=True)
        self.assertEqual(result.returncode,0,result.stderr)

    def test_profile_dispatch_and_claim_bind_the_actual_configured_group_size(self):
        p=copy.deepcopy(read(ROOT/'profiles.json')['profiles'][0])
        p.update(inductive=True,inductive_refinement=True,inductive_refinement_group_size=1)
        with tempfile.TemporaryDirectory()as tmp,patch('protocol_lab.refinement.refine',wraps=refine)as observed:
            r=run_profile(p,tmp,formal=True,depth=2)
            self.assertEqual(observed.call_args.kwargs['group_size'],1)
            self.assertEqual(r['inductive_refinement']['status'],'not_needed_primary_pass')
            c=read(Path(tmp)/'claims.json')['claims'][3]
            self.assertEqual(c['statement']['configured_group_size'],1)
            self.assertEqual(c['statement']['actual_group_size'],1)


class RefinementConfigEvidenceTests(unittest.TestCase):
    setUp = fixtures.RefinementTests.setUp
    unknown_fixture = fixtures.RefinementTests.unknown_fixture
    artifacts = fixtures.RefinementTests.artifacts

    def test_foreign_config_cannot_reuse_passing_refinement(self):
        primary=self.unknown_fixture();r=refine(self.model,self.primary,self.out,group_size=1)
        for size in (8,2):
            with self.subTest(configured=size),self.assertRaisesRegex(ModelError,'differs from profile'):
                build(self.model,{'id':'test','inductive_refinement':True,'inductive_refinement_group_size':size},checker_sources(),[],{'status':'not_run'},primary,self.artifacts(r),refinement=r)

    def test_cli_passes_explicit_group_size_to_real_checker(self):
        self.unknown_fixture();p=self.root/'model.json';p.write_text(json.dumps(self.model))
        result=subprocess.run([sys.executable,'-m','protocol_lab','inductive-refine',str(p),'--inductive',str(self.primary),'--out',str(self.out),'--group-size','1'],cwd=ROOT,capture_output=True,text=True)
        self.assertEqual(result.returncode,0,result.stderr)
        self.assertEqual(read(self.out/'result.json')['group_size'],1)
