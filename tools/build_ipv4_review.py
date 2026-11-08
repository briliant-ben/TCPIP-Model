#!/usr/bin/env python3
"""Render audited native/capture observations; never execute archived code."""
import argparse
import hashlib
import html
import json
from pathlib import Path
import sys
import zipfile
sys.path.insert(0,str(Path(__file__).resolve().parents[1]))
from ports.tcp_ipv4_probe_support import pcap_records


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
            packet_rows.append('<tr><td>'+str(i+1)+'</td><td>'+format((packet['timestamp_ns']-origin)/1000000,'.6f')+'</td><td>'+('Linux → C'if link['direction']=='ingress'else'C → Linux')+'</td><td>'+esc(proto)+'</td><td>'+str(len(raw))+'</td><td><details><summary>原始字节</summary><pre>'+raw.hex()+'</pre></details></td></tr>')
        quiet=(ns['capture_stop_request_wall_ns']-packets[-1]['timestamp_ns'])/1000000
        text='''<!doctype html><html lang="zh"><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1"><title>IPv4 有限原型实际运行审阅</title><style>body{font:15px/1.6 system-ui,sans-serif;background:#f6f8fa;color:#17212b;margin:24px auto;max-width:1250px;padding:0 20px}h1{font-size:26px}table{border-collapse:collapse;width:100%;background:white;margin:18px 0}td,th{border:1px solid #d8dee4;padding:8px;text-align:left;vertical-align:top}th{background:#eaf1f8}pre{white-space:pre-wrap;word-break:break-all;max-height:420px;overflow:auto;font-size:12px}summary{cursor:pointer}code{word-break:break-all}.note{padding:16px;background:#fff5d6;border-left:4px solid #b78900}.ok{padding:16px;background:#dff4e6}footer{margin:32px 0;color:#52606d}</style><h1>IPv4 有限原型：实际组合运行</h1>'''
        text+='<div class="ok">单个 IR 生成 C 进程 PID '+str(session['pid'])+' · ARP / TCP 回显与关闭 / 3 UDP 往返 / 3 ICMP Echo · '+str(len(packets))+' 包，零丢包 · 静默窗口 '+format(quiet,'.6f')+'ms · '+str(len(transitions))+' 步固定输入 Z3 SAT＋重放匹配</div>'
        text+='<p>完整 IR 有 '+str(len(model['transitions']))+' 条规则。下面只展示本次实际转换；展开规则可检查其 guard、action 与规范来源。C 逻辑时刻和 PCAP 实测时刻分别展示，未声明线时延等价。</p><div class="note">有限固定端点原型；TCP 缓冲16字节、SMSS4，关闭停在等待中的 TIME-WAIT。独立十阶段 flow 的全输入检查仍 UNKNOWN，声明探索覆盖10/335，结论 unresolved。未证明完整协议、编译器或规范解释正确性。</div>'
        text+='<p>模型 SHA256 <code>'+esc(report['source_hashes_before']['model'])+'</code><br>C SHA256 <code>'+esc(generation['outputs']['protocol.c'])+'</code><br>原始证据 ZIP SHA256 <code>'+esc(expected_sha256)+'</code></p>'
        text+='<h2>实际协议转换</h2><table><tr><th>C 逻辑 ms</th><th>事件</th><th>L / T 控制状态</th><th>IR 规则与来源</th><th>输出</th></tr>'+''.join(rule_rows)+'</table>'
        text+='<h2>独立原始抓包</h2><table><tr><th>序号</th><th>PCAP 相对 ms</th><th>方向</th><th>协议</th><th>字节数</th><th>报文</th></tr>'+''.join(packet_rows)+'</table><footer>从原始证据生成的离线审阅页面；未执行归档 Python、ELF 或求解器。证据真实性仍依赖 CI provenance 与只读审计。</footer></html>'
    out.write_text(text)
    return dict(transitions=len(transitions),packets=len(packets),native_pid=session['pid'],output=str(out))


if __name__=='__main__':
    p=argparse.ArgumentParser(description=__doc__);p.add_argument('--model',type=Path,required=True);p.add_argument('--archive',type=Path,required=True);p.add_argument('--sha256',required=True);p.add_argument('--out',type=Path,required=True);a=p.parse_args()
    print(json.dumps(render(a.model,a.archive,a.sha256,a.out)))
