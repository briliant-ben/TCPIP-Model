"""Offline controller oracle construction, never imported by protocol runtime/tests.

Uses struct and a separate word accumulator, not Protocol IR/reference/native code.
Run explicitly to reproduce literal oracle bytes; review/pin outputs before execution.
"""
import json
import struct
from pathlib import Path

SRC=bytes([192,0,2,2]);DST=bytes([192,0,2,1])


def checksum(raw):
    if len(raw)%2:raw+=b'\0'
    value=sum(struct.unpack('!'+str(len(raw)//2)+'H',raw))
    while value>>16:value=(value&65535)+(value>>16)
    return value^65535


def packet(data,absent=False):
    length=8+len(data);udp=struct.pack('!HHHH',8080,40000,length,0)+data
    value=checksum(SRC+DST+struct.pack('!BBH',0,17,length)+udp)
    udp=udp[:6]+struct.pack('!H',0 if absent else value or 65535)+udp[8:]
    ip=struct.pack('!BBHHHBBH4s4s',69,0,20+length,0,16384,64,17,0,SRC,DST)
    return ip[:10]+struct.pack('!H',checksum(ip))+ip[12:]+udp


def fix_ip(raw):return raw[:10]+struct.pack('!H',checksum(raw[:10]+b'\0\0'+raw[12:20]))+raw[12:]


def oracle():
    cases={}
    def add(name,raw,disposition,data=b'',require_checksum=False):
        cases[name]=dict(hex=raw.hex(),require_checksum=require_checksum,disposition=disposition,data=list(data))
    add('empty',packet(b''),'deliver')
    add('odd-NUL',packet(bytes([0,128,255,7,0])),'deliver',bytes([0,128,255,7,0]))
    zero=next(struct.pack('!H',n)for n in range(65536)if packet(struct.pack('!H',n))[26:28]==b'\xff\xff')
    # Explicitly verify genuine computed zero, not merely a 0xffff field coincidence.
    udp=struct.pack('!HHHH',8080,40000,10,0)+zero
    assert checksum(SRC+DST+struct.pack('!BBH',0,17,10)+udp)==0
    add('zero-mapped',packet(zero),'deliver',zero)
    add('absent-allowed',packet(b'hello',True),'deliver',b'hello')
    add('absent-required',packet(b'hello',True),'drop_absent',require_checksum=True)
    raw=bytearray(packet(b'hello'));raw[-1]^=1;add('bad-udp-checksum',bytes(raw),'drop_udp_checksum')
    raw=bytearray(packet(b'hello'));raw[10]^=1;add('bad-ip-checksum',bytes(raw),'drop_ip_checksum')
    raw=bytearray(packet(b'hello'));raw[3]+=1;add('bad-ip-length',fix_ip(bytes(raw)),'drop_ip_length')
    raw=bytearray(packet(b'hello',True));raw[24:26]=struct.pack('!H',7);add('udp-short-length',bytes(raw),'drop_udp_length')
    raw=bytearray(packet(b'hello',True));raw[24:26]=struct.pack('!H',14);add('udp-over-length',bytes(raw),'drop_udp_length')
    add('short-packet',packet(b'')[:27],'drop_short')
    maximum=bytes(n%256 for n in range(1472));add('mtu',packet(maximum),'deliver',maximum)
    gaps={}
    for name,index,value in [('options',0,70),('fragment',6,32),('other-port',23,65),('other-peer',15,3),('ttl',8,63)]:
        raw=bytearray(packet(b'hello'));raw[index]=value;gaps[name]=bytes(raw).hex()
    raw=bytearray(packet(b'hello'));raw.extend(b'xyz');raw[2:4]=struct.pack('!H',len(raw));gaps['udp-surplus']=fix_ip(bytes(raw)).hex()
    gaps['over-mtu']=packet(bytes(1473)).hex()
    return dict(schema='udp-wire-receive-literal-oracle-v1',basis='RFC768 Fields + RFC1122 3.2.1.2/4.1.3.4, explicit finite profile',cases=cases,model_gaps=gaps)


if __name__=='__main__':
    root=Path(__file__).resolve().parents[2]
    print(json.dumps(oracle(),indent=2))
