"""Offline independent struct oracle; never imported by subject/tests.
Freeze these literal frame/trace expectations before running the combined IR.
"""
import hashlib
import json
from pathlib import Path
import struct
L=bytes.fromhex('020000000001');P=bytes.fromhex('020000000002')
LI=bytes([192,0,2,1]);PI=bytes([192,0,2,2])

def checksum(raw):
    raw+=bytes(len(raw)%2);n=sum(struct.unpack('!'+str(len(raw)//2)+'H',raw))
    while n>>16:n=(n&65535)+(n>>16)
    return n^65535

def ip(body,protocol,inbound=True,ident=0,ttl=64):
    src,dst=(PI,LI)if inbound else(LI,PI)
    h=struct.pack('!BBHHHBBH4s4s',69,0,20+len(body),ident,16384,ttl,protocol,0,src,dst)
    return h[:10]+struct.pack('!H',checksum(h))+h[12:]+body

def udp(data,inbound=True,absent=False,ident=0):
    src,dst=(PI,LI)if inbound else(LI,PI);sp,dp=(8080,40000)if inbound else(40000,8080)
    n=8+len(data);u=struct.pack('!HHHH',sp,dp,n,0)+data
    c=checksum(src+dst+struct.pack('!BBH',0,17,n)+u)
    return ip(u[:6]+struct.pack('!H',0 if absent else c or 65535)+u[8:],17,inbound,ident)

def echo(data,inbound=True,ident=0,ttl=64):
    body=struct.pack('!BBHHH',8 if inbound else 0,0,0,0x1234,0xabcd)+data
    return ip(body[:2]+struct.pack('!H',checksum(body))+body[4:],1,inbound,ident,ttl)

def frame(raw,inbound=True,pad=0):
    return (L+P if inbound else P+L)+b'\x08\x00'+raw+bytes([pad])*max(0,46-len(raw))

def arp(reply=False):
    src,dst,spa,tpa,tha=(P,L,PI,LI,L)if reply else(L,bytes([255])*6,LI,PI,bytes(6))
    raw=dst+src+struct.pack('!HHHBBH',0x0806,1,0x0800,6,4,2 if reply else 1)+src+spa+tha+tpa
    return raw+bytes(18)

def oracle():
    wire=lambda raw:dict(message='ethernet.tx',fields=dict(frame=list(raw)))
    delivered=lambda data:dict(message='udp.rx',fields=dict(data=list(data)))
    resolved=dict(message='neighbor.resolved',fields=dict(ip=list(PI),mac=list(P)))
    net=lambda t,raw:dict(at_ms=t,event='net.frame',fields=dict(frame=list(raw)))
    send=lambda t,data:dict(at_ms=t,event='app.send',fields=dict(data=list(data)))
    cfg=lambda t,b:dict(at_ms=t,event='app.require_checksum',fields=dict(required=b))
    cases={};odd=bytes([0,128,255,7,0])
    def add(name,ops,state='EMPTY',variables=None,timers=None):
        steps=[]
        for op,messages in ops:
            op=dict(op);op['expect_trace']=[dict(at_ms=op['at_ms'],emitted=messages)];steps.append(op)
        cases[name]=dict(scenario_version='0.2',id=name,initial={},steps=steps,expect=dict(state=state,variables=variables or {},timers=timers or {}))
    add('cold-rx-echo',[(net(0,frame(udp(odd,ident=1234))),[delivered(odd)]),(net(1,frame(echo(odd,ident=65535,ttl=1))),[wire(frame(echo(odd,False),False))])],variables=dict(rxudp_payload=list(odd),echo_disposition='reply',pending_packet=[]))
    add('pending-ingress-preserves-queue',[(send(0,odd),[wire(arp())]),(net(1,frame(udp(b'R'))),[delivered(b'R')]),(net(2,frame(echo(b'E'))),[wire(frame(echo(b'E',False),False))]),(net(3,arp(True)),[resolved,wire(frame(udp(odd,False),False))])],state='RESOLVED',variables=dict(rxudp_payload=[82],pending_packet=[]),timers=dict(cache=60003))
    add('resolved-mixed',[(net(0,arp(True)),[]),(net(1,frame(udp(b''))),[delivered(b'')]),(send(2,odd),[wire(frame(udp(odd,False),False))]),(net(3,frame(echo(b''))),[wire(frame(echo(b'',False),False))])],state='RESOLVED',timers=dict(cache=60000))
    badu=bytearray(udp(odd));badu[-1]^=1
    bade=bytearray(echo(odd));bade[-1]^=1
    add('checksum-drops-clear-stale',[(net(0,frame(udp(odd))),[delivered(odd)]),(net(1,frame(bytes(badu))),[]),(net(2,frame(echo(odd))),[wire(frame(echo(odd,False),False))]),(net(3,frame(bytes(bade))),[])],variables=dict(rxudp_payload=[],rxudp_disposition='drop_udp_checksum',echo_reply=[],echo_disposition='drop_icmp_checksum'))
    add('absent-policy',[(net(0,frame(udp(odd,absent=True))),[delivered(odd)]),(cfg(1,True),[]),(net(2,frame(udp(odd,absent=True))),[])],variables=dict(rxudp_payload=[],rxudp_require_checksum=True,rxudp_disposition='drop_absent'))
    add('nonzero-link-padding',[(net(0,frame(udp(b''),pad=0xa5)),[delivered(b'')]),(net(1,frame(echo(b''),pad=0x7e)),[wire(frame(echo(b'',False),False))])])
    malformed=[]
    for tag,total in [('total-too-small',27),('truncated',47)]:
        raw=bytearray(udp(b'hello'));raw[2:4]=struct.pack('!H',total);raw[10:12]=bytes(2);raw[10:12]=struct.pack('!H',checksum(bytes(raw[:20])));malformed.append((tag,frame(bytes(raw))))
    for name,raw in malformed:add(name,[(net(0,raw),[])],variables=dict(rxudp_disposition='drop_ip_length',rxudp_payload=[]))
    maximum=bytes(n%256 for n in range(1472))
    add('mtu-rx-echo',[(net(0,frame(udp(maximum))),[delivered(maximum)]),(net(1,frame(echo(maximum))),[wire(frame(echo(maximum,False),False))])],variables=dict(rxudp_payload=list(maximum)))
    gaps={};base=frame(udp(b'hello'))
    for name,index,value in [('other-mac',11,3),('other-peer',29,3),('udp-ttl',22,63),('options',14,70),('fragment',20,32),('other-port',37,65),('other-ethertype',13,0x86)]:
        raw=bytearray(base);raw[index]=value;gaps[name]=raw.hex()
    gaps['noncanonical-surplus']=(base+b'X').hex();gaps['short-ethernet']=base[:59].hex();gaps['over-mtu']=frame(udp(bytes(1473))).hex()
    root=Path(__file__).resolve().parents[2]
    names=['rfc768.txt','rfc791.txt','rfc792.txt','rfc894.txt','rfc894-errata-570.html','rfc1122.txt','rfc6864.txt']
    return dict(schema='ipv4-udp-icmp-endpoint-literal-oracle-v1',basis='RFC894 Frame Format+verified570; RFC791 3.1; RFC768; RFC792 Echo; RFC1122; RFC6864 atomic; finite fixed-link profile',sources={n:hashlib.sha256((root/'spec/sources'/n).read_bytes()).hexdigest()for n in names},cases=cases,model_gaps=gaps)

if __name__=='__main__':print(json.dumps(oracle(),indent=2))
