"""Independent offline struct oracle, frozen before combined IR execution.

No IR/reference/compiler imports. Builder is never imported by runtime/tests.
"""
import json
import struct
L=bytes.fromhex('020000000001');A=bytes.fromhex('020000000002');B=bytes.fromhex('020000000003')
LI=bytes([192,0,2,1]);PI=bytes([192,0,2,2])

def checksum(raw):
    raw+=b'\0'*(len(raw)%2);total=sum(struct.unpack('!'+str(len(raw)//2)+'H',raw))
    while total>>16:total=(total&65535)+(total>>16)
    return total^65535

def arp(op,sha,spa,tha,tpa,dst,pad=False):
    raw=dst+sha+struct.pack('!HHHBBH',0x0806,1,0x0800,6,4,op)+sha+spa+tha+tpa
    return raw+bytes(18)if pad else raw

def packet(data,enabled=True):
    length=8+len(data);udp=struct.pack('!HHHH',40000,8080,length,0)+data
    value=checksum(LI+PI+struct.pack('!BBH',0,17,length)+udp)
    udp=udp[:6]+struct.pack('!H',(value or 65535)if enabled else 0)+udp[8:]
    ip=struct.pack('!BBHHHBBH4s4s',69,0,20+length,0,16384,64,17,0,LI,PI)
    return ip[:10]+struct.pack('!H',checksum(ip))+ip[12:]+udp

def ethernet(data,mac=A,enabled=True):
    raw=packet(data,enabled);return mac+L+struct.pack('!H',0x0800)+raw+bytes(max(0,46-len(raw)))

def oracle():
    request=arp(1,L,LI,bytes(6),PI,bytes([255])*6,True)
    response=lambda mac:arp(2,mac,PI,L,LI,L)
    query=arp(1,A,PI,bytes(6),LI,bytes([255])*6)
    answer=arp(2,L,LI,A,PI,A,True)
    foreign=arp(1,A,PI,bytes(6),bytes([192,0,2,3]),bytes([255])*6)
    wire=lambda raw:dict(message='ethernet.tx',fields=dict(frame=list(raw)))
    resolved=lambda mac:dict(message='neighbor.resolved',fields=dict(ip=list(PI),mac=list(mac)))
    fail=dict(message='neighbor.failed',fields=dict(ip=list(PI)))
    udp_fail=dict(message='udp.send_failed',fields=dict(reason='arp_timeout'))
    send=lambda at,data:dict(at_ms=at,event='app.send',fields=dict(data=list(data)))
    net=lambda at,raw:dict(at_ms=at,event='net.frame',fields=dict(frame=list(raw)))
    resolve=lambda at:dict(at_ms=at,event='app.resolve',fields=dict(ip=list(PI)))
    tick=lambda at:dict(at_ms=at,tick=True)
    cfg=lambda at,b:dict(at_ms=at,event='app.configure_checksum',fields=dict(enabled=b))
    cases={}
    def add(name,ops,state='RESOLVED',mac=A,timers=None,pending=b'',retries=0,enabled=True):
        steps=[]
        for step,trace in ops:
            step=step.copy();step['expect_trace']=[dict(at_ms=at,emitted=emitted)for at,emitted in trace];steps.append(step)
        cases[name]=dict(scenario_version='0.2',id=name,initial={},steps=steps,expect=dict(state=state,variables=dict(peer_mac=list(mac),retry_count=retries,pending_packet=list(pending),checksums_enabled=enabled),timers=timers or {}))
    odd=bytes([0,128,255,7,0])
    add('cold-empty-then-cached',[(send(0,b''),[(0,[wire(request)])]),(net(10,response(A)),[(10,[resolved(A),wire(ethernet(b''))])]),(send(11,odd),[(11,[wire(ethernet(odd))])])],timers=dict(cache=60010))
    add('latest-replaces',[(send(0,b'a'),[(0,[wire(request)])]),(send(1,odd),[(1,[])]),(net(2,response(A)),[(2,[resolved(A),wire(ethernet(odd))])])],timers=dict(cache=60002))
    add('retry-then-fail-clears',[(send(0,b'a'),[(0,[wire(request)])]),(tick(1000),[(1000,[wire(request)])]),(send(1500,odd),[(1500,[])]),(tick(2000),[(2000,[fail,udp_fail])])],state='EMPTY',mac=b'')
    add('same-deadline-replace',[(send(0,b'a'),[(0,[wire(request)])]),(send(1000,odd),[(1000,[wire(request)]),(1000,[])]),(net(1001,response(A)),[(1001,[resolved(A),wire(ethernet(odd))])])],timers=dict(cache=61001))
    add('cache-expiry-before-send',[(send(0,b'a'),[(0,[wire(request)])]),(net(1,response(A)),[(1,[resolved(A),wire(ethernet(b'a'))])]),(send(60001,odd),[(60001,[]),(60001,[wire(request)])])],state='PENDING',mac=b'',timers=dict(query=61001),pending=packet(odd))
    add('checksum-policy-freezes-queued',[(send(0,odd),[(0,[wire(request)])]),(cfg(1,False),[(1,[])]),(net(2,response(A)),[(2,[resolved(A),wire(ethernet(odd))])]),(send(3,odd),[(3,[wire(ethernet(odd,enabled=False))])])],timers=dict(cache=60002),enabled=False)
    add('unsolicited-learn-before-send',[(net(0,response(A)),[(0,[])]),(send(1,b''),[(1,[wire(ethernet(b''))])]),(resolve(2),[(2,[resolved(A)])])],timers=dict(cache=60000))
    add('resolve-before-queued-send',[(resolve(0),[(0,[wire(request)])]),(send(5,odd),[(5,[])]),(net(10,response(A)),[(10,[resolved(A),wire(ethernet(odd))])])],timers=dict(cache=60010))
    add('simultaneous-request-reply-order',[(send(0,odd),[(0,[wire(request)])]),(net(1,query),[(1,[wire(answer),resolved(A),wire(ethernet(odd))])])],timers=dict(cache=60001))
    add('one-flush-no-stale-replay',[(send(0,odd),[(0,[wire(request)])]),(net(1,response(A)),[(1,[resolved(A),wire(ethernet(odd))])]),(net(2,response(A)),[(2,[])]),(send(3,b''),[(3,[wire(ethernet(b''))])])],timers=dict(cache=60002))
    for name,data in [('mtu',bytes(i%256 for i in range(1472))),('padding-one',bytes(range(17))),('padding-zero',bytes(range(18)))]:
        add(name,[(send(0,data),[(0,[wire(request)])]),(net(1,response(A)),[(1,[resolved(A),wire(ethernet(data))])])],timers=dict(cache=60001))
    pseudo=LI+PI+struct.pack('!BBHHHHH',0,17,10,40000,8080,10,0)
    zero=struct.pack('!H',checksum(pseudo+b'\0\0'));assert packet(zero)[26:28]==b'\xff\xff'
    add('udp-zero-is-ffff',[(send(0,zero),[(0,[wire(request)])]),(net(1,response(A)),[(1,[resolved(A),wire(ethernet(zero))])])],timers=dict(cache=60001))
    add('resolve-only-no-udp-failure',[(resolve(0),[(0,[wire(request)])]),(tick(2000),[(1000,[wire(request)]),(2000,[fail])])],state='EMPTY',mac=b'')
    add('empty-data-replaces-not-empty-queue',[(send(0,odd),[(0,[wire(request)])]),(send(5,b''),[(5,[])]),(net(6,response(A)),[(6,[resolved(A),wire(ethernet(b''))])])],timers=dict(cache=60006))
    add('nonlocal-does-not-flush',[(send(0,odd),[(0,[wire(request)])]),(net(1,foreign),[(1,[])]),(net(2,response(B)),[(2,[resolved(B),wire(ethernet(odd,B))])])],mac=B,timers=dict(cache=60002))
    return dict(schema='arp-udp-transmit-literal-oracle-v1',basis='RFC1122 2.3.2.2 latest unresolved packet; RFC894 Frame Format+verified errata570; RFC826/768/791/6864',request_hex=request.hex(),peer_reply_hex=response(A).hex(),cases=cases,over_mtu_data=list(bytes(1473)))

if __name__=='__main__':print(json.dumps(oracle(),indent=2))
