import json
import os
import struct
import tempfile
import unittest
from unittest.mock import patch, MagicMock, mock_open
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / 'ports/linux-tcp-ipv4-peer'))

import probe
from ports.tcp_ipv4_probe_support import elapsed_ms, capture_stats, pcap_records, quiet_ok, operation_result, record_error

class TestProbeHelpers(unittest.TestCase):
    def test_is_tcp_ipv4(self):
        # ARP frame
        arp = b'\xff'*12 + b'\x08\x06' + b'\x00'*46
        self.assertFalse(probe.is_tcp_ipv4(arp))
        # IPv4 UDP - correct offset: EtherType at 12:14, IPv4 header starts at 14, protocol byte at 14+9=23
        udp = b'\xff'*12 + b'\x08\x00' + b'\x45\x00' + b'\x00'*30  # First 34 bytes of frame
        udp = udp[:23] + b'\x11' + udp[24:]  # Insert protocol=17 at index 23
        self.assertFalse(probe.is_tcp_ipv4(udp))
        # IPv4 TCP
        tcp = b'\xff'*12 + b'\x08\x00' + b'\x45\x00' + b'\x00'*30
        tcp = tcp[:23] + b'\x06' + tcp[24:]  # protocol=6
        self.assertTrue(probe.is_tcp_ipv4(tcp))

    def test_save_raw_frame_preserves_bytes(self):
        raw = b'\x00\x01\x02\xff'
        with tempfile.TemporaryDirectory() as td:
            out = Path(td)
            path = probe.save_raw_frame(raw, 'ingress', 0, out)
            saved = (out / path).read_bytes()
            self.assertEqual(saved, raw)

    def test_configure_peer_commands(self):
        with patch('subprocess.run') as mock_run:
            mock_run.return_value = MagicMock(returncode=0, stdout='', stderr='')
            with tempfile.TemporaryDirectory() as td:
                out = Path(td)
                probe.configure_peer(MagicMock(), out)
                self.assertEqual(mock_run.call_count, 4)
                commands = [call.args[0] for call in mock_run.call_args_list]
                self.assertIn(['ip', 'link', 'set', 'lo', 'up'], commands)
                self.assertIn(['ip', 'link', 'set', probe.TAP_NAME, 'address', probe.PEER_MAC], commands)
                self.assertIn(['ip', 'addr', 'add', probe.PEER_IP + '/24', 'dev', probe.TAP_NAME], commands)
                self.assertIn(['ip', 'link', 'set', probe.TAP_NAME, 'mtu', '1500', 'up'], commands)

    def test_process_model_operation_error_no_forward(self):
        rows = [
            {'status': 'transition', 'emitted': []},
            {'status': 'error', 'failure': 'uncovered_event'}
        ]
        with patch('os.write') as mock_write:
            out = tempfile.mkdtemp()
            result = probe.process_model_operation(rows, MagicMock(), 0, Path(out), [], [], [])
            self.assertEqual(result['status'], 'error')
            self.assertFalse(mock_write.called)

    def test_primary_model_gap_survives_cleanup(self):
        report = {'error': None, 'secondary_errors': []}
        record_error(report, 'model_gap', 'uncovered_event')
        record_error(report, 'capture_invalid', 'bad capture')
        self.assertEqual(report['error']['category'], 'model_gap')
        self.assertEqual(len(report['secondary_errors']), 1)
        self.assertEqual(report['secondary_errors'][0]['category'], 'capture_invalid')

    def test_timer_clock_relative(self):
        origin = 1000_000_000
        sample = 1100_000_000
        self.assertEqual(elapsed_ms(origin, sample), 100)

    def test_capture_stats_missing_drop_raises(self):
        text = "1 packet captured\n1 packet received by filter\n"
        with self.assertRaises(ValueError):
            capture_stats(text)

    def test_raw_short_frame_unmodified(self):
        raw = b'\x00' * 10  # shorter than 14
        with self.assertRaises(RuntimeError):
            with tempfile.TemporaryDirectory() as td:
                with patch('probe.os.read', return_value=raw):
                    probe.read_tap_frame(123, Path(td), 0, True, [])

    def test_quiet_ok_positive(self):
        records = [{'timestamp_ns': 1_000_000_000}]
        stop = 1_200_000_000  # 200ms later
        self.assertTrue(quiet_ok(records, stop, 100))

    def test_quiet_ok_negative(self):
        records = [{'timestamp_ns': 1_000_000_000}]
        stop = 1_050_000_000  # 50ms later
        self.assertFalse(quiet_ok(records, stop, 100))


if __name__ == '__main__':
    unittest.main()
