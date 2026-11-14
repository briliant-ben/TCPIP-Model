#!/usr/bin/env python3
"""Render audited native/capture observations; never execute archived code."""
import argparse
import hashlib
import html
import json
from pathlib import Path
import zipfile
import struct

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


def render(model_file, archive, expected_sha256, out):
    if hashlib.sha256(archive.read_bytes()).hexdigest()!=expected_sha256:
        raise ValueError('Original archive digest differs')
    model=json.loads(model_file.read_text())
    with zipfile.ZipFile(archive)as z:
        read=lambda n:json.loads(z.read(n))
        report,ns,session=read('live/report.json'),read('live/namespace.json'),read('live/native/session.json')
        generation=read('generation/generation.json');proof=read('verification/symbolic/result.json')
        if report['status']!='finite_ipv4_peer_pass' or proof['query']!='sat' or proof['status']!='match':
            raise ValueError('Finite observation was not accepted')
        if hashlib.sha256(model_file.read_bytes()).hexdigest()!=report['source_hashes_before']['model']:
            raise ValueError('Wrong model for original observation')
        rows=[json.loads(line)for line in z.read('live/native/native.stdout').splitlines()]
        transitions=[r for r in rows if r['status']=='transition']
        packets=pcap_records(z.read('live/capture.pcap'));links=read('live/links.json')
        if [p['raw']for p in packets]!=[bytes.fromhex(l['raw'])for l in links]:
            raise ValueError('Capture differs from original link bytes')
        if len(transitions)!=proof['steps'] or session['process_starts']!=1 or session['returncode']!=0:
            raise ValueError('Trace/process identity mismatch')
        rules={r['id']:r for r in model['transitions']}
        esc=lambda x:html.escape(str(x),quote=True)
        rule_rows=[]
        for row in transitions:
            rule=rules[row['transition']];v=row['after']['variables']
            source=[dict(id=n,**model['requirements'][n])for n in rule['requirements']]
            detail=json.dumps(dict(guard=rule['guard'],actions=rule['actions'],sources=source),ensure_ascii=False,indent=2)
            emits=', '.join(e['message']for e in row['emitted'])or'—'
            rule_rows.append('<tr><td>'+esc(row['time_ms'])+'</td><td>'+esc(row['event']['name'])+'</td><td>'+esc(v['L.control'])+' / '+esc(v['T.control'])+'</td><td><details><summary>'+esc(row['transition'])+'</summary><pre>'+esc(detail)+'</pre></details></td><td>'+esc(emits)+'</td></tr>')
        packet_rows=[];origin=packets[0]['timestamp_ns']
        for i,(packet,link)in enumerate(zip(packets,links)):
            raw=packet['raw'];proto='ARP'if raw[12:14]==b'\x08\x06'else {1:'ICMP',6:'TCP',17:'UDP'}.get(raw[23],'IPv4')
            packet_rows.append('<tr><td>'+str(i+1)+'</td><td>'+format((packet['timestamp_ns']-origin)/1000000,'.6f')+'</td><td>'+('Linux → C'if link['direction']=='ingress'else'C → Linux')+'</td><td>'+esc(proto)+'</td><td>'+str(len(raw))+'</td><td><details><summary>Raw bytes</summary><pre>'+raw.hex()+'</pre></details></td></tr>')
        quiet=(ns['capture_stop_request_wall_ns']-packets[-1]['timestamp_ns'])/1000000
        text='''<!doctype html><html lang="en"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Finite IPv4 prototype: recorded execution</title><style>body{font:15px/1.6 system-ui,sans-serif;background:#f6f8fa;color:#17212b;margin:24px auto;max-width:1250px;padding:0 20px}h1{font-size:26px}table{border-collapse:collapse;width:100%;background:white;margin:18px 0}td,th{border:1px solid #d8dee4;padding:8px;text-align:left;vertical-align:top}th{background:#eaf1f8}pre{white-space:pre-wrap;word-break:break-all;max-height:420px;overflow:auto;font-size:12px}summary{cursor:pointer}code{word-break:break-all}.note{padding:16px;background:#fff5d6;border-left:4px solid #b78900}.ok{padding:16px;background:#dff4e6}footer{margin:32px 0;color:#52606d}</style><h1>Finite IPv4 prototype: one recorded execution</h1>'''
        text+='<div class="ok">One IR-generated C process, PID '+str(session['pid'])+' · ARP / TCP echo and close / 3 UDP round trips / 3 ICMP Echo exchanges · '+str(len(packets))+' packets, zero capture drops · quiet interval '+format(quiet,'.6f')+'ms · '+str(len(transitions))+' fixed-input Z3 steps: SAT and replay match</div>'
        text+='<p>The complete IR declares '+str(len(model['transitions']))+' rules. Only transitions in this recorded run are shown. Expand a rule to inspect its guard, actions and specification references. C logical time and measured PCAP time are separate; no wire-latency equivalence is claimed.</p><div class="note">Fixed-endpoint finite prototype: TCP buffer16, SMSS4, close ends in pending TIME-WAIT. This is the retained 25-packet Linux observation, not a new network run. Later finite delivery includes 563 initialized one-step UNSAT checks; the general flow remains unresolved because complete exploration is not established. Old UNKNOWNs are retained. No full-protocol, compiler or specification-interpretation proof is claimed.</div>'
        text+='<p>Model SHA256 <code>'+esc(report['source_hashes_before']['model'])+'</code><br>C SHA256 <code>'+esc(generation['outputs']['protocol.c'])+'</code><br>Original evidence ZIP SHA256 <code>'+esc(expected_sha256)+'</code></p>'
        text+='<h2>Recorded protocol transitions</h2><table><tr><th>C logical ms</th><th>Event</th><th>L / T control state</th><th>IR rule and sources</th><th>Outputs</th></tr>'+''.join(rule_rows)+'</table>'
        text+='<h2>Independent raw packet capture</h2><table><tr><th>Frame</th><th>PCAP relative ms</th><th>Direction</th><th>Protocol</th><th>Bytes</th><th>Packet</th></tr>'+''.join(packet_rows)+'</table><footer>Offline view rendered from original evidence. No archived Python, ELF or solver is executed. Authenticity relies on CI provenance and the retained read-only audit.</footer></html>'
    out.write_text(text)
    return dict(transitions=len(transitions),packets=len(packets),native_pid=session['pid'],output=str(out))


if __name__=='__main__':
    root=Path(__file__).resolve().parents[1]
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--out',type=Path,default=root/'demo/review.html')
    a=p.parse_args()
    print(json.dumps(render(root/'model/ipv4-endpoint-virtual-link.json',root/'demo/recording.zip','b47bf2a2a0f7b92c23632e2eff5c7a17cfc1d681ed5f8de84b9de02f0bfea5d6',a.out)))
