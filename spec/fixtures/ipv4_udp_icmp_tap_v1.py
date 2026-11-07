"""Independent offline TAP interface literals; not imported by subject/tests.

No IR/reference/compiler imports. Inputs retain exact unpadded Ethernet octets.
"""
import hashlib
import json
from pathlib import Path
import struct
L=bytes.fromhex('020000000001');P=bytes.fromhex('020000000002')
LI=bytes([192,0,2,1]);PI=bytes([192,0,2,2])

def checksum(raw):
    raw+=bytes(len(raw)%2);total=sum(struct.unpack('!'+str(len(raw)//2)+'H',raw))
    while total>>16:total=(total&65535)+(total>>16)
    return total^65535

def ip(body,protocol,inbound=True,ident=0,ttl=64):
    src,dst=(PI,LI)if inbound else(LI,PI)
    h=struct.pack('!BBHHHBBH4s4s',69,0,20+len(body),ident,16384,ttl,protocol,0,src,dst)
    return h[:10]+struct.pack('!H',checksum(h))+h[12:]+body

def udp(data,inbound=True,ident=0):
    src,dst=(PI,LI)if inbound else(LI,PI);sp,dp=(8080,40000)if inbound else(40000,8080)
    n=len(data)+8;u=struct.pack('!HHHH',sp,dp,n,0)+data
    c=checksum(src+dst+struct.pack('!BBH',0,17,n)+u)
    return ip(u[:6]+struct.pack('!H',c or 65535)+u[8:],17,inbound,ident)

def echo(data,inbound=True,ident=0,ttl=64):
    u=struct.pack('!BBHHH',8 if inbound else 0,0,0,0x1234,0xabcd)+data
    return ip(u[:2]+struct.pack('!H',checksum(u))+u[4:],1,inbound,ident,ttl)

def frame(raw,inbound=True,padding=False,pad=0):
    return (L+P if inbound else P+L)+b'\x08\0'+raw+(bytes([pad])*max(0,46-len(raw))if padding else b'')

def arp(reply=False):
    src,dst,spa,tpa,tha=(P,L,PI,LI,L)if reply else(L,bytes([255])*6,LI,PI,bytes(6))
    raw=dst+src+struct.pack('!HHHBBH',0x0806,1,0x0800,6,4,2 if reply else 1)+src+spa+tha+tpa
    return raw+bytes(18)

def oracle():
    net=lambda t,raw:dict(at_ms=t,event='net.frame',fields=dict(frame=list(raw)))
    wire=lambda raw:dict(message='ethernet.tx',fields=dict(frame=list(raw)))
    delivery=lambda data:dict(message='udp.rx',fields=dict(data=list(data)))
    cases={};odd=bytes([0,128,255,7,0]);unpadded=[]
    def add(name,ops,variables=None,state='EMPTY',timers=None):
        steps=[]
        for step,messages in ops:
            step=dict(step);step['expect_trace']=[dict(at_ms=step['at_ms'],emitted=messages)];steps.append(step)
        cases[name]=dict(scenario_version='0.2',id=name,initial={},steps=steps,expect=dict(state=state,variables=variables or {},timers=timers or {}))
    for name,data in [('empty',b''),('odd',odd)]:
        raw=frame(udp(data,ident=1234));unpadded.append(raw.hex());add('udp-'+name,[(net(0,raw),[delivery(data)])],dict(rxudp_payload=list(data),rxudp_disposition='deliver'))
        raw=frame(echo(data,ident=65535,ttl=1));unpadded.append(raw.hex());add('echo-'+name,[(net(0,raw),[wire(frame(echo(data,False),False,True))])],dict(echo_disposition='reply'))
    maximum=bytes(i%256 for i in range(1472))
    add('mtu-mixed',[(net(0,frame(udp(maximum))),[delivery(maximum)]),(net(1,frame(echo(maximum))),[wire(frame(echo(maximum,False),False,True))])])
    bad=bytearray(udp(odd));bad[-1]^=1;add('bad-udp-checksum',[(net(0,frame(bytes(bad))),[])],dict(rxudp_payload=[],rxudp_disposition='drop_udp_checksum'))
    bad=bytearray(echo(odd));bad[-1]^=1;add('bad-echo-checksum',[(net(0,frame(bytes(bad))),[])],dict(echo_reply=[],echo_disposition='drop_icmp_checksum'))
    for name,total in [('total-too-small',27),('truncated',47)]:
        raw=bytearray(udp(b''));raw[2:4]=struct.pack('!H',total);raw[10:12]=bytes(2);raw[10:12]=struct.pack('!H',checksum(bytes(raw[:20])))
        add(name,[(net(0,frame(bytes(raw))),[])],dict(rxudp_payload=[],rxudp_disposition='drop_ip_length'))
    add('canonical-still-accepted',[(net(0,frame(udp(odd),padding=True,pad=0xa5)),[delivery(odd)]),(net(1,frame(echo(b''),padding=True,pad=0x7e)),[wire(frame(echo(b'',False),False,True))])])
    send=dict(at_ms=0,event='app.send',fields=dict(data=list(odd)))
    resolved=dict(message='neighbor.resolved',fields=dict(ip=list(PI),mac=list(P)))
    add('pending-ingress-retains-queue',[(send,[wire(arp())]),(net(1,frame(udp(b'R'))),[delivery(b'R')]),(net(2,frame(echo(b'E'))),[wire(frame(echo(b'E',False),False,True))]),(net(3,arp(True)),[resolved,wire(frame(udp(odd,False),False,True))])],dict(rxudp_payload=[82],pending_packet=[]),state='RESOLVED',timers=dict(cache=60003))
    empty=frame(udp(b''));oddframe=frame(udp(odd));gaps={'partial-pad-empty':(empty+b'X').hex(),'partial-pad-odd':(oddframe+b'X'*5).hex(),'surplus-over-canonical':(frame(udp(b''),padding=True)+b'X').hex()}
    for name,index,value in [('other-mac',11,3),('udp-ttl',22,63),('fragment',20,32)]:
        raw=bytearray(oddframe);raw[index]=value;gaps[name]=raw.hex()
    root=Path(__file__).resolve().parents[2];names=['linux-v6.12-tuntap.rst','rfc768.txt','rfc791.txt','rfc792.txt','rfc894.txt','rfc894-errata-570.html','rfc1122.txt','rfc6864.txt']
    return dict(schema='ipv4-udp-icmp-tap-literal-oracle-v1',basis='Linux v6.12 TUN/TAP document sections1/3 interface role; unpadded/canonical union is explicit finite profile choice, not a documentation padding mandate',sources={n:hashlib.sha256((root/'spec/sources'/n).read_bytes()).hexdigest()for n in names},cases=cases,canonical_model_gaps=unpadded,model_gaps=gaps)

if __name__=='__main__':print(json.dumps(oracle(),indent=2))
