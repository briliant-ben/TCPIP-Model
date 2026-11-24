#!/usr/bin/env python3
"""Run a live communicating IPv4/TCP/UDP/ICMP prototype and capture a .pcap trace.

Drives the compiled standalone C99 executable (`code/generated/protocol.c`,
192.0.2.1:40000 MAC 02:00:00:00:00:01) against an independent wire peer
(192.0.2.2:8080 MAC 02:00:00:00:00:02) over local UDP loopback sockets
(127.0.0.1) or an AF_UNIX socketpair fallback when INET sockets are blocked by
a sandbox, and writes an Ethernet DLT_EN10MB capture (`live-capture.pcap`).
"""
import argparse
import errno
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import pty
import select
import shutil
import socket
import struct
import subprocess
import sys
import termios
import threading
import time

ROOT = Path(__file__).resolve().parents[1]

C_MAC = bytes.fromhex("020000000001")
PEER_MAC = bytes.fromhex("020000000002")
BROADCAST_MAC = bytes.fromhex("ffffffffffff")
C_IP = bytes([192, 0, 2, 1])
PEER_IP = bytes([192, 0, 2, 2])
C_PORT = 40000
PEER_PORT = 8080
ETH_P_IP = 0x0800
ETH_P_ARP = 0x0806
TCP_WINDOW = 16
TCP_SMSS = 4


def _sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def _load_pcap_records():
    spec = importlib.util.spec_from_file_location("case_demo_review", ROOT / "demo/build_review.py")
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod.pcap_records


def inet_checksum(data: bytes) -> int:
    """Compute RFC 1071 16-bit one's-complement checksum."""
    if len(data) % 2 == 1:
        data = data + b"\x00"
    total = 0
    for i in range(0, len(data), 2):
        total += (data[i] << 8) | data[i + 1]
    while total >> 16:
        total = (total & 0xFFFF) + (total >> 16)
    return (~total) & 0xFFFF


def pad_eth_frame(dst_mac: bytes, src_mac: bytes, ethertype: int, payload: bytes) -> bytes:
    frame = dst_mac + src_mac + struct.pack("!H", ethertype) + payload
    if len(frame) < 60:
        frame += b"\x00" * (60 - len(frame))
    return frame


def build_arp_frame(op: int, dst_eth: bytes, src_mac: bytes, src_ip: bytes, dst_mac_arp: bytes, dst_ip: bytes) -> bytes:
    arp = struct.pack("!HHBBH", 1, 0x0800, 6, 4, op) + src_mac + src_ip + dst_mac_arp + dst_ip
    return pad_eth_frame(dst_eth, src_mac, ETH_P_ARP, arp)


def build_ipv4_packet(proto: int, src_ip: bytes, dst_ip: bytes, l4: bytes, ip_id: int = 0) -> bytes:
    total_len = 20 + len(l4)
    hdr0 = struct.pack("!BBHHHBBH4s4s", 0x45, 0, total_len, ip_id, 0x4000, 64, proto, 0, src_ip, dst_ip)
    csum = inet_checksum(hdr0)
    hdr = struct.pack("!BBHHHBBH4s4s", 0x45, 0, total_len, ip_id, 0x4000, 64, proto, csum, src_ip, dst_ip)
    return hdr + l4


def build_tcp_frame(
    dst_mac: bytes,
    src_mac: bytes,
    src_ip: bytes,
    dst_ip: bytes,
    src_port: int,
    dst_port: int,
    seq: int,
    ack: int,
    flags: int,
    window: int,
    data: bytes = b"",
    ip_id: int = 0,
) -> bytes:
    tcp0 = struct.pack("!HHIIBBHHH", src_port, dst_port, seq & 0xFFFFFFFF, ack & 0xFFFFFFFF, 0x50, flags, window, 0, 0) + data
    pseudo = src_ip + dst_ip + struct.pack("!BBH", 0, 6, len(tcp0))
    csum = inet_checksum(pseudo + tcp0)
    tcp = struct.pack("!HHIIBBHHH", src_port, dst_port, seq & 0xFFFFFFFF, ack & 0xFFFFFFFF, 0x50, flags, window, csum, 0) + data
    return pad_eth_frame(dst_mac, src_mac, ETH_P_IP, build_ipv4_packet(6, src_ip, dst_ip, tcp, ip_id=ip_id))


def build_udp_frame(
    dst_mac: bytes,
    src_mac: bytes,
    src_ip: bytes,
    dst_ip: bytes,
    src_port: int,
    dst_port: int,
    data: bytes,
    ip_id: int = 0,
) -> bytes:
    udp_len = 8 + len(data)
    udp0 = struct.pack("!HHHH", src_port, dst_port, udp_len, 0) + data
    pseudo = src_ip + dst_ip + struct.pack("!BBH", 0, 17, udp_len)
    csum = inet_checksum(pseudo + udp0)
    if csum == 0:
        csum = 0xFFFF
    udp = struct.pack("!HHHH", src_port, dst_port, udp_len, csum) + data
    return pad_eth_frame(dst_mac, src_mac, ETH_P_IP, build_ipv4_packet(17, src_ip, dst_ip, udp, ip_id=ip_id))


def build_icmp_echo_frame(
    dst_mac: bytes,
    src_mac: bytes,
    src_ip: bytes,
    dst_ip: bytes,
    icmp_type: int,
    ident: int,
    seq: int,
    data: bytes,
    ip_id: int = 0,
) -> bytes:
    icmp0 = struct.pack("!BBHHH", icmp_type, 0, 0, ident, seq) + data
    csum = inet_checksum(icmp0)
    icmp = struct.pack("!BBHHH", icmp_type, 0, csum, ident, seq) + data
    return pad_eth_frame(dst_mac, src_mac, ETH_P_IP, build_ipv4_packet(1, src_ip, dst_ip, icmp, ip_id=ip_id))


