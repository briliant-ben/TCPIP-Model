"""Author all 10 Protocol IR 0.6 modules and `model/tcpip-stack-system.json` declaratively."""
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
DEFAULT_FRAMEWORK = ROOT.parent / "Formal-Spec-Agent"


def _load_builder(framework: Path):
    f = str(framework.resolve())
    if f not in sys.path:
        sys.path.insert(0, f)
    from formal_spec_agent import ir_builder as B
    return B


def _csum_pseudo(B, src_ip, dst_ip, proto_num, l4_zero):
    return B.csum16(B.b_concat(src_ip, dst_ip, B.bytes_lit([0, proto_num]), B.pack16be(B.b_len(l4_zero)), l4_zero))


def _splice_2b(B, buf, offset, val16):
    p = B.pack16be(val16)
    return B.b_concat(B.b_slice(buf, 0, offset), p, B.b_slice(buf, offset + 2, B.sub_(B.b_len(buf), offset + 2)))


def _udp_build_pkt(B, src_ip, dst_ip, src_port, dst_port, data):
    ulen = B.add_(8, B.b_len(data))
    zero = B.b_concat(B.pack16be(src_port), B.pack16be(dst_port), B.pack16be(ulen), B.bytes_lit([0, 0]), data)
    raw_chk = _csum_pseudo(B, src_ip, dst_ip, 17, zero)
    chk = B.ite_(B.eq_(raw_chk, 0), 65535, raw_chk)
    return B.b_concat(B.pack16be(src_port), B.pack16be(dst_port), B.pack16be(ulen), B.pack16be(chk), data)


def _tcp_build_seg(B, src_ip, dst_ip, src_port, dst_port, seq_expr, ack_expr, flags_expr, wnd_expr, mss_opt, payload):
    opts = B.b_concat(B.bytes_lit([2, 4]), B.pack16be(mss_opt)) if mss_opt is not None else B.bytes_lit([])
    doff = 6 if mss_opt is not None else 5
    hdr_prefix = B.b_concat(
        B.pack16be(src_port),
        B.pack16be(dst_port),
        B.pack_seq32be(seq_expr),
        B.pack_seq32be(ack_expr),
        B.pack8(doff * 16),
        B.pack8(flags_expr),
        B.pack16be(wnd_expr),
    )
    hdr_tail = B.b_concat(B.bytes_lit([0, 0]), opts)
    hdr_zero = B.b_concat(hdr_prefix, B.bytes_lit([0, 0]), hdr_tail)
    seg_len = B.add_(doff * 4, B.b_len(payload))
    pseudo = B.b_concat(src_ip, dst_ip, B.bytes_lit([0, 6]), B.pack16be(seg_len), hdr_zero, payload)
    chk = B.csum16(pseudo)
    return B.b_concat(hdr_prefix, B.pack16be(chk), hdr_tail, payload)


def _ipv4_build_pkt(B, src_ip, dst_ip, ip_id, flags_off_u16, proto, payload):
    tot = B.add_(20, B.b_len(payload))
    hdr_head = B.b_concat(
        B.bytes_lit([0x45, 0x00]),
        B.pack16be(tot),
        B.pack16be(ip_id),
        B.pack16be(flags_off_u16),
        B.bytes_lit([64]),
        B.pack8(proto),
    )
    addrs = B.b_concat(src_ip, dst_ip)
    chk = B.csum16(B.b_concat(hdr_head, B.bytes_lit([0, 0]), addrs))
    return B.b_concat(hdr_head, B.pack16be(chk), addrs, payload)


def _icmp_echo_reply(B, req):
    z = B.b_concat(B.bytes_lit([0, 0, 0, 0]), B.b_slice(req, 4, B.sub_(B.b_len(req), 4)))
    chk = B.csum16(z)
    return B.b_concat(B.bytes_lit([0, 0]), B.pack16be(chk), B.b_slice(req, 4, B.sub_(B.b_len(req), 4)))


def _icmp_port_unreach(B, orig_prefix):
    trimmed = B.b_slice(orig_prefix, 0, 68)
    z = B.b_concat(B.bytes_lit([3, 3, 0, 0, 0, 0, 0, 0]), trimmed)
    chk = B.csum16(z)
    return B.b_concat(B.bytes_lit([3, 3]), B.pack16be(chk), B.bytes_lit([0, 0, 0, 0]), trimmed)


def _arp_frame(B, op, sha, spa, tha, tpa, eth_dst):
    pad18 = B.bytes_lit([0] * 18)
    return B.b_concat(
        eth_dst,
        sha,
        B.bytes_lit([0x08, 0x06, 0x00, 0x01, 0x08, 0x00, 6, 4]),
        B.pack16be(op),
        sha,
        spa,
        tha,
        tpa,
        pad18,
    )


def _u8_has_bit(B, byte_expr, bit):
    """O(1)-AST test for bit in {1,2,4,8,16,32,64,128} on a 0..255 byte."""
    return B.ge_(B.b_at(B.pack8(B.mul_(byte_expr, 128 // bit)), 0), 128)


def _u8_low_nibble(B, byte_expr):
    """O(1)-AST low nibble (`byte & 0x0f`) for a 0..255 byte."""
    return B.sub_(byte_expr, B.mul_(16, B.u8_hi_nibble(byte_expr)))


def _u16_div8(B, u16_expr):
    """Exact `x >> 3` for 0 <= x <= 65535 using big-endian byte split (2 copies)."""
    p = B.pack16be(u16_expr)
    return B.add_(B.mul_(B.b_at(p, 0), 32), B.b_at(B.pack16be(B.mul_(B.b_at(p, 1), 32)), 0))


def _same_subnet(B, ip_a, ip_b, mask):
    # Bytewise equality under 255/0 or subnet mask when mask bytes are 255 or 0 cleanly;
    # exact per-octet bytewise match for masked octets when mask byte == 255, or prefix check.
    def oct_ok(idx):
        m = B.u8(mask, idx)
        return B.or_(B.eq_(m, 0), B.eq_(B.u8(ip_a, idx), B.u8(ip_b, idx)))
    return B.and_(oct_ok(0), oct_ok(1), oct_ok(2), oct_ok(3))


def build_sys_port(B):
    reqs = {"ARCH.PORT": {"source": "spec/arch/sys-port.md", "interpretation": "OS port abstraction"}}
    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "arch-sys-port",
        "scope": {"terminal_states": [], "excluded": ["host OS syscalls"]},
        "states": ["UNINIT", "READY", "STOPPED"],
        "initial_state": "UNINIT",
        "requirements": reqs,
        "variables": {
            "sem_live": {"type": "int", "initial": 0},
            "mbox_live": {"type": "int", "initial": 0},
            "threads_live": {"type": "int", "initial": 0},
        },
        "events": {
            "port.start": {"origin": "application", "fields": {}},
            "port.stop": {"origin": "application", "fields": {}},
            "port.sem_alloc": {"origin": "application", "fields": {}},
            "port.sem_free": {"origin": "application", "fields": {}},
            "port.mbox_alloc": {"origin": "application", "fields": {}},
            "port.mbox_free": {"origin": "application", "fields": {}},
            "port.thread_spawn": {"origin": "application", "fields": {}},
            "port.thread_join": {"origin": "application", "fields": {}},
        },
        "messages": {},
        "timers": {},
        "transitions": [
            B.rule("SP.START", "UNINIT", "READY", "port.start", True, [], ["ARCH.PORT"]),
            B.rule("SP.RESTART", "STOPPED", "READY", "port.start", True, [], ["ARCH.PORT"]),
            B.rule("SP.STOP", "READY", "STOPPED", "port.stop", True, [], ["ARCH.PORT"]),
            B.rule("SP.SEM_ALLOC", "READY", "READY", "port.sem_alloc", B.lt_(B.var("sem_live"), 256),
                   [B.act_set("sem_live", B.add_(B.var("sem_live"), 1))], ["ARCH.PORT"]),
            B.rule("SP.SEM_FREE", "READY", "READY", "port.sem_free", B.gt_(B.var("sem_live"), 0),
                   [B.act_set("sem_live", B.sub_(B.var("sem_live"), 1))], ["ARCH.PORT"]),
            B.rule("SP.MBOX_ALLOC", "READY", "READY", "port.mbox_alloc", B.lt_(B.var("mbox_live"), 256),
                   [B.act_set("mbox_live", B.add_(B.var("mbox_live"), 1))], ["ARCH.PORT"]),
            B.rule("SP.MBOX_FREE", "READY", "READY", "port.mbox_free", B.gt_(B.var("mbox_live"), 0),
                   [B.act_set("mbox_live", B.sub_(B.var("mbox_live"), 1))], ["ARCH.PORT"]),
            B.rule("SP.THR_SPAWN", "READY", "READY", "port.thread_spawn", B.lt_(B.var("threads_live"), 64),
                   [B.act_set("threads_live", B.add_(B.var("threads_live"), 1))], ["ARCH.PORT"]),
            B.rule("SP.THR_JOIN", "READY", "READY", "port.thread_join", B.gt_(B.var("threads_live"), 0),
                   [B.act_set("threads_live", B.sub_(B.var("threads_live"), 1))], ["ARCH.PORT"]),
        ],
        "invariants": [
            B.inv("SP.SEM_BOUNDS", B.and_(B.ge_(B.var("sem_live"), 0), B.le_(B.var("sem_live"), 256)), ["ARCH.PORT"]),
            B.inv("SP.MBOX_BOUNDS", B.and_(B.ge_(B.var("mbox_live"), 0), B.le_(B.var("mbox_live"), 256)), ["ARCH.PORT"]),
            B.inv("SP.THR_BOUNDS", B.and_(B.ge_(B.var("threads_live"), 0), B.le_(B.var("threads_live"), 64)), ["ARCH.PORT"]),
        ],
    }


def build_frame_pool(B):
    reqs = {"ARCH.POOL": {"source": "spec/arch/frame-pool.md", "interpretation": "Fixed frame pool accounting"}}
    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "arch-frame-pool",
        "scope": {"terminal_states": [], "excluded": ["malloc/free"]},
        "states": ["ACTIVE"],
        "initial_state": "ACTIVE",
        "requirements": reqs,
        "variables": {
            "free_slots": {"type": "int", "initial": 128},
            "used_slots": {"type": "int", "initial": 0},
        },
        "events": {
            "pool.alloc": {"origin": "application", "fields": {}},
            "pool.free": {"origin": "application", "fields": {}},
            "pool.reset": {"origin": "application", "fields": {}},
        },
        "messages": {},
        "timers": {},
        "transitions": [
            B.rule("FP.ALLOC", "ACTIVE", "ACTIVE", "pool.alloc", B.gt_(B.var("free_slots"), 0),
                   [B.act_set("free_slots", B.sub_(B.var("free_slots"), 1)),
                    B.act_set("used_slots", B.add_(B.var("used_slots"), 1))], ["ARCH.POOL"]),
            B.rule("FP.FREE", "ACTIVE", "ACTIVE", "pool.free", B.gt_(B.var("used_slots"), 0),
                   [B.act_set("free_slots", B.add_(B.var("free_slots"), 1)),
                    B.act_set("used_slots", B.sub_(B.var("used_slots"), 1))], ["ARCH.POOL"]),
            B.rule("FP.RESET", "ACTIVE", "ACTIVE", "pool.reset", True,
                   [B.act_set("free_slots", 128), B.act_set("used_slots", 0)], ["ARCH.POOL"]),
        ],
        "invariants": [
            B.inv("FP.CONSERVATION", B.eq_(B.add_(B.var("free_slots"), B.var("used_slots")), 128), ["ARCH.POOL"]),
            B.inv("FP.BOUNDS", B.and_(B.ge_(B.var("free_slots"), 0), B.ge_(B.var("used_slots"), 0)), ["ARCH.POOL"]),
        ],
    }


def build_stack_actor(B):
    reqs = {"ARCH.ACTOR": {"source": "spec/arch/stack-actor.md", "interpretation": "Single-writer stack actor"}}
    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "arch-stack-actor",
        "scope": {"terminal_states": [], "excluded": ["kernel scheduler"]},
        "states": ["STOPPED", "IDLE", "DISPATCHING"],
        "initial_state": "STOPPED",
        "requirements": reqs,
        "variables": {
            "q_depth": {"type": "int", "initial": 0},
            "dispatched_total": {"type": "int", "initial": 0},
        },
        "events": {
            "actor.start": {"origin": "application", "fields": {}},
            "actor.stop": {"origin": "application", "fields": {}},
            "actor.post_rx": {"origin": "application", "fields": {}},
            "actor.post_api": {"origin": "application", "fields": {}},
            "actor.dispatch": {"origin": "application", "fields": {}},
            "actor.complete": {"origin": "application", "fields": {}},
        },
        "messages": {},
        "timers": {},
        "transitions": [
            B.rule("SA.START", "STOPPED", "IDLE", "actor.start", True, [], ["ARCH.ACTOR"]),
            B.rule("SA.STOP", "IDLE", "STOPPED", "actor.stop", True, [B.act_set("q_depth", 0)], ["ARCH.ACTOR"]),
            B.rule("SA.RX_IDLE", "IDLE", "IDLE", "actor.post_rx", B.lt_(B.var("q_depth"), 64),
                   [B.act_set("q_depth", B.add_(B.var("q_depth"), 1))], ["ARCH.ACTOR"]),
            B.rule("SA.RX_BUSY", "DISPATCHING", "DISPATCHING", "actor.post_rx", B.lt_(B.var("q_depth"), 64),
                   [B.act_set("q_depth", B.add_(B.var("q_depth"), 1))], ["ARCH.ACTOR"]),
            B.rule("SA.API_IDLE", "IDLE", "IDLE", "actor.post_api", B.lt_(B.var("q_depth"), 64),
                   [B.act_set("q_depth", B.add_(B.var("q_depth"), 1))], ["ARCH.ACTOR"]),
            B.rule("SA.API_BUSY", "DISPATCHING", "DISPATCHING", "actor.post_api", B.lt_(B.var("q_depth"), 64),
                   [B.act_set("q_depth", B.add_(B.var("q_depth"), 1))], ["ARCH.ACTOR"]),
            B.rule("SA.DISP_QUEUED", "IDLE", "DISPATCHING", "actor.dispatch", B.gt_(B.var("q_depth"), 0),
                   [B.act_set("q_depth", B.sub_(B.var("q_depth"), 1)),
                    B.act_set("dispatched_total", B.add_(B.var("dispatched_total"), 1))], ["ARCH.ACTOR"]),
            B.rule("SA.DISP_TMR", "IDLE", "DISPATCHING", "actor.dispatch", B.eq_(B.var("q_depth"), 0),
                   [B.act_set("dispatched_total", B.add_(B.var("dispatched_total"), 1))], ["ARCH.ACTOR"]),
            B.rule("SA.COMPLETE", "DISPATCHING", "IDLE", "actor.complete", True, [], ["ARCH.ACTOR"]),
        ],
        "invariants": [
            B.inv("SA.Q_BOUNDS", B.and_(B.ge_(B.var("q_depth"), 0), B.le_(B.var("q_depth"), 64)), ["ARCH.ACTOR"]),
            B.inv("SA.TOT_NONNEG", B.ge_(B.var("dispatched_total"), 0), ["ARCH.ACTOR"]),
        ],
    }


def build_arp_neighbor(B):
    reqs = {"L2.ARP": {"source": "spec/stack/l2-arp-netif.md", "interpretation": "RFC 826 neighbor cache"}}
    bcast_mac = B.bytes_lit([255, 255, 255, 255, 255, 255])
    zero_mac = B.bytes_lit([0, 0, 0, 0, 0, 0])
    eth_tx = lambda mac, src_mac, pkt: B.b_concat(mac, src_mac, B.bytes_lit([0x08, 0x00]), B.b_slice(pkt, 0, 1500))
    arp_req = lambda sha, spa, tpa: _arp_frame(B, 1, sha, spa, zero_mac, tpa, bcast_mac)

    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "arp-neighbor",
        "scope": {"terminal_states": [], "excluded": ["proxy ARP"]},
        "states": ["FREE", "PENDING", "REACHABLE"],
        "initial_state": "FREE",
        "requirements": reqs,
        "variables": {
            "ip": {"type": "bytes", "initial": []},
            "mac": {"type": "bytes", "initial": []},
            "src_ip": {"type": "bytes", "initial": []},
            "src_mac": {"type": "bytes", "initial": []},
            "pending_pkt": {"type": "bytes", "initial": []},
            "retries": {"type": "int", "initial": 0},
        },
        "events": {
            "arp.resolve_tx": {"origin": "application", "fields": {"ip": "bytes", "src_mac": "bytes", "src_ip": "bytes", "pkt": "bytes"}},
            "arp.learn": {"origin": "network", "fields": {"ip": "bytes", "mac": "bytes"}},
            "arp.clear": {"origin": "application", "fields": {}},
            "arp.retry_tmr": {"origin": "timer", "fields": {}},
            "arp.ttl_tmr": {"origin": "timer", "fields": {}},
        },
        "messages": {
            "wire_tx": {"fields": {"frame": "bytes"}},
        },
        "timers": {
            "retry_timer": {"event": "arp.retry_tmr"},
            "ttl_timer": {"event": "arp.ttl_tmr"},
        },
        "transitions": [
            *[B.rule(
                f"ARP.RESOLVE_BCAST_{st}", st, st, "arp.resolve_tx",
                B.and_(B.eq_(B.b_len(B.ev("ip")), 4), B.eq_(B.ev("ip"), B.bytes_lit([255, 255, 255, 255])),
                       B.eq_(B.b_len(B.ev("src_mac")), 6)),
                [B.act_emit("wire_tx", frame=eth_tx(B.bytes_lit([255, 255, 255, 255, 255, 255]),
                                                    B.b_slice(B.ev("src_mac"), 0, 6), B.ev("pkt")))],
                ["L2.ARP"],
            ) for st in ("FREE", "PENDING", "REACHABLE")],
            B.rule("ARP.RESOLVE_NEW", "FREE", "PENDING", "arp.resolve_tx",
                   B.and_(B.eq_(B.b_len(B.ev("ip")), 4), B.ne_(B.ev("ip"), B.bytes_lit([255, 255, 255, 255])),
                          B.eq_(B.b_len(B.ev("src_mac")), 6), B.eq_(B.b_len(B.ev("src_ip")), 4)),
                   [B.act_set("ip", B.b_slice(B.ev("ip"), 0, 4)),
                    B.act_set("src_mac", B.b_slice(B.ev("src_mac"), 0, 6)),
                    B.act_set("src_ip", B.b_slice(B.ev("src_ip"), 0, 4)),
                    B.act_set("pending_pkt", B.b_slice(B.ev("pkt"), 0, 1500)),
                    B.act_set("retries", 0),
                    B.act_arm("retry_timer", 250),
                    B.act_emit("wire_tx", frame=arp_req(B.var("src_mac"), B.var("src_ip"), B.var("ip")))],
                   ["L2.ARP"]),
            B.rule("ARP.RESOLVE_PEND", "PENDING", "PENDING", "arp.resolve_tx",
                   B.not_(B.and_(B.eq_(B.b_len(B.ev("ip")), 4), B.eq_(B.ev("ip"), B.bytes_lit([255, 255, 255, 255])),
                                 B.eq_(B.b_len(B.ev("src_mac")), 6))),
                   [B.act_set("pending_pkt", B.b_slice(B.ev("pkt"), 0, 1500)),
                    B.act_set("src_mac", B.b_slice(B.ev("src_mac"), 0, 6)),
                    B.act_set("src_ip", B.b_slice(B.ev("src_ip"), 0, 4))],
                   ["L2.ARP"]),
            B.rule("ARP.RESOLVE_HIT", "REACHABLE", "REACHABLE", "arp.resolve_tx",
                   B.and_(B.eq_(B.b_len(B.ev("src_mac")), 6),
                          B.not_(B.and_(B.eq_(B.b_len(B.ev("ip")), 4), B.eq_(B.ev("ip"), B.bytes_lit([255, 255, 255, 255]))))),
                   [B.act_emit("wire_tx", frame=eth_tx(B.b_slice(B.var("mac"), 0, 6), B.b_slice(B.ev("src_mac"), 0, 6), B.ev("pkt")))],
                   ["L2.ARP"]),
            B.rule("ARP.LEARN_FREE", "FREE", "REACHABLE", "arp.learn",
                   B.and_(B.eq_(B.b_len(B.ev("ip")), 4), B.eq_(B.b_len(B.ev("mac")), 6)),
                   [B.act_set("ip", B.b_slice(B.ev("ip"), 0, 4)),
                    B.act_set("mac", B.b_slice(B.ev("mac"), 0, 6)),
                    B.act_set("retries", 0),
                    B.act_arm("ttl_timer", 60000)],
                   ["L2.ARP"]),
            B.rule("ARP.LEARN_PEND_FLUSH", "PENDING", "REACHABLE", "arp.learn",
                   B.and_(B.eq_(B.b_len(B.ev("ip")), 4), B.eq_(B.b_len(B.ev("mac")), 6),
                          B.gt_(B.b_len(B.var("pending_pkt")), 0)),
                   [B.act_set("mac", B.b_slice(B.ev("mac"), 0, 6)),
                    B.act_cancel("retry_timer"),
                    B.act_arm("ttl_timer", 60000),
                    B.act_emit("wire_tx",
                               frame=eth_tx(B.b_slice(B.var("mac"), 0, 6), B.b_slice(B.var("src_mac"), 0, 6), B.var("pending_pkt"))),
                    B.act_set("pending_pkt", B.bytes_lit([])),
                    B.act_set("retries", 0)],
                   ["L2.ARP"]),
            B.rule("ARP.LEARN_PEND_EMPTY", "PENDING", "REACHABLE", "arp.learn",
                   B.and_(B.eq_(B.b_len(B.ev("ip")), 4), B.eq_(B.b_len(B.ev("mac")), 6),
                          B.eq_(B.b_len(B.var("pending_pkt")), 0)),
                   [B.act_set("mac", B.b_slice(B.ev("mac"), 0, 6)),
                    B.act_cancel("retry_timer"),
                    B.act_arm("ttl_timer", 60000),
                    B.act_set("retries", 0)],
                   ["L2.ARP"]),
            B.rule("ARP.LEARN_REFRESH", "REACHABLE", "REACHABLE", "arp.learn",
                   B.eq_(B.b_len(B.ev("mac")), 6),
                   [B.act_set("mac", B.b_slice(B.ev("mac"), 0, 6)),
                    B.act_arm("ttl_timer", 60000)],
                   ["L2.ARP"]),
            B.rule("ARP.RETRY", "PENDING", "PENDING", "arp.retry_tmr", B.lt_(B.var("retries"), 4),
                   [B.act_set("retries", B.add_(B.var("retries"), 1)),
                    B.act_arm("retry_timer", 250),
                    B.act_emit("wire_tx", frame=arp_req(B.b_slice(B.var("src_mac"), 0, 6), B.b_slice(B.var("src_ip"), 0, 4), B.b_slice(B.var("ip"), 0, 4)))],
                   ["L2.ARP"]),
            B.rule("ARP.RETRY_FAIL", "PENDING", "FREE", "arp.retry_tmr", B.ge_(B.var("retries"), 4),
                   [B.act_set("ip", B.bytes_lit([])), B.act_set("pending_pkt", B.bytes_lit([])), B.act_set("retries", 0)],
                   ["L2.ARP"]),
            B.rule("ARP.RETRY_NOOP_FREE", "FREE", "FREE", "arp.retry_tmr", True, [], ["L2.ARP"]),
            B.rule("ARP.RETRY_NOOP_REACH", "REACHABLE", "REACHABLE", "arp.retry_tmr", True, [], ["L2.ARP"]),
            B.rule("ARP.TTL_EXP", "REACHABLE", "FREE", "arp.ttl_tmr", True,
                   [B.act_set("ip", B.bytes_lit([])), B.act_set("mac", B.bytes_lit([]))],
                   ["L2.ARP"]),
            B.rule("ARP.TTL_NOOP_FREE", "FREE", "FREE", "arp.ttl_tmr", True, [], ["L2.ARP"]),
            B.rule("ARP.TTL_NOOP_PEND", "PENDING", "PENDING", "arp.ttl_tmr", True, [], ["L2.ARP"]),
            B.rule("ARP.CLR_PEND", "PENDING", "FREE", "arp.clear", True,
                   [B.act_cancel("retry_timer"), B.act_set("ip", B.bytes_lit([])), B.act_set("pending_pkt", B.bytes_lit([])), B.act_set("retries", 0)],
                   ["L2.ARP"]),
            B.rule("ARP.CLR_REACH", "REACHABLE", "FREE", "arp.clear", True,
                   [B.act_cancel("ttl_timer"), B.act_set("ip", B.bytes_lit([])), B.act_set("mac", B.bytes_lit([]))],
                   ["L2.ARP"]),
        ],
        "invariants": [
            B.inv("ARP.LEN_IP", B.le_(B.b_len(B.var("ip")), 4), ["L2.ARP"]),
            B.inv("ARP.LEN_MAC", B.le_(B.b_len(B.var("mac")), 6), ["L2.ARP"]),
            B.inv("ARP.LEN_PKT", B.le_(B.b_len(B.var("pending_pkt")), 1500), ["L2.ARP"]),
            B.inv("ARP.RETRIES", B.and_(B.ge_(B.var("retries"), 0), B.le_(B.var("retries"), 4)), ["L2.ARP"]),
        ],
    }


