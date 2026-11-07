"""Offline independent struct oracle; never imported by subject or tests.

Freeze/review literal bytes before executing model. No IR imports or generator.
"""
import json
import struct

LOCAL=bytes([192,0,2,1]);PEER=bytes([192,0,2,2])


def checksum(raw):
    words=raw+b'\0'*(len(raw)%2);total=sum(struct.unpack('!'+str(len(words)//2)+'H',words))
    while total>65535:total=(total&65535)+(total>>16)
    return 65535-total


def ip(body,src=PEER,dst=LOCAL,ident=0,ttl=64):
    header=struct.pack('!BBHHHBBH4s4s',69,0,20+len(body),ident,16384,ttl,1,0,src,dst)
    return header[:10]+struct.pack('!H',checksum(header))+header[12:]+body


def echo(data,identifier=0x1234,sequence=0xabcd,kind=8):
    body=struct.pack('!BBHHH',kind,0,0,identifier,sequence)+data
    return body[:2]+struct.pack('!H',checksum(body))+body[4:]


def oracle():
    cases={}
    def valid(name,data=b'',identifier=0x1234,sequence=0xabcd,ip_id=0,ttl=64):
        raw=ip(echo(data,identifier,sequence),ident=ip_id,ttl=ttl)
        reply=ip(echo(data,identifier,sequence,0),LOCAL,PEER)
        cases[name]=dict(hex=raw.hex(),reply_hex=reply.hex(),disposition='reply')
    def invalid(name,raw,disposition):cases[name]=dict(hex=raw.hex(),reply_hex='',disposition=disposition)
    valid('empty');valid('odd-NUL',bytes([0,128,255,7,0]));valid('identifier-sequence-zero',identifier=0,sequence=0)
    valid('request-checksum-zero',identifier=0xf7ff,sequence=0)
    valid('reply-checksum-zero',b'\xff\xff',identifier=0,sequence=0)
    valid('atomic-id-ffff',b'ID',ip_id=65535);valid('ttl-one',b'TTL',ttl=1);valid('ttl-255',b'TTL',ttl=255)
    valid('mtu',bytes(n%256 for n in range(1472)))
    raw=bytearray.fromhex(cases['odd-NUL']['hex']);raw[-1]^=1;invalid('bad-icmp-checksum',raw,'drop_icmp_checksum')
    raw=bytearray.fromhex(cases['odd-NUL']['hex']);raw[10]^=1;invalid('bad-ip-checksum',raw,'drop_ip_checksum')
    raw=bytearray.fromhex(cases['odd-NUL']['hex']);raw[2:4]=struct.pack('!H',len(raw)+1);raw[10:12]=b'\0\0';raw[10:12]=struct.pack('!H',checksum(raw[:20]));invalid('bad-ip-length',raw,'drop_ip_length')
    invalid('short',bytes.fromhex(cases['empty']['hex'])[:27],'drop_short')
    gaps={}
    for name,index,value in [('options',0,70),('tos',1,1),('fragment',6,32),('ttl-zero',8,0),('other-protocol',9,17),('other-peer',15,3),('other-local',19,3),('reply-input',20,0),('other-code',21,1)]:
        raw=bytearray.fromhex(cases['empty']['hex']);raw[index]=value
        # Make domain probes independently valid checksums where profile permits layout.
        raw[22:24]=b'\0\0';raw[22:24]=struct.pack('!H',checksum(raw[20:]))
        raw[10:12]=b'\0\0';raw[10:12]=struct.pack('!H',checksum(raw[:20]));gaps[name]=raw.hex()
    gaps['over-mtu']=ip(echo(bytes(1473))).hex()
    return dict(schema='icmp-echo-literal-oracle-v1',basis='RFC792 Echo pp14-15; RFC1122 3.2.2/3.2.2.6; finite atomic IPv4 profile',cases=cases,model_gaps=gaps)


if __name__=='__main__':print(json.dumps(oracle(),indent=2))