def parse_frame(raw: bytes) -> dict:
    """Decode Ethernet II / ARP / IPv4 / TCP / UDP / ICMP frame."""
    if len(raw) < 14:
        raise ValueError("Ethernet frame shorter than 14 bytes")
    dst_mac, src_mac, ethertype = struct.unpack("!6s6sH", raw[:14])
    out = {"dst_mac": dst_mac, "src_mac": src_mac, "ethertype": ethertype, "raw": raw}
    body = raw[14:]
    if ethertype == ETH_P_ARP:
        if len(body) < 28:
            raise ValueError("Truncated ARP frame")
        htype, ptype, hlen, plen, op = struct.unpack("!HHBBH", body[:8])
        out.update(
            kind="ARP",
            htype=htype,
            ptype=ptype,
            op=op,
            sha=body[8:14],
            spa=body[14:18],
            tha=body[18:24],
            tpa=body[24:28],
        )
        return out
    if ethertype != ETH_P_IP:
        out["kind"] = f"ETH(0x{ethertype:04x})"
        return out
    if len(body) < 20:
        raise ValueError("Truncated IPv4 header")
    ver_ihl, tos, total_len, ip_id, flags_frag, ttl, proto, hdr_csum, src_ip, dst_ip = struct.unpack(
        "!BBHHHBBH4s4s", body[:20]
    )
    ihl = (ver_ihl & 0x0F) * 4
    if ihl < 20 or len(body) < total_len or total_len < ihl:
        raise ValueError("Invalid IPv4 header or length")
    ip_pkt = body[:total_len]
    l4 = ip_pkt[ihl:]
    out.update(
        ihl=ihl,
        total_len=total_len,
        ip_id=ip_id,
        ttl=ttl,
        proto=proto,
        ip_header_csum_ok=(inet_checksum(ip_pkt[:ihl]) == 0),
        src_ip=src_ip,
        dst_ip=dst_ip,
        ip_pkt=ip_pkt,
        l4=l4,
    )
    if proto == 6:
        if len(l4) < 20:
            raise ValueError("Truncated TCP segment")
        sport, dport, seq, ack, doff_res, flags, win, csum, urp = struct.unpack("!HHIIBBHHH", l4[:20])
        doff = ((doff_res >> 4) & 0x0F) * 4
        if doff < 20 or len(l4) < doff:
            raise ValueError("Invalid TCP data offset")
        pseudo = src_ip + dst_ip + struct.pack("!BBH", 0, 6, len(l4))
        out.update(
            kind="TCP",
            sport=sport,
            dport=dport,
            seq=seq,
            ack=ack,
            doff=doff,
            flags=flags,
            window=win,
            l4_csum_ok=(inet_checksum(pseudo + l4) == 0),
            payload=l4[doff:],
        )
    elif proto == 17:
        if len(l4) < 8:
            raise ValueError("Truncated UDP datagram")
        sport, dport, ulen, csum = struct.unpack("!HHHH", l4[:8])
        if ulen < 8 or len(l4) < ulen:
            raise ValueError("Invalid UDP length")
        udp_slice = l4[:ulen]
        pseudo = src_ip + dst_ip + struct.pack("!BBH", 0, 17, ulen)
        csum_ok = True if csum == 0 else (inet_checksum(pseudo + udp_slice) == 0)
        out.update(
            kind="UDP",
            sport=sport,
            dport=dport,
            ulen=ulen,
            udp_csum=csum,
            l4_csum_ok=csum_ok,
            payload=udp_slice[8:],
        )
    elif proto == 1:
        if len(l4) < 8:
            raise ValueError("Truncated ICMP packet")
        itype, icode, csum, ident, seq = struct.unpack("!BBHHH", l4[:8])
        out.update(
            kind="ICMP",
            icmp_type=itype,
            icmp_code=icode,
            ident=ident,
            seq=seq,
            l4_csum_ok=(inet_checksum(l4) == 0),
            payload=l4[8:],
        )
    else:
        out["kind"] = f"IP({proto})"
    return out


def verify_frame_checksums(raw: bytes) -> dict:
    """Parse an Ethernet frame and fail if any IPv4/TCP/UDP/ICMP checksum is invalid."""
    pkt = parse_frame(raw)
    if pkt["kind"] == "ARP":
        return pkt
    if pkt["ethertype"] == ETH_P_IP:
        if not pkt["ip_header_csum_ok"]:
            raise ValueError(f"Invalid IPv4 header checksum in {pkt['kind']} frame")
        if pkt["kind"] in ("TCP", "UDP", "ICMP") and not pkt["l4_csum_ok"]:
            raise ValueError(f"Invalid {pkt['kind']} checksum")
    return pkt


def format_tcp_flags(flags: int) -> str:
    bits = []
    for mask, ch in ((0x02, "S"), (0x10, "A"), (0x08, "P"), (0x01, "F"), (0x04, "R")):
        if flags & mask:
            bits.append(ch)
    return "".join(bits) or "."


def format_frame_line(idx: int, direction: str, scenario: str, raw: bytes) -> str:
    try:
        pkt = parse_frame(raw)
    except ValueError:
        return f"#{idx:02d} [{scenario}] {direction} RAW ({len(raw)}B)"
    kind = pkt["kind"]
    if kind == "ARP":
        op_name = "Request" if pkt["op"] == 1 else "Reply" if pkt["op"] == 2 else f"op={pkt['op']}"
        detail = f"who-has {socket.inet_ntoa(pkt['tpa'])} tell {socket.inet_ntoa(pkt['spa'])}" if pkt["op"] == 1 else f"{socket.inet_ntoa(pkt['spa'])} is-at {pkt['sha'].hex(':')}"
        return f"#{idx:02d} [{scenario}] {direction} ARP {op_name}: {detail} ({len(raw)}B)"
    src = socket.inet_ntoa(pkt["src_ip"])
    dst = socket.inet_ntoa(pkt["dst_ip"])
    if kind == "TCP":
        fl = format_tcp_flags(pkt["flags"])
        return (
            f"#{idx:02d} [{scenario}] {direction} TCP {src}:{pkt['sport']} -> {dst}:{pkt['dport']} "
            f"[{fl}] seq={pkt['seq']} ack={pkt['ack']} win={pkt['window']} len={len(pkt['payload'])} ({len(raw)}B)"
        )
    if kind == "UDP":
        return (
            f"#{idx:02d} [{scenario}] {direction} UDP {src}:{pkt['sport']} -> {dst}:{pkt['dport']} "
            f"len={len(pkt['payload'])} ({len(raw)}B)"
        )
    if kind == "ICMP":
        tname = "EchoReq" if pkt["icmp_type"] == 8 else "EchoReply" if pkt["icmp_type"] == 0 else f"type={pkt['icmp_type']}"
        return (
            f"#{idx:02d} [{scenario}] {direction} ICMP {src} -> {dst} {tname} "
            f"id=0x{pkt['ident']:04x} seq={pkt['seq']} len={len(pkt['payload'])} ({len(raw)}B)"
        )
    return f"#{idx:02d} [{scenario}] {direction} {kind} ({len(raw)}B)"


