import json
import os
import select
import socket
import tempfile
import threading
import unittest
from pathlib import Path
from types import SimpleNamespace

import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "ports" / "linux-tcp-wire-peer"))
from exchange import run_exchange


def pkt(flags, payload=b""):
    b = bytearray(20)
    b[0] = 0x45
    b[9] = 6
    b[13] = flags
    return bytes(b) + payload


SYN = pkt(0x02)
SYNACK = pkt(0x12)
ACK = pkt(0x10)
FIN = pkt(0x01)
FINACK = pkt(0x11)

MODEL = {
    "variables": {
        "iss": {"type": "seq32", "initial": 1000},
        "irs": {"type": "seq32", "initial": 0},
        "snd_una": {"type": "seq32", "initial": 1000},
        "snd_nxt": {"type": "seq32", "initial": 1000},
        "rcv_nxt": {"type": "seq32", "initial": 0},
        "snd_buf": {"type": "bytes", "initial": []},
        "rcv_buf": {"type": "bytes", "initial": []},
        "local_window": {"type": "int", "initial": 16},
        "rto_ms": {"type": "int", "initial": 1000},
    },
    "initial": {},
    "steps": [],
    "events": {
        "app.connect": {"origin": "application", "fields": {}},
        "app.send": {"origin": "application", "fields": {"data": "bytes"}},
        "app.transmit": {"origin": "application", "fields": {}},
        "app.receive": {"origin": "application", "fields": {"count": "int"}},
        "app.close": {"origin": "application", "fields": {}},
        "net.packet": {"origin": "network", "fields": {"packet": "bytes"}},
    },
}

CONFIG = {"phase_timeout_seconds": 2.0, "payload_hex": "0080ff07"}
EXPECTED_PAYLOAD = bytes([0x00, 0x80, 0xFF, 0x07])
EXPECTED_DATA = pkt(0x18, EXPECTED_PAYLOAD)


def make_actor():
    snap = {
        "state": "CLOSED",
        "variables": {
            "iss": 1000,
            "irs": 0,
            "snd_una": 1000,
            "snd_nxt": 1000,
            "rcv_nxt": 0,
            "snd_buf": [],
            "rcv_buf": [],
            "local_window": 16,
            "rto_ms": 1000,
        },
        "timers": {},
    }
    rows = []

    def op(line):
        rows.append(line)
        parts = line.split()
        out = []
        head = parts[0] if parts else ""
        if head == "T":
            out.append({"status": "transition", "emitted": []})
            out.append({"status": "ok", "snapshot": snap})
            return out
        event = parts[2] if len(parts) >= 3 else ""
        toks = parts[3:]
        if event == "app.connect":
            if snap["state"] == "CLOSED":
                snap["state"] = "SYN-SENT"
                out.append({"status": "transition", "emitted": [
                    {"message": "ipv4.tx", "fields": {"packet": list(SYN)}}]})
            else:
                out.append({"status": "transition", "emitted": []})
        elif event == "app.send":
            data = bytes.fromhex(toks[0][2:]) if toks else b""
            snap["variables"]["snd_buf"] = list(snap["variables"]["snd_buf"]) + list(data)
            out.append({"status": "transition", "emitted": []})
        elif event == "app.transmit":
            payload = bytes(snap["variables"]["snd_buf"])
            snap["variables"]["snd_nxt"] = int(snap["variables"]["snd_nxt"]) + len(payload)
            snap["variables"]["snd_buf"] = []
            out.append({"status": "transition", "emitted": [
                {"message": "ipv4.tx", "fields": {"packet": list(pkt(0x18, payload))}}]})
        elif event == "app.receive":
            count = int(toks[0]) if toks else 0
            buf = list(snap["variables"]["rcv_buf"])
            chunk = buf[:count]
            snap["variables"]["rcv_buf"] = buf[count:]
            out.append({"status": "transition", "emitted": [
                {"message": "application_data", "fields": {"data": chunk}}]})
        elif event == "app.close":
            if snap["state"] == "ESTABLISHED":
                snap["state"] = "FIN-WAIT-1"
                out.append({"status": "transition", "emitted": [
                    {"message": "ipv4.tx", "fields": {"packet": list(FIN)}}]})
            else:
                out.append({"status": "transition", "emitted": []})
        elif event == "net.packet":
            raw = bytes.fromhex(toks[0][2:]) if toks else b""
            flags = raw[13] if len(raw) >= 20 else 0
            if snap["state"] == "SYN-SENT" and flags == 0x12:
                snap["state"] = "ESTABLISHED"
                snap["variables"]["snd_una"] = snap["variables"]["snd_nxt"]
            elif snap["state"] == "FIN-WAIT-1" and flags == 0x11:
                snap["state"] = "TIME-WAIT"
                snap["timers"] = {"time_wait": 120000}
            elif snap["state"] == "ESTABLISHED" and (flags & 0x10) and (flags & 0x08):
                snap["variables"]["rcv_buf"] = list(snap["variables"]["rcv_buf"]) + list(raw[20:])
                snap["variables"]["snd_buf"] = []
                snap["variables"]["snd_una"] = snap["variables"]["snd_nxt"]
            elif snap["state"] == "ESTABLISHED" and flags == 0x10:
                snap["variables"]["snd_buf"] = []
                snap["variables"]["snd_una"] = snap["variables"]["snd_nxt"]
            out.append({"status": "transition", "emitted": []})
        else:
            return [{"status": "error", "failure": "uncovered:" + event, "snapshot": snap}]
        out.append({"status": "ok", "snapshot": snap})
        return out

    actor = SimpleNamespace(
        snapshot=snap,
        rows=rows,
        operations=[],
        operation=op,
        process=SimpleNamespace(pid=os.getpid(), poll=lambda: None),
    )
    return actor


