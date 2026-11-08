import re
import struct


def elapsed_ms(origin_ns, sample_ns):
    if type(origin_ns) is not int or type(sample_ns) is not int:
        raise ValueError("origin_ns and sample_ns must be exact ints")
    if origin_ns < 0:
        raise ValueError("origin_ns must be >= 0")
    if sample_ns < origin_ns:
        raise ValueError("sample_ns must be >= origin_ns")
    return (sample_ns - origin_ns) // 1_000_000


def capture_stats(text):
    if not isinstance(text, str):
        raise ValueError("text must be a string")
    lines = [line.strip() for line in text.strip().split('\n') if line.strip()]

    stats = {'captured': None, 'received': None, 'dropped': None}
    patterns = {
        'captured': r'^(\d+)\s+packets?\s+captured$',
        'received': r'^(\d+)\s+packets?\s+received by filter$',
        'dropped': r'^(\d+)\s+packets?\s+dropped by kernel$'
    }
    # Substrings that indicate a line is attempting to be a stat but is malformed
    stat_keywords = {
        'captured': 'packets captured',
        'received': 'packets received by filter',
        'dropped': 'packets dropped by kernel'
    }
    for line in lines:
        matched = False
        # First try exact match
        for key, pattern in patterns.items():
            m = re.fullmatch(pattern, line)
            if m:
                if stats[key] is not None:
                    raise ValueError(f"duplicate {key} stat")
                stats[key] = int(m.group(1))
                matched = True
                break
        if matched:
            continue
        # If no exact match, check if line contains any stat keyword (case-sensitive)
        # If it does, it's a malformed stat line and should raise
        for key, keyword in stat_keywords.items():
            if re.search(r'\b' + keyword.replace('packets', r'packets?').replace(' ', r'\s+') + r'\b', line):
                raise ValueError(f"malformed {key} stat line: {line!r}")
        # Otherwise it's an unrelated header/diagnostic line, ignore it

    if stats['dropped'] != 0:
        raise ValueError("dropped packets must be zero")
    if stats['captured'] is None or stats['received'] is None or stats['dropped'] is None:
        raise ValueError("missing stats")
    return {'captured': stats['captured'], 'received': stats['received'], 'dropped': stats['dropped']}


def pcap_records(raw):
    if not isinstance(raw, bytes):
        raise ValueError("raw must be bytes")
    if len(raw) < 24:
        raise ValueError("incomplete pcap global header")
    first4 = raw[:4]
    if first4 == b'\xd4\xc3\xb2\xa1':
        endian = '<'
        magic_expected = 0xa1b2c3d4
    elif first4 == b'\xa1\xb2\xc3\xd4':
        endian = '>'
        magic_expected = 0xa1b2c3d4
    elif first4 == b'\x4d\x3c\xb2\xa1' or first4 == b'\xa1\xb2\x3c\x4d':
        raise ValueError("nanosecond pcap unsupported")
    else:
        raise ValueError("unsupported pcap magic")

    header = struct.unpack(endian + 'IHHIIII', raw[:24])
    magic, vmaj, vmin, thiszone, sigfig, snap, link = header
    if magic != magic_expected:
        raise ValueError("bad magic")
    if vmaj != 2 or vmin != 4:
        raise ValueError("unsupported pcap version")
    if link != 1:
        raise ValueError("linktype must be Ethernet")
    if not (1 <= snap <= 65535):
        raise ValueError("snaplen out of range")

    offset = 24
    records = []
    prev_ts = None
    while offset < len(raw):
        if len(raw) - offset < 16:
            raise ValueError("incomplete packet header")
        ts_sec, ts_frac, incl_len, orig_len = struct.unpack(endian + 'IIII', raw[offset:offset+16])
        offset += 16
        if ts_frac >= 1000000:
            raise ValueError("invalid fraction")
        if incl_len > snap:
            raise ValueError("captured length exceeds snaplen")
        if incl_len != orig_len:
            raise ValueError("truncated capture")
        if orig_len < 14:
            raise ValueError("packet too short")
        if len(raw) - offset < incl_len:
            raise ValueError("incomplete packet data")
        pkt_data = raw[offset:offset+incl_len]
        offset += incl_len
        ts_ns = ts_sec * 1_000_000_000 + ts_frac * 1000
        if prev_ts is not None and ts_ns < prev_ts:
            raise ValueError("timestamps not nondecreasing")
        prev_ts = ts_ns
        records.append({'timestamp_ns': ts_ns, 'raw': pkt_data})
    if offset != len(raw):
        raise ValueError("trailing bytes")
    return records