class PcapRecorder:
    """Thread-safe Ethernet DLT_EN10MB libpcap v2.4 capture writer."""

    def __init__(self, pcap_path: Path):
        self.path = pcap_path
        self._lock = threading.Lock()
        self._prev_us = 0
        self.frames = []
        self._fp = pcap_path.open("wb")
        # libpcap global header: little-endian magic 0xa1b2c3d4, v2.4, snap=65535, DLT_EN10MB=1
        self._fp.write(struct.pack("<IHHIIII", 0xA1B2C3D4, 2, 4, 0, 0, 65535, 1))
        self._fp.flush()

    def record(self, raw: bytes, direction: str, scenario: str) -> None:
        with self._lock:
            now_us = time.time_ns() // 1000
            if now_us < self._prev_us:
                now_us = self._prev_us
            self._prev_us = now_us
            sec = now_us // 1_000_000
            usec = now_us % 1_000_000
            self._fp.write(struct.pack("<IIII", sec, usec, len(raw), len(raw)))
            self._fp.write(raw)
            self._fp.flush()
            self.frames.append((len(self.frames) + 1, direction, scenario, raw))

    def close(self) -> None:
        self._fp.close()


class WireEnd:
    """Datagram/framed stream endpoint between the C stack bridge and peer."""

    def __init__(self, sock: socket.socket, is_stream: bool):
        self.sock = sock
        self.is_stream = is_stream
        self.sock.settimeout(5.0)

    def send(self, frame: bytes) -> None:
        if self.is_stream:
            self.sock.sendall(struct.pack("!I", len(frame)) + frame)
        else:
            self.sock.send(frame)

    def recv(self) -> bytes:
        if not self.is_stream:
            return self.sock.recv(4096)
        hdr = self._recv_exact(4)
        (length,) = struct.unpack("!I", hdr)
        return self._recv_exact(length)

    def _recv_exact(self, n: int) -> bytes:
        buf = bytearray()
        while len(buf) < n:
            chunk = self.sock.recv(n - len(buf))
            if not chunk:
                raise EOFError("Wire socket closed")
            buf.extend(chunk)
        return bytes(buf)

    def close(self) -> None:
        try:
            self.sock.close()
        except OSError:
            pass


def open_wire_pair(transport: str, port_a: int, port_b: int) -> tuple[WireEnd, WireEnd, str, dict]:
    """Open a two-ended Ethernet frame channel over UDP loopback or AF_UNIX fallback."""
    if transport in ("auto", "udp"):
        sa = None
        sb = None
        try:
            sa = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            sb = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
            sa.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            sb.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            sa.bind(("127.0.0.1", port_a))
            sb.bind(("127.0.0.1", port_b))
            pa = sa.getsockname()[1]
            pb = sb.getsockname()[1]
            sa.connect(("127.0.0.1", pb))
            sb.connect(("127.0.0.1", pa))
            return WireEnd(sa, False), WireEnd(sb, False), "udp_loopback", {"c_udp_port": pa, "peer_udp_port": pb}
        except PermissionError as exc:
            for sock in (sb, sa):
                if sock is not None:
                    sock.close()
            if transport == "udp":
                raise RuntimeError(f"UDP loopback transport denied by environment: {exc}") from exc
        except Exception:
            for sock in (sb, sa):
                if sock is not None:
                    sock.close()
            raise
    a, b = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
    return WireEnd(a, True), WireEnd(b, True), "unix_socketpair", {}


class NativeEndpoint:
    """Interactive PTY-backed driver for the compiled C99 `tcpip-reference` binary."""

    def __init__(self, executable: Path):
        # protocol.c flushes stdout with fputs() (without fflush); a PTY makes stdout line-buffered.
        master_fd, slave_fd = pty.openpty()
        self.master_fd = master_fd
        self._rx_buf = bytearray()
        try:
            attrs = termios.tcgetattr(slave_fd)
            attrs[1] &= ~termios.OPOST
            attrs[3] &= ~termios.ECHO
            termios.tcsetattr(slave_fd, termios.TCSANOW, attrs)
            self.proc = subprocess.Popen(
                [str(executable)],
                stdin=subprocess.PIPE,
                stdout=slave_fd,
                stderr=subprocess.PIPE,
                bufsize=0,
                close_fds=True,
            )
        except Exception:
            os.close(master_fd)
            raise
        finally:
            os.close(slave_fd)

        self.transitions = 0
        self.last_vars = {}
        try:
            self.proc.stdin.write(b"B\n")
            self.proc.stdin.flush()
            ready = json.loads(self._readline().decode())
            if ready.get("status") != "ready":
                raise RuntimeError(f"Unexpected C startup status: {ready}")
            self.last_vars = ready["snapshot"]["variables"]
        except Exception:
            self.close(ignore_status=True)
            raise

    def _readline(self, timeout: float = 5.0) -> bytes:
        deadline = time.monotonic() + timeout
        while True:
            nl = self._rx_buf.find(b"\n")
            if nl != -1:
                line = bytes(self._rx_buf[: nl + 1])
                del self._rx_buf[: nl + 1]
                return line
            remaining = deadline - time.monotonic()
            if remaining <= 0:
                raise TimeoutError("Timed out waiting for tcpip-reference stdout line")
            readable, _, _ = select.select([self.master_fd], [], [], remaining)
            if not readable:
                continue
            try:
                chunk = os.read(self.master_fd, 65536)
            except OSError as exc:
                if exc.errno == errno.EIO:
                    return b""
                raise
            if not chunk:
                return b""
            self._rx_buf.extend(chunk)

    def dispatch(self, time_ms: int, event_name: str, *args: str) -> dict:
        parts = ["D", str(time_ms), event_name, *args]
        self.proc.stdin.write((" ".join(parts) + "\n").encode())
        self.proc.stdin.flush()
        transitions_rows = []
        emitted_all = []
        while True:
            line = self._readline()
            if not line:
                stderr = self.proc.stderr.read().decode(errors="replace")
                raise RuntimeError(f"tcpip-reference terminated early during {event_name}: {stderr}")
            row = json.loads(line.decode())
            status = row.get("status")
            if status == "transition":
                transitions_rows.append(row)
                emitted_all.extend(row.get("emitted", []))
                self.transitions += 1
                self.last_vars = row["after"]["variables"]
            elif status == "ok":
                self.last_vars = row["snapshot"]["variables"]
                return {
                    "status": "ok",
                    "transitions": transitions_rows,
                    "emitted": emitted_all,
                    "snapshot": row["snapshot"],
                }
            else:
                raise RuntimeError(f"Event {event_name} rejected: {row}")

    def feed_frame(self, time_ms: int, frame: bytes) -> dict:
        return self.dispatch(time_ms, "L.net.frame", f"b:{frame.hex()}")

    @staticmethod
    def emitted_frames(row: dict) -> list[bytes]:
        return [bytes(e["fields"]["frame"]) for e in row.get("emitted", []) if e.get("message") == "L.ethernet.tx"]

    @staticmethod
    def emitted_data(row: dict, msg_name: str) -> list[bytes]:
        return [bytes(e["fields"]["data"]) for e in row.get("emitted", []) if e.get("message") == msg_name]

    def close(self, *, ignore_status: bool = False) -> int:
        rc = None
        stderr = ""
        try:
            try:
                if self.proc.stdin and not self.proc.stdin.closed:
                    self.proc.stdin.close()
            except OSError:
                pass
            try:
                rc = self.proc.wait(timeout=10)
            except subprocess.TimeoutExpired:
                self.proc.kill()
                self.proc.wait(timeout=5)
                raise
        finally:
            try:
                if self.proc.stderr:
                    stderr = self.proc.stderr.read().decode(errors="replace")
                    self.proc.stderr.close()
            finally:
                if self.master_fd >= 0:
                    os.close(self.master_fd)
                    self.master_fd = -1
        if not ignore_status and (rc != 0 or stderr):
            raise RuntimeError(f"tcpip-reference failed on exit rc={rc}: {stderr}")
        return rc