def build_ipv4_reass(B):
    reqs = {"L3.REASS": {"source": "spec/stack/l3-ipv4-icmp.md", "interpretation": "RFC 791/815 fragment reassembly"}}
    ev_fields = {
        "src_ip": "bytes", "dst_ip": "bytes", "ip_id": "int", "proto": "int",
        "frag_off": "int", "mf": "bool", "hdr": "bytes", "payload": "bytes",
    }
    reset_acts = [
        B.act_cancel("reass_timer"),
        B.act_set("src_ip", B.bytes_lit([])),
        B.act_set("dst_ip", B.bytes_lit([])),
        B.act_set("ip_id", 0),
        B.act_set("proto", 0),
        B.act_set("f0_len", 0),
        B.act_set("f1_off", 0),
        B.act_set("f1_len", 0),
        B.act_set("f2_off", 0),
        B.act_set("f2_len", 0),
        B.act_set("has_last", False),
        B.act_set("total_len", 0),
        B.act_set("hdr", B.bytes_lit([])),
        B.act_set("f0", B.bytes_lit([])),
        B.act_set("f1", B.bytes_lit([])),
        B.act_set("f2", B.bytes_lit([])),
    ]

    # Completion predicate for 2 or 3 fragments (handles any permutation!)
    new_f0 = B.ite_(B.eq_(B.ev("frag_off"), 0), B.b_slice(B.ev("payload"), 0, 1500), B.var("f0"))
    new_f0_len = B.b_len(new_f0)
    is_slot1 = B.and_(B.gt_(B.ev("frag_off"), 0), B.or_(B.eq_(B.var("f1_len"), 0), B.eq_(B.var("f1_off"), B.ev("frag_off"))))
    new_f1 = B.ite_(is_slot1, B.b_slice(B.ev("payload"), 0, 1500), B.var("f1"))
    new_f1_off = B.ite_(is_slot1, B.ev("frag_off"), B.var("f1_off"))
    new_f1_len = B.b_len(new_f1)
    is_slot2 = B.and_(B.gt_(B.ev("frag_off"), 0), B.not_(is_slot1), B.or_(B.eq_(B.var("f2_len"), 0), B.eq_(B.var("f2_off"), B.ev("frag_off"))))
    new_f2 = B.ite_(is_slot2, B.b_slice(B.ev("payload"), 0, 1500), B.var("f2"))
    new_f2_off = B.ite_(is_slot2, B.ev("frag_off"), B.var("f2_off"))
    new_f2_len = B.b_len(new_f2)

    new_has_last = B.or_(B.var("has_last"), B.not_(B.ev("mf")))
    new_total = B.ite_(B.not_(B.ev("mf")), B.add_(B.ev("frag_off"), B.b_len(B.ev("payload"))), B.var("total_len"))
    new_hdr = B.ite_(B.eq_(B.ev("frag_off"), 0), B.b_slice(B.ev("hdr"), 0, 60), B.var("hdr"))

    done2 = B.and_(
        new_has_last, B.gt_(new_f0_len, 0), B.gt_(new_f1_len, 0), B.eq_(new_f2_len, 0),
        B.eq_(new_f0_len, new_f1_off), B.eq_(B.add_(new_f1_off, new_f1_len), new_total),
    )
    done3_12 = B.and_(
        new_has_last, B.gt_(new_f0_len, 0), B.gt_(new_f1_len, 0), B.gt_(new_f2_len, 0),
        B.eq_(new_f0_len, new_f1_off),
        B.eq_(B.add_(new_f1_off, new_f1_len), new_f2_off),
        B.eq_(B.add_(new_f2_off, new_f2_len), new_total),
    )
    done3_21 = B.and_(
        new_has_last, B.gt_(new_f0_len, 0), B.gt_(new_f1_len, 0), B.gt_(new_f2_len, 0),
        B.eq_(new_f0_len, new_f2_off),
        B.eq_(B.add_(new_f2_off, new_f2_len), new_f1_off),
        B.eq_(B.add_(new_f1_off, new_f1_len), new_total),
    )
    done_any = B.or_(done2, done3_12, done3_21)

    assembled = B.ite_(
        done3_12, B.b_concat(new_f0, new_f1, new_f2),
        B.ite_(done3_21, B.b_concat(new_f0, new_f2, new_f1), B.b_concat(new_f0, new_f1)),
    )

    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "ipv4-reass",
        "scope": {"terminal_states": [], "excluded": ["overlapping fragments"]},
        "states": ["IDLE", "COLLECTING"],
        "initial_state": "IDLE",
        "requirements": reqs,
        "variables": {
            "src_ip": {"type": "bytes", "initial": []},
            "dst_ip": {"type": "bytes", "initial": []},
            "ip_id": {"type": "int", "initial": 0},
            "proto": {"type": "int", "initial": 0},
            "f0_len": {"type": "int", "initial": 0},
            "f1_off": {"type": "int", "initial": 0},
            "f1_len": {"type": "int", "initial": 0},
            "f2_off": {"type": "int", "initial": 0},
            "f2_len": {"type": "int", "initial": 0},
            "has_last": {"type": "bool", "initial": False},
            "total_len": {"type": "int", "initial": 0},
            "hdr": {"type": "bytes", "initial": []},
            "f0": {"type": "bytes", "initial": []},
            "f1": {"type": "bytes", "initial": []},
            "f2": {"type": "bytes", "initial": []},
        },
        "events": {
            "reass.frag": {"origin": "network", "fields": ev_fields},
            "reass.tmr": {"origin": "timer", "fields": {}},
        },
        "messages": {
            "reassembled": {"fields": {"src_ip": "bytes", "dst_ip": "bytes", "proto": "int", "payload": "bytes", "orig_hdr": "bytes"}},
        },
        "timers": {"reass_timer": {"event": "reass.tmr"}},
        "transitions": [
            B.rule("REASS.START", "IDLE", "COLLECTING", "reass.frag",
                   B.and_(B.eq_(B.b_len(B.ev("src_ip")), 4), B.eq_(B.b_len(B.ev("dst_ip")), 4),
                          B.ge_(B.b_len(B.ev("payload")), 1), B.le_(B.b_len(B.ev("payload")), 1500)),
                   [B.act_set("src_ip", B.b_slice(B.ev("src_ip"), 0, 4)),
                    B.act_set("dst_ip", B.b_slice(B.ev("dst_ip"), 0, 4)),
                    B.act_set("ip_id", B.ev("ip_id")),
                    B.act_set("proto", B.ev("proto")),
                    B.act_set("hdr", B.ite_(B.eq_(B.ev("frag_off"), 0), B.b_slice(B.ev("hdr"), 0, 60), B.bytes_lit([]))),
                    B.act_set("f0", B.ite_(B.eq_(B.ev("frag_off"), 0), B.b_slice(B.ev("payload"), 0, 1500), B.bytes_lit([]))),
                    B.act_set("f0_len", B.b_len(B.var("f0"))),
                    B.act_set("f1", B.ite_(B.gt_(B.ev("frag_off"), 0), B.b_slice(B.ev("payload"), 0, 1500), B.bytes_lit([]))),
                    B.act_set("f1_off", B.ite_(B.gt_(B.ev("frag_off"), 0), B.ev("frag_off"), 0)),
                    B.act_set("f1_len", B.b_len(B.var("f1"))),
                    B.act_set("has_last", B.not_(B.ev("mf"))),
                    B.act_set("total_len", B.ite_(B.not_(B.ev("mf")), B.add_(B.ev("frag_off"), B.b_len(B.ev("payload"))), 0)),
                    B.act_arm("reass_timer", 5000)],
                   ["L3.REASS"]),
            B.rule("REASS.COMPLETE", "COLLECTING", "IDLE", "reass.frag",
                   B.and_(B.ge_(B.b_len(B.ev("payload")), 1), B.le_(B.b_len(B.ev("payload")), 1500), done_any),
                   [B.act_emit("reassembled",
                               src_ip=B.var("src_ip"), dst_ip=B.var("dst_ip"),
                               proto=B.var("proto"), payload=B.b_slice(assembled, 0, 4500), orig_hdr=new_hdr),
                    *reset_acts],
                   ["L3.REASS"]),
            B.rule("REASS.STORE", "COLLECTING", "COLLECTING", "reass.frag",
                   B.and_(B.ge_(B.b_len(B.ev("payload")), 1), B.le_(B.b_len(B.ev("payload")), 1500), B.not_(done_any)),
                   [B.act_set("hdr", new_hdr),
                    B.act_set("f2", new_f2),
                    B.act_set("f2_off", new_f2_off),
                    B.act_set("f2_len", B.b_len(B.var("f2"))),
                    B.act_set("f1", new_f1),
                    B.act_set("f1_off", new_f1_off),
                    B.act_set("f1_len", B.b_len(B.var("f1"))),
                    B.act_set("f0", new_f0),
                    B.act_set("f0_len", B.b_len(B.var("f0"))),
                    B.act_set("has_last", new_has_last),
                    B.act_set("total_len", new_total)],
                   ["L3.REASS"]),
            B.rule("REASS.TIMEOUT", "COLLECTING", "IDLE", "reass.tmr", True, reset_acts, ["L3.REASS"]),
            B.rule("REASS.TMO_IDLE", "IDLE", "IDLE", "reass.tmr", True, [], ["L3.REASS"]),
        ],
        "invariants": [
            B.inv("REASS.LEN_IP", B.and_(B.le_(B.b_len(B.var("src_ip")), 4), B.le_(B.b_len(B.var("dst_ip")), 4)), ["L3.REASS"]),
            B.inv("REASS.LEN_F", B.and_(B.le_(B.b_len(B.var("f0")), 1500), B.le_(B.b_len(B.var("f1")), 1500),
                                        B.le_(B.b_len(B.var("f2")), 1500), B.le_(B.b_len(B.var("hdr")), 60)), ["L3.REASS"]),
            B.inv("REASS.OFFS", B.and_(B.ge_(B.var("f0_len"), 0), B.ge_(B.var("f1_off"), 0), B.ge_(B.var("f2_off"), 0)), ["L3.REASS"]),
        ],
    }