def peer_loop(psock, stop, seen):
    while not stop[0]:
        try:
            ready, _, _ = select.select([psock], [], [], 0.05)
        except (OSError, ValueError):
            break
        if not ready:
            continue
        if stop[0]:
            break
        try:
            raw = psock.recv(4096)
        except OSError:
            break
        if not raw:
            continue
        seen.append(raw)
        if len(raw) < 20:
            continue
        flags = raw[13]
        try:
            if flags & 0x02:
                psock.send(SYNACK)
            elif flags & 0x08:
                psock.send(ACK)
                psock.send(pkt(0x18, raw[20:]))
            elif flags & 0x01:
                psock.send(FINACK)
        except OSError:
            break


class TestSyntheticAfUnix(unittest.TestCase):
    def test_echo_and_close_roundtrip(self):
        actor = make_actor()
        native, peer_sock = socket.socketpair(socket.AF_UNIX, socket.SOCK_DGRAM)
        peer = SimpleNamespace(poll=lambda: None)
        stop = [False]
        seen = []
        errors = []

        def runner():
            try:
                peer_loop(peer_sock, stop, seen)
            except BaseException as exc:  # pragma: no cover - guard
                errors.append(exc)

        thread = threading.Thread(target=runner, daemon=True)
        thread.start()
        try:
            with tempfile.TemporaryDirectory() as td:
                out = Path(td) / "evidence"
                result = run_exchange(MODEL, actor, native.fileno(), peer, out, CONFIG)

                self.assertEqual(result["phase"], "complete")
                self.assertEqual(result["final_state"], "TIME-WAIT")

                # Every native operation dispatch produced exactly one step
                # and one ABI line, with no B/reset rows observed.
                self.assertTrue(actor.rows)
                self.assertTrue(all(r.startswith(("D ", "T ")) for r in actor.rows))
                self.assertFalse(any(r.startswith("B ") or r.strip() == "B" for r in actor.rows))
                self.assertEqual(len(actor.rows), len(result["steps"]))
                self.assertEqual(result["step_count"], len(result["steps"]))

                # Echo service emitted exactly once with the expected payload.
                app_data = [s for s in result["services"]
                            if s.get("message") == "application_data"]
                self.assertEqual(len(app_data), 1)
                self.assertEqual(bytes(app_data[0]["data"]), EXPECTED_PAYLOAD)

                # Subject-originated raw transmissions recorded as literal
                # SYN, DATA(payload), FIN in that order.
                subject_tx = [e for e in result["links"]
                              if e.get("direction") == "subject_tx"]
                self.assertEqual(len(subject_tx), 3)
                raw_tx = [(out / e["file"]).read_bytes() for e in subject_tx]
                self.assertEqual(raw_tx[0], SYN)
                self.assertEqual(raw_tx[1], EXPECTED_DATA)
                self.assertEqual(raw_tx[2], FIN)
                self.assertEqual(subject_tx[0]["intended_bytes"], len(SYN))
                self.assertEqual(subject_tx[1]["intended_bytes"], len(EXPECTED_DATA))
                self.assertEqual(subject_tx[2]["intended_bytes"], len(FIN))
                for e in subject_tx:
                    self.assertEqual(e["written_bytes"], e["intended_bytes"])

                # Peer actually received the scripted literal segments over
                # the AF_UNIX datagram channel.
                self.assertIn(SYN, seen)
                self.assertIn(EXPECTED_DATA, seen)
                self.assertIn(FIN, seen)

                # Time-WAIT is pending, not awaited; integer due_ms order-only.
                self.assertFalse(result["time_wait_awaited"])
                self.assertIs(result["clock"]["time_wait_awaited"], False)
                pending = dict(result["clock"]["pending_timers"])
                self.assertEqual(pending.get("time_wait"), 120000)
                self.assertIsInstance(pending.get("time_wait"), int)

                # Driver must not close our handles or claim the process died.
                self.assertGreaterEqual(native.fileno(), 0)
                self.assertGreaterEqual(peer_sock.fileno(), 0)
                self.assertIsNone(actor.process.poll())
                self.assertIsNone(peer.poll())

                # Evidence record is JSON-serialisable.
                json.dumps(result)
        finally:
            stop[0] = True
            thread.join(2.0)
            native.close()
            peer_sock.close()

        self.assertFalse(errors, errors)


if __name__ == "__main__":  # pragma: no cover
    unittest.main()
