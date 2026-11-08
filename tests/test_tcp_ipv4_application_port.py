"""Transport/application contracts; these fakes are never network evidence."""
import copy
import unittest
from ports.tcp_ipv4_application_port import ApplicationPort, verify_tcp_peer_events


class PortContracts(unittest.TestCase):
    def test_dispatch_forwards_original_service_and_rejects_native_error(self):
        operations = []
        service = [{'message': 'T.application_data', 'fields': {'data': [0, 128, 255, 7]}}]
        def operation(step):
            operations.append(step)
            return dict(status='ok', services=service)
        p = ApplicationPort(operation, None, None, None, None)
        self.assertIs(p.dispatch('T.app.receive', {'count': 4}), service)
        self.assertEqual(operations, [dict(event='T.app.receive', fields={'count': 4})])
        p.operation = lambda _: dict(status='error', failure='uncovered_event')
        with self.assertRaises(RuntimeError): p.dispatch('T.app.connect', {})

    def test_wait_pumps_once_per_observation_and_preserves_snapshot(self):
        state, calls = {'ready': False}, []
        def pump(deadline):
            calls.append(deadline);state['ready'] = True
            return dict(status='ok')
        p = ApplicationPort(None, pump, lambda: state, lambda: None, lambda: 1)
        self.assertIs(p.wait_for(lambda s: s['ready'], 5, 'ready'), state)
        self.assertEqual(calls, [6])

    def test_timeout_or_model_rejection_never_becomes_readiness(self):
        stamps = iter([0, 0, 6])
        p = ApplicationPort(None, lambda _: None, lambda: {}, lambda: None, lambda: next(stamps))
        with self.assertRaises(TimeoutError): p.wait_for(lambda _: False, 5, 'fixture')
        p.clock = lambda: 0
        p.pump = lambda _: dict(status='error', failure='rule_conflict')
        with self.assertRaises(RuntimeError): p.wait_for(lambda _: False, 5, 'fixture')

    def test_exact_peer_receipt_missing_corrupt_extra_or_early_close_rejected(self):
        names = ['listening', 'accepted', 'received', 'echo_sent', 'eof', 'write_shutdown', 'close_requested', 'closed']
        events = [dict(event=n, monotonic_ns=i) for i, n in enumerate(names)]
        events[0]['address'] = ['192.0.2.2', 8080];events[1]['address'] = ['192.0.2.1', 40000]
        events[2]['hex'] = events[3]['hex'] = '0080ff07'
        self.assertTrue(verify_tcp_peer_events(events[:6]))
        self.assertTrue(verify_tcp_peer_events(events, closed=True))
        wrong = copy.deepcopy(events);wrong[2]['hex'] = '0080ff08'
        reordered = copy.deepcopy(events);reordered[-2:] = reversed(reordered[-2:])
        for case in [[], events[:5], events[:7], wrong, reordered, events+[events[-1]]]:
            with self.assertRaises(ValueError): verify_tcp_peer_events(case, closed=True)