def build_eth_ipv4_icmp(B):
    reqs = {
        "L2.ETH": {"source": "spec/stack/l2-arp-netif.md", "interpretation": "Ethernet/ARP RX & netif dispatch"},
        "L3.IP4": {"source": "spec/stack/l3-ipv4-icmp.md", "interpretation": "RFC 791/792 IPv4/ICMP/Frag"},
    }
    f = B.ev("frame")
    flen = B.b_len(f)
    ethtype = B.u16be(f, 12)

    # ARP RX decoding (offset 14..42)
    arp_op = B.u16be(f, 20)
    arp_sha = B.b_slice(f, 22, 6)
    arp_spa = B.b_slice(f, 28, 4)
    arp_tpa = B.b_slice(f, 38, 4)
    is_arp = B.and_(
        B.ge_(flen, 42), B.eq_(ethtype, 0x0806),
        B.eq_(B.u16be(f, 14), 1), B.eq_(B.u16be(f, 16), 0x0800),
        B.eq_(B.u8(f, 18), 6), B.eq_(B.u8(f, 19), 4),
    )

    # IPv4 RX decoding directly from frame f (IPv4 starts at byte 14)
    ip_ihl = _u8_low_nibble(B, B.u8(f, 14))
    ip_hlen = B.mul_(ip_ihl, 4)
    ip_tot = B.u16be(f, 16)
    ip_proto = B.u8(f, 23)
    ip_src = B.b_slice(f, 26, 4)
    ip_dst = B.b_slice(f, 30, 4)
    bcast_ip = B.bytes_lit([255, 255, 255, 255])
    zero_ip = B.bytes_lit([0, 0, 0, 0])
    bcast_mac = B.bytes_lit([255, 255, 255, 255, 255, 255])

    ip_f6 = B.u8(f, 20)
    ip_fo_hi = B.sub_(ip_f6, B.mul_(32, B.b_at(B.pack16be(B.mul_(ip_f6, 8)), 0)))
    ip_mf = _u8_has_bit(B, ip_f6, 32)
    ip_frag_off = B.mul_(B.add_(B.mul_(ip_fo_hi, 256), B.u8(f, 21)), 8)
    is_frag = B.or_(ip_mf, B.gt_(ip_frag_off, 0))

    ip_valid_common = B.and_(
        B.ge_(flen, 34),
        B.eq_(ethtype, 0x0800),
        B.eq_(B.u8_hi_nibble(B.u8(f, 14)), 4),
        B.ge_(ip_hlen, 20), B.le_(ip_hlen, 60),
        B.ge_(ip_tot, ip_hlen), B.le_(ip_tot, B.sub_(flen, 14)),
        B.eq_(B.csum16(B.b_slice(f, 14, ip_hlen)), 0),
        B.or_(B.eq_(ip_dst, B.var("local_ip")), B.eq_(ip_dst, bcast_ip), B.eq_(B.var("local_ip"), zero_ip)),
    )
    ip_pay = B.b_slice(f, B.add_(14, ip_hlen), B.sub_(ip_tot, ip_hlen))
    ip_prefix = B.b_slice(f, 14, B.min_(ip_tot, B.add_(ip_hlen, 8)))

    def next_hop(dst):
        return B.ite_(
            B.or_(B.eq_(dst, bcast_ip), B.eq_(B.var("gateway"), zero_ip), _same_subnet(B, dst, B.var("local_ip"), B.var("netmask"))),
            dst,
            B.b_slice(B.var("gateway"), 0, 4),
        )

    def emit_ip_or_bcast(src_expr, dst_expr, pkt_expr):
        return [
            B.act_emit("arp_send", ip=next_hop(dst_expr), src_mac=B.b_slice(B.var("local_mac"), 0, 6),
                       src_ip=src_expr, pkt=pkt_expr),
        ]

    # UDP checks & emit helper
    udp_ulen = lambda p: B.u16be(p, 4)
    udp_chk_raw = lambda p: B.u16be(p, 6)
    udp_valid = lambda sip, dip, p: B.and_(
        B.ge_(B.b_len(p), 8), B.ge_(udp_ulen(p), 8), B.le_(udp_ulen(p), B.b_len(p)),
        B.or_(B.eq_(udp_chk_raw(p), 0), B.eq_(_csum_pseudo(B, sip, dip, 17, B.b_slice(p, 0, udp_ulen(p))), 0)),
    )

    # TCP checks & emit helper
    tcp_doff = lambda p: B.mul_(B.u8_hi_nibble(B.u8(p, 12)), 4)
    tcp_valid = lambda sip, dip, p: B.and_(
        B.ge_(B.b_len(p), 20),
        B.ge_(tcp_doff(p), 20), B.le_(tcp_doff(p), B.b_len(p)),
        B.eq_(_csum_pseudo(B, sip, dip, 6, p), 0),
    )

    def emit_tcp_rx_msg(sip, dip, p):
        fl = B.u8(p, 13)
        df = tcp_doff(p)
        mss = B.ite_(
            B.and_(B.ge_(df, 24), B.eq_(B.u8(p, 20), 2), B.eq_(B.u8(p, 21), 4)),
            B.u16be(p, 22), 0,
        )
        return B.act_emit(
            "tcp_rx",
            src_ip=sip, dst_ip=dip,
            src_port=B.u16be(p, 0), dst_port=B.u16be(p, 2),
            seq=B.u32be_seq(p, 4), ack=B.u32be_seq(p, 8),
            is_fin=_u8_has_bit(B, fl, 1), is_syn=_u8_has_bit(B, fl, 2),
            is_rst=_u8_has_bit(B, fl, 4), is_ack=_u8_has_bit(B, fl, 16),
            wnd=B.u16be(p, 14), mss=mss,
            data=B.b_slice(p, df, B.sub_(B.b_len(p), df)),
        )

    # TX IPv4 + up to 3-fragment MTU split
    tx_src = B.ite_(B.and_(B.eq_(B.b_len(B.ev("src_ip")), 4), B.ne_(B.ev("src_ip"), zero_ip)),
                   B.b_slice(B.ev("src_ip"), 0, 4), B.b_slice(B.var("local_ip"), 0, 4))
    tx_dst = B.b_slice(B.ev("dst_ip"), 0, 4)
    tx_pay = B.ev("payload")
    tx_plen = B.b_len(tx_pay)
    u1_units = _u16_div8(B, B.sub_(B.var("mtu"), 20))
    tx_max_pay = B.mul_(8, u1_units)
    tx_fit = B.le_(B.add_(20, tx_plen), B.var("mtu"))
    tx_pkt_single = _ipv4_build_pkt(B, tx_src, tx_dst, B.var("ip_id"), 0, B.ev("proto"), tx_pay)

    # 2 or 3 fragments
    frag1_pkt = _ipv4_build_pkt(B, tx_src, tx_dst, B.var("ip_id"), 0x2000, B.ev("proto"),
                                B.b_slice(tx_pay, 0, tx_max_pay))
    rem_after_1 = B.sub_(tx_plen, tx_max_pay)
    need_frag3 = B.gt_(rem_after_1, tx_max_pay)
    frag2_flags = B.ite_(need_frag3, B.add_(0x2000, u1_units), u1_units)
    frag2_len = B.min_(tx_max_pay, rem_after_1)
    frag2_pkt = _ipv4_build_pkt(B, tx_src, tx_dst, B.var("ip_id"), frag2_flags, B.ev("proto"),
                                B.b_slice(tx_pay, tx_max_pay, frag2_len))
    off2_bytes = B.mul_(tx_max_pay, 2)
    u2_units = B.mul_(2, u1_units)
    frag3_pkt = _ipv4_build_pkt(B, tx_src, tx_dst, B.var("ip_id"), u2_units, B.ev("proto"),
                                B.b_slice(tx_pay, off2_bytes, B.sub_(tx_plen, off2_bytes)))

    # ICMP Echo reply on RX
    icmp_rx_reply = _ipv4_build_pkt(B, B.b_slice(ip_dst, 0, 4), ip_src, B.var("ip_id"), 0, 1, _icmp_echo_reply(B, ip_pay))
    reass_icmp_reply = _ipv4_build_pkt(B, B.b_slice(B.ev("dst_ip"), 0, 4), B.b_slice(B.ev("src_ip"), 0, 4), B.var("ip_id"), 0, 1,
                                       _icmp_echo_reply(B, B.ev("payload")))

    # Unreachable & RST builders
    unreach_pkt = _ipv4_build_pkt(B, B.b_slice(B.ev("dst_ip"), 0, 4), B.b_slice(B.ev("src_ip"), 0, 4), B.var("ip_id"), 0, 1,
                                  _icmp_port_unreach(B, B.ev("orig_prefix")))
    rst_seq = B.ite_(B.ev("is_ack"), B.ev("ack"), B.seq_lit(0))
    rst_ack = B.ite_(B.ev("is_ack"), B.seq_lit(0), B.seq_add_(B.ev("seq"), B.max_(1, B.ev("seg_len"))))
    rst_flags = B.ite_(B.ev("is_ack"), 4, 20)
    rst_seg = _tcp_build_seg(B, B.b_slice(B.ev("dst_ip"), 0, 4), B.b_slice(B.ev("src_ip"), 0, 4),
                             B.ev("dst_port"), B.ev("src_port"), rst_seq, rst_ack, rst_flags, 0, None, B.bytes_lit([]))
    rst_pkt = _ipv4_build_pkt(B, B.b_slice(B.ev("dst_ip"), 0, 4), B.b_slice(B.ev("src_ip"), 0, 4), B.var("ip_id"), 0, 6, rst_seg)

    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "eth-ipv4-icmp",
        "scope": {"terminal_states": [], "excluded": ["IPv6", "multicast IGMP"]},
        "states": ["READY"],
        "initial_state": "READY",
        "requirements": reqs,
        "variables": {
            "local_ip": {"type": "bytes", "initial": [0, 0, 0, 0]},
            "netmask": {"type": "bytes", "initial": [255, 255, 255, 0]},
            "gateway": {"type": "bytes", "initial": [0, 0, 0, 0]},
            "local_mac": {"type": "bytes", "initial": [2, 0, 0, 0, 0, 1]},
            "dns_ip": {"type": "bytes", "initial": [0, 0, 0, 0]},
            "mtu": {"type": "int", "initial": 1500},
            "ip_id": {"type": "int", "initial": 1},
            "rx_frames": {"type": "int", "initial": 0},
        },
        "events": {
            "cfg.init_if": {"origin": "application", "fields": {"ip": "bytes", "mask": "bytes", "gw": "bytes", "mac": "bytes", "mtu": "int"}},
            "cfg.set_ip": {"origin": "application", "fields": {"ip": "bytes", "mask": "bytes", "gw": "bytes", "dns_ip": "bytes"}},
            "net.rx_frame": {"origin": "network", "fields": {"frame": "bytes"}},
            "l3.reassembled": {"origin": "network", "fields": {"src_ip": "bytes", "dst_ip": "bytes", "proto": "int", "payload": "bytes", "orig_hdr": "bytes"}},
            "l3.tx_ip": {"origin": "application", "fields": {"src_ip": "bytes", "dst_ip": "bytes", "proto": "int", "payload": "bytes"}},
            "l3.send_icmp_unreach": {"origin": "application", "fields": {"src_ip": "bytes", "dst_ip": "bytes", "orig_prefix": "bytes"}},
            "l3.send_tcp_rst": {"origin": "application", "fields": {
                "src_ip": "bytes", "dst_ip": "bytes", "src_port": "int", "dst_port": "int",
                "seq": "seq32", "ack": "seq32", "is_ack": "bool", "seg_len": "int",
            }},
        },
        "messages": {
            "wire_tx": {"fields": {"frame": "bytes"}},
            "arp_learn": {"fields": {"ip": "bytes", "mac": "bytes"}},
            "arp_send": {"fields": {"ip": "bytes", "src_mac": "bytes", "src_ip": "bytes", "pkt": "bytes"}},
            "frag_in": {"fields": {"src_ip": "bytes", "dst_ip": "bytes", "ip_id": "int", "proto": "int", "frag_off": "int", "mf": "bool", "hdr": "bytes", "payload": "bytes"}},
            "udp_rx": {"fields": {"src_ip": "bytes", "dst_ip": "bytes", "src_port": "int", "dst_port": "int", "data": "bytes", "orig_prefix": "bytes"}},
            "tcp_rx": {"fields": {
                "src_ip": "bytes", "dst_ip": "bytes", "src_port": "int", "dst_port": "int",
                "seq": "seq32", "ack": "seq32",
                "is_fin": "bool", "is_syn": "bool", "is_rst": "bool", "is_ack": "bool",
                "wnd": "int", "mss": "int", "data": "bytes",
            }},
        },
        "timers": {},
        "transitions": [
            B.rule("ETH.INIT_IF", "READY", "READY", "cfg.init_if",
                   B.and_(B.eq_(B.b_len(B.ev("ip")), 4), B.eq_(B.b_len(B.ev("mask")), 4),
                          B.eq_(B.b_len(B.ev("gw")), 4), B.eq_(B.b_len(B.ev("mac")), 6),
                          B.ge_(B.ev("mtu"), 256), B.le_(B.ev("mtu"), 1500)),
                   [B.act_set("local_ip", B.b_slice(B.ev("ip"), 0, 4)),
                    B.act_set("netmask", B.b_slice(B.ev("mask"), 0, 4)),
                    B.act_set("gateway", B.b_slice(B.ev("gw"), 0, 4)),
                    B.act_set("local_mac", B.b_slice(B.ev("mac"), 0, 6)),
                    B.act_set("mtu", B.ev("mtu"))],
                   ["L2.ETH"]),
            B.rule("ETH.SET_IP", "READY", "READY", "cfg.set_ip",
                   B.and_(B.eq_(B.b_len(B.ev("ip")), 4), B.eq_(B.b_len(B.ev("mask")), 4),
                          B.eq_(B.b_len(B.ev("gw")), 4), B.eq_(B.b_len(B.ev("dns_ip")), 4)),
                   [B.act_set("local_ip", B.b_slice(B.ev("ip"), 0, 4)),
                    B.act_set("netmask", B.b_slice(B.ev("mask"), 0, 4)),
                    B.act_set("gateway", B.b_slice(B.ev("gw"), 0, 4)),
                    B.act_set("dns_ip", B.b_slice(B.ev("dns_ip"), 0, 4))],
                   ["L2.ETH"]),
            B.rule("ETH.RX_ARP_REQ_ME", "READY", "READY", "net.rx_frame",
                   B.and_(is_arp, B.eq_(arp_op, 1), B.ne_(B.var("local_ip"), zero_ip), B.eq_(arp_tpa, B.var("local_ip"))),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1)),
                    B.act_emit("arp_learn", ip=arp_spa, mac=arp_sha),
                    B.act_emit("wire_tx", frame=_arp_frame(B, 2, B.var("local_mac"), B.var("local_ip"), arp_sha, arp_spa, arp_sha))],
                   ["L2.ETH"]),
            B.rule("ETH.RX_ARP_REQ_OTHER", "READY", "READY", "net.rx_frame",
                   B.and_(is_arp, B.eq_(arp_op, 1), B.not_(B.and_(B.ne_(B.var("local_ip"), zero_ip), B.eq_(arp_tpa, B.var("local_ip"))))),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1)),
                    B.act_emit("arp_learn", ip=arp_spa, mac=arp_sha)],
                   ["L2.ETH"]),
            B.rule("ETH.RX_ARP_REP", "READY", "READY", "net.rx_frame",
                   B.and_(is_arp, B.eq_(arp_op, 2)),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1)),
                    B.act_emit("arp_learn", ip=arp_spa, mac=arp_sha)],
                   ["L2.ETH"]),
            B.rule("ETH.RX_IP_FRAG", "READY", "READY", "net.rx_frame",
                   B.and_(ip_valid_common, is_frag),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1)),
                    B.act_emit("frag_in", src_ip=ip_src, dst_ip=ip_dst, ip_id=B.u16be(f, 18),
                               proto=ip_proto, frag_off=ip_frag_off, mf=ip_mf,
                               hdr=B.b_slice(f, 14, ip_hlen), payload=ip_pay)],
                   ["L3.IP4"]),
            B.rule("ETH.RX_ICMP_ECHO", "READY", "READY", "net.rx_frame",
                   B.and_(ip_valid_common, B.not_(is_frag), B.eq_(ip_proto, 1),
                          B.ge_(B.b_len(ip_pay), 8), B.eq_(B.u8(ip_pay, 0), 8), B.eq_(B.u8(ip_pay, 1), 0),
                          B.eq_(B.csum16(ip_pay), 0)),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1)),
                    B.act_set("ip_id", B.ite_(B.ge_(B.var("ip_id"), 65535), 1, B.add_(B.var("ip_id"), 1))),
                    *emit_ip_or_bcast(ip_dst, ip_src, icmp_rx_reply)],
                   ["L3.IP4"]),
            B.rule("ETH.RX_UDP", "READY", "READY", "net.rx_frame",
                   B.and_(ip_valid_common, B.not_(is_frag), B.eq_(ip_proto, 17), udp_valid(ip_src, ip_dst, ip_pay)),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1)),
                    B.act_emit("udp_rx", src_ip=ip_src, dst_ip=ip_dst,
                               src_port=B.u16be(ip_pay, 0), dst_port=B.u16be(ip_pay, 2),
                               data=B.b_slice(ip_pay, 8, B.sub_(udp_ulen(ip_pay), 8)),
                               orig_prefix=ip_prefix)],
                   ["L3.IP4"]),
            B.rule("ETH.RX_TCP", "READY", "READY", "net.rx_frame",
                   B.and_(ip_valid_common, B.not_(is_frag), B.eq_(ip_proto, 6), tcp_valid(ip_src, ip_dst, ip_pay)),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1)),
                    emit_tcp_rx_msg(ip_src, ip_dst, ip_pay)],
                   ["L3.IP4"]),
            B.rule("ETH.RX_DROP_NONIP_ARP", "READY", "READY", "net.rx_frame",
                   B.and_(B.not_(B.and_(is_arp, B.or_(B.eq_(arp_op, 1), B.eq_(arp_op, 2)))),
                          B.not_(ip_valid_common)),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1))],
                   ["L2.ETH"]),
            B.rule("ETH.RX_DROP_BAD_ICMP", "READY", "READY", "net.rx_frame",
                   B.and_(ip_valid_common, B.not_(is_frag), B.eq_(ip_proto, 1),
                          B.not_(B.and_(B.ge_(B.b_len(ip_pay), 8), B.eq_(B.u8(ip_pay, 0), 8),
                                        B.eq_(B.u8(ip_pay, 1), 0), B.eq_(B.csum16(ip_pay), 0)))),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1))],
                   ["L3.IP4"]),
            B.rule("ETH.RX_DROP_BAD_UDP", "READY", "READY", "net.rx_frame",
                   B.and_(ip_valid_common, B.not_(is_frag), B.eq_(ip_proto, 17), B.not_(udp_valid(ip_src, ip_dst, ip_pay))),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1))],
                   ["L3.IP4"]),
            B.rule("ETH.RX_DROP_BAD_TCP", "READY", "READY", "net.rx_frame",
                   B.and_(ip_valid_common, B.not_(is_frag), B.eq_(ip_proto, 6), B.not_(tcp_valid(ip_src, ip_dst, ip_pay))),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1))],
                   ["L3.IP4"]),
            B.rule("ETH.RX_DROP_OTHER_PROTO", "READY", "READY", "net.rx_frame",
                   B.and_(ip_valid_common, B.not_(is_frag),
                          B.ne_(ip_proto, 1), B.ne_(ip_proto, 17), B.ne_(ip_proto, 6)),
                   [B.act_set("rx_frames", B.add_(B.var("rx_frames"), 1))],
                   ["L3.IP4"]),
            B.rule("ETH.REASS_ICMP", "READY", "READY", "l3.reassembled",
                   B.and_(B.eq_(B.ev("proto"), 1), B.ge_(B.b_len(B.ev("payload")), 8),
                          B.eq_(B.u8(B.ev("payload"), 0), 8), B.eq_(B.u8(B.ev("payload"), 1), 0),
                          B.eq_(B.csum16(B.ev("payload")), 0)),
                   [B.act_set("ip_id", B.ite_(B.ge_(B.var("ip_id"), 65535), 1, B.add_(B.var("ip_id"), 1))),
                    *emit_ip_or_bcast(B.ev("dst_ip"), B.ev("src_ip"), reass_icmp_reply)],
                   ["L3.IP4"]),
            B.rule("ETH.REASS_UDP", "READY", "READY", "l3.reassembled",
                   B.and_(B.eq_(B.ev("proto"), 17), udp_valid(B.ev("src_ip"), B.ev("dst_ip"), B.ev("payload"))),
                   [B.act_emit("udp_rx", src_ip=B.ev("src_ip"), dst_ip=B.ev("dst_ip"),
                               src_port=B.u16be(B.ev("payload"), 0), dst_port=B.u16be(B.ev("payload"), 2),
                               data=B.b_slice(B.ev("payload"), 8, B.sub_(udp_ulen(B.ev("payload")), 8)),
                               orig_prefix=B.b_concat(B.ev("orig_hdr"), B.b_slice(B.ev("payload"), 0, 8)))],
                   ["L3.IP4"]),
            B.rule("ETH.REASS_TCP", "READY", "READY", "l3.reassembled",
                   B.and_(B.eq_(B.ev("proto"), 6), tcp_valid(B.ev("src_ip"), B.ev("dst_ip"), B.ev("payload"))),
                   [emit_tcp_rx_msg(B.ev("src_ip"), B.ev("dst_ip"), B.ev("payload"))],
                   ["L3.IP4"]),
            B.rule("ETH.TX_SINGLE", "READY", "READY", "l3.tx_ip",
                   B.and_(B.eq_(B.b_len(B.ev("dst_ip")), 4), tx_fit),
                   [B.act_set("ip_id", B.ite_(B.ge_(B.var("ip_id"), 65535), 1, B.add_(B.var("ip_id"), 1))),
                    *emit_ip_or_bcast(tx_src, tx_dst, tx_pkt_single)],
                   ["L3.IP4"]),
            B.rule("ETH.TX_FRAG2", "READY", "READY", "l3.tx_ip",
                   B.and_(B.eq_(B.b_len(B.ev("dst_ip")), 4), B.not_(tx_fit), B.not_(need_frag3)),
                   [B.act_set("ip_id", B.ite_(B.ge_(B.var("ip_id"), 65535), 1, B.add_(B.var("ip_id"), 1))),
                    *emit_ip_or_bcast(tx_src, tx_dst, frag1_pkt),
                    *emit_ip_or_bcast(tx_src, tx_dst, frag2_pkt)],
                   ["L3.IP4"]),
            B.rule("ETH.TX_FRAG3", "READY", "READY", "l3.tx_ip",
                   B.and_(B.eq_(B.b_len(B.ev("dst_ip")), 4), B.not_(tx_fit), need_frag3),
                   [B.act_set("ip_id", B.ite_(B.ge_(B.var("ip_id"), 65535), 1, B.add_(B.var("ip_id"), 1))),
                    *emit_ip_or_bcast(tx_src, tx_dst, frag1_pkt),
                    *emit_ip_or_bcast(tx_src, tx_dst, frag2_pkt),
                    *emit_ip_or_bcast(tx_src, tx_dst, frag3_pkt)],
                   ["L3.IP4"]),
            B.rule("ETH.TX_ICMP_UNREACH", "READY", "READY", "l3.send_icmp_unreach", True,
                   [B.act_set("ip_id", B.ite_(B.ge_(B.var("ip_id"), 65535), 1, B.add_(B.var("ip_id"), 1))),
                    *emit_ip_or_bcast(B.b_slice(B.ev("dst_ip"), 0, 4), B.b_slice(B.ev("src_ip"), 0, 4), unreach_pkt)],
                   ["L3.IP4"]),
            B.rule("ETH.TX_TCP_RST", "READY", "READY", "l3.send_tcp_rst", True,
                   [B.act_set("ip_id", B.ite_(B.ge_(B.var("ip_id"), 65535), 1, B.add_(B.var("ip_id"), 1))),
                    *emit_ip_or_bcast(B.b_slice(B.ev("dst_ip"), 0, 4), B.b_slice(B.ev("src_ip"), 0, 4), rst_pkt)],
                   ["L3.IP4"]),
        ],
        "invariants": [
            B.inv("ETH.LEN_IP", B.and_(B.eq_(B.b_len(B.var("local_ip")), 4), B.eq_(B.b_len(B.var("netmask")), 4),
                                       B.eq_(B.b_len(B.var("gateway")), 4), B.eq_(B.b_len(B.var("local_mac")), 6),
                                       B.eq_(B.b_len(B.var("dns_ip")), 4)), ["L2.ETH"]),
            B.inv("ETH.MTU", B.and_(B.ge_(B.var("mtu"), 256), B.le_(B.var("mtu"), 1500)), ["L3.IP4"]),
            B.inv("ETH.IPID", B.and_(B.ge_(B.var("ip_id"), 1), B.le_(B.var("ip_id"), 65535)), ["L3.IP4"]),
            B.inv("ETH.RXCNT", B.ge_(B.var("rx_frames"), 0), ["L2.ETH"]),
        ],
    }


