import copy
import importlib.util
from pathlib import Path
import tempfile
import unittest

from protocol_lab.flow import ROOT, read, run_scenario
from protocol_lab.ir import Machine, ModelError, Uncovered, load
from protocol_lab.profiles import control_packets, graph, run_profile, run_suite, verify_suite
from protocol_lab.symbolic import Encoding, check, replay


def established():
    m = Machine(load(ROOT / "model/tcp-connection.json"))
    m.dispatch("app.connect", time_ms=0)
    m.dispatch("net.synack", {"seq":9000,"ack":1001}, 10)
    return m


class ConnectionTests(unittest.TestCase):
    def setUp(self):
        self.model = load(ROOT / "model/tcp-connection.json")

    def test_all_named_scenarios_reach_expected_state_and_cover_all_states(self):
        seen = {"CLOSED"}
        paths = list((ROOT / "scenarios/connection").glob("*.json"))
        self.assertGreaterEqual(len(paths), 29)
        for path in paths:
            with self.subTest(scenario=path.stem):
                m = run_scenario(self.model, read(path))
                for row in m.trace:
                    seen.add(row["before"]["state"])
                    seen.add(row["after"]["state"])
        self.assertEqual(seen, set(self.model["states"]))

    def test_fin_retransmission_never_consumes_extra_sequence_space(self):
        m = established()
        m.dispatch("app.close", time_ms=20)
        m.tick(1020)
        m.tick(3020)
        packets = [p for row in m.trace for p in row["emitted"] if p["message"] == "tcp" and p["fields"]["flags"] == "FA"]
        self.assertEqual([p["fields"]["seq"] for p in packets], [1001,1001,1001])
        self.assertEqual(m.values["snd_nxt"], 1002)
        self.assertEqual(m.state, "FIN-WAIT-1")

    def test_syn_timeout_changes_only_small_post_handshake_rto(self):
        for arrival, rto in ((10,1000),(1010,3000),(3010,4000),(7010,8000)):
            with self.subTest(arrival=arrival):
                m = Machine(self.model)
                m.dispatch("app.connect")
                m.dispatch("net.synack", {"seq":9000,"ack":1001}, arrival)
                self.assertEqual(m.values["rto_ms"], rto)

    def test_synack_retry_repeats_flags_and_original_sequence(self):
        m = Machine(self.model)
        m.dispatch("app.listen")
        m.dispatch("net.syn", {"seq":9000}, 10)
        m.tick(1010)
        first, second = [p["fields"] for row in m.trace for p in row["emitted"] if p["message"] == "tcp"]
        self.assertEqual(first, second)
        self.assertEqual(first["flags"], "SA")

    def test_simultaneous_open_remembers_origin_for_reset(self):
        for active in (False,True):
            m = Machine(self.model)
            m.dispatch("app.connect" if active else "app.listen")
            m.dispatch("net.syn", {"seq":9000}, 10)
            m.dispatch("net.rst", {"seq":9001}, 20)
            self.assertEqual(m.state, "CLOSED" if active else "LISTEN")
            self.assertEqual(m.timers, {})

    def test_unvalidated_reset_is_not_accepted(self):
        m = established()
        before = m.snapshot()
        with self.assertRaises(Uncovered):
            m.dispatch("net.rst", {"seq":9002}, 20)
        self.assertEqual(m.snapshot(), before)

    def test_ack_before_syn_does_not_establish(self):
        m = Machine(self.model)
        m.dispatch("app.connect")
        m.dispatch("net.ack", {"seq":77,"ack":1001}, 10)
        self.assertEqual(m.state,"SYN-SENT")
        self.assertEqual(m.timers,{"rtx":1000,"user":30000})

    def test_invalid_synack_sends_reset_without_consuming_valid_attempt(self):
        m = Machine(self.model)
        m.dispatch("app.connect")
        m.dispatch("net.synack", {"seq":9000,"ack":2000}, 10)
        self.assertEqual(m.state,"SYN-SENT")
        self.assertEqual(m.trace[-1]["emitted"][0]["fields"], {"flags":"R","seq":2000,"ack":0,"window":65535})
        m.dispatch("net.synack", {"seq":9000,"ack":1001}, 20)
        self.assertEqual(m.state,"ESTABLISHED")

    def test_time_wait_duplicate_fin_restarts_deadline(self):
        m = established()
        m.dispatch("app.close",time_ms=20)
        m.dispatch("net.fin",{"seq":9001,"ack":1002},30)
        self.assertEqual(m.timers,{"time_wait":120030})
        m.dispatch("net.fin",{"seq":9001,"ack":1002},1000)
        m.tick(120030)
        self.assertEqual(m.state,"TIME-WAIT")
        self.assertEqual(m.values["rcv_nxt"],9002)
        m.tick(121000)
        self.assertEqual(m.state,"CLOSED")

    def test_ack_only_does_not_trigger_ack_loop(self):
        m = established()
        m.dispatch("net.ack",{"seq":9001,"ack":1001},20)
        self.assertEqual(m.trace[-1]["emitted"],[])

    def test_repeated_close_does_not_send_second_fin(self):
        m = established()
        m.dispatch("app.close",time_ms=20)
        m.dispatch("app.close",time_ms=30)
        self.assertFalse(any(p["message"]=="tcp" for p in m.trace[-1]["emitted"]))
        self.assertEqual(m.values["snd_nxt"],1002)

    def test_user_timeout_cancels_retransmissions_and_late_ack_cannot_reopen(self):
        m = Machine(self.model)
        m.dispatch("app.connect")
        m.tick(30000)
        count = len(m.trace)
        m.tick(1000000)
        self.assertEqual(len(m.trace),count)
        self.assertEqual(m.timers,{})
        m.dispatch("net.ack",{"seq":9001,"ack":1001},1000010)
        self.assertEqual(m.state,"CLOSED")
        self.assertEqual(m.trace[-1]["emitted"][0]["fields"]["flags"],"R")

    def test_closed_syn_reset_ack_wraps(self):
        m = Machine(self.model)
        m.dispatch("net.syn",{"seq":4294967295})
        self.assertEqual(m.trace[-1]["emitted"][0]["fields"],{"flags":"RA","seq":0,"ack":0,"window":65535})

    def test_abort_rst_is_state_dependent(self):
        m = established()
        m.dispatch("app.abort",time_ms=20)
        self.assertEqual(m.trace[-1]["emitted"][0]["fields"]["flags"],"R")
        m = Machine(self.model)
        m.dispatch("app.connect")
        m.dispatch("app.abort",time_ms=20)
        self.assertFalse(any(p["message"]=="tcp" for p in m.trace[-1]["emitted"]))

    def test_application_observations_remain_in_trace_but_not_pcap(self):
        m = established()
        self.assertTrue(any(p["message"]=="application" and p["fields"]["code"]=="connected" for p in m.trace[-1]["emitted"]))
        packets = control_packets(m,{"environment":{"drop_outgoing":[]}})
        self.assertEqual([p["flags"] for p in packets],["S","SA","A"])

    def test_close_before_handshake_completion_is_explicitly_uncovered(self):
        m = Machine(self.model)
        m.dispatch("app.listen")
        m.dispatch("net.syn",{"seq":9000},10)
        with self.assertRaises(Uncovered):
            m.dispatch("app.close",time_ms=20)

    def test_dot_graph_contains_every_transition(self):
        dot = graph(self.model)
        for rule in self.model["transitions"]:
            self.assertIn(rule["id"],dot)
        self.assertEqual(dot.count(" -> "),len(self.model["transitions"]))

    def test_profile_report_does_not_claim_full_protocol(self):
        profile = read(ROOT/"profiles.json")["profiles"][1]
        with tempfile.TemporaryDirectory() as tmp:
            report = run_profile(profile,tmp)
            self.assertEqual(report["unvisited_states"],[])
            self.assertFalse(report["protocol_complete"])
            self.assertEqual(report["formal"]["status"],"not_run")
            self.assertEqual(report["uncovered_transitions"], [])
            for scenario in report["scenarios"]:
                self.assertEqual(scenario["packetdrill"],"unavailable_for_profile")

    def test_suite_reuses_both_models_and_lists_remaining_modules(self):
        with tempfile.TemporaryDirectory() as tmp:
            report = run_suite(tmp)
            self.assertEqual(len(report["implemented_profiles"]),len(read(ROOT/"profiles.json")["profiles"]))
            self.assertFalse(report["full_stack_complete"])
            self.assertTrue(any(m["id"]=="ipv4" for m in report["pending_modules"]))

    def test_suite_integrity_detects_tampered_trace(self):
        with tempfile.TemporaryDirectory() as tmp:
            run_suite(tmp)
            self.assertFalse(verify_suite(tmp)["full_stack_complete"])
            path = Path(tmp)/"tcp-connection/active-close/trace.json"
            path.write_text("[]\n")
            with self.assertRaisesRegex(ModelError, "artifact changed"):
                verify_suite(tmp)

    @unittest.skipUnless(importlib.util.find_spec("z3"), "optional Z3 backend required")
    def test_time_wait_timer_mutation_has_independent_counterexample(self):
        m = copy.deepcopy(self.model)
        rule = next(r for r in m["transitions"] if r["id"] == "C-PEER-FIN-FW1-ACKED")
        rule["actions"] = [a for a in rule["actions"] if not ("arm" in a and a["arm"]["timer"] == "time_wait")]
        result = check(m, depth=5)
        self.assertEqual(result["status"], "counterexample")
        self.assertIn("C-INV-TIMER-TIME-WAIT-time_wait", result["replay"]["error"])

    @unittest.skipUnless(importlib.util.find_spec("z3"), "optional Z3 backend required")
    def test_lifecycle_symbolic_and_reference_snapshots_agree(self):
        for name in ("active-close", "passive-close", "simultaneous-open", "sequence-wrap-close", "duplicate-fin-time-wait"):
            with self.subTest(scenario=name):
                scenario = read(ROOT / "scenarios/connection" / (name+".json"))
                runtime = run_scenario(self.model, scenario)
                enc = Encoding(self.model, len(runtime.trace), ["iss"])
                z = enc.z
                enc.solver.add(enc.frames[0]["values"]["iss"] == z.BitVecVal(scenario["initial"].get("iss",1000),32))
                for i,row in enumerate(runtime.trace):
                    choice = next(j for j,r in enumerate(self.model["transitions"]) if r["id"] == row["transition"])
                    enc.solver.add(z.Int(f"choice_{i}") == choice, enc.frames[i+1]["now"] == row["time_ms"])
                    for field,value in row["event"]["fields"].items():
                        enc.solver.add(enc.events[i][row["event"]["name"]][field] == z.BitVecVal(value,32))
                self.assertEqual(enc.solver.check(), z.sat)
                self.assertEqual(replay(self.model, enc.witness(enc.solver.model()))["status"], "match")


if __name__ == "__main__":
    unittest.main()
