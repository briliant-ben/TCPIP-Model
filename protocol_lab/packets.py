"""TCP slice adapters. PCAPs are synthetic model evidence, not real captures."""
import socket
import struct

from .ir import MOD, ModelError, require


def normalize_trace(machine, scenario):
    packets = []
    drops = set(scenario["environment"]["drop_outgoing"])
    for row in machine.trace:
        common = {"time_ms": row["time_ms"], "event_id": row["event_id"],
                  "transition": row["transition"], "requirements": row["requirements"]}
        if row["event"]["name"] == "net.synack":
            fields = row["event"]["fields"]
            packets.append({**common, "packet_id": row["event_id"] + ":in", "direction": "in",
                            "flags": "SA", "seq": fields["seq"], "ack": fields["ack"], "window": 65535,
                            "dropped_after_egress": False})
        for i, msg in enumerate(row["emitted"]):
            require(msg["message"] == "tcp", "TCP adapter received another message type")
            packet_id = f"{row['event_id']}:out:{i}"
            packets.append({**common, "packet_id": packet_id, "direction": "out", **msg["fields"],
                            "dropped_after_egress": packet_id in drops})
    outgoing = {p["packet_id"] for p in packets if p["direction"] == "out"}
    require(drops <= outgoing, f"Drop refers to nonexistent outgoing packet: {drops-outgoing}")
    # This profile only models loss of SYN transmissions before the peer responds.
    require(all(p["flags"] == "S" for p in packets if p["packet_id"] in drops), "Only SYN loss supported")
    return packets


def checksum(data):
    if len(data) % 2:
        data += b"\0"
    total = sum(struct.unpack(f"!{len(data)//2}H", data))
    while total >> 16:
        total = (total & 0xffff) + (total >> 16)
    return (~total) & 0xffff


def ipv4_tcp(packet, identification):
    flag_values = {"S": 2, "SA": 18, "A": 16, "F": 1, "FA": 17, "R": 4, "RA": 20}
    require(packet["flags"] in flag_values, "Unsupported TCP flags")
    local, remote = socket.inet_aton("192.0.2.1"), socket.inet_aton("192.0.2.2")
    src, dst, sport, dport = (local, remote, 40000, 8080) if packet["direction"] == "out" else (remote, local, 8080, 40000)
    flags = flag_values[packet["flags"]]
    tcp = struct.pack("!HHIIBBHHH", sport, dport, packet["seq"], packet["ack"], 5 << 4, flags, packet["window"], 0, 0)
    pseudo = src + dst + struct.pack("!BBH", 0, 6, len(tcp))
    tcp = tcp[:16] + struct.pack("!H", checksum(pseudo + tcp)) + tcp[18:]
    ip = struct.pack("!BBHHHBBH4s4s", 0x45, 0, 40, identification & 0xffff, 0, 64, 6, 0, src, dst)
    ip = ip[:10] + struct.pack("!H", checksum(ip)) + ip[12:]
    return ip + tcp


def write_pcap(path, packets):
    # DLT_RAW=101, little-endian PCAP v2.4, microsecond timestamps.
    data = struct.pack("<IHHIIII", 0xa1b2c3d4, 2, 4, 0, 0, 65535, 101)
    for i, packet in enumerate(packets, 1):
        raw = ipv4_tcp(packet, i)
        seconds, ms = divmod(packet["time_ms"], 1000)
        data += struct.pack("<IIII", seconds, ms * 1000, len(raw), len(raw)) + raw
    path.write_bytes(data)


def packetdrill(packets):
    """Generate an unexecuted Linux profile; relative seq numbers are per peer."""
    require(bool(packets) and packets[0]["flags"] == "S", "Expected initial SYN")
    local_iss = packets[0]["seq"]
    peer = next((p["seq"] for p in packets if p["direction"] == "in" and p["flags"] == "SA"), None)
    require(peer is not None, "Expected peer SYN+ACK")
    lines = ["// GENERATED from Protocol IR; external execution is recorded separately.",
             "// Linux active-open profile; default initial RTO 1s; no SYN payload.",
             "// Outgoing SYN options are wildcarded; timestamps/windows are outside comparison.",
             "0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3",
             "+0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0",
             "+0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)"]
    mapping = []
    previous_ms = 0
    for p in packets:
        lines.append(f"// {p['packet_id']} {p['transition']} {' '.join(p['requirements'])}")
        # Relative timing preserves causality when the real retransmission is late.
        # The runner supplies a 50ms tolerance. Timings are a selected test profile.
        delta = (p["time_ms"] - previous_ms) / 1000
        when = f"+{delta:.3f}"
        previous_ms = p["time_ms"]
        arrow = ">" if p["direction"] == "out" else "<"
        base = local_iss if p["direction"] == "out" else peer
        ack_base = peer if p["direction"] == "out" else local_iss
        seq = (p["seq"] - base) % MOD
        flags = {"S": "S", "SA": "S.", "A": "."}[p["flags"]]
        line = f"{when} {arrow} {flags} {seq}:{seq}(0)"
        if "A" in p["flags"]:
            line += f" ack {(p['ack'] - ack_base) % MOD}"
        if p["direction"] == "in":
            line += f" win {p['window']}"
        if p["flags"] == "S":
            line += " <...>"
        lines.append(line)
        mapping.append({"line": len(lines), "packet_id": p["packet_id"], "event_id": p["event_id"]})
    # Confirm nonblocking connect completion through the public socket API.
    lines.append("+0 getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0")
    return "\n".join(lines) + "\n", mapping


def compare(expected, observed, tolerance_ms=50):
    """Strict ordered projection oracle for this deterministic profile only.

    Input sequence values must already be normalized to the model's ISS values.
    PCAP parsing/reassembly, option comparison and nondeterministic trace-language
    acceptance are future adapters, not implicit behavior here.
    """
    require(type(tolerance_ms) is int and tolerance_ms >= 0, "Invalid tolerance")
    require(type(observed) is list, "Observed packets must be a list")
    differences = []
    if len(expected) != len(observed):
        differences.append({"kind": "packet_count", "expected": len(expected), "observed": len(observed)})
    for index, packet in enumerate(observed):
        require(type(packet) is dict, f"Invalid observed packet {index}")
        for key in ("direction", "flags", "seq", "ack", "time_ms"):
            require(key in packet, f"Missing observed packet field {key}")
        require(packet["direction"] in ("in", "out"), "Invalid observed direction")
        require(type(packet["flags"]) is str, "Invalid observed flags")
        require(all(type(packet[k]) is int and 0 <= packet[k] < MOD for k in ("seq", "ack")), "Invalid observed sequence")
        require(type(packet["time_ms"]) in (int, float) and packet["time_ms"] >= 0, "Invalid observed time")
    for index, (want, got) in enumerate(zip(expected, observed)):
        for key in ("direction", "flags", "seq", "ack", "time_ms"):
            mismatch = abs(want[key] - got[key]) > tolerance_ms if key == "time_ms" else want[key] != got[key]
            if mismatch:
                differences.append({"kind": "field", "index": index, "packet_id": want["packet_id"],
                                    "event_id": want["event_id"], "requirements": want["requirements"],
                                    "field": key, "expected": want[key], "observed": got[key]})
    return {"status": "mismatch" if differences else "match", "oracle": "ordered-projection-v1",
            "tolerance_ms": tolerance_ms, "compared_fields": ["direction", "flags", "seq", "ack", "time_ms"],
            "differences": differences}