def build_udp_endpoint(B):
    reqs = {"L4.UDP": {"source": "spec/stack/l4-udp-tcp.md", "interpretation": "RFC 768 multi-endpoint UDP"}}
    use_src_bind = lambda s: B.ite_(B.eq_(B.b_len(s), 4), B.b_slice(s, 0, 4), B.b_slice(B.var("local_ip"), 0, 4))
    tx_to = lambda sip, dip, dp: _udp_build_pkt(B, sip, dip, B.var("local_port"), dp, B.ev("data"))
    close_acts = [
        B.act_set("local_ip", B.bytes_lit([])),
        B.act_set("remote_ip", B.bytes_lit([])),
        B.act_set("local_port", 0),
        B.act_set("remote_port", 0),
    ]
    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "udp-endpoint",
        "scope": {"terminal_states": [], "excluded": ["multicast join"]},
        "states": ["UNBOUND", "BOUND", "CONNECTED"],
        "initial_state": "UNBOUND",
        "requirements": reqs,
        "variables": {
            "local_ip": {"type": "bytes", "initial": []},
            "remote_ip": {"type": "bytes", "initial": []},
            "local_port": {"type": "int", "initial": 0},
            "remote_port": {"type": "int", "initial": 0},
        },
        "events": {
            "app.bind": {"origin": "application", "fields": {"local_ip": "bytes", "local_port": "int"}},
            "app.connect": {"origin": "application", "fields": {"remote_ip": "bytes", "remote_port": "int"}},
            "app.sendto": {"origin": "application", "fields": {"src_ip": "bytes", "dst_ip": "bytes", "dst_port": "int", "data": "bytes"}},
            "app.send": {"origin": "application", "fields": {"src_ip": "bytes", "data": "bytes"}},
            "app.close": {"origin": "application", "fields": {}},
            "udp.rx": {"origin": "network", "fields": {"src_ip": "bytes", "dst_ip": "bytes", "src_port": "int", "dst_port": "int", "data": "bytes"}},
        },
        "messages": {
            "tx_ip": {"fields": {"src_ip": "bytes", "dst_ip": "bytes", "proto": "int", "payload": "bytes"}},
            "app_rx": {"fields": {"src_ip": "bytes", "src_port": "int", "dst_port": "int", "data": "bytes"}},
        },
        "timers": {},
        "transitions": [
            B.rule("UDP.BIND", "UNBOUND", "BOUND", "app.bind",
                   B.and_(B.le_(B.b_len(B.ev("local_ip")), 4), B.ge_(B.ev("local_port"), 1), B.le_(B.ev("local_port"), 65535)),
                   [B.act_set("local_ip", B.b_slice(B.ev("local_ip"), 0, 4)), B.act_set("local_port", B.ev("local_port"))], ["L4.UDP"]),
            B.rule("UDP.CONN_UNBOUND", "UNBOUND", "CONNECTED", "app.connect",
                   B.and_(B.eq_(B.b_len(B.ev("remote_ip")), 4), B.ge_(B.ev("remote_port"), 1), B.le_(B.ev("remote_port"), 65535)),
                   [B.act_set("local_port", 49152), B.act_set("remote_ip", B.b_slice(B.ev("remote_ip"), 0, 4)),
                    B.act_set("remote_port", B.ev("remote_port"))], ["L4.UDP"]),
            B.rule("UDP.CONN_BOUND", "BOUND", "CONNECTED", "app.connect",
                   B.and_(B.eq_(B.b_len(B.ev("remote_ip")), 4), B.ge_(B.ev("remote_port"), 1), B.le_(B.ev("remote_port"), 65535)),
                   [B.act_set("remote_ip", B.b_slice(B.ev("remote_ip"), 0, 4)), B.act_set("remote_port", B.ev("remote_port"))], ["L4.UDP"]),
            B.rule("UDP.SENDTO_BOUND", "BOUND", "BOUND", "app.sendto",
                   B.and_(B.eq_(B.b_len(B.ev("dst_ip")), 4), B.eq_(B.b_len(B.ev("src_ip")), 4), B.ge_(B.ev("dst_port"), 1)),
                   [B.act_emit("tx_ip", src_ip=use_src_bind(B.ev("src_ip")), dst_ip=B.b_slice(B.ev("dst_ip"), 0, 4),
                               proto=17, payload=tx_to(use_src_bind(B.ev("src_ip")), B.b_slice(B.ev("dst_ip"), 0, 4), B.ev("dst_port")))],
                   ["L4.UDP"]),
            B.rule("UDP.SENDTO_CONN", "CONNECTED", "CONNECTED", "app.sendto",
                   B.and_(B.eq_(B.b_len(B.ev("dst_ip")), 4), B.eq_(B.b_len(B.ev("src_ip")), 4), B.ge_(B.ev("dst_port"), 1)),
                   [B.act_emit("tx_ip", src_ip=use_src_bind(B.ev("src_ip")), dst_ip=B.b_slice(B.ev("dst_ip"), 0, 4),
                               proto=17, payload=tx_to(use_src_bind(B.ev("src_ip")), B.b_slice(B.ev("dst_ip"), 0, 4), B.ev("dst_port")))],
                   ["L4.UDP"]),
            B.rule("UDP.SEND_CONN", "CONNECTED", "CONNECTED", "app.send",
                   B.eq_(B.b_len(B.ev("src_ip")), 4),
                   [B.act_emit("tx_ip", src_ip=use_src_bind(B.ev("src_ip")), dst_ip=B.var("remote_ip"),
                               proto=17, payload=tx_to(use_src_bind(B.ev("src_ip")), B.var("remote_ip"), B.var("remote_port")))],
                   ["L4.UDP"]),
            B.rule("UDP.RX_BOUND", "BOUND", "BOUND", "udp.rx", True,
                   [B.act_emit("app_rx", src_ip=B.ev("src_ip"), src_port=B.ev("src_port"), dst_port=B.ev("dst_port"), data=B.ev("data"))],
                   ["L4.UDP"]),
            B.rule("UDP.RX_CONN", "CONNECTED", "CONNECTED", "udp.rx", True,
                   [B.act_emit("app_rx", src_ip=B.ev("src_ip"), src_port=B.ev("src_port"), dst_port=B.ev("dst_port"), data=B.ev("data"))],
                   ["L4.UDP"]),
            B.rule("UDP.CLOSE_B", "BOUND", "UNBOUND", "app.close", True, close_acts, ["L4.UDP"]),
            B.rule("UDP.CLOSE_C", "CONNECTED", "UNBOUND", "app.close", True, close_acts, ["L4.UDP"]),
        ],
        "invariants": [
            B.inv("UDP.IPS", B.and_(B.le_(B.b_len(B.var("local_ip")), 4), B.le_(B.b_len(B.var("remote_ip")), 4)), ["L4.UDP"]),
            B.inv("UDP.PORTS", B.and_(B.ge_(B.var("local_port"), 0), B.le_(B.var("local_port"), 65535),
                                      B.ge_(B.var("remote_port"), 0), B.le_(B.var("remote_port"), 65535)), ["L4.UDP"]),
        ],
    }