def _send_and_record(wire_end: WireEnd, pcap: PcapRecorder, frame: bytes, direction: str, scenario: str) -> None:
    verify_frame_checksums(frame)
    pcap.record(frame, direction, scenario)
    wire_end.send(frame)


def _recv_and_record(wire_end: WireEnd, pcap: PcapRecorder, direction: str, scenario: str) -> bytes:
    frame = wire_end.recv()
    verify_frame_checksums(frame)
    pcap.record(frame, direction, scenario)
    return frame


def _echo_bytes(payload: bytes) -> bytes:
    prefixed = b"echo:" + payload
    return prefixed if len(prefixed) <= TCP_WINDOW else payload


def _send_tcp_from_c(
    ep: NativeEndpoint,
    wire_c: WireEnd,
    pcap: PcapRecorder,
    scenario: str,
    t_ms: int,
    payload: bytes,
) -> int:
    """Queue TCP payload in C stack and pump SMSS=4 transmit / ACK steps."""
    ep.dispatch(t_ms, "T.app.send", f"b:{payload.hex()}")
    t_ms += 1
    while ep.last_vars["T.snd_buf"] or ep.last_vars["T.rtx_buf"]:
        if ep.last_vars["T.snd_buf"]:
            tx_row = ep.dispatch(t_ms, "T.app.transmit")
            t_ms += 1
            for frame in ep.emitted_frames(tx_row):
                _send_and_record(wire_c, pcap, frame, "C -> Peer", scenario)
                ack_frame = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
                ep.feed_frame(t_ms, ack_frame)
                t_ms += 1
        elif ep.last_vars["T.rtx_buf"]:
            ack_frame = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
            ep.feed_frame(t_ms, ack_frame)
            t_ms += 1
    return t_ms


def _receive_tcp_into_c(
    ep: NativeEndpoint,
    wire_c: WireEnd,
    pcap: PcapRecorder,
    scenario: str,
    t_ms: int,
    expected_len: int,
) -> tuple[bytes, int]:
    """Receive peer SMSS=4 TCP data segments into C stack, ACK, and app.receive."""
    while len(ep.last_vars["T.rcv_buf"]) < expected_len:
        data_frame = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        rx_row = ep.feed_frame(t_ms, data_frame)
        t_ms += 1
        for ack_frame in ep.emitted_frames(rx_row):
            _send_and_record(wire_c, pcap, ack_frame, "C -> Peer", scenario)
    read_row = ep.dispatch(t_ms, "T.app.receive", str(expected_len))
    t_ms += 1
    for win_frame in ep.emitted_frames(read_row):
        _send_and_record(wire_c, pcap, win_frame, "C -> Peer", scenario)
    chunks = ep.emitted_data(read_row, "T.application_data")
    if not chunks:
        raise RuntimeError(f"Expected T.application_data from T.app.receive, got {read_row}")
    return b"".join(chunks), t_ms


