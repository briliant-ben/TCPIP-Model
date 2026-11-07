"""Independent raw IPv4/ICMP observer; never used to generate subject bytes."""
import socket
import struct


def checksum(raw):
    total=0
    for index in range(0,len(raw),2):
        total+=(raw[index]<<8)+(raw[index+1]if index+1<len(raw)else 0)
        total=(total&65535)+(total>>16)
    return (~((total&65535)+(total>>16)))&65535


def decode_packet(raw):
    if len(raw)<28:raise ValueError('Short IP/ICMP header')
    v,tos,total,ident,frag,ttl,proto,ipcheck,src,dst=struct.unpack('!BBHHHBBH4s4s',raw[:20])
    if v!=69 or total!=len(raw)or frag!=16384 or proto!=1 or ttl==0:raise ValueError('Outside exact atomic IHL5 ICMP packet shape')
    if checksum(raw[:20])or checksum(raw[20:]):raise ValueError('Invalid IP/ICMP checksum')
    kind,code,check,identifier,sequence=struct.unpack('!BBHHH',raw[20:28])
    if kind not in (0,8)or code!=0:raise ValueError('Outside Echo Request/Reply')
    return dict(source=socket.inet_ntoa(src),destination=socket.inet_ntoa(dst),type=kind,code=code,identifier=identifier,sequence=sequence,ip_id=ident,ttl=ttl,tos=tos,ip_checksum=ipcheck,icmp_checksum=check,length=total,data_hex=raw[28:].hex())