def build_tcp_connection(B):
    reqs = {"L4.TCP": {"source": "spec/stack/l4-udp-tcp.md", "interpretation": "RFC 9293/6298/5681 11-state TCP"}}
    states = [
        "CLOSED", "LISTEN", "SYN_SENT", "SYN_RCVD", "ESTABLISHED",
        "FIN_WAIT_1", "FIN_WAIT_2", "CLOSE_WAIT", "CLOSING", "LAST_ACK", "TIME_WAIT",
    ]
    seg_fields = {
        "src_ip": "bytes", "dst_ip": "bytes", "src_port": "int", "dst_port": "int",
        "seq": "seq32", "ack": "seq32",
        "is_fin": "bool", "is_syn": "bool", "is_rst": "bool", "is_ack": "bool",
        "wnd": "int", "mss": "int", "data": "bytes",
    }

    def tx_seg(seq_e, ack_e, flags_e, wnd_e, mss_opt, payload):
        seg = _tcp_build_seg(B, B.var("local_ip"), B.var("remote_ip"), B.var("local_port"), B.var("remote_port"),
                             seq_e, ack_e, flags_e, wnd_e, mss_opt, payload)
        return B.act_emit("tx_ip", src_ip=B.var("local_ip"), dst_ip=B.var("remote_ip"), proto=6, payload=seg)

    def tx_seg_if(cond, seq_e, ack_e, flags_e, wnd_e, mss_opt, payload):
        seg = _tcp_build_seg(B, B.var("local_ip"), B.var("remote_ip"), B.var("local_port"), B.var("remote_port"),
                             seq_e, ack_e, flags_e, wnd_e, mss_opt, payload)
        return B.act_emit_if(cond, "tx_ip", src_ip=B.var("local_ip"), dst_ip=B.var("remote_ip"), proto=6, payload=seg)

    rst_reset = [
        B.act_cancel("rtx_timer"), B.act_cancel("delack_timer"),
        B.act_cancel("persist_timer"), B.act_cancel("tw_timer"),
        B.act_set("snd_buf", B.bytes_lit([])), B.act_set("ooo_buf", B.bytes_lit([])),
        B.act_set("ooo_valid", False), B.act_set("ooo_has_fin", False),
        B.act_set("fin_queued", False), B.act_set("retries", 0), B.act_set("dupacks", 0),
        B.act_set("remote_port", 0), B.act_set("local_port", 0),
    ]

    # Helpers for sliding window send chunk from snd_buf starting at snd_nxt
    unsent_off = B.seq_dist_(B.var("snd_una"), B.var("snd_nxt"))
    eff_wnd = lambda sw: B.min_(sw, B.var("cwnd"))
    rem_unsent = B.sub_(B.b_len(B.var("snd_buf")), unsent_off)
    # After sliding snd_buf by acked bytes:
    def post_ack_send_chunk(new_sbuf, new_una, new_nxt, new_sw, new_cwnd):
        u_off = B.seq_dist_(new_una, new_nxt)
        ew = B.min_(new_sw, new_cwnd)
        can_send = B.and_(
            B.gt_(B.b_len(new_sbuf), u_off),
            B.lt_(u_off, ew),
        )
        avail_w = B.sub_(ew, u_off)
        chunk_len = B.min_(B.var("mss"), B.min_(avail_w, B.sub_(B.b_len(new_sbuf), u_off)))
        chunk_bytes = B.b_slice(new_sbuf, u_off, chunk_len)
        return can_send, chunk_len, chunk_bytes

    transitions = [
        # 1. Passive LISTEN + incoming SYN fork + active OPEN
        B.rule("TCP.LISTEN", "CLOSED", "LISTEN", "app.listen",
               B.and_(B.le_(B.b_len(B.ev("local_ip")), 4), B.ge_(B.ev("local_port"), 1), B.le_(B.ev("local_port"), 65535)),
               [B.act_set("local_ip", B.b_slice(B.ev("local_ip"), 0, 4)),
                B.act_set("local_port", B.ev("local_port"))], ["L4.TCP"]),

        B.rule("TCP.CONNECT", "CLOSED", "SYN_SENT", "app.connect",
               B.and_(B.eq_(B.b_len(B.ev("local_ip")), 4), B.eq_(B.b_len(B.ev("remote_ip")), 4),
                      B.ge_(B.ev("local_port"), 1), B.ge_(B.ev("remote_port"), 1)),
               [B.act_set("local_ip", B.b_slice(B.ev("local_ip"), 0, 4)),
                B.act_set("local_port", B.ev("local_port")),
                B.act_set("remote_ip", B.b_slice(B.ev("remote_ip"), 0, 4)),
                B.act_set("remote_port", B.ev("remote_port")),
                B.act_set("iss", B.ev("iss")),
                B.act_set("snd_una", B.ev("iss")),
                B.act_set("snd_nxt", B.seq_add_(B.ev("iss"), 1)),
                B.act_set("snd_lbb", B.seq_add_(B.ev("iss"), 1)),
                B.act_set("rcv_wnd", 8192), B.act_set("mss", 1460),
                B.act_set("rto_ms", 250), B.act_set("retries", 0),
                B.act_arm("rtx_timer", 250),
                tx_seg(B.ev("iss"), B.seq_lit(0), 2, 8192, 1460, B.bytes_lit([]))],
               ["L4.TCP"]),

        B.rule("TCP.LISTEN_SYN", "CLOSED", "SYN_RCVD", "net.listen_syn",
               B.and_(B.ev("is_syn"), B.not_(B.ev("is_ack")), B.not_(B.ev("is_rst")),
                      B.eq_(B.b_len(B.ev("src_ip")), 4), B.eq_(B.b_len(B.ev("dst_ip")), 4)),
               [B.act_set("local_ip", B.b_slice(B.ev("dst_ip"), 0, 4)),
                B.act_set("remote_ip", B.b_slice(B.ev("src_ip"), 0, 4)),
                B.act_set("remote_port", B.ev("src_port")),
                B.act_set("irs", B.ev("seq")),
                B.act_set("rcv_nxt", B.seq_add_(B.ev("seq"), 1)),
                B.act_set("iss", B.seq_lit(1382023300)),
                B.act_set("snd_una", B.seq_lit(1382023300)),
                B.act_set("snd_nxt", B.seq_lit(1382023301)),
                B.act_set("snd_lbb", B.seq_lit(1382023301)),
                B.act_set("snd_wnd", B.max_(1, B.min_(65535, B.ev("wnd")))),
                B.act_set("mss", B.ite_(B.gt_(B.ev("mss"), 0), B.min_(1460, B.max_(536, B.ev("mss"))), 1460)),
                B.act_set("rcv_wnd", 8192), B.act_set("cwnd", B.mul_(2, B.var("mss"))),
                B.act_set("rto_ms", 250), B.act_set("retries", 0),
                B.act_arm("rtx_timer", 250),
                tx_seg(B.var("iss"), B.var("rcv_nxt"), 18, 8192, B.var("mss"), B.bytes_lit([])),
                B.act_emit("accepted", parent_slot=B.var("parent_slot"), remote_ip=B.var("remote_ip"), remote_port=B.var("remote_port"))],
               ["L4.TCP"]),

        # 2. SYN_SENT -> ESTABLISHED / RST
        B.rule("TCP.SYN_SENT_SYNACK", "SYN_SENT", "ESTABLISHED", "net.seg",
               B.and_(B.not_(B.ev("is_rst")), B.ev("is_syn"), B.ev("is_ack"), B.eq_(B.ev("ack"), B.var("snd_nxt"))),
               [B.act_cancel("rtx_timer"),
                B.act_set("snd_una", B.ev("ack")),
                B.act_set("irs", B.ev("seq")),
                B.act_set("rcv_nxt", B.seq_add_(B.ev("seq"), 1)),
                B.act_set("snd_wnd", B.max_(1, B.min_(65535, B.ev("wnd")))),
                B.act_set("mss", B.ite_(B.gt_(B.ev("mss"), 0), B.min_(1460, B.max_(536, B.ev("mss"))), 1460)),
                B.act_set("cwnd", B.mul_(2, B.var("mss"))),
                B.act_set("retries", 0), B.act_set("rto_ms", 250),
                tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 16, B.var("rcv_wnd"), None, B.bytes_lit([])),
                B.act_emit("connected", mss=B.var("mss"))],
               ["L4.TCP"]),

        # 3. SYN_RCVD -> ESTABLISHED
        B.rule("TCP.SYN_RCVD_ACK", "SYN_RCVD", "ESTABLISHED", "net.seg",
               B.and_(B.not_(B.ev("is_rst")), B.ev("is_ack"), B.eq_(B.ev("ack"), B.var("snd_nxt"))),
               [B.act_cancel("rtx_timer"),
                B.act_set("snd_una", B.ev("ack")),
                B.act_set("snd_wnd", B.min_(65535, B.ev("wnd"))),
                B.act_set("retries", 0), B.act_set("rto_ms", 250)],
               ["L4.TCP"]),
    ]

    # RST handling across active states
    for st in ["SYN_SENT", "SYN_RCVD", "ESTABLISHED", "FIN_WAIT_1", "FIN_WAIT_2", "CLOSE_WAIT", "CLOSING", "LAST_ACK"]:
        transitions.append(B.rule(
            f"TCP.RST_{st}", st, "CLOSED", "net.seg", B.ev("is_rst"),
            [*rst_reset, B.act_emit("closed", reason=1)], ["L4.TCP"],
        ))

    # RST in TIME_WAIT ignored cleanly per RFC 9293
    transitions.append(B.rule("TCP.RST_TW", "TIME_WAIT", "TIME_WAIT", "net.seg", B.ev("is_rst"), [], ["L4.TCP"]))

    # In-order + ACK + FIN rules for ESTABLISHED, FIN_WAIT_1, FIN_WAIT_2, CLOSE_WAIT, CLOSING, LAST_ACK
    in_order_states = ["ESTABLISHED", "FIN_WAIT_1", "FIN_WAIT_2", "CLOSE_WAIT", "CLOSING", "LAST_ACK"]
    for st in in_order_states:
        in_ord = B.and_(B.not_(B.ev("is_rst")), B.not_(B.ev("is_syn")), B.eq_(B.ev("seq"), B.var("rcv_nxt")))
        dlen = B.b_len(B.ev("data"))
        can_rx = (st in ("ESTABLISHED", "FIN_WAIT_1", "FIN_WAIT_2"))
        take_n = B.min_(dlen, B.var("rcv_wnd")) if can_rx else 0
        rx_slice = B.b_slice(B.ev("data"), 0, take_n) if can_rx else B.bytes_lit([])
        # Guard in_ord guarantees B.ev("seq") == B.var("rcv_nxt"), so deriving from ev("seq") avoids rcv_nxt self-cycles.
        rcv_nxt1 = B.seq_add_(B.ev("seq"), take_n)
        rcv_wnd1 = B.sub_(B.var("rcv_wnd"), take_n)

        # Coalesce buffered OOO segment if rcv_nxt1 == ooo_seq
        ooo_hit = B.and_(B.var("ooo_valid"), B.eq_(rcv_nxt1, B.var("ooo_seq"))) if can_rx else False
        ooo_take = B.ite_(ooo_hit, B.min_(B.b_len(B.var("ooo_buf")), rcv_wnd1), 0)
        ooo_slice = B.b_slice(B.var("ooo_buf"), 0, ooo_take)
        rcv_nxt2 = B.seq_add_(rcv_nxt1, ooo_take)
        rcv_wnd2 = B.sub_(rcv_wnd1, ooo_take)
        got_fin = B.or_(B.ev("is_fin"), B.and_(ooo_hit, B.var("ooo_has_fin")))
        rcv_nxt3 = B.ite_(got_fin, B.seq_add_(rcv_nxt2, 1), rcv_nxt2)

        # Process ACK against [snd_una .. snd_una + len(snd_buf) + (fin_queued?1:0)]
        max_ack_seq = B.seq_add_(B.var("snd_una"), B.add_(B.b_len(B.var("snd_buf")), B.ite_(B.var("fin_queued"), 1, 0)))
        ack_advances = B.and_(
            B.ev("is_ack"),
            B.seq_gt_(B.ev("ack"), B.var("snd_una")),
            B.seq_le_(B.ev("ack"), max_ack_seq),
        )
        total_acked = B.ite_(ack_advances, B.seq_dist_(B.var("snd_una"), B.ev("ack")), 0)
        data_acked = B.min_(total_acked, B.b_len(B.var("snd_buf")))
        new_una = B.ite_(ack_advances, B.ev("ack"), B.var("snd_una"))
        new_nxt_after_ack = B.ite_(B.seq_lt_(B.var("snd_nxt"), new_una), new_una, B.var("snd_nxt"))
        new_sbuf = B.ite_(ack_advances, B.b_slice(B.var("snd_buf"), data_acked, B.sub_(B.b_len(B.var("snd_buf")), data_acked)), B.var("snd_buf"))
        new_sw = B.ite_(B.ev("is_ack"), B.min_(65535, B.ev("wnd")), B.var("snd_wnd"))
        fin_acked_now = B.and_(B.var("fin_queued"), B.gt_(total_acked, data_acked))

        # DupACK detection (empty pure ACK equal to snd_una with data in flight)
        is_dupack = B.and_(
            B.ev("is_ack"), B.not_(ack_advances), B.eq_(B.ev("ack"), B.var("snd_una")),
            B.eq_(dlen, 0), B.not_(B.ev("is_fin")), B.gt_(B.b_len(B.var("snd_buf")), 0),
        )
        new_dups = B.ite_(ack_advances, 0, B.ite_(is_dupack, B.add_(B.var("dupacks"), 1), B.var("dupacks")))
        fast_rtx = B.eq_(new_dups, 3)

        can_tx, tx_len, tx_chunk = post_ack_send_chunk(new_sbuf, new_una, new_nxt_after_ack, new_sw,
                                                       B.ite_(fast_rtx, B.max_(B.mul_(2, B.var("mss")), B.u16_div2(B.min_(B.var("cwnd"), new_sw))),
                                                              B.ite_(B.and_(ack_advances, B.gt_(data_acked, 0)),
                                                                     B.min_(65535, B.add_(B.var("cwnd"), B.min_(data_acked, B.var("mss")))),
                                                                     B.var("cwnd"))))
        new_nxt_final = B.ite_(can_tx, B.seq_add_(new_nxt_after_ack, tx_len), new_nxt_after_ack)

        # Post-snapshot derived helpers for hazard-free sequential act_set updates
        total_rx = B.add_(take_n, ooo_take)
        combined_rx = B.b_concat(rx_slice, ooo_slice)
        has_unacked_post = B.gt_(B.b_len(new_sbuf), 0)
        ack_needed = B.or_(B.gt_(total_rx, 0), got_fin)

        rx_update_acts = [
            B.act_set("_rx_hit", B.ite_(ooo_hit, 1, 0)),
            B.act_set("rcv_nxt", rcv_nxt3),
            B.act_set("rcv_wnd", rcv_wnd2),
            B.act_set("ooo_valid", B.ite_(B.eq_(B.var("_rx_hit"), 1), False, B.var("ooo_valid"))),
            B.act_set("ooo_has_fin", B.ite_(B.eq_(B.var("_rx_hit"), 1), False, B.var("ooo_has_fin"))),
            B.act_set("ooo_buf", B.ite_(B.eq_(B.var("_rx_hit"), 1), B.bytes_lit([]), B.var("ooo_buf"))),
        ]
        data_acked_v = B.min_(B.var("_tx_acked"), B.b_len(B.var("snd_buf")))
        fin_acked_v = B.and_(B.var("fin_queued"), B.gt_(B.var("_tx_acked"), B.b_len(B.var("snd_buf"))))
        is_dupack_v = B.and_(
            B.ev("is_ack"), B.eq_(B.var("_tx_acked"), 0), B.eq_(B.ev("ack"), B.var("snd_una")),
            B.eq_(dlen, 0), B.not_(B.ev("is_fin")), B.gt_(B.b_len(B.var("snd_buf")), 0),
        )
        fast_rtx_v = B.and_(is_dupack_v, B.eq_(B.var("dupacks"), 2))
        nxt_after_ack_post = B.ite_(B.seq_lt_(B.var("snd_nxt"), B.var("snd_una")), B.var("snd_una"), B.var("snd_nxt"))
        can_tx_p, tx_len_p, _ = post_ack_send_chunk(B.var("snd_buf"), B.var("snd_una"), nxt_after_ack_post, B.var("snd_wnd"), B.var("cwnd"))
        # Split post-ACK updates from snd_nxt/TX emission so every tx_seg uses shallow B.var(...) leaves!
        tx_ack_state_acts = [
            B.act_set("_tx_acked", total_acked),
            B.act_set("ssthresh", B.ite_(fast_rtx_v, B.max_(B.mul_(2, B.var("mss")), B.u16_div2(B.min_(B.var("cwnd"), new_sw))), B.var("ssthresh"))),
            B.act_set("cwnd", B.ite_(fast_rtx_v, B.var("ssthresh"),
                                     B.ite_(B.gt_(data_acked_v, 0),
                                            B.min_(65535, B.add_(B.var("cwnd"), B.min_(data_acked_v, B.var("mss")))),
                                            B.var("cwnd")))),
            B.act_set("dupacks", B.ite_(B.gt_(B.var("_tx_acked"), 0), 0, B.ite_(is_dupack_v, B.add_(B.var("dupacks"), 1), B.var("dupacks")))),
            B.act_set("retries", B.ite_(B.gt_(B.var("_tx_acked"), 0), 0, B.var("retries"))),
            B.act_set("rto_ms", B.ite_(B.gt_(B.var("_tx_acked"), 0), 250, B.var("rto_ms"))),
            B.act_set("fin_queued", B.and_(B.var("fin_queued"), B.not_(fin_acked_v))),
            B.act_set("snd_buf", B.ite_(B.gt_(data_acked_v, 0),
                                        B.b_slice(B.var("snd_buf"), data_acked_v,
                                                  B.min_(8192, B.sub_(B.b_len(B.var("snd_buf")), data_acked_v))),
                                        B.var("snd_buf"))),
            B.act_set("snd_una", B.ite_(B.gt_(B.var("_tx_acked"), 0), B.ev("ack"), B.var("snd_una"))),
            B.act_set("snd_wnd", new_sw),
        ]
        # Post-ACK TX expressions reading strictly updated B.var(...) leaves:
        can_tx_post, tx_len_post, tx_chunk_post = post_ack_send_chunk(
            B.var("snd_buf"), B.var("snd_una"), nxt_after_ack_post, B.var("snd_wnd"), B.var("cwnd")
        )
        post_rtx_seg = tx_seg(B.var("snd_una"), B.var("rcv_nxt"), 24, B.var("rcv_wnd"), None,
                              B.b_slice(B.var("snd_buf"), 0, B.min_(B.var("mss"), B.b_len(B.var("snd_buf")))))
        post_pump_seg = tx_seg(nxt_after_ack_post, B.var("rcv_nxt"), 24, B.var("rcv_wnd"), None, tx_chunk_post)
        post_ack_seg = tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 16, B.var("rcv_wnd"), None, B.bytes_lit([]))
        set_nxt_pump = B.act_set("snd_nxt", B.ite_(can_tx_post, B.seq_add_(nxt_after_ack_post, tx_len_post), nxt_after_ack_post))
        set_nxt_nopump = B.act_set("snd_nxt", nxt_after_ack_post)

        # Target next state computation using strictly atomic actions (no emit_if/arm_if/cancel_if)
        if st == "ESTABLISHED":
            rx_emit = B.act_emit("tcp_rx_data", data=combined_rx)

            for fin_tag, fin_cond, nxt_st, eof_acts in (
                ("NOFIN", B.not_(got_fin), "ESTABLISHED", []),
                ("FIN", got_fin, "CLOSE_WAIT", [B.act_emit("peer_eof")]),
            ):
                transitions.append(B.rule(
                    f"TCP.EST_FASTRTX_{fin_tag}", "ESTABLISHED", nxt_st, "net.seg",
                    B.and_(in_ord, fin_cond, fast_rtx),
                    [rx_emit, *eof_acts, *rx_update_acts, *tx_ack_state_acts,
                     post_rtx_seg, set_nxt_nopump, B.act_arm("rtx_timer", B.var("rto_ms"))],
                    ["L4.TCP"],
                ))
                transitions.append(B.rule(
                    f"TCP.EST_PUMP_{fin_tag}", "ESTABLISHED", nxt_st, "net.seg",
                    B.and_(in_ord, fin_cond, B.not_(fast_rtx), can_tx),
                    [rx_emit, *eof_acts, *rx_update_acts, *tx_ack_state_acts,
                     post_pump_seg, set_nxt_pump, B.act_arm("rtx_timer", B.var("rto_ms"))],
                    ["L4.TCP"],
                ))
                transitions.append(B.rule(
                    f"TCP.EST_ACK_PEND_{fin_tag}", "ESTABLISHED", nxt_st, "net.seg",
                    B.and_(in_ord, fin_cond, B.not_(fast_rtx), B.not_(can_tx), ack_needed, has_unacked_post),
                    [rx_emit, *eof_acts, *rx_update_acts, *tx_ack_state_acts,
                     set_nxt_nopump, post_ack_seg, B.act_arm("rtx_timer", B.var("rto_ms"))],
                    ["L4.TCP"],
                ))
                transitions.append(B.rule(
                    f"TCP.EST_ACK_IDLE_{fin_tag}", "ESTABLISHED", nxt_st, "net.seg",
                    B.and_(in_ord, fin_cond, B.not_(fast_rtx), B.not_(can_tx), ack_needed, B.not_(has_unacked_post)),
                    [rx_emit, *eof_acts, *rx_update_acts, *tx_ack_state_acts,
                     set_nxt_nopump, post_ack_seg, B.act_cancel("rtx_timer")],
                    ["L4.TCP"],
                ))
            transitions.append(B.rule(
                "TCP.EST_QUIET_PEND", "ESTABLISHED", "ESTABLISHED", "net.seg",
                B.and_(in_ord, B.not_(fast_rtx), B.not_(can_tx), B.not_(ack_needed), has_unacked_post),
                [*rx_update_acts, *tx_ack_state_acts, set_nxt_nopump, B.act_arm("rtx_timer", B.var("rto_ms"))],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.EST_QUIET_IDLE", "ESTABLISHED", "ESTABLISHED", "net.seg",
                B.and_(in_ord, B.not_(fast_rtx), B.not_(can_tx), B.not_(ack_needed), B.not_(has_unacked_post)),
                [*rx_update_acts, *tx_ack_state_acts, set_nxt_nopump, B.act_cancel("rtx_timer")],
                ["L4.TCP"],
            ))
        elif st == "CLOSE_WAIT":
            transitions.append(B.rule(
                "TCP.CW_PUMP", "CLOSE_WAIT", "CLOSE_WAIT", "net.seg",
                B.and_(in_ord, can_tx),
                [*tx_ack_state_acts, post_pump_seg, set_nxt_pump, B.act_arm("rtx_timer", B.var("rto_ms"))],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.CW_PEND", "CLOSE_WAIT", "CLOSE_WAIT", "net.seg",
                B.and_(in_ord, B.not_(can_tx), has_unacked_post),
                [*tx_ack_state_acts, set_nxt_nopump, B.act_arm("rtx_timer", B.var("rto_ms"))],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.CW_IDLE", "CLOSE_WAIT", "CLOSE_WAIT", "net.seg",
                B.and_(in_ord, B.not_(can_tx), B.not_(has_unacked_post)),
                [*tx_ack_state_acts, set_nxt_nopump, B.act_cancel("rtx_timer")],
                ["L4.TCP"],
            ))
        elif st == "FIN_WAIT_1":
            rx_emit = B.act_emit("tcp_rx_data", data=combined_rx)

            # Unacked FIN -> rtx_timer stays armed
            transitions.append(B.rule(
                "TCP.FW1_STAY_PUMP", "FIN_WAIT_1", "FIN_WAIT_1", "net.seg",
                B.and_(in_ord, B.not_(fin_acked_now), B.not_(got_fin), can_tx),
                [rx_emit, *rx_update_acts, *tx_ack_state_acts,
                 post_pump_seg, set_nxt_pump, B.act_arm("rtx_timer", B.var("rto_ms"))],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.FW1_STAY_ACK", "FIN_WAIT_1", "FIN_WAIT_1", "net.seg",
                B.and_(in_ord, B.not_(fin_acked_now), B.not_(got_fin), B.not_(can_tx), B.gt_(total_rx, 0)),
                [rx_emit, *rx_update_acts, *tx_ack_state_acts,
                 set_nxt_nopump, post_ack_seg, B.act_arm("rtx_timer", B.var("rto_ms"))],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.FW1_STAY_QUIET", "FIN_WAIT_1", "FIN_WAIT_1", "net.seg",
                B.and_(in_ord, B.not_(fin_acked_now), B.not_(got_fin), B.not_(can_tx), B.eq_(total_rx, 0)),
                [*rx_update_acts, *tx_ack_state_acts, set_nxt_nopump, B.act_arm("rtx_timer", B.var("rto_ms"))],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.FW1_CLOSING_PUMP", "FIN_WAIT_1", "CLOSING", "net.seg",
                B.and_(in_ord, B.not_(fin_acked_now), got_fin, can_tx),
                [rx_emit, B.act_emit("peer_eof"), *rx_update_acts, *tx_ack_state_acts,
                 post_pump_seg, set_nxt_pump, B.act_arm("rtx_timer", B.var("rto_ms"))],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.FW1_CLOSING_ACK", "FIN_WAIT_1", "CLOSING", "net.seg",
                B.and_(in_ord, B.not_(fin_acked_now), got_fin, B.not_(can_tx)),
                [rx_emit, B.act_emit("peer_eof"), *rx_update_acts, *tx_ack_state_acts,
                 set_nxt_nopump, post_ack_seg, B.act_arm("rtx_timer", B.var("rto_ms"))],
                ["L4.TCP"],
            ))
            # FIN ACKed -> cancel rtx_timer
            transitions.append(B.rule(
                "TCP.FW1_TO_FW2_ACK", "FIN_WAIT_1", "FIN_WAIT_2", "net.seg",
                B.and_(in_ord, fin_acked_now, B.not_(got_fin), B.gt_(total_rx, 0)),
                [rx_emit, *rx_update_acts, *tx_ack_state_acts,
                 set_nxt_nopump, post_ack_seg, B.act_cancel("rtx_timer")],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.FW1_TO_FW2_QUIET", "FIN_WAIT_1", "FIN_WAIT_2", "net.seg",
                B.and_(in_ord, fin_acked_now, B.not_(got_fin), B.eq_(total_rx, 0)),
                [*rx_update_acts, *tx_ack_state_acts, set_nxt_nopump, B.act_cancel("rtx_timer")],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.FW1_TO_TW", "FIN_WAIT_1", "TIME_WAIT", "net.seg",
                B.and_(in_ord, fin_acked_now, got_fin),
                [rx_emit, B.act_emit("peer_eof"), *rx_update_acts, *tx_ack_state_acts,
                 set_nxt_nopump, post_ack_seg, B.act_cancel("rtx_timer"), B.act_arm("tw_timer", 2000)],
                ["L4.TCP"],
            ))
        elif st == "FIN_WAIT_2":
            rx_emit = B.act_emit("tcp_rx_data", data=combined_rx)
            transitions.append(B.rule(
                "TCP.FW2_STAY_ACK", "FIN_WAIT_2", "FIN_WAIT_2", "net.seg",
                B.and_(in_ord, B.not_(got_fin), B.gt_(total_rx, 0)),
                [rx_emit, *rx_update_acts, post_ack_seg],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.FW2_STAY_QUIET", "FIN_WAIT_2", "FIN_WAIT_2", "net.seg",
                B.and_(in_ord, B.not_(got_fin), B.eq_(total_rx, 0)),
                [*rx_update_acts],
                ["L4.TCP"],
            ))
            transitions.append(B.rule(
                "TCP.FW2_TO_TW", "FIN_WAIT_2", "TIME_WAIT", "net.seg",
                B.and_(in_ord, got_fin),
                [rx_emit, B.act_emit("peer_eof"), *rx_update_acts, post_ack_seg, B.act_arm("tw_timer", 2000)],
                ["L4.TCP"],
            ))
        elif st == "CLOSING":
            transitions.append(B.rule("TCP.CLOSING_ACK", "CLOSING", "TIME_WAIT", "net.seg",
                                      B.and_(in_ord, fin_acked_now),
                                      [B.act_cancel("rtx_timer"), B.act_set("fin_queued", False),
                                       B.act_set("snd_una", new_una), B.act_arm("tw_timer", 2000)], ["L4.TCP"]))
            transitions.append(B.rule("TCP.CLOSING_STAY", "CLOSING", "CLOSING", "net.seg",
                                      B.and_(in_ord, B.not_(fin_acked_now)), [], ["L4.TCP"]))
        elif st == "LAST_ACK":
            transitions.append(B.rule("TCP.LAST_ACK_DONE", "LAST_ACK", "CLOSED", "net.seg",
                                      B.and_(in_ord, fin_acked_now),
                                      [*rst_reset, B.act_emit("closed", reason=0)], ["L4.TCP"]))
            transitions.append(B.rule("TCP.LAST_ACK_WAIT", "LAST_ACK", "LAST_ACK", "net.seg",
                                      B.and_(in_ord, B.not_(fin_acked_now)), [], ["L4.TCP"]))

        # Out-of-order & duplicate segment handling
        if st in ("ESTABLISHED", "FIN_WAIT_1", "FIN_WAIT_2"):
            ooo_cond = B.and_(
                B.not_(B.ev("is_rst")), B.not_(B.ev("is_syn")),
                B.seq_gt_(B.ev("seq"), B.var("rcv_nxt")),
                B.gt_(B.b_len(B.ev("data")), 0),
                B.le_(B.b_len(B.ev("data")), 1460),
            )
            transitions.append(B.rule(
                f"TCP.OOO_{st}", st, st, "net.seg", ooo_cond,
                [B.act_set("ooo_buf", B.b_slice(B.ev("data"), 0, 1460)),
                 B.act_set("ooo_seq", B.ev("seq")),
                 B.act_set("ooo_has_fin", B.ev("is_fin")),
                 B.act_set("ooo_valid", True),
                 tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 16, B.var("rcv_wnd"), None, B.bytes_lit([]))],
                ["L4.TCP"],
            ))
            old_dup_cond = B.and_(
                B.not_(B.ev("is_rst")), B.not_(B.ev("is_syn")),
                B.ne_(B.ev("seq"), B.var("rcv_nxt")), B.not_(ooo_cond),
            )
            transitions.append(B.rule(
                f"TCP.OLD_{st}", st, st, "net.seg", old_dup_cond,
                [tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 16, B.var("rcv_wnd"), None, B.bytes_lit([]))],
                ["L4.TCP"],
            ))
        else:
            transitions.append(B.rule(
                f"TCP.UNEXP_{st}", st, st, "net.seg",
                B.and_(B.not_(B.ev("is_rst")), B.or_(B.ev("is_syn"), B.ne_(B.ev("seq"), B.var("rcv_nxt")))),
                [], ["L4.TCP"],
            ))

    # SYN_SENT / SYN_RCVD non-SYNACK / SYNACK fallback to satisfy full guard coverage on net.seg
    transitions.append(B.rule("TCP.SYN_SENT_OTHER", "SYN_SENT", "SYN_SENT", "net.seg",
                              B.and_(B.not_(B.ev("is_rst")), B.not_(B.and_(B.ev("is_syn"), B.ev("is_ack"), B.eq_(B.ev("ack"), B.var("snd_nxt"))))),
                              [], ["L4.TCP"]))
    transitions.append(B.rule("TCP.SYN_RCVD_OTHER", "SYN_RCVD", "SYN_RCVD", "net.seg",
                              B.and_(B.not_(B.ev("is_rst")), B.not_(B.and_(B.ev("is_ack"), B.eq_(B.ev("ack"), B.var("snd_nxt"))))),
                              [], ["L4.TCP"]))
    transitions.append(B.rule("TCP.TW_SEG_FIN", "TIME_WAIT", "TIME_WAIT", "net.seg",
                              B.and_(B.not_(B.ev("is_rst")), B.ev("is_fin")),
                              [tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 16, B.var("rcv_wnd"), None, B.bytes_lit([]))],
                              ["L4.TCP"]))
    transitions.append(B.rule("TCP.TW_SEG_OTHER", "TIME_WAIT", "TIME_WAIT", "net.seg",
                              B.and_(B.not_(B.ev("is_rst")), B.not_(B.ev("is_fin"))),
                              [], ["L4.TCP"]))

    # app.send, app.pump, app.recved, app.close, app.abort
    for st in ("ESTABLISHED", "CLOSE_WAIT"):
        sbuf_next = B.b_concat(B.var("snd_buf"), B.ev("data"))
        u_off = B.seq_dist_(B.var("snd_una"), B.var("snd_nxt"))
        ew = B.min_(B.var("snd_wnd"), B.var("cwnd"))
        can_tx = B.and_(B.gt_(B.b_len(sbuf_next), u_off), B.lt_(u_off, ew))
        c_len = B.min_(B.var("mss"), B.min_(B.sub_(ew, u_off), B.sub_(B.b_len(sbuf_next), u_off)))
        c_bytes = B.b_slice(sbuf_next, u_off, c_len)
        nxt1 = B.seq_add_(B.var("snd_nxt"), c_len)
        fit_nonempty = B.and_(B.gt_(B.b_len(B.ev("data")), 0),
                              B.le_(B.add_(B.b_len(B.var("snd_buf")), B.b_len(B.ev("data"))), 8192))
        transitions.append(B.rule(
            f"TCP.SEND_EMPTY_{st}", st, st, "app.send",
            B.eq_(B.b_len(B.ev("data")), 0), [], ["L4.TCP"],
        ))
        transitions.append(B.rule(
            f"TCP.SEND_NOW_{st}", st, st, "app.send",
            B.and_(fit_nonempty, can_tx),
            [tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 24, B.var("rcv_wnd"), None, c_bytes),
             B.act_set("snd_nxt", nxt1),
             B.act_set("snd_buf", B.b_slice(sbuf_next, 0, 8192)),
             B.act_set("snd_lbb", B.seq_add_(B.var("snd_lbb"), B.b_len(B.ev("data")))),
             B.act_arm("rtx_timer", B.var("rto_ms"))],
            ["L4.TCP"],
        ))
        transitions.append(B.rule(
            f"TCP.SEND_ZWP_{st}", st, st, "app.send",
            B.and_(fit_nonempty, B.not_(can_tx), B.eq_(B.var("snd_wnd"), 0)),
            [B.act_set("snd_buf", B.b_slice(sbuf_next, 0, 8192)),
             B.act_set("snd_lbb", B.seq_add_(B.var("snd_lbb"), B.b_len(B.ev("data")))),
             B.act_arm("rtx_timer", 250)],
            ["L4.TCP"],
        ))
        transitions.append(B.rule(
            f"TCP.SEND_BUF_{st}", st, st, "app.send",
            B.and_(fit_nonempty, B.not_(can_tx), B.ne_(B.var("snd_wnd"), 0)),
            [B.act_set("snd_buf", B.b_slice(sbuf_next, 0, 8192)),
             B.act_set("snd_lbb", B.seq_add_(B.var("snd_lbb"), B.b_len(B.ev("data")))),
             B.act_arm("rtx_timer", B.var("rto_ms"))],
            ["L4.TCP"],
        ))
        p_len = B.min_(B.var("mss"), B.min_(B.sub_(ew, u_off), B.sub_(B.b_len(B.var("snd_buf")), u_off)))
        transitions.append(B.rule(
            f"TCP.PUMP_{st}", st, st, "app.pump",
            B.and_(B.gt_(B.b_len(B.var("snd_buf")), u_off), B.lt_(u_off, ew)),
            [tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 24, B.var("rcv_wnd"), None, B.b_slice(B.var("snd_buf"), u_off, p_len)),
             B.act_set("snd_nxt", B.seq_add_(B.var("snd_nxt"), p_len)),
             B.act_arm("rtx_timer", B.var("rto_ms"))],
            ["L4.TCP"],
        ))

    for st in ("ESTABLISHED", "FIN_WAIT_1", "FIN_WAIT_2"):
        new_w = B.min_(8192, B.add_(B.var("rcv_wnd"), B.ev("len")))
        w_upd = B.and_(B.lt_(B.var("rcv_wnd"), B.var("mss")), B.ge_(new_w, B.var("mss")))
        transitions.append(B.rule(
            f"TCP.RECVED_UPD_{st}", st, st, "app.recved", B.and_(B.ge_(B.ev("len"), 0), w_upd),
            [B.act_set("rcv_wnd", new_w),
             tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 16, new_w, None, B.bytes_lit([]))],
            ["L4.TCP"],
        ))
        transitions.append(B.rule(
            f"TCP.RECVED_QUIET_{st}", st, st, "app.recved", B.and_(B.ge_(B.ev("len"), 0), B.not_(w_upd)),
            [B.act_set("rcv_wnd", new_w)],
            ["L4.TCP"],
        ))

    # app.close
    transitions.append(B.rule("TCP.CLOSE_LISTEN", "LISTEN", "CLOSED", "app.close", True, rst_reset, ["L4.TCP"]))
    transitions.append(B.rule("TCP.CLOSE_SYN_SENT", "SYN_SENT", "CLOSED", "app.close", True, rst_reset, ["L4.TCP"]))
    transitions.append(B.rule("TCP.CLOSE_SYN_RCVD", "SYN_RCVD", "CLOSED", "app.close", True, rst_reset, ["L4.TCP"]))
    transitions.append(B.rule("TCP.CLOSE_EST", "ESTABLISHED", "FIN_WAIT_1", "app.close", True,
                              [tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 17, B.var("rcv_wnd"), None, B.bytes_lit([])),
                               B.act_set("fin_queued", True),
                               B.act_set("snd_nxt", B.seq_add_(B.var("snd_nxt"), 1)),
                               B.act_set("snd_lbb", B.seq_add_(B.var("snd_lbb"), 1)),
                               B.act_arm("rtx_timer", B.var("rto_ms"))],
                              ["L4.TCP"]))
    transitions.append(B.rule("TCP.CLOSE_CW", "CLOSE_WAIT", "LAST_ACK", "app.close", True,
                              [tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 17, B.var("rcv_wnd"), None, B.bytes_lit([])),
                               B.act_set("fin_queued", True),
                               B.act_set("snd_nxt", B.seq_add_(B.var("snd_nxt"), 1)),
                               B.act_set("snd_lbb", B.seq_add_(B.var("snd_lbb"), 1)),
                               B.act_arm("rtx_timer", B.var("rto_ms"))],
                              ["L4.TCP"]))
    for st in ("FIN_WAIT_1", "FIN_WAIT_2", "CLOSING", "LAST_ACK", "TIME_WAIT"):
        transitions.append(B.rule(f"TCP.ABORT_{st}", st, "CLOSED", "app.abort", True,
                                  [*rst_reset, B.act_emit("closed", reason=1)], ["L4.TCP"]))
    transitions.append(B.rule("TCP.ABORT_EST", "ESTABLISHED", "CLOSED", "app.abort", True,
                              [tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 20, 0, None, B.bytes_lit([])),
                               *rst_reset, B.act_emit("closed", reason=1)], ["L4.TCP"]))

    # Timers
    transitions.append(B.rule(
        "TCP.RTX_SYN", "SYN_SENT", "SYN_SENT", "tmr.rtx", B.lt_(B.var("retries"), 8),
        [B.act_set("retries", B.add_(B.var("retries"), 1)),
         B.act_set("rto_ms", B.min_(60000, B.mul_(B.var("rto_ms"), 2))),
         B.act_arm("rtx_timer", B.var("rto_ms")),
         tx_seg(B.var("snd_una"), B.seq_lit(0), 2, B.var("rcv_wnd"), 1460, B.bytes_lit([]))],
        ["L4.TCP"],
    ))
    transitions.append(B.rule(
        "TCP.RTX_SYNACK", "SYN_RCVD", "SYN_RCVD", "tmr.rtx", B.lt_(B.var("retries"), 8),
        [B.act_set("retries", B.add_(B.var("retries"), 1)),
         B.act_set("rto_ms", B.min_(60000, B.mul_(B.var("rto_ms"), 2))),
         B.act_arm("rtx_timer", B.var("rto_ms")),
         tx_seg(B.var("snd_una"), B.var("rcv_nxt"), 18, B.var("rcv_wnd"), B.var("mss"), B.bytes_lit([]))],
        ["L4.TCP"],
    ))
    for st in ("ESTABLISHED", "FIN_WAIT_1", "CLOSING", "LAST_ACK"):
        zwp_cond = B.and_(B.eq_(B.var("snd_wnd"), 0), B.gt_(B.b_len(B.var("snd_buf")), 0))
        transitions.append(B.rule(
            f"TCP.RTX_ZWP_{st}", st, st, "tmr.rtx", zwp_cond,
            [B.act_arm("rtx_timer", 250),
             tx_seg(B.var("snd_una"), B.var("rcv_nxt"), 24, B.var("rcv_wnd"), None, B.b_slice(B.var("snd_buf"), 0, 1))],
            ["L4.TCP"],
        ))
        transitions.append(B.rule(
            f"TCP.RTX_DATA_{st}", st, st, "tmr.rtx",
            B.and_(B.not_(zwp_cond), B.lt_(B.var("retries"), 8), B.gt_(B.b_len(B.var("snd_buf")), 0)),
            [B.act_set("retries", B.add_(B.var("retries"), 1)),
             B.act_set("rto_ms", B.min_(60000, B.mul_(B.var("rto_ms"), 2))),
             B.act_set("ssthresh", B.max_(B.mul_(2, B.var("mss")), B.u16_div2(B.var("cwnd")))),
             B.act_set("cwnd", B.var("mss")),
             B.act_set("dupacks", 0),
             B.act_arm("rtx_timer", B.var("rto_ms")),
             tx_seg(B.var("snd_una"), B.var("rcv_nxt"), 24, B.var("rcv_wnd"), None,
                    B.b_slice(B.var("snd_buf"), 0, B.min_(B.var("mss"), B.b_len(B.var("snd_buf")))))],
            ["L4.TCP"],
        ))
        transitions.append(B.rule(
            f"TCP.RTX_FIN_{st}", st, st, "tmr.rtx",
            B.and_(B.lt_(B.var("retries"), 8), B.eq_(B.b_len(B.var("snd_buf")), 0), B.var("fin_queued")),
            [B.act_set("retries", B.add_(B.var("retries"), 1)),
             B.act_set("rto_ms", B.min_(60000, B.mul_(B.var("rto_ms"), 2))),
             B.act_arm("rtx_timer", B.var("rto_ms")),
             tx_seg(B.var("snd_una"), B.var("rcv_nxt"), 17, B.var("rcv_wnd"), None, B.bytes_lit([]))],
            ["L4.TCP"],
        ))
        transitions.append(B.rule(
            f"TCP.RTX_IDLE_{st}", st, st, "tmr.rtx",
            B.and_(B.lt_(B.var("retries"), 8), B.eq_(B.b_len(B.var("snd_buf")), 0), B.not_(B.var("fin_queued"))),
            [], ["L4.TCP"],
        ))
        transitions.append(B.rule(
            f"TCP.RTX_DROP_{st}", st, "CLOSED", "tmr.rtx",
            B.and_(B.not_(zwp_cond), B.ge_(B.var("retries"), 8)),
            [tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 20, 0, None, B.bytes_lit([])),
             *rst_reset, B.act_emit("closed", reason=2)],
            ["L4.TCP"],
        ))
    transitions.append(B.rule("TCP.RTX_DROP_SYNSENT", "SYN_SENT", "CLOSED", "tmr.rtx", B.ge_(B.var("retries"), 8),
                              [*rst_reset, B.act_emit("closed", reason=2)], ["L4.TCP"]))
    transitions.append(B.rule("TCP.RTX_DROP_SYNRCVD", "SYN_RCVD", "CLOSED", "tmr.rtx", B.ge_(B.var("retries"), 8),
                              [*rst_reset, B.act_emit("closed", reason=2)], ["L4.TCP"]))
    for st in ("CLOSED", "LISTEN", "FIN_WAIT_2", "CLOSE_WAIT", "TIME_WAIT"):
        transitions.append(B.rule(f"TCP.RTX_NOOP_{st}", st, st, "tmr.rtx", True, [], ["L4.TCP"]))

    transitions.append(B.rule("TCP.PERSIST_ZWP", "ESTABLISHED", "ESTABLISHED", "tmr.persist", True,
                              [B.act_arm("persist_timer", 250),
                               tx_seg(B.seq_add_(B.var("snd_nxt"), -1), B.var("rcv_nxt"), 16, B.var("rcv_wnd"), None, B.bytes_lit([]))],
                              ["L4.TCP"]))
    for st in states:
        if st != "ESTABLISHED":
            transitions.append(B.rule(f"TCP.PERSIST_NOOP_{st}", st, st, "tmr.persist", True, [], ["L4.TCP"]))
    transitions.append(B.rule("TCP.DELACK", "ESTABLISHED", "ESTABLISHED", "tmr.delack", True,
                              [tx_seg(B.var("snd_nxt"), B.var("rcv_nxt"), 16, B.var("rcv_wnd"), None, B.bytes_lit([]))],
                              ["L4.TCP"]))
    for st in states:
        if st != "ESTABLISHED":
            transitions.append(B.rule(f"TCP.DELACK_NOOP_{st}", st, st, "tmr.delack", True, [], ["L4.TCP"]))
    transitions.append(B.rule("TCP.TW_EXPIRE", "TIME_WAIT", "CLOSED", "tmr.tw", True,
                              [*rst_reset, B.act_emit("closed", reason=0)], ["L4.TCP"]))
    for st in states:
        if st != "TIME_WAIT":
            transitions.append(B.rule(f"TCP.TW_NOOP_{st}", st, st, "tmr.tw", True, [], ["L4.TCP"]))

    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "tcp-connection",
        "scope": {"terminal_states": [], "excluded": ["SACK", "window scale", "timestamps"]},
        "states": states,
        "initial_state": "CLOSED",
        "requirements": reqs,
        "variables": {
            "local_ip": {"type": "bytes", "initial": []},
            "remote_ip": {"type": "bytes", "initial": []},
            "local_port": {"type": "int", "initial": 0},
            "remote_port": {"type": "int", "initial": 0},
            "parent_slot": {"type": "int", "initial": -1},
            "snd_una": {"type": "seq32", "initial": 0},
            "snd_nxt": {"type": "seq32", "initial": 0},
            "snd_lbb": {"type": "seq32", "initial": 0},
            "rcv_nxt": {"type": "seq32", "initial": 0},
            "iss": {"type": "seq32", "initial": 0},
            "irs": {"type": "seq32", "initial": 0},
            "mss": {"type": "int", "initial": 1460},
            "snd_wnd": {"type": "int", "initial": 8192},
            "rcv_wnd": {"type": "int", "initial": 8192},
            "cwnd": {"type": "int", "initial": 2920},
            "ssthresh": {"type": "int", "initial": 65535},
            "rto_ms": {"type": "int", "initial": 250},
            "retries": {"type": "int", "initial": 0},
            "dupacks": {"type": "int", "initial": 0},
            "_rx_hit": {"type": "int", "initial": 0},
            "_tx_acked": {"type": "int", "initial": 0},
            "fin_queued": {"type": "bool", "initial": False},
            "ooo_valid": {"type": "bool", "initial": False},
            "ooo_has_fin": {"type": "bool", "initial": False},
            "ooo_seq": {"type": "seq32", "initial": 0},
            "snd_buf": {"type": "bytes", "initial": []},
            "ooo_buf": {"type": "bytes", "initial": []},
        },
        "events": {
            "app.listen": {"origin": "application", "fields": {"local_ip": "bytes", "local_port": "int"}},
            "app.connect": {"origin": "application", "fields": {"local_ip": "bytes", "local_port": "int", "remote_ip": "bytes", "remote_port": "int", "iss": "seq32"}},
            "app.send": {"origin": "application", "fields": {"data": "bytes"}},
            "app.pump": {"origin": "application", "fields": {}},
            "app.recved": {"origin": "application", "fields": {"len": "int"}},
            "app.close": {"origin": "application", "fields": {}},
            "app.abort": {"origin": "application", "fields": {}},
            "net.listen_syn": {"origin": "network", "fields": seg_fields},
            "net.seg": {"origin": "network", "fields": seg_fields},
            "tmr.rtx": {"origin": "timer", "fields": {}},
            "tmr.delack": {"origin": "timer", "fields": {}},
            "tmr.persist": {"origin": "timer", "fields": {}},
            "tmr.tw": {"origin": "timer", "fields": {}},
        },
        "messages": {
            "tx_ip": {"fields": {"src_ip": "bytes", "dst_ip": "bytes", "proto": "int", "payload": "bytes"}},
            "accepted": {"fields": {"parent_slot": "int", "remote_ip": "bytes", "remote_port": "int"}},
            "connected": {"fields": {"mss": "int"}},
            "tcp_rx_data": {"fields": {"data": "bytes"}},
            "peer_eof": {"fields": {}},
            "closed": {"fields": {"reason": "int"}},
        },
        "timers": {
            "rtx_timer": {"event": "tmr.rtx"},
            "delack_timer": {"event": "tmr.delack"},
            "persist_timer": {"event": "tmr.persist"},
            "tw_timer": {"event": "tmr.tw"},
        },
        "transitions": transitions,
        "invariants": [
            B.inv("TCP.IPS", B.and_(B.le_(B.b_len(B.var("local_ip")), 4), B.le_(B.b_len(B.var("remote_ip")), 4)), ["L4.TCP"]),
            B.inv("TCP.BUFS", B.and_(B.le_(B.b_len(B.var("snd_buf")), 8192), B.le_(B.b_len(B.var("ooo_buf")), 1460)), ["L4.TCP"]),
            B.inv("TCP.WND", B.and_(B.ge_(B.var("rcv_wnd"), 0), B.le_(B.var("rcv_wnd"), 8192),
                                    B.ge_(B.var("mss"), 256), B.le_(B.var("mss"), 1460)), ["L4.TCP"]),
            B.inv("TCP.RTO", B.and_(B.ge_(B.var("rto_ms"), 100), B.le_(B.var("rto_ms"), 60000),
                                    B.ge_(B.var("retries"), 0), B.le_(B.var("retries"), 8)), ["L4.TCP"]),
        ],
    }


