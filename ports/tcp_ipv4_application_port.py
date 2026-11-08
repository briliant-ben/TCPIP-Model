"""Application test port over raw-I/O callbacks; no protocol decisions."""


class ApplicationPort:
    def __init__(self, operation, pump, snapshot, alive, clock):
        self.operation, self.pump = operation, pump
        self.snapshot, self.alive, self.clock = snapshot, alive, clock

    @staticmethod
    def checked(result):
        if result is not None and result['status'] == 'error':
            raise RuntimeError('Native operation rejected: ' + result['failure'])
        return result

    def dispatch(self, event, fields):
        result = self.checked(self.operation(dict(event=event, fields=fields)))
        return result['services']

    def wait_for(self, predicate, timeout_s, purpose):
        deadline = self.clock() + timeout_s
        while True:
            self.alive()
            current = self.snapshot()
            if predicate(current):
                return current
            if self.clock() >= deadline:
                raise TimeoutError('Application wait timed out: ' + purpose)
            self.checked(self.pump(deadline))


def verify_tcp_peer_events(events, closed=False):
    """Independent ordinary socket's exact finite exchange receipt."""
    expected = ['listening', 'accepted', 'received', 'echo_sent', 'eof', 'write_shutdown']
    if closed:
        expected += ['close_requested', 'closed']
    if [e.get('event') for e in events] != expected:
        raise ValueError('Independent TCP peer event sequence mismatch')
    if events[0].get('address') != ['192.0.2.2', 8080]:
        raise ValueError('Independent TCP peer listen address mismatch')
    if events[1].get('address') != ['192.0.2.1', 40000]:
        raise ValueError('Independent TCP peer source address mismatch')
    if any(events[i].get('hex') != '0080ff07' for i in (2, 3)):
        raise ValueError('Independent TCP peer payload mismatch')
    stamps = [e.get('monotonic_ns') for e in events]
    if not all(type(t) is int and t >= 0 for t in stamps) or stamps != sorted(stamps):
        raise ValueError('Independent TCP peer event clock mismatch')
    return True
