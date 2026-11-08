"""Application stimulus only: no packets, timers or protocol state mutations.

The caller owns one generated-C process and pumps raw link/timer I/O. Completing
this script is not live peer, capture, model, compiler or whole-endpoint proof.
"""


def run_tcp_echo_application(port, payload=b'\x00\x80\xff\x07', timeout_s=5):
    if type(payload) is not bytes or len(payload) != 4:
        raise ValueError('This finite application fixture requires exactly four bytes')
    if type(timeout_s) not in (int, float) or not 0 < timeout_s < float('inf'):
        raise ValueError('Finite positive timeout required')

    def wait(predicate, purpose):
        snapshot = port.wait_for(predicate, timeout_s, purpose)
        if not predicate(snapshot):
            raise ValueError('Transport returned an unsatisfied application wait')
        return snapshot

    port.dispatch('T.app.connect', {})
    wait(lambda s: s['variables']['T.control'] == 'ESTABLISHED', 'TCP established')
    port.dispatch('T.app.send', {'data': list(payload)})
    port.dispatch('T.app.transmit', {})
    snapshot = wait(lambda s: len(s['variables']['T.rcv_buf']) >= len(payload), 'echo buffered')
    if snapshot['variables']['T.rcv_buf'][:len(payload)] != list(payload):
        raise ValueError('Unexpected echo bytes in receive buffer')
    services = port.dispatch('T.app.receive', {'count': len(payload)})
    data = [s for s in services if s.get('message') == 'T.application_data']
    if len(data) != 1 or data[0].get('fields') != {'data': list(payload)}:
        raise ValueError('Missing, duplicated or corrupt application echo service')
    wait(lambda s: s['variables']['T.rtx_buf'] == []
         and s['variables']['T.snd_buf'] == []
         and s['variables']['T.snd_una'] == s['variables']['T.snd_nxt'], 'send fully acknowledged')
    port.dispatch('T.app.close', {})
    wait(lambda s: s['variables']['T.control'] == 'TIME-WAIT', 'active close to pending TIME-WAIT')
    return dict(status='application_script_complete', payload_hex=payload.hex(),
                full_ipv4_endpoint_complete=False, time_wait_expiry_observed=False)