def quiet_ok(records, stop_request_wall_ns, quiet_ms=100):
    if not isinstance(records, list):
        raise ValueError("records must be a list")
    if type(stop_request_wall_ns) is not int or type(quiet_ms) is not int:
        raise ValueError("stop_request_wall_ns and quiet_ms must be exact ints")
    if stop_request_wall_ns < 0 or quiet_ms < 0:
        raise ValueError("stop and quiet must be nonnegative")
    if len(records) == 0:
        return False
    for rec in records:
        if not isinstance(rec, dict) or 'timestamp_ns' not in rec:
            raise ValueError("records must be dicts with timestamp_ns")
        if type(rec['timestamp_ns']) is not int:
            raise ValueError("timestamp_ns must be exact int")
    last_ts = records[-1]['timestamp_ns']
    if last_ts > stop_request_wall_ns:
        return False
    diff = stop_request_wall_ns - last_ts
    return diff >= quiet_ms * 1_000_000


def _deepcopy(obj):
    if isinstance(obj, dict):
        return {k: _deepcopy(v) for k, v in obj.items()}
    if isinstance(obj, list):
        return [_deepcopy(item) for item in obj]
    if isinstance(obj, (str, int, float, bool, type(None))):
        return obj
    raise ValueError("unsupported type in emission")


def operation_result(rows, wire_message='ethernet.tx'):
    if type(wire_message) is not str or not wire_message:
        raise ValueError('Explicit wire message name required')
    if not isinstance(rows, list) or len(rows) == 0:
        raise ValueError("rows must be nonempty list")
    terminal = rows[-1]
    if not isinstance(terminal, dict) or 'status' not in terminal:
        raise ValueError("terminal row must be dict with status")
    if terminal['status'] not in ('ok', 'error'):
        raise ValueError("terminal status must be 'ok' or 'error'")
    for row in rows[:-1]:
        if not isinstance(row, dict) or row.get('status') != 'transition':
            raise ValueError("preceding rows must be transitions")

    if terminal['status'] == 'error':
        if 'failure' not in terminal or not isinstance(terminal['failure'], str) or terminal['failure'] == '':
            raise ValueError("error terminal requires nonempty string failure")
        failure = terminal['failure']
        if failure == 'uncovered_event':
            category = 'model_gap'
        elif failure == 'rule_conflict':
            category = 'rule_conflict'
        elif failure.startswith('invariant:'):
            category = 'invariant_failure'
        else:
            category = 'driver_failure'
        return {'status': 'error', 'category': category, 'failure': failure, 'frames': [], 'services': []}

    # status == 'ok'
    if 'emitted' in terminal and terminal['emitted']:
        raise ValueError("terminal ok must not have emitted")
    frames = []
    services = []
    for row in rows[:-1]:
        if 'emitted' not in row or not isinstance(row['emitted'], list):
            raise ValueError("transition row must have emitted list")
        for emission in row['emitted']:
            if not isinstance(emission, dict) or 'message' not in emission or 'fields' not in emission:
                raise ValueError("emission must be dict with message and fields")
            message = emission['message']
            fields = emission['fields']
            if not isinstance(message, str) or not isinstance(fields, dict):
                raise ValueError("message must be str and fields dict")
            if message == wire_message:
                if set(fields.keys()) != {'frame'}:
                    raise ValueError("ethernet.tx fields must exactly contain 'frame'")
                frame_list = fields['frame']
                if not isinstance(frame_list, list):
                    raise ValueError("frame must be list")
                for item in frame_list:
                    if isinstance(item, bool) or not isinstance(item, int):
                        raise ValueError("frame items must be int not bool")
                    if not (0 <= item <= 255):
                        raise ValueError("frame items must be octets")
                frames.append(bytes(frame_list))
            else:
                services.append(_deepcopy(emission))
    return {'status': 'ok', 'category': None, 'failure': None, 'frames': frames, 'services': services}


def record_error(report, category, reason):
    allowed = {'blocked_preflight', 'driver_failure', 'model_gap',
               'rule_conflict', 'invariant_failure', 'capture_invalid', 'cleanup_failure'}
    if not isinstance(report, dict):
        raise ValueError("report must be dict")
    if 'error' not in report:
        raise ValueError("report must have error key")
    if report['error'] is not None and not isinstance(report['error'], dict):
        raise ValueError("error must be None or dict")
    if category not in allowed:
        raise ValueError("invalid category")
    if not isinstance(reason, str):
        raise ValueError("reason must be str")
    if 'secondary_errors' not in report:
        report['secondary_errors'] = []
    elif not isinstance(report['secondary_errors'], list):
        raise ValueError("secondary_errors must be list")
    if report['error'] is None:
        report['error'] = {'category': category, 'reason': reason}
    else:
        report['secondary_errors'].append({'category': category, 'reason': reason})
    return None
