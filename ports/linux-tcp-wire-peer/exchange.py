"""Bounded TCP exchange driver between an existing generated-C Session and an
already-started independent ordinary Linux TCP peer over an already-isolated
TUN fd. This module owns no namespaces, TUN setup, capture, or peer lifecycle;
the trusted outer harness keeps those resources live for quiet capture after
this returns. No subprocess, no packet synthesis, no ACK/seq decisions.
"""
import json
import os
import select
import time
from pathlib import Path
from protocol_lab.codegen.execute import commands

SELECTED_PROTO = 6
SUCCESS_STATES = ("TIME-WAIT", "CLOSED")


def _ms(origin_ns, now_ns=None):
    return ((now_ns if now_ns is not None else time.monotonic_ns()) - origin_ns) // 1000000


def _timers(snap, fail):
    """Return [(name, due_ms)] sorted; exact schema name -> int due_ms."""
    timers = (snap or {}).get("timers") or {}
    if not isinstance(timers, dict):
        fail("backend_or_input_failure", "timer schema not mapping")
    out = []
    for name, due in timers.items():
        if isinstance(due, bool) or not isinstance(due, int):
            fail("backend_or_input_failure", "timer value not int: " + str(name))
        out.append((name, due))
    out.sort(key=lambda p: (p[1], p[0]))
    return out


def _emit(rows, fail):
    packets, services = [], []
    for row in rows or []:
        for ev in (row or {}).get("emitted") or []:
            msg = ev.get("message")
            fields = ev.get("fields") or {}
            if msg == "ipv4.tx":
                if set(fields) != {"packet"}:
                    fail("backend_or_input_failure", "ipv4.tx schema")
                packets.append(bytes(fields["packet"]))
            elif msg == "application_data":
                if set(fields) != {"data"}:
                    fail("backend_or_input_failure", "application_data schema")
                services.append(dict(message=msg, data=list(fields["data"])))
            elif msg == "application":
                if set(fields) != {"code"}:
                    fail("backend_or_input_failure", "application schema")
                services.append(dict(message=msg, code=fields["code"]))
            else:
                fail("backend_or_input_failure", "unknown_native_message:" + str(msg))
    return packets, services


def _classify(failure):
    text = str(failure)
    if text == "uncovered_event" or "uncovered" in text:
        return "model_gap"
    if "conflict" in text:
        return "rule_conflict"
    if text.startswith("invariant:"):
        return "invariant_failure"
    return "backend_or_input_failure"


