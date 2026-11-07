"""Independent frozen packet and synthetic-PCAP codec tests, not live evidence."""
import copy
import importlib.util
import json
from pathlib import Path
import struct
import tempfile
import unittest
ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('tcp_wire_capture',ROOT/'ports/linux-tcp-wire-peer/capture.py');codec=importlib.util.module_from_spec(spec);spec.loader.exec_module(codec)
class TcpWireCaptureTests(unittest.TestCase):
    def packet(self):
        oracle=json.loads((ROOT/'spec/tcp-wire-endpoint-oracle.json').read_text())
        return bytes(oracle['cases']['bidirectional-cumulative-close']['steps'][0]['expect_trace'][0]['emitted'][0]['fields']['packet'])
    def test_frozen_syn_fields_and_independent_checksums(self):
        packet=self.packet();decoded=codec.decode_packet(packet)
        self.assertEqual((decoded['source'],decoded['destination'],decoded['source_port'],decoded['destination_port'],decoded['seq'],decoded['ack']),('192.0.2.1','192.0.2.2',40000,8080,1000,0))
        for offset in (8,24):
            bad=bytearray(packet);bad[offset]^=1
            with self.assertRaisesRegex(ValueError,'checksum'):codec.decode_packet(bytes(bad))
    def test_raw_pcap_extent_and_time_are_strict(self):
        packet=self.packet();header=struct.pack('<IHHIIII',0xa1b2c3d4,2,4,0,0,65535,101)
        record=lambda sec:struct.pack('<IIII',sec,0,len(packet),len(packet))+packet
        with tempfile.TemporaryDirectory()as temporary:
            path=Path(temporary)/'synthetic-unit-only.pcap';path.write_bytes(header+record(2));self.assertEqual(codec.records(path)[0]['hex'],packet.hex())
            for invalid in (header+record(2)+record(1),(header+record(2))[:-1]):
                path.write_bytes(invalid)
                with self.assertRaises(ValueError):codec.records(path)