def build_dhcpv4_client(B):
    reqs = {"CTRL.DHCP": {"source": "spec/stack/ctrl-dhcp-dns.md", "interpretation": "RFC 2131 DHCPv4 DORA"}}
    bcast = B.bytes_lit([255, 255, 255, 255])
    zero4 = B.bytes_lit([0, 0, 0, 0])
    magic = B.bytes_lit([99, 130, 83, 99])

    def build_dhcp_pkt(msg_type, ciaddr, mac, xid_e, req_ip, srv_ip):
        opts = B.b_concat(
            B.bytes_lit([53, 1, msg_type]),
            B.bytes_lit([50, 4]) if msg_type == 3 else B.bytes_lit([]),
            req_ip if msg_type == 3 else B.bytes_lit([]),
            B.bytes_lit([54, 4]) if msg_type == 3 else B.bytes_lit([]),
            srv_ip if msg_type == 3 else B.bytes_lit([]),
            B.bytes_lit([55, 4, 1, 3, 6, 54, 255]),
        )
        bootp = B.b_concat(
            B.bytes_lit([1, 1, 6, 0]),
            B.pack32be(xid_e),
            B.bytes_lit([0, 0, 0x80, 0]),  # secs=0, flags=0x8000 (broadcast)
            ciaddr,
            zero4, zero4, zero4,
            mac,
            B.bytes_lit([0] * 202),  # 10B chaddr pad + 64B sname + 128B file
            magic,
            opts,
        )
        return _udp_build_pkt(B, ciaddr, bcast, 68, 67, bootp)

    # Parse DHCP message type from first 2 TLV hops in guard (O(1) AST);
    # parse TLV options 1, 3, 6, 54 sequentially in action steps using _opt_off.
    p = B.ev("payload")
    yiaddr = B.b_slice(p, 16, 4)

    def guard_mtype():
        pos0 = 240
        op0 = B.u8(p, pos0)
        ol0 = B.u8(p, 241)
        mt0 = B.ite_(B.and_(B.eq_(op0, 53), B.ge_(ol0, 1)), B.u8(p, 242), 0)
        pos1 = B.add_(240, B.ite_(B.eq_(op0, 0), 1, B.ite_(B.eq_(op0, 255), 0, B.add_(2, ol0))))
        op1 = B.u8(p, pos1)
        ol1 = B.u8(p, B.add_(pos1, 1))
        return B.ite_(B.and_(B.eq_(op1, 53), B.ge_(ol1, 1)), B.u8(p, B.add_(pos1, 2)), mt0)

    def scan_tlv_acts(include_server_id):
        acts = [B.act_set("_opt_off", 240)]
        if include_server_id:
            acts.append(B.act_set("server_ip", zero4))
        op_v = B.u8(p, B.var("_opt_off"))
        ol_v = B.u8(p, B.add_(B.var("_opt_off"), 1))
        vp_v = B.add_(B.var("_opt_off"), 2)
        in_range = B.and_(B.ge_(ol_v, 4), B.ge_(vp_v, 0), B.le_(B.add_(vp_v, 4), B.b_len(p)))
        step_v = B.ite_(B.eq_(op_v, 0), 1, B.ite_(B.eq_(op_v, 255), 0, B.add_(2, ol_v)))
        for _ in range(5):
            acts.append(B.act_set("netmask", B.ite_(B.and_(B.eq_(op_v, 1), in_range), B.b_slice(p, vp_v, 4), B.var("netmask"))))
            acts.append(B.act_set("gateway", B.ite_(B.and_(B.eq_(op_v, 3), in_range), B.b_slice(p, vp_v, 4), B.var("gateway"))))
            acts.append(B.act_set("dns_ip", B.ite_(B.and_(B.eq_(op_v, 6), in_range), B.b_slice(p, vp_v, 4), B.var("dns_ip"))))
            if include_server_id:
                acts.append(B.act_set("server_ip", B.ite_(B.and_(B.eq_(op_v, 54), in_range), B.b_slice(p, vp_v, 4), B.var("server_ip"))))
            acts.append(B.act_set("_opt_off", B.add_(B.var("_opt_off"), step_v)))
        if include_server_id:
            acts.append(B.act_set("server_ip", B.ite_(B.eq_(B.var("server_ip"), zero4), B.b_slice(B.ev("src_ip"), 0, 4), B.var("server_ip"))))
        return acts

    mtype = guard_mtype()
    valid_reply = B.and_(
        B.ge_(B.b_len(p), 244),
        B.eq_(B.u8(p, 0), 2),
        B.eq_(B.u32be_int(p, 4), B.var("xid")),
        B.eq_(B.b_slice(p, 236, 4), magic),
    )

    disc_pkt = build_dhcp_pkt(1, zero4, B.b_slice(B.ev("mac"), 0, 6), B.ev("xid"), zero4, zero4)
    req_pkt = build_dhcp_pkt(3, zero4, B.var("client_mac"), B.var("xid"), yiaddr, B.var("server_ip"))
    retry_disc = build_dhcp_pkt(1, zero4, B.var("client_mac"), B.var("xid"), zero4, zero4)
    retry_req = build_dhcp_pkt(3, zero4, B.var("client_mac"), B.var("xid"), B.var("offered_ip"), B.var("server_ip"))

    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "dhcpv4-client",
        "scope": {"terminal_states": [], "excluded": ["DHCP relay", "options > 5"]},
        "states": ["INIT", "SELECTING", "REQUESTING", "BOUND", "RENEWING"],
        "initial_state": "INIT",
        "requirements": reqs,
        "variables": {
            "xid": {"type": "int", "initial": 0x10203040},
            "retries": {"type": "int", "initial": 0},
            "_opt_off": {"type": "int", "initial": 240},
            "client_mac": {"type": "bytes", "initial": [2, 0, 0, 0, 0, 1]},
            "offered_ip": {"type": "bytes", "initial": [0, 0, 0, 0]},
            "server_ip": {"type": "bytes", "initial": [0, 0, 0, 0]},
            "netmask": {"type": "bytes", "initial": [255, 255, 255, 0]},
            "gateway": {"type": "bytes", "initial": [0, 0, 0, 0]},
            "dns_ip": {"type": "bytes", "initial": [0, 0, 0, 0]},
        },
        "events": {
            "dhcp.start": {"origin": "application", "fields": {"mac": "bytes", "xid": "int"}},
            "dhcp.rx": {"origin": "network", "fields": {"src_ip": "bytes", "payload": "bytes"}},
            "dhcp.tmr": {"origin": "timer", "fields": {}},
        },
        "messages": {
            "tx_ip": {"fields": {"src_ip": "bytes", "dst_ip": "bytes", "proto": "int", "payload": "bytes"}},
            "lease_assigned": {"fields": {"ip": "bytes", "mask": "bytes", "gw": "bytes", "dns_ip": "bytes"}},
        },
        "timers": {"retry_timer": {"event": "dhcp.tmr"}},
        "transitions": [
            B.rule("DHCP.START", "INIT", "SELECTING", "dhcp.start",
                   B.and_(B.eq_(B.b_len(B.ev("mac")), 6), B.ge_(B.ev("xid"), 1)),
                   [B.act_set("client_mac", B.b_slice(B.ev("mac"), 0, 6)),
                    B.act_set("xid", B.ev("xid")),
                    B.act_set("retries", 0),
                    B.act_arm("retry_timer", 1000),
                    B.act_emit("tx_ip", src_ip=zero4, dst_ip=bcast, proto=17, payload=disc_pkt)],
                   ["CTRL.DHCP"]),
            B.rule("DHCP.OFFER", "SELECTING", "REQUESTING", "dhcp.rx",
                   B.and_(valid_reply, B.eq_(mtype, 2), B.eq_(B.b_len(B.ev("src_ip")), 4)),
                   [B.act_set("offered_ip", yiaddr),
                    *scan_tlv_acts(True),
                    B.act_set("retries", 0),
                    B.act_arm("retry_timer", 1000),
                    B.act_emit("tx_ip", src_ip=zero4, dst_ip=bcast, proto=17, payload=req_pkt)],
                   ["CTRL.DHCP"]),
            B.rule("DHCP.ACK", "REQUESTING", "BOUND", "dhcp.rx",
                   B.and_(valid_reply, B.eq_(mtype, 5)),
                   [B.act_cancel("retry_timer"),
                    B.act_set("offered_ip", yiaddr),
                    *scan_tlv_acts(False),
                    B.act_emit("lease_assigned", ip=B.var("offered_ip"), mask=B.var("netmask"),
                               gw=B.var("gateway"), dns_ip=B.var("dns_ip"))],
                   ["CTRL.DHCP"]),
            B.rule("DHCP.RX_IGNORE_SEL", "SELECTING", "SELECTING", "dhcp.rx",
                   B.not_(B.and_(valid_reply, B.eq_(mtype, 2), B.eq_(B.b_len(B.ev("src_ip")), 4))), [], ["CTRL.DHCP"]),
            B.rule("DHCP.RX_IGNORE_REQ", "REQUESTING", "REQUESTING", "dhcp.rx",
                   B.not_(B.and_(valid_reply, B.eq_(mtype, 5))), [], ["CTRL.DHCP"]),
            B.rule("DHCP.RETRY_SEL", "SELECTING", "SELECTING", "dhcp.tmr", B.lt_(B.var("retries"), 4),
                   [B.act_set("retries", B.add_(B.var("retries"), 1)), B.act_arm("retry_timer", 1000),
                    B.act_emit("tx_ip", src_ip=zero4, dst_ip=bcast, proto=17, payload=retry_disc)], ["CTRL.DHCP"]),
            B.rule("DHCP.RETRY_SEL_FAIL", "SELECTING", "INIT", "dhcp.tmr", B.ge_(B.var("retries"), 4), [], ["CTRL.DHCP"]),
            B.rule("DHCP.RETRY_REQ", "REQUESTING", "REQUESTING", "dhcp.tmr", B.lt_(B.var("retries"), 4),
                   [B.act_set("retries", B.add_(B.var("retries"), 1)), B.act_arm("retry_timer", 1000),
                    B.act_emit("tx_ip", src_ip=zero4, dst_ip=bcast, proto=17, payload=retry_req)], ["CTRL.DHCP"]),
            B.rule("DHCP.RETRY_REQ_FAIL", "REQUESTING", "SELECTING", "dhcp.tmr", B.ge_(B.var("retries"), 4), [], ["CTRL.DHCP"]),
            *[B.rule(f"DHCP.TMR_NOOP_{st}", st, st, "dhcp.tmr", True, [], ["CTRL.DHCP"])
              for st in ("INIT", "BOUND", "RENEWING")],
        ],
        "invariants": [
            B.inv("DHCP.MAC", B.eq_(B.b_len(B.var("client_mac")), 6), ["CTRL.DHCP"]),
            B.inv("DHCP.IPS", B.and_(B.eq_(B.b_len(B.var("offered_ip")), 4), B.eq_(B.b_len(B.var("server_ip")), 4),
                                     B.eq_(B.b_len(B.var("netmask")), 4), B.eq_(B.b_len(B.var("gateway")), 4),
                                     B.eq_(B.b_len(B.var("dns_ip")), 4)), ["CTRL.DHCP"]),
            B.inv("DHCP.RETRIES", B.and_(B.ge_(B.var("retries"), 0), B.le_(B.var("retries"), 4)), ["CTRL.DHCP"]),
        ],
    }