def run_client_scenario(
    executable: Path,
    wire_c: WireEnd,
    wire_peer: WireEnd,
    pcap: PcapRecorder,
    client_msg: bytes,
    udp_msg: bytes,
    icmp_msg: bytes,
) -> dict:
    """C stack actively connects, exchanges TCP/UDP/ICMP traffic with peer thread."""
    scenario = "client"
    expected_tcp_echo = _echo_bytes(client_msg)
    expected_udp_echo = b"echo:" + udp_msg
    peer_error: list[BaseException] = []
    peer_state: dict = {}

    def peer_worker() -> None:
        try:
            # 1. ARP Request -> Reply
            arp_req = parse_frame(wire_peer.recv())
            assert arp_req["kind"] == "ARP" and arp_req["op"] == 1 and arp_req["tpa"] == PEER_IP
            arp_reply = build_arp_frame(2, arp_req["sha"], PEER_MAC, PEER_IP, arp_req["sha"], arp_req["spa"])
            wire_peer.send(arp_reply)

            # 2. TCP SYN -> SYN-ACK -> ACK
            syn = parse_frame(wire_peer.recv())
            assert syn["kind"] == "TCP" and (syn["flags"] & 0x02)
            peer_seq = 9000
            c_next_seq = (syn["seq"] + 1) & 0xFFFFFFFF
            synack = build_tcp_frame(
                C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                peer_seq, c_next_seq, 0x12, TCP_WINDOW, ip_id=10,
            )
            peer_seq = (peer_seq + 1) & 0xFFFFFFFF
            wire_peer.send(synack)
            ack = parse_frame(wire_peer.recv())
            assert ack["kind"] == "TCP" and (ack["flags"] & 0x10) and ack["ack"] == peer_seq

            # 3. Receive client TCP stream chunks (SMSS=4) and ACK each
            received = bytearray()
            ip_id = 11
            while len(received) < len(client_msg):
                seg = parse_frame(wire_peer.recv())
                assert seg["kind"] == "TCP" and seg["seq"] == c_next_seq and seg["payload"]
                received.extend(seg["payload"])
                c_next_seq = (c_next_seq + len(seg["payload"])) & 0xFFFFFFFF
                wire_peer.send(
                    build_tcp_frame(
                        C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                        peer_seq, c_next_seq, 0x10, TCP_WINDOW, ip_id=ip_id,
                    )
                )
                ip_id += 1
            peer_state["tcp_received"] = bytes(received)

            # 4. Echo payload back to C client in SMSS=4 chunks
            echo_data = _echo_bytes(bytes(received))
            for offset in range(0, len(echo_data), TCP_SMSS):
                chunk = echo_data[offset : offset + TCP_SMSS]
                wire_peer.send(
                    build_tcp_frame(
                        C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                        peer_seq, c_next_seq, 0x18, TCP_WINDOW, data=chunk, ip_id=ip_id,
                    )
                )
                ip_id += 1
                peer_seq = (peer_seq + len(chunk)) & 0xFFFFFFFF
                data_ack = parse_frame(wire_peer.recv())
                assert data_ack["kind"] == "TCP" and data_ack["ack"] == peer_seq
            # Window-update ACK emitted on T.app.receive
            win_ack = parse_frame(wire_peer.recv())
            assert win_ack["kind"] == "TCP" and (win_ack["flags"] & 0x10)

            # 5. Receive client FIN-ACK, reply FIN-ACK, receive final ACK
            fin = parse_frame(wire_peer.recv())
            assert fin["kind"] == "TCP" and (fin["flags"] & 0x01)
            c_next_seq = (c_next_seq + 1) & 0xFFFFFFFF
            wire_peer.send(
                build_tcp_frame(
                    C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                    peer_seq, c_next_seq, 0x11, TCP_WINDOW, ip_id=ip_id,
                )
            )
            ip_id += 1
            peer_seq = (peer_seq + 1) & 0xFFFFFFFF
            last_ack = parse_frame(wire_peer.recv())
            assert last_ack["kind"] == "TCP" and last_ack["ack"] == peer_seq

            # 6. UDP datagram echo
            udp_req = parse_frame(wire_peer.recv())
            assert udp_req["kind"] == "UDP" and udp_req["sport"] == C_PORT and udp_req["dport"] == PEER_PORT
            peer_state["udp_received"] = udp_req["payload"]
            wire_peer.send(
                build_udp_frame(
                    C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                    b"echo:" + udp_req["payload"], ip_id=ip_id,
                )
            )
            ip_id += 1

            # 7. ICMP Echo Request -> expect C stack's Echo Reply
            wire_peer.send(
                build_icmp_echo_frame(
                    C_MAC, PEER_MAC, PEER_IP, C_IP, 8, 0x1234, 1, icmp_msg, ip_id=ip_id
                )
            )
            icmp_rep = parse_frame(wire_peer.recv())
            assert icmp_rep["kind"] == "ICMP" and icmp_rep["icmp_type"] == 0 and icmp_rep["icmp_code"] == 0
            assert icmp_rep["ident"] == 0x1234 and icmp_rep["seq"] == 1
            peer_state["icmp_reply_payload"] = icmp_rep["payload"]
        except BaseException as exc:  # pragma: no cover - surfaced in main thread
            peer_error.append(exc)

    thread = threading.Thread(target=peer_worker, daemon=True)
    thread.start()

    ep = NativeEndpoint(executable)
    try:
        t_ms = 0
        # Active open triggers ARP resolution (L.control=PENDING)
        r0 = ep.dispatch(t_ms, "T.app.connect")
        for f in ep.emitted_frames(r0):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        t_ms += 1

        # Feed ARP Reply -> flushes queued TCP SYN
        arp_rep = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        r_syn = ep.feed_frame(t_ms, arp_rep)
        for f in ep.emitted_frames(r_syn):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        t_ms += 1

        # Feed SYN-ACK -> emits final ACK -> ESTABLISHED
        synack = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        r_est = ep.feed_frame(t_ms, synack)
        for f in ep.emitted_frames(r_est):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        assert ep.last_vars["T.control"] == "ESTABLISHED"
        t_ms += 1

        # Send TCP message and receive echoed response
        t_ms = _send_tcp_from_c(ep, wire_c, pcap, scenario, t_ms, client_msg)
        tcp_rx, t_ms = _receive_tcp_into_c(ep, wire_c, pcap, scenario, t_ms, len(expected_tcp_echo))
        if tcp_rx != expected_tcp_echo:
            raise AssertionError(f"Client TCP echo mismatch: got {tcp_rx!r}, expected {expected_tcp_echo!r}")

        # Active close
        r_fin = ep.dispatch(t_ms, "T.app.close")
        for f in ep.emitted_frames(r_fin):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        t_ms += 1
        peer_fin = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        r_tw = ep.feed_frame(t_ms, peer_fin)
        for f in ep.emitted_frames(r_tw):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        t_ms += 1

        # UDP datagram echo
        r_udp = ep.dispatch(t_ms, "L.app.send", f"b:{udp_msg.hex()}")
        for f in ep.emitted_frames(r_udp):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        t_ms += 1
        udp_rep = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        r_udp_rx = ep.feed_frame(t_ms, udp_rep)
        udp_got = b"".join(ep.emitted_data(r_udp_rx, "L.udp.rx"))
        if udp_got != expected_udp_echo:
            raise AssertionError(f"Client UDP echo mismatch: got {udp_got!r}, expected {expected_udp_echo!r}")
        t_ms += 1

        # ICMP Echo Request -> Reply
        icmp_req = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        r_icmp = ep.feed_frame(t_ms, icmp_req)
        for f in ep.emitted_frames(r_icmp):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)

        final_l = ep.last_vars["L.control"]
        final_t = ep.last_vars["T.control"]
        transitions = ep.transitions
    except Exception:
        ep.close(ignore_status=True)
        raise
    else:
        ep.close()

    thread.join(timeout=5.0)
    if thread.is_alive():
        raise TimeoutError("Client scenario peer thread did not exit cleanly")
    if peer_error:
        raise peer_error[0]

    assert peer_state.get("icmp_reply_payload") == icmp_msg
    return {
        "transitions": transitions,
        "final_L_control": final_l,
        "final_T_control": final_t,
        "tcp_sent": client_msg.decode("utf-8", errors="replace"),
        "tcp_echo_received": tcp_rx.decode("utf-8", errors="replace"),
        "udp_sent": udp_msg.decode("utf-8", errors="replace"),
        "udp_echo_received": udp_got.decode("utf-8", errors="replace"),
        "icmp_echo_received": peer_state["icmp_reply_payload"].decode("utf-8", errors="replace"),
    }


