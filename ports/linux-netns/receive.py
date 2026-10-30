"""Finite stimulus rendering only; TCP state and delivery remain Protocol IR."""
from protocol_lab.ir import require

CASE='receive-four-zero-octets'


def render(scene,packets):
    require(scene['initial']=={} and scene['environment']['drop_outgoing']==[],'Unsupported receive initial/loss setup')
    require(scene['steps']==[
        {'at_ms':0,'event':'app.connect','fields':{}},
        {'at_ms':10,'event':'net.synack','fields':{'seq':9000,'ack':1001,'window':8}},
        {'at_ms':20,'event':'net.data','fields':{'seq':9001,'ack':1001,'window':8,'data':[0,0,0,0]}}],
        'Only the declared zero-octet receive stimulus is supported')
    require([p['flags']for p in packets]==['S','SA','A','A','A'],'Unexpected receive packet shape')
    require([p['direction']for p in packets]==['out','in','out','in','out'],'Unexpected receive packet directions')
    require(packets[3]['payload']==[0,0,0,0],'Packetdrill cannot represent arbitrary incoming TCP payload octets')
    lines=['// GENERATED finite receive stimuli from Protocol IR; ACKs observed independently.',
        '// No application reads, PSH, loss or internal kernel receive-buffer claim.',
        '0 socket(..., SOCK_STREAM, IPPROTO_TCP) = 3',
        '+0 fcntl(3, F_SETFL, O_RDWR|O_NONBLOCK) = 0',
        '+0 connect(3, ..., ...) = -1 EINPROGRESS (Operation now in progress)']
    mapping=[];previous=0
    for i in (0,1,3):
        p=packets[i];delta=(p['time_ms']-previous)/1000;previous=p['time_ms']
        # Pinned packetdrill injects zero-filled TCP payload for the declared length.
        # No outgoing ACK timing/shape expectation is imposed by this driver: all
        # such packets remain in independent capture and the complete strict oracle.
        if i==0:line=f'+{delta:.3f} > S 0:0(0) <...>'
        elif i==1:line=f'+{delta:.3f} < S. 0:0(0) ack 1 win 8'
        else:line=f'+{delta:.3f} < . 1:5(4) ack 1 win 8'
        lines.append('// '+p['packet_id']);lines.append(line)
        mapping.append(dict(line=len(lines),packet_id=p['packet_id'],event_id=p['event_id']))
    lines.append('+0 getsockopt(3, SOL_SOCKET, SO_ERROR, [0], [4]) = 0')
    return '\n'.join(lines)+'\n',mapping