def build_dns_resolver(B):
    reqs = {"CTRL.DNS": {"source": "spec/stack/ctrl-dhcp-dns.md", "interpretation": "RFC 1035 DNS A stub resolver"}}
    msg = B.ev("payload")

    q_end = B.add_(12, B.b_len(B.var("qname_wire")))
    ans_off = B.add_(q_end, 4)  # skip QTYPE(2) + QCLASS(2)
    ans_after_name = B.ite_(B.ge_(B.u8(msg, ans_off), 192), B.add_(ans_off, 2), B.add_(ans_off, B.b_len(B.var("qname_wire"))))
    rr_type = B.u16be(msg, ans_after_name)
    rr_class = B.u16be(msg, B.add_(ans_after_name, 2))
    rr_ttl = B.u32be_int(msg, B.add_(ans_after_name, 4))
    rr_rdlen = B.u16be(msg, B.add_(ans_after_name, 8))
    rr_ip = B.b_slice(msg, B.add_(ans_after_name, 10), 4)

    flags_hi = B.u8(msg, 2)
    flags_lo = B.u8(msg, 3)
    qr = B.ge_(flags_hi, 128)
    rcode = _u8_low_nibble(B, flags_lo)
    ancount = B.u16be(msg, 6)

    valid_ans = B.and_(
        B.ge_(B.b_len(msg), 28),
        qr, B.eq_(rcode, 0), B.ge_(ancount, 1),
        B.eq_(B.u16be(msg, 0), B.var("txid")),
        B.ge_(ans_after_name, 0),
        B.le_(B.add_(ans_after_name, 14), B.b_len(msg)),
        B.eq_(rr_type, 1), B.eq_(rr_class, 1), B.eq_(rr_rdlen, 4),
    )

    query_pkt = B.b_concat(
        B.pack16be(B.var("txid")),
        B.bytes_lit([0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
        B.var("qname_wire"),
        B.bytes_lit([0x00, 0x01, 0x00, 0x01]),
    )
    start_query_pkt = B.b_concat(
        B.pack16be(B.ev("txid")),
        B.bytes_lit([0x01, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00]),
        B.b_slice(B.ev("qname_wire"), 0, 255),
        B.bytes_lit([0x00, 0x01, 0x00, 0x01]),
    )
    udp_q_start = _udp_build_pkt(B, B.b_slice(B.ev("src_ip"), 0, 4), B.b_slice(B.ev("server_ip"), 0, 4),
                                 53001, 53, start_query_pkt)
    udp_q_retry = _udp_build_pkt(B, B.var("src_ip"), B.var("server_ip"), 53001, 53, query_pkt)

    return {
        "ir_version": "0.6",
        "semantics": "flat-efsm-atomic-ordered-v1",
        "protocol": "dns-resolver",
        "scope": {"terminal_states": [], "excluded": ["AAAA", "CNAME recursion"]},
        "states": ["IDLE", "QUERYING", "CACHED"],
        "initial_state": "IDLE",
        "requirements": reqs,
        "variables": {
            "txid": {"type": "int", "initial": 0},
            "retries": {"type": "int", "initial": 0},
            "src_ip": {"type": "bytes", "initial": [0, 0, 0, 0]},
            "server_ip": {"type": "bytes", "initial": [0, 0, 0, 0]},
            "qname_wire": {"type": "bytes", "initial": []},
            "resolved_ip": {"type": "bytes", "initial": [0, 0, 0, 0]},
            "ttl_s": {"type": "int", "initial": 60},
        },
        "events": {
            "dns.resolve": {"origin": "application", "fields": {"src_ip": "bytes", "server_ip": "bytes", "qname_wire": "bytes", "txid": "int"}},
            "dns.rx": {"origin": "network", "fields": {"payload": "bytes"}},
            "dns.retry_tmr": {"origin": "timer", "fields": {}},
            "dns.ttl_tmr": {"origin": "timer", "fields": {}},
        },
        "messages": {
            "tx_ip": {"fields": {"src_ip": "bytes", "dst_ip": "bytes", "proto": "int", "payload": "bytes"}},
            "dns_resolved": {"fields": {"qname_wire": "bytes", "ip": "bytes", "ttl_s": "int"}},
            "dns_failed": {"fields": {"qname_wire": "bytes"}},
        },
        "timers": {
            "retry_timer": {"event": "dns.retry_tmr"},
            "ttl_timer": {"event": "dns.ttl_tmr"},
        },
        "transitions": [
            B.rule("DNS.RESOLVE_IDLE", "IDLE", "QUERYING", "dns.resolve",
                   B.and_(B.eq_(B.b_len(B.ev("src_ip")), 4), B.eq_(B.b_len(B.ev("server_ip")), 4),
                          B.ge_(B.b_len(B.ev("qname_wire")), 2), B.le_(B.b_len(B.ev("qname_wire")), 255),
                          B.ge_(B.ev("txid"), 1), B.le_(B.ev("txid"), 65535)),
                   [B.act_set("src_ip", B.b_slice(B.ev("src_ip"), 0, 4)),
                    B.act_set("server_ip", B.b_slice(B.ev("server_ip"), 0, 4)),
                    B.act_set("qname_wire", B.b_slice(B.ev("qname_wire"), 0, 255)),
                    B.act_set("txid", B.ev("txid")),
                    B.act_set("retries", 0),
                    B.act_arm("retry_timer", 1000),
                    B.act_emit("tx_ip", src_ip=B.b_slice(B.ev("src_ip"), 0, 4), dst_ip=B.b_slice(B.ev("server_ip"), 0, 4),
                               proto=17, payload=udp_q_start)],
                   ["CTRL.DNS"]),
            B.rule("DNS.RX_ANSWER", "QUERYING", "CACHED", "dns.rx", valid_ans,
                   [B.act_cancel("retry_timer"),
                    B.act_set("resolved_ip", rr_ip),
                    B.act_set("ttl_s", B.max_(1, B.min_(86400, rr_ttl))),
                    B.act_arm("ttl_timer", 60000),
                    B.act_emit("dns_resolved", qname_wire=B.var("qname_wire"), ip=rr_ip, ttl_s=B.var("ttl_s"))],
                   ["CTRL.DNS"]),
            B.rule("DNS.RX_BAD", "QUERYING", "QUERYING", "dns.rx", B.not_(valid_ans), [], ["CTRL.DNS"]),
            B.rule("DNS.RETRY", "QUERYING", "QUERYING", "dns.retry_tmr", B.lt_(B.var("retries"), 3),
                   [B.act_set("retries", B.add_(B.var("retries"), 1)), B.act_arm("retry_timer", 1000),
                    B.act_emit("tx_ip", src_ip=B.var("src_ip"), dst_ip=B.var("server_ip"), proto=17, payload=udp_q_retry)],
                   ["CTRL.DNS"]),
            B.rule("DNS.TIMEOUT", "QUERYING", "IDLE", "dns.retry_tmr", B.ge_(B.var("retries"), 3),
                   [B.act_set("retries", 0), B.act_emit("dns_failed", qname_wire=B.var("qname_wire"))],
                   ["CTRL.DNS"]),
            B.rule("DNS.TTL_EXP", "CACHED", "IDLE", "dns.ttl_tmr", True,
                   [B.act_set("resolved_ip", B.bytes_lit([0, 0, 0, 0])), B.act_set("qname_wire", B.bytes_lit([]))],
                   ["CTRL.DNS"]),
            *[B.rule(f"DNS.RETRY_NOOP_{st}", st, st, "dns.retry_tmr", True, [], ["CTRL.DNS"])
              for st in ("IDLE", "CACHED")],
            *[B.rule(f"DNS.TTL_NOOP_{st}", st, st, "dns.ttl_tmr", True, [], ["CTRL.DNS"])
              for st in ("IDLE", "QUERYING")],
        ],
        "invariants": [
            B.inv("DNS.IPS", B.and_(B.eq_(B.b_len(B.var("src_ip")), 4), B.eq_(B.b_len(B.var("server_ip")), 4),
                                    B.eq_(B.b_len(B.var("resolved_ip")), 4), B.le_(B.b_len(B.var("qname_wire")), 255)),
                  ["CTRL.DNS"]),
            B.inv("DNS.RETRIES", B.and_(B.ge_(B.var("retries"), 0), B.le_(B.var("retries"), 3)), ["CTRL.DNS"]),
        ],
    }


def build_system_recipe():
    return {
        "schema": "fsa-system-v1",
        "system_name": "tcpip_stack",
        "bus_queue_cap": 32,
        "bus_byte_cap": 8192,
        "modules": {
            "sys_port": {"model": "arch/sys_port.json", "prefix": "fsa_sys_port", "capacity": 1, "byte_cap": 64, "arena_cap": 1024},
            "frame_pool": {"model": "arch/frame_pool.json", "prefix": "fsa_frame_pool", "capacity": 1, "byte_cap": 64, "arena_cap": 1024},
            "stack_actor": {"model": "arch/stack_actor.json", "prefix": "fsa_stack_actor", "capacity": 1, "byte_cap": 64, "arena_cap": 1024},
            "eth_ipv4_icmp": {"model": "stack/eth_ipv4_icmp.json", "prefix": "fsa_eth_ip", "capacity": 1, "byte_cap": 4608, "arena_cap": 24576},
            "arp_neighbor": {"model": "stack/arp_neighbor.json", "prefix": "fsa_arp", "capacity": 16, "byte_cap": 1536, "arena_cap": 4096, "free_state": "FREE"},
            "ipv4_reass": {"model": "stack/ipv4_reass.json", "prefix": "fsa_reass", "capacity": 4, "byte_cap": 4608, "arena_cap": 16384, "free_state": "IDLE"},
            "udp_endpoint": {"model": "stack/udp_endpoint.json", "prefix": "fsa_udp", "capacity": 16, "byte_cap": 2048, "arena_cap": 8192, "free_state": "UNBOUND"},
            "tcp_connection": {"model": "stack/tcp_connection.json", "prefix": "fsa_tcp", "capacity": 12, "byte_cap": 8192, "arena_cap": 65536, "free_state": "CLOSED"},
            "dhcpv4_client": {"model": "stack/dhcpv4_client.json", "prefix": "fsa_dhcp", "capacity": 1, "byte_cap": 600, "arena_cap": 4096},
            "dns_resolver": {"model": "stack/dns_resolver.json", "prefix": "fsa_dns", "capacity": 4, "byte_cap": 512, "arena_cap": 4096, "free_state": "IDLE"},
        },
        "architecture_hooks": {
            "port": "sys_port",
            "port_start_ev": "port.start",
            "port_stop_ev": "port.stop",
            "actor": "stack_actor",
            "actor_start_ev": "actor.start",
            "actor_stop_ev": "actor.stop",
            "actor_post_rx_ev": "actor.post_rx",
            "actor_post_api_ev": "actor.post_api",
            "actor_dispatch_ev": "actor.dispatch",
            "actor_complete_ev": "actor.complete",
        },
        "host_outputs": [
            "WIRE_TX",
            "TCP_ACCEPTED",
            "TCP_CONNECTED",
            "TCP_RX_DATA",
            "TCP_PEER_EOF",
            "TCP_CLOSED",
            "UDP_RX",
            "DHCP_BOUND",
            "DNS_RESOLVED",
            "DNS_FAILED",
        ],
        "routes": {
            "eth_ipv4_icmp.wire_tx": {"kind": "host_out", "out_id": "WIRE_TX"},
            "arp_neighbor.wire_tx": {"kind": "host_out", "out_id": "WIRE_TX"},
            "eth_ipv4_icmp.arp_learn": {
                "kind": "upsert",
                "target": "arp_neighbor",
                "match_vars": [{"var": "ip", "from_field": "ip"}],
                "event": "arp.learn",
                "args": [{"from_field": "ip"}, {"from_field": "mac"}],
            },
            "eth_ipv4_icmp.arp_send": {
                "kind": "upsert",
                "target": "arp_neighbor",
                "match_vars": [{"var": "ip", "from_field": "ip"}],
                "event": "arp.resolve_tx",
                "args": [
                    {"from_field": "ip"},
                    {"from_field": "src_mac"},
                    {"from_field": "src_ip"},
                    {"from_field": "pkt"},
                ],
            },
            "eth_ipv4_icmp.frag_in": {
                "kind": "upsert",
                "target": "ipv4_reass",
                "match_vars": [
                    {"var": "src_ip", "from_field": "src_ip"},
                    {"var": "dst_ip", "from_field": "dst_ip"},
                    {"var": "ip_id", "from_field": "ip_id"},
                    {"var": "proto", "from_field": "proto"},
                ],
                "event": "reass.frag",
                "args": [
                    {"from_field": "src_ip"}, {"from_field": "dst_ip"},
                    {"from_field": "ip_id"}, {"from_field": "proto"},
                    {"from_field": "frag_off"}, {"from_field": "mf"},
                    {"from_field": "hdr"}, {"from_field": "payload"},
                ],
            },
            "ipv4_reass.reassembled": {
                "kind": "singleton",
                "target": "eth_ipv4_icmp",
                "event": "l3.reassembled",
                "args": [
                    {"from_field": "src_ip"}, {"from_field": "dst_ip"},
                    {"from_field": "proto"}, {"from_field": "payload"},
                    {"from_field": "orig_hdr"},
                ],
            },
            "eth_ipv4_icmp.udp_rx": {
                "kind": "lookup_chain",
                "attempts": [
                    {
                        "kind": "match",
                        "target": "udp_endpoint",
                        "in_states": ["CONNECTED"],
                        "match_vars": [
                            {"var": "local_port", "from_field": "dst_port"},
                            {"var": "remote_port", "from_field": "src_port"},
                            {"var": "remote_ip", "from_field": "src_ip"},
                            {"var": "local_ip", "from_field": "dst_ip", "wildcard_empty_or_zero": True},
                        ],
                        "event": "udp.rx",
                        "args": [
                            {"from_field": "src_ip"}, {"from_field": "dst_ip"},
                            {"from_field": "src_port"}, {"from_field": "dst_port"},
                            {"from_field": "data"},
                        ],
                    },
                    {
                        "kind": "match",
                        "target": "udp_endpoint",
                        "in_states": ["BOUND"],
                        "match_vars": [
                            {"var": "local_port", "from_field": "dst_port"},
                            {"var": "local_ip", "from_field": "dst_ip", "wildcard_empty_or_zero": True},
                        ],
                        "event": "udp.rx",
                        "args": [
                            {"from_field": "src_ip"}, {"from_field": "dst_ip"},
                            {"from_field": "src_port"}, {"from_field": "dst_port"},
                            {"from_field": "data"},
                        ],
                    },
                    {
                        "kind": "match",
                        "target": "dhcpv4_client",
                        "in_states": ["SELECTING", "REQUESTING"],
                        "when_field_eq": [{"field": "dst_port", "int": 68}],
                        "match_vars": [],
                        "event": "dhcp.rx",
                        "args": [{"from_field": "src_ip"}, {"from_field": "data"}],
                    },
                    {
                        "kind": "match",
                        "target": "dns_resolver",
                        "in_states": ["QUERYING"],
                        "when_field_eq": [{"field": "src_port", "int": 53}],
                        "match_vars": [],
                        "event": "dns.rx",
                        "args": [{"from_field": "data"}],
                    },
                ],
                "on_miss": {
                    "kind": "singleton",
                    "target": "eth_ipv4_icmp",
                    "event": "l3.send_icmp_unreach",
                    "args": [
                        {"from_field": "src_ip"},
                        {"from_field": "dst_ip"},
                        {"from_field": "orig_prefix"},
                    ],
                },
            },
            "eth_ipv4_icmp.tcp_rx": {
                "kind": "lookup_chain",
                "attempts": [
                    {
                        "kind": "match",
                        "target": "tcp_connection",
                        "not_in_states": ["CLOSED", "LISTEN"],
                        "match_vars": [
                            {"var": "local_port", "from_field": "dst_port"},
                            {"var": "remote_port", "from_field": "src_port"},
                            {"var": "remote_ip", "from_field": "src_ip"},
                            {"var": "local_ip", "from_field": "dst_ip", "wildcard_empty_or_zero": True},
                        ],
                        "event": "net.seg",
                        "args": [
                            {"from_field": "src_ip"}, {"from_field": "dst_ip"},
                            {"from_field": "src_port"}, {"from_field": "dst_port"},
                            {"from_field": "seq"}, {"from_field": "ack"},
                            {"from_field": "is_fin"}, {"from_field": "is_syn"},
                            {"from_field": "is_rst"}, {"from_field": "is_ack"},
                            {"from_field": "wnd"}, {"from_field": "mss"}, {"from_field": "data"},
                        ],
                    },
                    {
                        "kind": "fork_from_match",
                        "target": "tcp_connection",
                        "in_states": ["LISTEN"],
                        "when_field_eq": [
                            {"field": "is_syn", "bool": True},
                            {"field": "is_ack", "bool": False},
                            {"field": "is_rst", "bool": False},
                        ],
                        "match_vars": [
                            {"var": "local_port", "from_field": "dst_port"},
                            {"var": "local_ip", "from_field": "dst_ip", "wildcard_empty_or_zero": True},
                        ],
                        "copy_vars": ["local_ip", "local_port"],
                        "parent_slot_var": "parent_slot",
                        "event": "net.listen_syn",
                        "args": [
                            {"from_field": "src_ip"}, {"from_field": "dst_ip"},
                            {"from_field": "src_port"}, {"from_field": "dst_port"},
                            {"from_field": "seq"}, {"from_field": "ack"},
                            {"from_field": "is_fin"}, {"from_field": "is_syn"},
                            {"from_field": "is_rst"}, {"from_field": "is_ack"},
                            {"from_field": "wnd"}, {"from_field": "mss"}, {"from_field": "data"},
                        ],
                    },
                ],
                "on_miss": {
                    "kind": "singleton",
                    "target": "eth_ipv4_icmp",
                    "when_field_eq": [{"field": "is_rst", "bool": False}],
                    "event": "l3.send_tcp_rst",
                    "args": [
                        {"from_field": "src_ip"}, {"from_field": "dst_ip"},
                        {"from_field": "src_port"}, {"from_field": "dst_port"},
                        {"from_field": "seq"}, {"from_field": "ack"},
                        {"from_field": "is_ack"}, {"int": 1},
                    ],
                },
            },
            "udp_endpoint.tx_ip": {
                "kind": "singleton",
                "target": "eth_ipv4_icmp",
                "event": "l3.tx_ip",
                "args": [{"from_field": "src_ip"}, {"from_field": "dst_ip"}, {"from_field": "proto"}, {"from_field": "payload"}],
            },
            "tcp_connection.tx_ip": {
                "kind": "singleton",
                "target": "eth_ipv4_icmp",
                "event": "l3.tx_ip",
                "args": [{"from_field": "src_ip"}, {"from_field": "dst_ip"}, {"from_field": "proto"}, {"from_field": "payload"}],
            },
            "dhcpv4_client.tx_ip": {
                "kind": "singleton",
                "target": "eth_ipv4_icmp",
                "event": "l3.tx_ip",
                "args": [{"from_field": "src_ip"}, {"from_field": "dst_ip"}, {"from_field": "proto"}, {"from_field": "payload"}],
            },
            "dns_resolver.tx_ip": {
                "kind": "singleton",
                "target": "eth_ipv4_icmp",
                "event": "l3.tx_ip",
                "args": [{"from_field": "src_ip"}, {"from_field": "dst_ip"}, {"from_field": "proto"}, {"from_field": "payload"}],
            },
            "dhcpv4_client.lease_assigned": [
                {
                    "kind": "singleton",
                    "target": "eth_ipv4_icmp",
                    "event": "cfg.set_ip",
                    "args": [{"from_field": "ip"}, {"from_field": "mask"}, {"from_field": "gw"}, {"from_field": "dns_ip"}],
                },
                {"kind": "host_out", "out_id": "DHCP_BOUND"},
            ],
            "udp_endpoint.app_rx": {"kind": "host_out", "out_id": "UDP_RX"},
            "tcp_connection.accepted": {"kind": "host_out", "out_id": "TCP_ACCEPTED"},
            "tcp_connection.connected": {"kind": "host_out", "out_id": "TCP_CONNECTED"},
            "tcp_connection.tcp_rx_data": {"kind": "host_out", "out_id": "TCP_RX_DATA"},
            "tcp_connection.peer_eof": {"kind": "host_out", "out_id": "TCP_PEER_EOF"},
            "tcp_connection.closed": {"kind": "host_out", "out_id": "TCP_CLOSED"},
            "dns_resolver.dns_resolved": {"kind": "host_out", "out_id": "DNS_RESOLVED"},
            "dns_resolver.dns_failed": {"kind": "host_out", "out_id": "DNS_FAILED"},
        },
        "entrypoints": [
            {
                "name": "init_if",
                "target": "eth_ipv4_icmp",
                "slot_mode": "singleton",
                "event": "cfg.init_if",
                "params": [
                    {"name": "ip", "type": "bytes"},
                    {"name": "mask", "type": "bytes"},
                    {"name": "gw", "type": "bytes"},
                    {"name": "mac", "type": "bytes"},
                    {"name": "mtu", "type": "int"},
                ],
                "is_api": True,
            },
            {
                "name": "rx_frame",
                "target": "eth_ipv4_icmp",
                "slot_mode": "singleton",
                "event": "net.rx_frame",
                "params": [{"name": "frame", "type": "bytes"}],
                "is_rx": True,
            },
            {
                "name": "tx_ip",
                "target": "eth_ipv4_icmp",
                "slot_mode": "singleton",
                "event": "l3.tx_ip",
                "params": [
                    {"name": "src_ip", "type": "bytes"},
                    {"name": "dst_ip", "type": "bytes"},
                    {"name": "proto", "type": "int"},
                    {"name": "payload", "type": "bytes"},
                ],
                "is_api": True,
            },
            {
                "name": "udp_bind",
                "target": "udp_endpoint",
                "slot_mode": "slot_arg",
                "event": "app.bind",
                "params": [{"name": "local_ip", "type": "bytes"}, {"name": "local_port", "type": "int"}],
                "is_api": True,
            },
            {
                "name": "udp_connect",
                "target": "udp_endpoint",
                "slot_mode": "slot_arg",
                "event": "app.connect",
                "params": [{"name": "remote_ip", "type": "bytes"}, {"name": "remote_port", "type": "int"}],
                "is_api": True,
            },
            {
                "name": "udp_sendto",
                "target": "udp_endpoint",
                "slot_mode": "slot_arg",
                "event": "app.sendto",
                "params": [
                    {"name": "src_ip", "type": "bytes"},
                    {"name": "dst_ip", "type": "bytes"},
                    {"name": "dst_port", "type": "int"},
                    {"name": "data", "type": "bytes"},
                ],
                "is_api": True,
            },
            {
                "name": "udp_send",
                "target": "udp_endpoint",
                "slot_mode": "slot_arg",
                "event": "app.send",
                "params": [{"name": "src_ip", "type": "bytes"}, {"name": "data", "type": "bytes"}],
                "is_api": True,
            },
            {
                "name": "udp_close",
                "target": "udp_endpoint",
                "slot_mode": "slot_arg",
                "event": "app.close",
                "params": [],
                "is_api": True,
            },
            {
                "name": "tcp_listen",
                "target": "tcp_connection",
                "slot_mode": "slot_arg",
                "event": "app.listen",
                "params": [{"name": "local_ip", "type": "bytes"}, {"name": "local_port", "type": "int"}],
                "is_api": True,
            },
            {
                "name": "tcp_connect",
                "target": "tcp_connection",
                "slot_mode": "slot_arg",
                "event": "app.connect",
                "params": [
                    {"name": "local_ip", "type": "bytes"},
                    {"name": "local_port", "type": "int"},
                    {"name": "remote_ip", "type": "bytes"},
                    {"name": "remote_port", "type": "int"},
                    {"name": "iss", "type": "seq32"},
                ],
                "is_api": True,
            },
            {
                "name": "tcp_send",
                "target": "tcp_connection",
                "slot_mode": "slot_arg",
                "event": "app.send",
                "params": [{"name": "data", "type": "bytes"}],
                "is_api": True,
            },
            {
                "name": "tcp_pump",
                "target": "tcp_connection",
                "slot_mode": "slot_arg",
                "event": "app.pump",
                "params": [],
                "is_api": True,
            },
            {
                "name": "tcp_recved",
                "target": "tcp_connection",
                "slot_mode": "slot_arg",
                "event": "app.recved",
                "params": [{"name": "len", "type": "int"}],
                "is_api": True,
            },
            {
                "name": "tcp_close",
                "target": "tcp_connection",
                "slot_mode": "slot_arg",
                "event": "app.close",
                "params": [],
                "is_api": True,
            },
            {
                "name": "tcp_abort",
                "target": "tcp_connection",
                "slot_mode": "slot_arg",
                "event": "app.abort",
                "params": [],
                "is_api": True,
            },
            {
                "name": "dhcp_start",
                "target": "dhcpv4_client",
                "slot_mode": "singleton",
                "event": "dhcp.start",
                "params": [{"name": "mac", "type": "bytes"}, {"name": "xid", "type": "int"}],
                "is_api": True,
            },
            {
                "name": "dns_resolve",
                "target": "dns_resolver",
                "slot_mode": "slot_arg",
                "event": "dns.resolve",
                "params": [
                    {"name": "src_ip", "type": "bytes"},
                    {"name": "server_ip", "type": "bytes"},
                    {"name": "qname_wire", "type": "bytes"},
                    {"name": "txid", "type": "int"},
                ],
                "is_api": True,
            },
            {
                "name": "pool_alloc",
                "target": "frame_pool",
                "slot_mode": "singleton",
                "event": "pool.alloc",
                "params": [],
                "is_api": False,
            },
            {
                "name": "pool_free",
                "target": "frame_pool",
                "slot_mode": "singleton",
                "event": "pool.free",
                "params": [],
                "is_api": False,
            },
            {
                "name": "pool_reset",
                "target": "frame_pool",
                "slot_mode": "singleton",
                "event": "pool.reset",
                "params": [],
                "is_api": False,
            },
            *[
                {
                    "name": ep_n,
                    "target": "sys_port",
                    "slot_mode": "singleton",
                    "event": ev_n,
                    "params": [],
                    "is_api": False,
                }
                for ep_n, ev_n in (
                    ("port_sem_alloc", "port.sem_alloc"),
                    ("port_sem_free", "port.sem_free"),
                    ("port_mbox_alloc", "port.mbox_alloc"),
                    ("port_mbox_free", "port.mbox_free"),
                    ("port_thread_spawn", "port.thread_spawn"),
                    ("port_thread_join", "port.thread_join"),
                )
            ],
        ],
    }


def main():
    fw = Path(sys.argv[1]) if len(sys.argv) > 1 else DEFAULT_FRAMEWORK
    B = _load_builder(fw)

    outputs = [
        (ROOT / "model/arch/sys_port.json", build_sys_port(B)),
        (ROOT / "model/arch/frame_pool.json", build_frame_pool(B)),
        (ROOT / "model/arch/stack_actor.json", build_stack_actor(B)),
        (ROOT / "model/stack/arp_neighbor.json", build_arp_neighbor(B)),
        (ROOT / "model/stack/ipv4_reass.json", build_ipv4_reass(B)),
        (ROOT / "model/stack/eth_ipv4_icmp.json", build_eth_ipv4_icmp(B)),
        (ROOT / "model/stack/udp_endpoint.json", build_udp_endpoint(B)),
        (ROOT / "model/stack/tcp_connection.json", build_tcp_connection(B)),
        (ROOT / "model/stack/dhcpv4_client.json", build_dhcpv4_client(B)),
        (ROOT / "model/stack/dns_resolver.json", build_dns_resolver(B)),
    ]
    for path, mod in outputs:
        B.validate_and_dump(mod, path)
        print(f"OK IR: {path.relative_to(ROOT)} (rules={len(mod['transitions'])}, states={len(mod['states'])})")

    recipe_path = ROOT / "model/tcpip-stack-system.json"
    recipe_path.write_text(json.dumps(build_system_recipe(), indent=2) + "\n", encoding="utf-8")
    print(f"OK SYSTEM: {recipe_path.relative_to(ROOT)}")


if __name__ == "__main__":
    main()