def run_server_scenario(
    executable: Path,
    wire_c: WireEnd,
    wire_peer: WireEnd,
    pcap: PcapRecorder,
    server_msg: bytes,
) -> dict:
    """C stack passively listens on TCP port 40000 and serves an echo connection."""
    scenario = "server"
    expected_echo = _echo_bytes(server_msg)
    peer_error: list[BaseException] = []
    peer_state: dict = {}

    def peer_worker() -> None:
        try:
            peer_seq = 5000
            ip_id = 100
            # 1. Peer initiates TCP active open (SYN)
            wire_peer.send(
                build_tcp_frame(
                    C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                    peer_seq, 0, 0x02, TCP_WINDOW, ip_id=ip_id,
                )
            )
            ip_id += 1
            peer_seq = (peer_seq + 1) & 0xFFFFFFFF

            # 2. C server resolves peer MAC via ARP before replying SYN-ACK
            arp_req = parse_frame(wire_peer.recv())
            assert arp_req["kind"] == "ARP" and arp_req["op"] == 1
            wire_peer.send(build_arp_frame(2, arp_req["sha"], PEER_MAC, PEER_IP, arp_req["sha"], arp_req["spa"]))

            synack = parse_frame(wire_peer.recv())
            assert synack["kind"] == "TCP" and (synack["flags"] & 0x12) == 0x12 and synack["ack"] == peer_seq
            c_next_seq = (synack["seq"] + 1) & 0xFFFFFFFF
            wire_peer.send(
                build_tcp_frame(
                    C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                    peer_seq, c_next_seq, 0x10, TCP_WINDOW, ip_id=ip_id,
                )
            )
            ip_id += 1

            # 3. Peer sends request payload in SMSS=4 chunks
            for offset in range(0, len(server_msg), TCP_SMSS):
                chunk = server_msg[offset : offset + TCP_SMSS]
                wire_peer.send(
                    build_tcp_frame(
                        C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                        peer_seq, c_next_seq, 0x18, TCP_WINDOW, data=chunk, ip_id=ip_id,
                    )
                )
                ip_id += 1
                peer_seq = (peer_seq + len(chunk)) & 0xFFFFFFFF
                ack = parse_frame(wire_peer.recv())
                assert ack["kind"] == "TCP" and ack["ack"] == peer_seq
            # Window-update ACK emitted on T.app.receive
            win_ack = parse_frame(wire_peer.recv())
            assert win_ack["kind"] == "TCP" and (win_ack["flags"] & 0x10)

            # 4. Receive echoed response from C server
            echoed = bytearray()
            while len(echoed) < len(expected_echo):
                seg = parse_frame(wire_peer.recv())
                assert seg["kind"] == "TCP" and seg["seq"] == c_next_seq and seg["payload"]
                echoed.extend(seg["payload"])
                c_next_seq = (c_next_seq + len(seg["payload"])) & 0xFFFFFFFF
                wire_peer.send(
                    build_tcp_frame(
                        C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                        peer_seq, c_next_seq, 0x10, TCP_WINDOW, ip_id=ip_id,
                    )
                )
                ip_id += 1
            peer_state["echoed"] = bytes(echoed)

            # 5. Passive-close teardown: peer sends FIN-ACK -> receives ACK + C FIN-ACK -> replies final ACK
            wire_peer.send(
                build_tcp_frame(
                    C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                    peer_seq, c_next_seq, 0x11, TCP_WINDOW, ip_id=ip_id,
                )
            )
            peer_seq = (peer_seq + 1) & 0xFFFFFFFF
            fin_ack_reply = parse_frame(wire_peer.recv())
            assert fin_ack_reply["kind"] == "TCP" and fin_ack_reply["ack"] == peer_seq
            c_fin = parse_frame(wire_peer.recv())
            assert c_fin["kind"] == "TCP" and (c_fin["flags"] & 0x01)
            c_next_seq = (c_next_seq + 1) & 0xFFFFFFFF
            wire_peer.send(
                build_tcp_frame(
                    C_MAC, PEER_MAC, PEER_IP, C_IP, PEER_PORT, C_PORT,
                    peer_seq, c_next_seq, 0x10, TCP_WINDOW, ip_id=ip_id + 1,
                )
            )
        except BaseException as exc:  # pragma: no cover - surfaced in main thread
            peer_error.append(exc)

    thread = threading.Thread(target=peer_worker, daemon=True)
    thread.start()

    ep = NativeEndpoint(executable)
    try:
        t_ms = 0
        # Passive open (LISTEN)
        ep.dispatch(t_ms, "T.app.listen")
        assert ep.last_vars["T.control"] == "LISTEN"
        t_ms += 1

        # Receive peer SYN -> SYN-RECEIVED + ARP Request
        syn_frame = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        r_arp = ep.feed_frame(t_ms, syn_frame)
        assert ep.last_vars["T.control"] == "SYN-RECEIVED"
        for f in ep.emitted_frames(r_arp):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        t_ms += 1

        # Receive ARP Reply -> flushes SYN-ACK
        arp_rep = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        r_sa = ep.feed_frame(t_ms, arp_rep)
        for f in ep.emitted_frames(r_sa):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        t_ms += 1

        # Receive peer ACK -> ESTABLISHED
        ack_frame = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        ep.feed_frame(t_ms, ack_frame)
        assert ep.last_vars["T.control"] == "ESTABLISHED"
        t_ms += 1

        # Read request from peer and echo response back
        req_rx, t_ms = _receive_tcp_into_c(ep, wire_c, pcap, scenario, t_ms, len(server_msg))
        if req_rx != server_msg:
            raise AssertionError(f"Server received {req_rx!r}, expected {server_msg!r}")
        reply_bytes = _echo_bytes(req_rx)
        t_ms = _send_tcp_from_c(ep, wire_c, pcap, scenario, t_ms, reply_bytes)

        # Peer FIN-ACK -> CLOSE-WAIT -> T.app.close -> LAST-ACK -> final ACK -> CLOSED
        peer_fin = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        r_cw = ep.feed_frame(t_ms, peer_fin)
        assert ep.last_vars["T.control"] == "CLOSE-WAIT"
        for f in ep.emitted_frames(r_cw):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        t_ms += 1

        r_la = ep.dispatch(t_ms, "T.app.close")
        assert ep.last_vars["T.control"] == "LAST-ACK"
        for f in ep.emitted_frames(r_la):
            _send_and_record(wire_c, pcap, f, "C -> Peer", scenario)
        t_ms += 1

        final_ack = _recv_and_record(wire_c, pcap, "Peer -> C", scenario)
        ep.feed_frame(t_ms, final_ack)
        final_l = ep.last_vars["L.control"]
        final_t = ep.last_vars["T.control"]
        transitions = ep.transitions
    except Exception:
        ep.close(ignore_status=True)
        raise
    else:
        ep.close()

    thread.join(timeout=5.0)
    if thread.is_alive():
        raise TimeoutError("Server scenario peer thread did not exit cleanly")
    if peer_error:
        raise peer_error[0]

    assert peer_state.get("echoed") == expected_echo
    return {
        "transitions": transitions,
        "final_L_control": final_l,
        "final_T_control": final_t,
        "server_received": req_rx.decode("utf-8", errors="replace"),
        "peer_received_echo": peer_state["echoed"].decode("utf-8", errors="replace"),
    }


