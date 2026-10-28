"""Strict classic-PCAP IPv4/TCP decoder and explicit opening normalizers.

This decoder is independent of the synthetic packet encoder. Unsupported selected
traffic is rejected; unrelated traffic is counted and filtered explicitly.
"""
import hashlib
import ipaddress
import json
import struct
from pathlib import Path

from .ir import MOD, ModelError, require


def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def sum_ok(data):
    data += b"\0" if len(data) % 2 else b""
    total = sum(int.from_bytes(data[i:i+2], "big") for i in range(0, len(data), 2))
    while total > 65535:
        total = (total & 65535) + (total >> 16)
    return total == 65535


def decode(path):
    data = Path(path).read_bytes()
    require(len(data) >= 24, "Truncated PCAP header")
    magics = {b"\xd4\xc3\xb2\xa1": ("<", 1000), b"\xa1\xb2\xc3\xd4": (">", 1000),
              b"\x4d\x3c\xb2\xa1": ("<", 1), b"\xa1\xb2\x3c\x4d": (">", 1)}
    require(data[:4] in magics, "Unsupported capture format (classic PCAP required)")
    endian, ns_factor = magics[data[:4]]
    major, minor, zone, accuracy, snaplen, linktype = struct.unpack(endian+"HHIIII", data[4:24])
    require((major, minor) == (2, 4) and linktype in (1, 101, 113), "Unsupported PCAP version/link type")
    require(snaplen > 0, "Invalid snaplen")
    pos, frame, previous_ns = 24, 0, -1
    while pos < len(data):
        require(pos+16 <= len(data), "Truncated PCAP record header")
        sec, fraction, captured, original = struct.unpack(endian+"IIII", data[pos:pos+16])
        pos += 16
        require(fraction < (1000000000 // ns_factor), "Invalid PCAP timestamp fraction")
        timestamp_ns = sec*1000000000 + fraction*ns_factor
        require(timestamp_ns >= previous_ns, "Nonmonotonic PCAP timestamps")
        previous_ns = timestamp_ns
        require(captured <= snaplen and captured <= original and pos+captured <= len(data), "Truncated/invalid PCAP record")
        raw = data[pos:pos+captured]
        pos += captured
        frame += 1
        base = {"frame": frame, "timestamp_ns": timestamp_ns}
        if linktype == 1:
            require(len(raw) >= 14, "Truncated Ethernet header")
            protocol, offset = int.from_bytes(raw[12:14], "big"), 14
            while protocol in (0x8100, 0x88a8):
                require(len(raw) >= offset+4, "Truncated VLAN tag")
                protocol = int.from_bytes(raw[offset+2:offset+4], "big")
                offset += 4
            if protocol != 0x800:
                yield {**base, "ignored": "non_ipv4"}
                continue
            raw = raw[offset:]
        elif linktype == 113:
            require(len(raw) >= 16, "Truncated Linux cooked header")
            if raw[14:16] != b"\x08\x00":
                yield {**base, "ignored": "non_ipv4"}
                continue
            raw = raw[16:]
        require(len(raw) >= 20 and raw[0] >> 4 == 4, "Truncated/invalid IPv4 header")
        ihl = (raw[0] & 15)*4
        total = int.from_bytes(raw[2:4], "big")
        require(ihl >= 20 and ihl <= len(raw) and ihl <= total <= len(raw), "Truncated/invalid IPv4 length")
        if raw[9] != 6:
            yield {**base, "ignored": "non_tcp"}
            continue
        require(total >= ihl+4, "Truncated TCP ports")
        tcp = raw[ihl:total]
        # Return metadata first so connection filtering precedes selected-packet checks.
        yield {**base, "src": str(ipaddress.IPv4Address(raw[12:16])), "dst": str(ipaddress.IPv4Address(raw[16:20])),
               "sport": int.from_bytes(tcp[:2], "big"), "dport": int.from_bytes(tcp[2:4], "big"),
               "ip": raw[:ihl], "tcp": tcp, "fragmented": bool(int.from_bytes(raw[6:8], "big") & 0x3fff)}


def normalize(pcap, profile, expected, origin="unverified", checksum_policy="strict", projection="active-open-v1"):
    require(projection in ("active-open-v1", "tcp-data-v1", "tcp-fin-v1", "tcp-connection-v1"), "Unsupported TCP projection")
    data_mode = projection in ("tcp-data-v1", "tcp-fin-v1", "tcp-connection-v1")
    require(origin in ("unverified", "synthetic", "external_capture"), "Invalid capture origin")
    require(checksum_policy in ("strict", "record_offload"), "Invalid checksum policy")
    require(bool(expected), "Expected packet trace is empty")
    for endpoint in (profile["local"], profile["peer"]):
        ipaddress.IPv4Address(endpoint["ip"])
        require(type(endpoint["port"]) is int and 0 < endpoint["port"] < 65536, "Invalid endpoint port")
    local = (profile["local"]["ip"], profile["local"]["port"])
    peer = (profile["peer"]["ip"], profile["peer"]["port"])
    selected, ignored, checksum_warnings = [], 0, []
    for record in decode(pcap):
        if "ignored" in record:
            ignored += 1
            continue
        source, dest = (record["src"], record["sport"]), (record["dst"], record["dport"])
        direction = "out" if (source, dest) == (local, peer) else "in" if (source, dest) == (peer, local) else None
        if direction is None:
            ignored += 1
            continue
        require(not record["fragmented"], "Selected IPv4 fragmentation is unsupported")
        tcp = record["tcp"]
        require(len(tcp) >= 20, "Truncated selected TCP header")
        size = (tcp[12] >> 4)*4
        require(20 <= size <= len(tcp), "Invalid selected TCP data offset")
        require(data_mode or size == len(tcp), "TCP payload is outside this active-open slice")
        require(tcp[12] & 15 == 0, "Reserved/extended TCP flags unsupported")
        shapes = {2: "S", 18: "SA", 16: "A"}
        if data_mode:
            shapes.update({1: "F", 17: "FA", 4: "R", 20: "RA"})
        flags = shapes.get(tcp[13])
        require(flags is not None, "TCP control flags outside this active-open slice")
        require(size == len(tcp) or flags == "A" or (projection in ("tcp-fin-v1", "tcp-connection-v1") and flags == "FA"), "Payload on SYN/FIN/RST is outside this data slice")
        require(sum_ok(record["ip"]), "Invalid IPv4 checksum")
        pseudo = record["ip"][12:20] + b"\x00\x06" + len(tcp).to_bytes(2, "big")
        if not sum_ok(pseudo + tcp):
            require(checksum_policy == "record_offload", "Invalid TCP checksum (possible offload; policy must be explicit)")
            checksum_warnings.append(record["frame"])
        selected.append({"direction": direction, "flags": flags, "seq": int.from_bytes(tcp[4:8], "big"),
                         "ack": int.from_bytes(tcp[8:12], "big") if tcp[13] & 16 else 0,
                         **({"window": int.from_bytes(tcp[14:16], "big"), "payload": list(tcp[size:])} if data_mode else {}),
                         "frame": record["frame"], "timestamp_ns": record["timestamp_ns"]})
    if projection == "tcp-connection-v1":
        require(bool(selected) and selected[0]["flags"] == "S", "Connection capture must begin with an initial SYN")
        require(expected[0]["flags"] == "S", "Connection expected trace must begin with an initial SYN")
        def origins(packets):
            return {direction: next((p["seq"] for p in packets if p["direction"] == direction and p["flags"] in ("S", "SA")), None)
                    for direction in ("in", "out")}
        wire, model = origins(selected), origins(expected)
        wire_local, wire_peer = wire["out"], wire["in"]
        model_local, model_peer = model["out"], model["in"]
    else:
        require(bool(selected) and selected[0]["direction"] == "out" and selected[0]["flags"] == "S", "Capture must begin with this connection's initial outgoing SYN")
        synack = next((p for p in selected if p["direction"] == "in" and p["flags"] == "SA"), None)
        require(synack is not None, "No peer SYN+ACK captured")
        require(expected[0]["direction"] == "out" and expected[0]["flags"] == "S", "Expected trace must start with SYN")
        model_peer = next((p["seq"] for p in expected if p["direction"] == "in" and p["flags"] == "SA"), None)
        require(model_peer is not None, "Expected trace lacks SYN+ACK")
        wire_local, wire_peer = selected[0]["seq"], synack["seq"]
        model_local = expected[0]["seq"]
    result = []
    for packet in selected:
        out = packet["direction"] == "out"
        require((wire_local if out else wire_peer) is not None and (model_local if out else model_peer) is not None,
                "Missing observed/model SYN anchor for sequence direction")
        if "A" in packet["flags"]:
            require((wire_peer if out else wire_local) is not None and (model_peer if out else model_local) is not None,
                    "Missing observed/model SYN anchor for ACK direction")
        result.append({"direction": packet["direction"], "flags": packet["flags"],
                       "seq": (packet["seq"] - (wire_local if out else wire_peer) + (model_local if out else model_peer)) % MOD,
                       "ack": (packet["ack"] - (wire_peer if out else wire_local) + (model_peer if out else model_local)) % MOD if "A" in packet["flags"] else 0,
                       "time_ms": (packet["timestamp_ns"] - selected[0]["timestamp_ns"])/1000000 + expected[0]["time_ms"],
                       "capture_frame": packet["frame"]})
        if data_mode:
            result[-1].update(window=packet["window"], payload=packet["payload"])
    metadata = {"normalizer": "classic-pcap-ipv4-tcp-v1", "capture_origin": origin,
                "capture_sha256": sha(pcap), "profile": profile, "profile_sha256": hashlib.sha256(json.dumps(profile, sort_keys=True).encode()).hexdigest(),
                "selected_packets": len(result), "ignored_frames": ignored,
                "time_origin_ns": selected[0]["timestamp_ns"], "wire_local_iss": wire_local, "wire_peer_iss": wire_peer,
                "checksum_policy": checksum_policy, "checksum_warning_frames": checksum_warnings,
                "deduplication": "none", "origin_is_user_assertion": True}
    if data_mode:
        metadata.update(normalizer="classic-pcap-ipv4-" + projection, projection=projection)
    if projection == "tcp-connection-v1":
        metadata.update(sequence_anchor_policy="first_observed_SYN_per_direction", missing_anchor_policy="reject_when_required")
    return result, metadata
