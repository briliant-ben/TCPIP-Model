"""Independent post-observation RFC792 Echo byte oracle, never subject encoder.

Called only after live native exchange in the driver. No IR imports/evaluation.
Literal fixture tests freeze policy before the real peer run.
"""
import struct


def checksum(raw):
    raw=raw+b'\0'*(len(raw)%2)
    total=sum(struct.unpack('!'+str(len(raw)//2)+'H',raw))
    while total>>16:total=(total&65535)+(total>>16)
    return total^65535


def expected_reply(request):
    if len(request)<28 or len(request)>1500:raise ValueError('Oracle ingress length outside profile')
    v,tos,total,ident,frag,ttl,proto,check,src,dst=struct.unpack('!BBHHHBBH4s4s',request[:20])
    if v!=69 or tos!=0 or total!=len(request)or frag!=16384 or ttl==0 or proto!=1 or src!=bytes([192,0,2,2])or dst!=bytes([192,0,2,1]):raise ValueError('Oracle ingress outside declared profile')
    if request[20:22]!=b'\x08\0'or checksum(request[:20])or checksum(request[20:]):raise ValueError('Invalid Echo request')
    body=b'\0\0\0\0'+request[24:]
    body=body[:2]+struct.pack('!H',checksum(body))+body[4:]
    header=struct.pack('!BBHHHBBH4s4s',69,0,len(request),0,16384,64,1,0,dst,src)
    return header[:10]+struct.pack('!H',checksum(header))+header[12:]+body


def assert_echo(request,reply):
    if reply!=expected_reply(request):raise ValueError('Independent exact Echo byte oracle differs')