def _open_linux_tap(ifname: str) -> int:
    if not sys.platform.startswith("linux"):
        raise RuntimeError("--mode tap is supported on Linux /dev/net/tun hosts only")
    if not ifname or len(ifname.encode()) >= 16:
        raise ValueError("TAP interface name must be 1..15 bytes")
    import fcntl

    tunsetiff = 0x400454CA
    iff_tap_no_pi = 0x1002
    fd = os.open("/dev/net/tun", os.O_RDWR | os.O_NONBLOCK)
    try:
        fcntl.ioctl(fd, tunsetiff, struct.pack("16sH", ifname.encode(), iff_tap_no_pi))
    except Exception:
        os.close(fd)
        raise
    return fd


def run_tap_bridge(executable: Path, out: Path, ifname: str, duration: float) -> dict:
    """Attach compiled tcpip-reference (LISTEN mode) to a live Linux TAP device."""
    tap_fd = _open_linux_tap(ifname)
    pcap = None
    ep = None
    start_ns = time.monotonic_ns()
    deadline_ns = start_ns + int(duration * 1_000_000_000)
    try:
        pcap = PcapRecorder(out / "live-capture.pcap")
        ep = NativeEndpoint(executable)
        ep.dispatch(0, "T.app.listen")
        while True:
            now_ns = time.monotonic_ns()
            if now_ns >= deadline_ns:
                break
            timeout = min(0.2, (deadline_ns - now_ns) / 1_000_000_000)
            readable, _, _ = select.select([tap_fd], [], [], timeout)
            if not readable:
                continue
            raw = os.read(tap_fd, 2048)
            if len(raw) < 14:
                continue
            ethertype = struct.unpack("!H", raw[12:14])[0]
            if ethertype not in (ETH_P_ARP, ETH_P_IP):
                continue
            pcap.record(raw, "TAP -> C", "tap")
            t_ms = (time.monotonic_ns() - start_ns) // 1_000_000
            try:
                row = ep.feed_frame(t_ms, raw)
            except RuntimeError:
                continue
            for tx in ep.emitted_frames(row):
                pcap.record(tx, "C -> TAP", "tap")
                os.write(tap_fd, tx)
        return {
            "tap_interface": ifname,
            "duration_seconds": duration,
            "transitions": ep.transitions,
            "final_L_control": ep.last_vars["L.control"],
            "final_T_control": ep.last_vars["T.control"],
        }
    except KeyboardInterrupt:
        return {
            "tap_interface": ifname,
            "interrupted": True,
            "transitions": ep.transitions if ep else 0,
            "final_L_control": ep.last_vars.get("L.control") if ep else None,
            "final_T_control": ep.last_vars.get("T.control") if ep else None,
        }
    finally:
        if pcap is not None:
            pcap.close()
        os.close(tap_fd)
        if ep is not None:
            # OS noise on TAP (uncovered ARP/multicast) increments protocol.c's error exit code.
            ep.close(ignore_status=True)


def _compile_c_binary(out: Path) -> tuple[Path, dict]:
    manifest = json.loads((ROOT / "code/generated/manifest.json").read_text())
    source = ROOT / manifest["source"]
    model = ROOT / manifest["authority"]
    if _sha256(source) != manifest["C_sha256"] or _sha256(model) != manifest["model_sha256"]:
        raise ValueError("Model or generated C differs from code/generated/manifest.json")
    compiler = shutil.which("cc")
    if not compiler:
        raise ValueError("A C99 compiler named cc is required")
    executable = out / "tcpip-reference"
    cmd = [compiler, "-std=c99", "-Wall", "-Wextra", "-Werror", str(source), "-o", str(executable)]
    res = subprocess.run(cmd, capture_output=True, text=True, timeout=90)
    if res.returncode != 0:
        raise RuntimeError(f"C compilation failed: {res.stderr}")
    return executable, manifest


