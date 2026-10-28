"""Standalone integration/fault tests for the independent finite data channel."""
import copy
import json
from pathlib import Path
import tempfile
import unittest

import run as driver


class PlanTests(unittest.TestCase):
    def test_reject_unsupported_inputs(self):
        source=driver.read(driver.PORT/'scenario.json')
        mutations=[lambda s:s['steps'][3].update(at_ms=22),
                   lambda s:s['steps'][2]['fields'].update(data=[True,0,1,2]),
                   lambda s:s['steps'][2]['fields'].update(data=[1,2,3]),
                   lambda s:s['environment'].update(drop_outgoing=['E1:out:0']),
                   lambda s:s['environment'].update(unknown_network_action=True),
                   lambda s:s['initial'].update(snd_nxt=123)]
        for mutation in mutations:
            with self.subTest(mutation=mutation):
                scenario=copy.deepcopy(source);mutation(scenario)
                with self.assertRaises(ValueError):driver.validate_plan(scenario)
        self.assertEqual(driver.validate_plan(source),'0080ff07')


class IndependentDataTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.temp=tempfile.TemporaryDirectory(prefix='lwip-data-test-')
        cls.out=Path(cls.temp.name)
        cls.result=driver.run(cls.out)

    @classmethod
    def tearDownClass(cls):
        cls.temp.cleanup()

    def corrupt(self, name, mutation, error):
        target=self.out/name;report=self.out/'report.json'
        old=target.read_bytes();old_report=report.read_bytes()
        try:
            mutation(target)
            r=json.loads(old_report)
            r['file_hashes'][name]=driver.digest(target)
            driver.write(report,r)
            with self.assertRaisesRegex(ValueError,error):driver.verify(self.out)
        finally:
            target.write_bytes(old);report.write_bytes(old_report)

    def test_actual_lwip_data_matches(self):
        self.assertEqual(self.result['comparison'],'match')
        packets=driver.read(self.out/'observed.json')
        payload=[p['payload'] for p in packets if p['direction']=='out' and p.get('payload')]
        self.assertEqual(payload,[[0,128,255,7]])
        self.assertEqual(driver.verify(self.out)['status'],'valid_independent_lwip_data_evidence')

    def test_rehashed_oracle_is_rejected(self):
        def change(path):
            packets=driver.read(path)
            next(p for p in packets if p.get('payload'))['payload'][0]=1
            driver.write(path,packets)
        self.corrupt('expected.json',change,'Reference output changed')

    def test_rehashed_capture_is_rejected(self):
        def change(path):
            raw=bytearray(path.read_bytes());raw[-1]^=1;path.write_bytes(raw)
        self.corrupt('capture.pcap',change,'checksum')

    def test_rehashed_execution_summary_is_rejected(self):
        target=self.out/'execution.log';report=self.out/'report.json'
        old=target.read_bytes();old_report=report.read_bytes()
        try:
            summary=copy.deepcopy(driver.SUMMARY);summary['acknowledged_bytes']=0
            driver.write(target,summary)
            r=json.loads(old_report);r['summary']=summary;r['file_hashes']['execution.log']=driver.digest(target)
            driver.write(report,r)
            with self.assertRaisesRegex(ValueError,'Execution summary changed'):driver.verify(self.out)
        finally:target.write_bytes(old);report.write_bytes(old_report)

    def test_rehashed_query_is_rejected(self):
        query=self.out/'symbolic/path.smt2';result=self.out/'symbolic/result.json';report=self.out/'report.json'
        old={p:p.read_bytes() for p in (query,result,report)}
        try:
            query.write_text('(assert true)\n(check-sat)\n')
            symbolic=driver.read(result);symbolic['smt2_sha256']=driver.digest(query);driver.write(result,symbolic)
            r=driver.read(report)
            for name in ('symbolic/path.smt2','symbolic/result.json'):r['file_hashes'][name]=driver.digest(self.out/name)
            driver.write(report,r)
            with self.assertRaisesRegex(ValueError,'differs from regenerated semantics'):driver.verify(self.out)
        finally:
            for path,data in old.items():path.write_bytes(data)

    def test_rehashed_build_command_is_rejected(self):
        def change(path):
            build=driver.read(path);build['command'][1]='-std=c11';driver.write(path,build)
        self.corrupt('build.json',change,'Build command/log changed')

    def test_missing_required_artifact_is_rejected(self):
        target=self.out/'report.json';old=target.read_bytes()
        try:
            r=json.loads(old);del r['file_hashes']['capture.pcap'];driver.write(target,r)
            with self.assertRaisesRegex(ValueError,'file set changed'):driver.verify(self.out)
        finally:target.write_bytes(old)

    def test_linux_relabelling_is_rejected(self):
        target=self.out/'report.json';old=target.read_bytes()
        try:
            r=json.loads(old);r['linux_execution']=True;driver.write(target,r)
            with self.assertRaisesRegex(ValueError,'scope relabelled'):driver.verify(self.out)
        finally:target.write_bytes(old)


if __name__=='__main__':unittest.main(verbosity=2)
