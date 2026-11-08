"""Transport-only lifecycle tests; fake peers are never network evidence."""
import json
import sys
import tempfile
import time
import unittest
from contextlib import ExitStack
from pathlib import Path
from unittest.mock import Mock, patch

sys.path.insert(0, str(Path(__file__).resolve().parents[1]/'ports/linux-tcp-ipv4-peer'))
import probe


class ProbeLifecycleTests(unittest.TestCase):
    def exercise(self, gap=False, close_failure=False, capture_code=0, missing_stats=False):
        timeline = []
        original_readlink = probe.os.readlink
        raw = b'\0'*12 + b'\x08\x00' + bytes([0x45,0,0,40,0,0,0x40,0,64,6]) + b'\0'*30
        self.assertEqual(len(raw), 54)
        class Process:
            pid = 1234
            def __init__(self, name):
                self.name, self.returncode, self.stdin = name, None, Mock()
            def poll(self): return self.returncode
            def send_signal(self, _): timeline.append(self.name+'-stop-request')
            def wait(self, timeout=None):
                self.returncode = capture_code if self.name == 'capture' else -15
                timeline.append(self.name+'-stopped')
                return self.returncode
            def terminate(self): timeline.append(self.name+'-terminate')
            def kill(self): timeline.append(self.name+'-kill')
        capture, server = Process('capture'), Process('server')
        class Actor:
            def __init__(self, executable, out):
                self.process, self.closed, self.rows = Process('native'), False, []
                self.snapshot = {'timers': {}}
                self.out = Path(out); self.out.mkdir()
                (self.out/'session.json').write_text(json.dumps(dict(process_starts=1,pid=self.process.pid)))
            def operation(self, line):
                row = dict(status='error',failure='uncovered_event') if gap and self.rows else dict(status='ok')
                self.rows.append(row)
                return [row]
            def close(self):
                timeline.append('native-close');self.closed=True
                if close_failure:raise ValueError('injected close failure')
                return 0
        records = [dict(timestamp_ns=time.time_ns()-300_000_000, raw=raw)]
        model = dict(variables={}, messages={'L.ethernet.tx':dict(fields={'frame':'bytes'})}, events={'T.app.connect':dict(fields={}), 'L.net.frame':dict(origin='network',fields={'frame':'bytes'})})
        with tempfile.TemporaryDirectory() as folder:
            out = Path(folder)/'result'
            def start_capture(destination):
                (destination/'capture.pcap').write_bytes(b'fixture-not-live-pcap')
                (destination/'capture.log').write_text('tcpdump: listening on tap0\n1 packet captured\n1 packet received by filter\n0 packets dropped by kernel\n')
                if missing_stats:
                    (destination/'capture.log').write_text('tcpdump: listening on tap0\n1 packet captured\n')
                return capture,(destination/'capture.log').open('a')
            with ExitStack() as stack:
                for name, value in {
                    'preflight':lambda _: {}, 'load':lambda _: model,
                    'sha256_file':lambda _: 'fixture-source-hash',
                    'configure_peer':lambda *_: [], 'start_server':lambda _: server,
                    'start_capture':start_capture, 'Session':Actor,
                    'pcap_records':lambda _: records,
                }.items():stack.enter_context(patch.object(probe,name,value))
                stack.enter_context(patch('probe.os.readlink',side_effect=lambda n: ('net:[isolated]' if '/self/' in str(n) else 'net:[outer]') if str(n).startswith('/proc/') else original_readlink(n)))
                stack.enter_context(patch('probe.os.open',return_value=123))
                stack.enter_context(patch('probe.os.read',return_value=raw))
                stack.enter_context(patch('probe.os.close',side_effect=lambda _:timeline.append('tap-close')))
                stack.enter_context(patch('probe.fcntl.ioctl'))
                stack.enter_context(patch('probe.select.select',side_effect=[([123],[],[]),([],[],[])]))
                stack.enter_context(patch.object(sys,'argv',['probe','--out',str(out),'--model','fixture.json','--executable','fixture-native','--parent-netns','net:[outer]']))
                code=probe.main()
            report=json.loads((out/'report.json').read_text())
            links=json.loads((out/'links.json').read_text())
            self.assertEqual(bytes.fromhex(links[0]['raw']),raw)
            self.assertEqual((out/links[0]['file']).read_bytes(),raw)
            self.assertLess(timeline.index('capture-stopped'),timeline.index('server-terminate'))
            self.assertLess(timeline.index('capture-stopped'),timeline.index('native-close'))
            self.assertLess(timeline.index('capture-stopped'),timeline.index('tap-close'))
            self.assertFalse(report['full_TCP_exchange_complete'])
            self.assertFalse(report['whole_ipv4_endpoint_complete'])
            self.assertEqual(json.loads((out/'scenario.json').read_text())['steps'][-1]['fields']['frame'],list(raw))
            return code,report

    def test_success_is_only_first_ingress_diagnostic(self):
        code,r=self.exercise()
        self.assertEqual(code,0)
        self.assertEqual(r['status'],'first_ingress_diagnostic_pass')

    def test_model_gap_retains_capture_and_primary_error_after_close_failure(self):
        code,r=self.exercise(gap=True,close_failure=True)
        self.assertEqual(code,1)
        self.assertEqual(r['error']['category'],'model_gap')
        self.assertTrue(any(e['category']=='cleanup_failure' for e in r['secondary_errors']))

    def test_cleanup_failure_cannot_return_success(self):
        code,r=self.exercise(close_failure=True)
        self.assertEqual(code,1)
        self.assertEqual(r['error']['category'],'cleanup_failure')

    def test_capture_nonzero_cannot_return_success(self):
        code,r=self.exercise(capture_code=2)
        self.assertEqual(code,1)
        self.assertEqual(r['error']['category'],'capture_invalid')

    def test_missing_capture_stats_is_capture_invalid(self):
        code,r=self.exercise(missing_stats=True)
        self.assertEqual(code,1)
        self.assertEqual(r['error']['category'],'capture_invalid')

    def test_preflight_failure_never_touches_network(self):
        with tempfile.TemporaryDirectory() as folder, patch.object(sys,'argv',['probe','--out',str(Path(folder)/'out'),'--model','x','--executable','x','--parent-netns','net:[outer]']), patch.object(probe,'preflight',side_effect=RuntimeError('blocked')), patch('probe.os.open')as opened, patch('probe.fcntl.ioctl')as ioctl:
            self.assertEqual(probe.main(),1)
            opened.assert_not_called();ioctl.assert_not_called()
            report=json.loads((Path(folder)/'out/report.json').read_text())
            self.assertEqual(report['error']['category'],'blocked_preflight')


if __name__=='__main__':unittest.main()
