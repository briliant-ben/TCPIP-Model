import copy
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch
from agents.run_model_job import frozen_scenarios,validate_shape,run,write

ROOT=Path(__file__).resolve().parents[1]


class UnattendedModelJobTests(unittest.TestCase):
    def setUp(self):self.job=json.loads((ROOT/'agents/jobs/udp-payload.json').read_text())

    def test_candidate_cannot_change_interface_or_import_external_source(self):
        model=dict(events=self.job['events'],messages=self.job['messages'],states=['READY'],initial_state='READY',timers={},requirements={'x':{'source':self.job['references'][0]}})
        validate_shape(model,self.job)
        for change in ({'events':{}},{'requirements':{'x':{'source':'/private/secret'}}},{'extends':'../../other.json'}):
            with self.subTest(change=change),self.assertRaises(ValueError):validate_shape(dict(model,**change),self.job)

    def test_missing_literal_oracle_and_candidate_override_rejected(self):
        case=dict(scenario_version='0.2',initial={},expect=dict(state='READY',timers={}),steps=[dict(event='app.send',at_ms=0,fields={},expect_trace=[])])
        frozen_scenarios({'scenarios':[case]*4},self.job)
        for changed in ('initial','expect_trace'):
            bad=copy.deepcopy(case)
            if changed=='initial':bad['initial']={'checksums_enabled':False}
            else:del bad['steps'][0]['expect_trace']
            with self.assertRaises(ValueError):frozen_scenarios({'scenarios':[bad]*4},self.job)

    def test_completed_job_is_not_paid_or_executed_again(self):
        import hashlib
        path=ROOT/'agents/jobs/udp-payload.json'
        with tempfile.TemporaryDirectory()as temporary:
            out=Path(temporary);prior=dict(status='candidate_ready_for_controller',job_sha256=hashlib.sha256(path.read_bytes()).hexdigest())
            write(out/'status.json',prior)
            with patch('agents.run_model_job.request')as api,patch('agents.run_model_job.subprocess.run')as execute:
                self.assertEqual(run(path,out,ROOT,out/'ledger',out/'absent-key'),prior)
                api.assert_not_called();execute.assert_not_called()


if __name__=='__main__':unittest.main()