def run_demo(
    out: Path,
    mode: str = "all",
    transport: str = "auto",
    port_a: int = 0,
    port_b: int = 0,
    tap: str = "",
    duration: float = 10.0,
    client_message: str = "hello",
    server_message: str = "ping",
    udp_message: str = "udp-ping",
    icmp_message: str = "icmp-ping",
) -> dict:
    """Compile C stack, execute live communicating protocol exchanges, write PCAP."""
    out = Path(out).resolve()
    if out.is_relative_to(ROOT) or out.exists():
        raise ValueError("Use a fresh output directory outside the repository")

    client_bytes = client_message.encode("utf-8")
    server_bytes = server_message.encode("utf-8")
    udp_bytes = udp_message.encode("utf-8")
    icmp_bytes = icmp_message.encode("utf-8")
    for label, val in (("client-message", client_bytes), ("server-message", server_bytes)):
        if not (1 <= len(val) <= TCP_WINDOW):
            raise ValueError(f"{label} must be 1..{TCP_WINDOW} UTF-8 bytes (got {len(val)})")
    if len(udp_bytes) > 1467 or len(icmp_bytes) > 1472:
        raise ValueError("UDP/ICMP payload exceeds MTU 1500 budget")
    if mode == "tap":
        if not tap:
            raise ValueError("--tap <ifname> is required with --mode tap")
        if not sys.platform.startswith("linux"):
            raise RuntimeError("--mode tap is supported on Linux /dev/net/tun hosts only")

    out.mkdir(parents=True)
    executable, manifest = _compile_c_binary(out)
    pcap_path = out / "live-capture.pcap"
    scenarios: dict = {}

    if mode == "tap":
        transport_used = "linux_tap"
        transport_meta = {"tap": tap}
        scenarios["tap"] = run_tap_bridge(executable, out, tap, duration)
        frame_lines = []
    else:
        pcap = PcapRecorder(pcap_path)
        transport_used = ""
        transport_meta = {}
        try:
            for sc_name in (("client", "server") if mode == "all" else (mode,)):
                wire_c, wire_peer, transport_used, sc_meta = open_wire_pair(transport, port_a, port_b)
                transport_meta[sc_name] = sc_meta
                try:
                    if sc_name == "client":
                        scenarios["client"] = run_client_scenario(
                            executable, wire_c, wire_peer, pcap, client_bytes, udp_bytes, icmp_bytes
                        )
                    else:
                        scenarios["server"] = run_server_scenario(
                            executable, wire_c, wire_peer, pcap, server_bytes
                        )
                finally:
                    wire_c.close()
                    wire_peer.close()
            frame_lines = [
                format_frame_line(idx, direction, scen, raw)
                for idx, direction, scen, raw in pcap.frames
            ]
        finally:
            pcap.close()

    pcap_records_fn = _load_pcap_records()
    decoded = pcap_records_fn(pcap_path.read_bytes())
    if mode == "tap" and decoded:
        frame_lines = [format_frame_line(i + 1, "TAP", "tap", r["raw"]) for i, r in enumerate(decoded)]

    (out / "frames.txt").write_text("\n".join(frame_lines) + ("\n" if frame_lines else ""))

    tcpdump_bin = shutil.which("tcpdump")
    tcpdump_text = ""
    if tcpdump_bin and pcap_path.stat().st_size > 24:
        td = subprocess.run([tcpdump_bin, "-nn", "-r", str(pcap_path)], capture_output=True, text=True, timeout=30)
        tcpdump_text = td.stdout
        (out / "tcpdump.txt").write_text(tcpdump_text)

    summary = {
        "schema": "tcpip-live-demo-v1",
        "status": "pass",
        "mode": mode,
        "transport_used": transport_used,
        "transport_meta": transport_meta,
        "executable": str(executable),
        "C_sha256": manifest["C_sha256"],
        "model_sha256": manifest["model_sha256"],
        "pcap_path": str(pcap_path),
        "pcap_sha256": _sha256(pcap_path),
        "packet_count": len(decoded),
        "tcpdump_available": bool(tcpdump_bin),
        "scenarios": scenarios,
    }
    (out / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    summary["frame_lines"] = frame_lines
    summary["tcpdump_output"] = tcpdump_text
    return summary


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, required=True, help="Fresh output directory outside repository")
    parser.add_argument("--mode", choices=("all", "client", "server", "tap"), default="all")
    parser.add_argument("--transport", choices=("auto", "udp", "unix"), default="auto")
    parser.add_argument("--port-a", type=int, default=0, help="Local UDP port for C bridge (0=ephemeral)")
    parser.add_argument("--port-b", type=int, default=0, help="Local UDP port for peer thread (0=ephemeral)")
    parser.add_argument("--tap", default="", help="Linux TAP interface name (with --mode tap)")
    parser.add_argument("--duration", type=float, default=10.0, help="Seconds to run --mode tap bridge")
    parser.add_argument("--client-message", default="hello")
    parser.add_argument("--server-message", default="ping")
    parser.add_argument("--udp-message", default="udp-ping")
    parser.add_argument("--icmp-message", default="icmp-ping")
    parser.add_argument("--json", action="store_true", help="Print JSON summary instead of trace report")
    args = parser.parse_args()
    try:
        res = run_demo(
            out=args.out,
            mode=args.mode,
            transport=args.transport,
            port_a=args.port_a,
            port_b=args.port_b,
            tap=args.tap,
            duration=args.duration,
            client_message=args.client_message,
            server_message=args.server_message,
            udp_message=args.udp_message,
            icmp_message=args.icmp_message,
        )
    except (ValueError, RuntimeError, OSError, AssertionError, subprocess.TimeoutExpired) as exc:
        print(json.dumps({"status": "error", "reason": str(exc)}), file=sys.stderr)
        return 2

    if args.json:
        out_obj = {k: v for k, v in res.items() if k not in ("frame_lines", "tcpdump_output")}
        print(json.dumps(out_obj, indent=2))
    else:
        print(f"Live IPv4 prototype run: PASS (transport={res['transport_used']}, packets={res['packet_count']})")
        for name, sc in res["scenarios"].items():
            if name == "client":
                print(
                    f"  [client] TCP {sc['tcp_sent']!r} -> {sc['tcp_echo_received']!r} | "
                    f"UDP {sc['udp_sent']!r} -> {sc['udp_echo_received']!r} | "
                    f"ICMP -> {sc['icmp_echo_received']!r} | state={sc['final_T_control']}"
                )
            elif name == "server":
                print(
                    f"  [server] rx={sc['server_received']!r} -> echo={sc['peer_received_echo']!r} | "
                    f"state={sc['final_T_control']}"
                )
        print("Wire trace:")
        for line in res["frame_lines"]:
            print(" ", line)
        print(f"\nPCAP written: {res['pcap_path']}")
        print(f"Inspect with: tcpdump -nn -r {res['pcap_path']}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
