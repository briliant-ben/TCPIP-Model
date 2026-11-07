"""Independent offline struct wire oracle, frozen before TCP wire IR execution.

No IR/reference/native imports. Profile trajectories are literal and manual.
"""
import hashlib
import json
from pathlib import Path
import struct
L=bytes([192,0,2,1]);P=bytes([192,0,2,2])

def checksum(raw):
    raw+=bytes(len(raw)%2);n=sum(struct.unpack('!'+str(len(raw)//2)+'H',raw))
    while n>>16:n=(n&65535)+(n>>16)
    return n^65535

def packet(seq,ack,flags,data=b'',window=16,inbound=True,mss=None,ident=0,ttl=64):
    src,dst=(P,L)if inbound else(L,P);sp,dp=(8080,40000)if inbound else(40000,8080)
    options=struct.pack('!BBH',2,4,mss)if mss is not None else b''
    tcp=struct.pack('!HHIIBBHHH',sp,dp,seq,ack,0x60 if options else 0x50,flags,window,0,0)+options+data
    pseudo=src+dst+struct.pack('!BBH',0,6,len(tcp));tcp=tcp[:16]+struct.pack('!H',checksum(pseudo+tcp))+tcp[18:]
    ip=struct.pack('!BBHHHBBH4s4s',69,0,20+len(tcp),ident,16384,ttl,6,0,src,dst)
    return ip[:10]+struct.pack('!H',checksum(ip))+ip[12:]+tcp

def fix_ip(raw):return raw[:10]+struct.pack('!H',checksum(raw[:10]+b'\0\0'+raw[12:20]))+raw[12:]
def fix_tcp(raw):
    tcp=raw[20:36]+b'\0\0'+raw[38:];pseudo=raw[12:20]+struct.pack('!BBH',0,6,len(tcp))
    return raw[:36]+struct.pack('!H',checksum(pseudo+tcp))+raw[38:]

def oracle():
    cases={};odd=bytes([0,128,255,7,0]);received=bytes([9,0,254])
    app=lambda t,n,**f:dict(at_ms=t,event=n,fields=f)
    net=lambda t,raw:app(t,'net.packet',packet=list(raw))
    wire=lambda s,a,f,d=b'',w=16:dict(message='ipv4.tx',fields=dict(packet=list(packet(s,a,f,d,w,False))))
    code=lambda c:dict(message='application',fields=dict(code=c))
    read=lambda d:dict(message='application_data',fields=dict(data=list(d)))
    def add(name,ops,state='ESTABLISHED',variables=None,timers=None,initial=None):
        steps=[]
        for op,rows in ops:
            op=dict(op);op['expect_trace']=[dict(at_ms=t,emitted=emitted)for t,emitted in rows];steps.append(op)
        cases[name]=dict(scenario_version='0.2',id=name,initial=initial or {},steps=steps,expect=dict(state=state,variables=variables or {},timers=timers or {}))
    start=[(app(0,'app.connect'),[(0,[wire(1000,0,2)])]),(net(10,packet(9000,1001,18)),[(10,[code('connected'),wire(1001,9001,16)])])]
    add('bidirectional-cumulative-close',start+[(app(20,'app.send',data=list(odd)),[(20,[code('queued')])]),(app(21,'app.transmit'),[(21,[wire(1001,9001,24,odd[:4])])]),(app(22,'app.transmit'),[(22,[wire(1005,9001,24,odd[4:])])]),(net(30,packet(9001,1006,16)),[(30,[])]),(net(40,packet(9001,1006,24,received)),[(40,[wire(1006,9004,16,w=13)])]),(app(41,'app.receive',count=3),[(41,[read(received),wire(1006,9004,16)])]),(app(50,'app.close'),[(50,[wire(1006,9004,17)])]),(net(60,packet(9004,1007,16)),[(60,[])]),(net(70,packet(9004,1007,17)),[(70,[wire(1007,9005,16),code('peer_eof')])])],state='TIME-WAIT',variables=dict(snd_buf=[],rtx_buf=[],rcv_buf=[]),timers=dict(time_wait=120070))
    add('synack-mss-only',[(app(0,'app.connect'),[(0,[wire(1000,0,2)])]),(net(10,packet(9000,1001,18,mss=1460,ident=65535,ttl=1)),[(10,[code('connected'),wire(1001,9001,16)])])])
    add('syn-loss-retransmission',[(app(0,'app.connect'),[(0,[wire(1000,0,2)])]),(dict(at_ms=1000,tick=True),[(1000,[wire(1000,0,2)])]),(net(1010,packet(9000,1001,18)),[(1010,[code('connected'),wire(1001,9001,16)])])])
    add('data-loss-retransmission',start+[(app(20,'app.send',data=list(odd[:4])),[(20,[code('queued')])]),(app(21,'app.transmit'),[(21,[wire(1001,9001,24,odd[:4])])]),(dict(at_ms=1021,tick=True),[(1021,[wire(1001,9001,24,odd[:4])])]),(net(1030,packet(9001,1005,16)),[(1030,[])])],variables=dict(snd_buf=[],rtx_buf=[],rto_ms=2000))
    add('partial-ack-prefix-retransmission',start+[(app(20,'app.send',data=list(odd)),[(20,[code('queued')])]),(app(21,'app.transmit'),[(21,[wire(1001,9001,24,odd[:4])])]),(net(30,packet(9001,1003,16)),[(30,[])]),(dict(at_ms=1030,tick=True),[(1030,[wire(1003,9001,24,odd[2:4])])]),(net(1040,packet(9001,1005,16)),[(1040,[])]),(app(1041,'app.transmit'),[(1041,[wire(1005,9001,24,odd[4:])])]),(net(1050,packet(9001,1006,16)),[(1050,[])])],variables=dict(snd_buf=[],rtx_buf=[]))
    add('sequence-wrap',[(app(0,'app.connect'),[(0,[wire(4294967293,0,2)])]),(net(10,packet(4294967294,4294967294,18)),[(10,[code('connected'),wire(4294967294,4294967295,16)])]),(app(20,'app.send',data=list(odd[:4])),[(20,[code('queued')])]),(app(21,'app.transmit'),[(21,[wire(4294967294,4294967295,24,odd[:4])])]),(net(30,packet(4294967295,2,16)),[(30,[])]),(net(40,packet(4294967295,2,16,received)),[(40,[wire(2,2,16,w=13)])]),(app(41,'app.receive',count=3),[(41,[read(received),wire(2,2,16)])])],initial=dict(iss=4294967293),variables=dict(snd_nxt=2,snd_una=2,rcv_nxt=2,rcv_buf=[]))
    base=packet(9000,1001,18);bad=bytearray(base);bad[3]+=1;badlen=fix_ip(bytes(bad));badip=bytearray(base);badip[10]^=1;badtcp=bytearray(base);badtcp[36]^=1;badoffset=bytearray(base);badoffset[32]=64;badoffset=fix_tcp(bytes(badoffset))
    for name,raw,disposition in [('short',base[:39],'drop_short'),('bad-ip-length',badlen,'drop_ip_length'),('bad-ip-checksum',bytes(badip),'drop_ip_checksum'),('bad-tcp-length',badoffset,'drop_tcp_length'),('bad-tcp-checksum',bytes(badtcp),'drop_tcp_checksum')]:
        add(name,[(net(0,raw),[(0,[])])],state='CLOSED',variables=dict(wire_disposition=disposition,snd_buf=[],rtx_buf=[],rcv_buf=[]))
    gaps={}
    for name,index,value in [('other-peer',15,3),('other-port',23,65),('ttl-zero',8,0),('ip-options',0,70),('fragment',6,32),('urgent',39,1),('unknown-flags',33,0),('reserved',32,81)]:
        raw=bytearray(base);raw[index]=value;gaps[name]=fix_tcp(fix_ip(bytes(raw))).hex()
    gaps['mss-three']=packet(9000,1001,18,mss=3).hex();raw=bytearray(packet(9000,1001,18,mss=1460));raw[40:44]=bytes([1,1,1,1]);gaps['other-options']=fix_tcp(bytes(raw)).hex()
    gaps['syn-data']=packet(9000,0,2,b'X').hex();gaps['over-mtu']=packet(9001,1001,24,bytes(1461)).hex()
    root=Path(__file__).resolve().parents[2];names=['rfc791.txt','rfc9293.txt','rfc6298.txt','rfc6864.txt']
    return dict(schema='tcp-wire-endpoint-literal-oracle-v1',basis='RFC9293 3.1/3.4/3.7.1/3.9.1.2/.3; RFC7913.1; RFC6298; finite tcp-data original 16-byte/SMSS4/RTO profile',sources={n:hashlib.sha256((root/'spec/sources'/n).read_bytes()).hexdigest()for n in names},cases=cases,model_gaps=gaps)

if __name__=='__main__':print(json.dumps(oracle(),indent=2))
