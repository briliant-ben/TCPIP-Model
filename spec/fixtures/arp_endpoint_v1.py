"""Offline struct-based controller fixtures; no IR/reference/subject code used."""
import json
import struct
L=bytes.fromhex('020000000001');A=bytes.fromhex('020000000002');B=bytes.fromhex('020000000003')
LI=bytes([192,0,2,1]);PI=bytes([192,0,2,2]);OTHER=bytes([192,0,2,3])


def frame(op,sha,spa,tha,tpa,destination,padding=b''):
    return destination+sha+struct.pack('!HHHBBH',0x0806,1,0x0800,6,4,op)+sha+spa+tha+tpa+padding


def oracle():
    request=frame(1,L,LI,bytes(6),PI,bytes([255])*6,bytes(18))
    reply=lambda mac:frame(2,L,LI,mac,PI,mac,bytes(18))
    pa=frame(2,A,PI,L,LI,L);pb=frame(2,B,PI,L,LI,L)
    qa=frame(1,A,PI,bytes(6),LI,bytes([255])*6);qb=frame(1,B,PI,bytes(6),LI,bytes([255])*6)
    foreign=lambda mac:frame(1,mac,PI,bytes(6),OTHER,bytes([255])*6)
    wire=lambda raw:dict(message='ethernet.tx',fields=dict(frame=list(raw)))
    resolved=lambda mac:dict(message='neighbor.resolved',fields=dict(ip=list(PI),mac=list(mac)))
    failed=dict(message='neighbor.failed',fields=dict(ip=list(PI)))
    send=lambda at:dict(at_ms=at,event='app.resolve',fields=dict(ip=list(PI)))
    net=lambda at,raw:dict(at_ms=at,event='net.frame',fields=dict(frame=list(raw)))
    cfg=lambda at,n:dict(at_ms=at,event='app.cache_ttl',fields=dict(milliseconds=n))
    tick=lambda at:dict(at_ms=at,tick=True)
    cases={}
    def add(name,steps,state,mac=b'',timers=None,ttl=60000,retries=0):
        declared=[]
        for operation,trace in steps:
            op=operation.copy();op['expect_trace']=[dict(at_ms=at,emitted=messages)for at,messages in trace];declared.append(op)
        cases[name]=dict(scenario_version='0.2',id=name,initial={},steps=declared,expect=dict(state=state,variables=dict(peer_mac=list(mac),retry_count=retries,cache_ttl_ms=ttl),timers=timers or {}))
    add('resolve-reply-hit',[(send(0),[(0,[wire(request)])]),(net(10,pa),[(10,[resolved(A)])]),(send(20),[(20,[resolved(A)])])],'RESOLVED',A,dict(cache=60010))
    add('incoming-request',[(net(0,qa),[(0,[wire(reply(A))])])],'RESOLVED',A,dict(cache=60000))
    add('simultaneous-request',[(send(0),[(0,[wire(request)])]),(net(10,qb),[(10,[wire(reply(B)),resolved(B)])])],'RESOLVED',B,dict(cache=60010))
    add('merge-before-target',[(net(0,qa),[(0,[wire(reply(A))])]),(net(10,foreign(B)),[(10,[])]),(send(20),[(20,[resolved(B)])])],'RESOLVED',B,dict(cache=60010))
    add('nonlocal-empty',[(net(0,foreign(A)),[(0,[])])],'EMPTY')
    add('retry-failure',[(send(0),[(0,[wire(request)])]),(send(10),[(10,[])]),(tick(1000),[(1000,[wire(request)])]),(tick(2000),[(2000,[failed])])],'EMPTY')
    add('expire-before-query',[(net(0,pa),[(0,[])]),(send(60000),[(60000,[]),(60000,[wire(request)])])],'PENDING',timers=dict(query=61000))
    add('refresh-extends',[(net(0,pa),[(0,[])]),(net(59999,foreign(B)),[(59999,[])]),(tick(60000),[]),(send(60001),[(60001,[resolved(B)])])],'RESOLVED',B,dict(cache=119999))
    add('configure-ttl',[(cfg(0,120000),[(0,[])]),(net(10,pa),[(10,[])]),(cfg(20,60000),[(20,[])]),(tick(60020),[(60020,[])])],'EMPTY')
    add('reply-replaces',[(net(0,pa),[(0,[])]),(net(5,pb),[(5,[])]),(send(10),[(10,[resolved(B)])])],'RESOLVED',B,dict(cache=60005))
    add('padding-ignored',[(net(0,qa+bytes(range(18))),[(0,[wire(reply(A))])])],'RESOLVED',A,dict(cache=60000))
    add('short-entry',[(net(0,bytes(14)),[(0,[])])],'EMPTY')
    add('pending-nonlocal',[(send(0),[(0,[wire(request)])]),(net(5,foreign(A)),[(5,[])]),(net(10,pa),[(10,[resolved(A)])])],'RESOLVED',A,dict(cache=60010))
    gaps={}
    for name,index,value in [('hlen',18,4),('other-sender-ip',31,3),('source-sha-mismatch',6,4),('opcode',21,3),('other-ethernet-target',5,9)]:
        raw=bytearray(pa);raw[index]=value;gaps[name]=dict(event='net.frame',fields=dict(frame=list(raw)))
    gaps['vlan']=dict(event='net.frame',fields=dict(frame=list(pa[:12]+bytes.fromhex('810000010806')+pa[14:])))
    raw=bytearray(pa);raw[6]=raw[22]=4;gaps['unsupported-mac-prefix']=dict(event='net.frame',fields=dict(frame=list(raw)))
    gaps['oversized']=dict(event='net.frame',fields=dict(frame=list(pa+bytes(19))))
    gaps['other-query']=dict(event='app.resolve',fields=dict(ip=list(OTHER)))
    gaps['ttl-zero']=dict(event='app.cache_ttl',fields=dict(milliseconds=0))
    return dict(schema='arp-endpoint-literal-v1',basis='RFC826 Packet Generation/Reception; RFC1122 2.3.2.1 plus declared finite profile',cases=cases,model_gaps=gaps,request_hex=request.hex(),peer_reply_hex=pa.hex())


if __name__=='__main__':print(json.dumps(oracle(),indent=2))
