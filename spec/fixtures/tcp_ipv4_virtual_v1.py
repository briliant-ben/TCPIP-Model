"""Independent frozen virtual-link fixtures; never used by subject/adapter.

Only standard byte encoding/checksum arithmetic and the original observed input
are used. No IR imports, interpreter, generated source or model callbacks.
"""
import copy
import struct

OBSERVED_SYNACK = bytes.fromhex('02000000000102000000000208004500002c000040004006b6c8c0000202c00002011f909c40377d2bea000003e96012faf0f6000000020405b4')
OBSERVED_ARP_REPLY = bytes.fromhex('02000000000102000000000208060001080006040002020000000002c0000202020000000001c0000201')
LOCAL_MAC = bytes.fromhex('020000000001')
PEER_MAC = bytes.fromhex('020000000002')
LOCAL_IP = bytes([192,0,2,1])
PEER_IP = bytes([192,0,2,2])


def checksum(data):
    if len(data) % 2:
        data += b'\0'
    total = sum(int.from_bytes(data[i:i+2], 'big') for i in range(0,len(data),2))
    while total >> 16:
        total = (total & 65535) + (total >> 16)
    return (~total) & 65535


def tcp_frame(seq, ack, flags, window, options=b'', subject=False):
    src,dst = (LOCAL_IP,PEER_IP) if subject else (PEER_IP,LOCAL_IP)
    sport,dport = (40000,8080) if subject else (8080,40000)
    assert len(options) % 4 == 0
    tcp = struct.pack('!HHIIBBHHH',sport,dport,seq,ack,((20+len(options))//4)<<4,flags,window,0,0) + options
    check = checksum(src+dst+struct.pack('!BBH',0,6,len(tcp))+tcp)
    tcp = tcp[:16]+struct.pack('!H',check)+tcp[18:]
    ip = struct.pack('!BBHHHBBH4s4s',0x45,0,20+len(tcp),0,0x4000,64,6,0,src,dst)
    ip = ip[:10]+struct.pack('!H',checksum(ip))+ip[12:]
    eth = (PEER_MAC+LOCAL_MAC) if subject else (LOCAL_MAC+PEER_MAC)
    return eth+b'\x08\x00'+ip+tcp


def pad(frame):
    return frame + b'\0'*max(0,60-len(frame))


def build():
    raw=OBSERVED_SYNACK
    assert len(raw)==58 and raw[46]>>4==6 and raw[47]==18
    peer_seq=int.from_bytes(raw[38:42],'big')
    window=int.from_bytes(raw[48:50],'big')
    assert checksum(raw[14:34])==0
    assert checksum(raw[26:34]+struct.pack('!BBH',0,6,len(raw)-34)+raw[34:])==0
    arp=bytes.fromhex('ffffffffffff')+LOCAL_MAC+b'\x08\x06'+struct.pack('!HHBBH6s4s6s4s',1,0x0800,6,4,1,LOCAL_MAC,LOCAL_IP,b'\0'*6,PEER_IP)
    syn=pad(tcp_frame(1000,0,2,16,subject=True))
    prefix=[dict(at_ms=0,event='T.app.connect',fields={},expected_emitted=[dict(message='L.ethernet.tx',fields=dict(frame=list(pad(arp))))]),dict(at_ms=1,event='L.net.frame',fields=dict(frame=list(OBSERVED_ARP_REPLY)),expected_emitted=[dict(message='L.neighbor.resolved',fields=dict(ip=list(PEER_IP),mac=list(PEER_MAC))),dict(message='L.ethernet.tx',fields=dict(frame=list(syn)))])]
    cases=[]
    def case(name,frame,kind,seq=peer_seq):
        variables={'L.control':'RESOLVED','T.control':'ESTABLISHED'if kind=='accept'else'SYN-SENT','ip_pending_owner':'none','T.snd_una':1001 if kind=='accept'else 1000,'T.snd_nxt':1001,'T.rcv_nxt':(seq+1)&0xffffffff if kind=='accept'else 0}
        timers={'L.cache':60001}if kind=='accept'else{'L.cache':60001,'T.rtx':1000,'T.user':30000}
        emitted=[dict(message='T.application',fields=dict(code='connected')),dict(message='L.ethernet.tx',fields=dict(frame=list(pad(tcp_frame(1001,(seq+1)&0xffffffff,16,16,subject=True)))))]if kind=='accept'else[]
        cases.append(dict(id=name,at_ms=2,frame=list(frame),kind=kind,expected_variables=variables,expected_timers=timers,expected_emitted=emitted))
    case('observed-linux-synack-58',raw,'accept')
    case('canonical-offline-padded-60',pad(raw),'accept')
    case('synthetic-no-options-54',tcp_frame(peer_seq,1001,18,window),'accept')
    case('synthetic-wrap-no-options-54',tcp_frame(0xffffffff,1001,18,window),'accept',0xffffffff)
    a=bytearray(raw);a[50]^=1;case('bad-tcp-checksum',bytes(a),'drop')
    a=bytearray(raw);a[24]^=1;case('bad-ip-checksum',bytes(a),'drop')
    case('truncated-ip-extent',raw[:-1],'model_gap')
    case('partial-surplus-padding',raw+b'\0','model_gap')
    a=bytearray(raw);a[11]=3;case('wrong-peer-mac',bytes(a),'model_gap')
    return dict(schema='tcp-ipv4-virtual-boundary-oracle-v1',source_observation=dict(run_id=42445362865,artifact_id=13603282242,zip_sha256='20a5588b3603481c4535bdf07fea71961ea479915c8af1a0963b822d1dc25d07',source_commit='6bf692484f85be8365fe7460a969422b8296eacf',claim='only observed58 is Linux input; padded/synthetic/fault variants are offline fixtures'),prefix=prefix,cases=cases,policy='TCP receive service frame is exact14+IPv4total or canonical max(60,14+IPv4total); other guards/actions unchanged; physical Ethernet TX still padded')


if __name__=='__main__':
    import json
    print(json.dumps(build(),indent=2))