def run_exchange(model, actor, fd, peer, out, config):
    out = Path(out)
    out.mkdir(parents=True, exist_ok=True)
    phase_timeout = float(config["phase_timeout_seconds"])
    payload = bytes.fromhex(config["payload_hex"])
    origin_ns = time.monotonic_ns()
    steps = []
    scene = {"scenario_version": "0.2", "id": "linux-tcp-wire", "initial": {}, "steps": steps}
    links, services = [], []
    receipts = {"origin_monotonic_ns": origin_ns, "phases": {}, "dispatches": []}
    state = {"last_ms": 0}

    def save_evidence(kind, reason):
        (out / "evidence.json").write_text(json.dumps(dict(
            kind=kind, reason=str(reason), scene=scene, links=links,
            services=services, receipts=receipts,
            final_snapshot=actor.snapshot), indent=2) + "\n")

    def fail(kind, reason):
        save_evidence(kind, reason)
        raise RuntimeError(kind + ": " + str(reason))

    def check_alive():
        if actor.process.poll() is not None:
            fail("backend_or_input_failure", "subject exited")
        if peer.poll() is not None:
            fail("backend_or_input_failure", "peer exited")

    def dispatch(step):
        at = int(step["at_ms"])
        if at < state["last_ms"]:
            fail("backend_or_input_failure", "monotonic clock reversed")
        # Record boundary and step BEFORE issuing the native operation.
        steps.append(step)
        row_start = len(actor.rows)
        sampled = time.monotonic_ns()
        receipt = dict(at_ms=at, pid=actor.process.pid, sampled_monotonic_ns=sampled,
                       row_start=row_start, step=step)
        try:
            line = commands(model, {"initial": {}, "steps": [step]}).splitlines()[1]
        except Exception as error:
            receipt["raised"] = "commands:" + str(error)
            receipts["dispatches"].append(receipt)
            save_evidence("backend_or_input_failure", error)
            raise
        receipt["line"] = line
        try:
            rows = actor.operation(line)
        except Exception as error:
            receipt["row_end"] = len(actor.rows)
            receipt["reply_monotonic_ns"] = time.monotonic_ns()
            receipt["raised"] = str(error)
            receipts["dispatches"].append(receipt)
            save_evidence("backend_or_input_failure", error)
            raise
        receipt["row_end"] = len(actor.rows)
        receipt["reply_monotonic_ns"] = time.monotonic_ns()
        receipts["dispatches"].append(receipt)
        state["last_ms"] = at
        last = rows[-1] if rows else {}
        if last.get("status") == "error":
            fail(_classify(last.get("failure")), last.get("failure"))
        packets, svc = _emit(rows, fail)
        for s in svc:
            s["at_ms"] = at
            services.append(s)
        for raw in packets:
            name = "link-%d.raw" % len(links)
            try:
                (out / name).write_bytes(raw)
            except OSError as error:
                fail("backend_or_input_failure", error)
            entry = dict(direction="subject_tx", file=name, at_ms=at,
                         intended_bytes=len(raw), monotonic_ns=time.monotonic_ns())
            try:
                written = os.write(fd, raw)
            except OSError as error:
                entry["written_bytes"] = None
                links.append(entry)
                fail("backend_or_input_failure", "tun_write:" + str(error))
            entry["written_bytes"] = written
            links.append(entry)
            if written != len(raw):
                fail("backend_or_input_failure", "partial TUN write")
        return actor.snapshot or {}

    def pump_once(deadline_s):
        """Dispatch one due timer or one ready packet if any; else return None."""
        check_alive()
        now = time.monotonic()
        if now >= deadline_s:
            return None
        snap = actor.snapshot or {}
        now_ms = _ms(origin_ns)
        due = [(n, d) for (n, d) in _timers(snap, fail) if d <= now_ms]
        if due:
            name, due_ms = due[0]
            step = {"tick": True, "at_ms": now_ms}
            receipt_at = dispatch(step)
            receipts.setdefault("ticks", []).append(dict(timer=name, due_ms=due_ms,
                tick_at_ms=now_ms, snapshot_state=receipt_at.get("state")))
            return receipt_at
        ready = select.select([fd], [], [], min(0.01, deadline_s - now))[0]
        if not ready:
            return None
        raw = os.read(fd, 65535)
        if not raw:
            return None
        ver = raw[0] >> 4
        proto = raw[9] if ver == 4 and len(raw) >= 20 else None
        if ver != 4 or proto != SELECTED_PROTO:
            name = "unselected-%d.raw" % len(links)
            try:
                (out / name).write_bytes(raw)
            except OSError as error:
                fail("backend_or_input_failure", error)
            links.append(dict(direction="unselected", file=name,
                              reason="outside_selected_ipv4_tcp",
                              length=len(raw), monotonic_ns=time.monotonic_ns()))
            return None
        name = "link-%d.raw" % len(links)
        try:
            (out / name).write_bytes(raw)
        except OSError as error:
            fail("backend_or_input_failure", error)
        sample_ms = _ms(origin_ns)
        links.append(dict(direction="peer_tx", file=name, at_ms=sample_ms,
                          length=len(raw), monotonic_ns=time.monotonic_ns()))
        return dispatch({"at_ms": sample_ms, "event": "net.packet",
                         "fields": {"packet": list(raw)}})

    def pump_until(deadline_s, predicate):
        while True:
            snap = actor.snapshot or {}
            if predicate(snap):
                return snap
            if time.monotonic() >= deadline_s:
                fail("backend_or_input_failure", "phase timeout")
            pump_once(deadline_s)

    # Phase 1: connect and wait ESTABLISHED.
    receipts["phases"]["connect"] = time.monotonic() + phase_timeout
    dispatch({"at_ms": _ms(origin_ns), "event": "app.connect", "fields": {}})
    pump_until(receipts["phases"]["connect"],
               lambda s: s.get("state") == "ESTABLISHED")

    # Phase 2: buffer payload then explicitly transmit (no send phase wait).
    dispatch({"at_ms": _ms(origin_ns), "event": "app.send",
              "fields": {"data": list(payload)}})
    dispatch({"at_ms": _ms(origin_ns), "event": "app.transmit", "fields": {}})

    # Phase 3: drain echoed bytes via app.receive and collect application_data
    # service emissions exactly once. Send-drained readiness is snd_buf empty
    # and snd_una == snd_nxt (no seq arithmetic).
    receipts["phases"]["drain"] = time.monotonic() + phase_timeout
    echo = bytearray()
    observed = 0
    while time.monotonic() < receipts["phases"]["drain"]:
        snap = actor.snapshot or {}
        variables = snap.get("variables") or {}
        rcv = list(variables.get("rcv_buf") or [])
        drained = (not variables.get("snd_buf")) and \
            variables.get("snd_una") == variables.get("snd_nxt")
        for svc in services[observed:]:
            if svc.get("message") == "application_data":
                echo.extend(svc["data"])
        observed = len(services)
        if drained and len(echo) >= len(payload):
            break
        if rcv:
            dispatch({"at_ms": _ms(origin_ns), "event": "app.receive",
                      "fields": {"count": len(rcv)}})
            continue
        if pump_once(receipts["phases"]["drain"]) is None:
            time.sleep(0.001)
    if bytes(echo) != payload:
        fail("backend_or_input_failure", "echo mismatch: got " + bytes(echo).hex())

    # Phase 4: orderly active close; wait observed terminal state without
    # pretending the MSL time_wait timer (60000ms) expired.
    receipts["phases"]["close"] = time.monotonic() + phase_timeout
    dispatch({"at_ms": _ms(origin_ns), "event": "app.close", "fields": {}})
    final = pump_until(receipts["phases"]["close"],
                       lambda s: s.get("state") in SUCCESS_STATES)
    receipts["final_snapshot"] = final
    receipts["pending_timers"] = _timers(final, fail)
    receipts["time_wait_awaited"] = False

    result = dict(
        phase="complete",
        steps=steps,
        step_count=len(steps),
        links=links,
        services=services,
        clock=receipts,
        origin_monotonic_ns=origin_ns,
        final_state=final.get("state"),
        time_wait_awaited=False,
    )
    (out / "exchange.json").write_text(json.dumps(result, indent=2) + "\n")
    return result
