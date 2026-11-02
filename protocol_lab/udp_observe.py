"""Independent fixed-header IPv4/UDP observation only; never encode protocol bytes."""
import ipaddress
import struct
from pathlib import Path


def checksum_valid(raw):
    # Independently byte-weighted sum; no reference IR checksum or C helper.
    total=sum(value*(256 if i%2==0 else 1)for i,value in enumerate(raw))
    while total>65535:total=(total&65535)+(total>>16)
    return total==65535


def decode_packet(raw):
    if len(raw)<28:raise ValueError('Truncated IPv4/UDP packet')
    version,tos,total,ident,fragment,ttl,proto,header_sum,src,dst=struct.unpack('!BBHHHBBH4s4s',raw[:20])
    if version!=0x45 or proto!=17 or fragment&0xbfff:raise ValueError('Unsupported IPv4/UDP header shape')
    if total!=len(raw):raise ValueError('IPv4 length mismatch')
    if not checksum_valid(raw[:20]):raise ValueError('Invalid IPv4 header checksum')
    sport,dport,length,udp_sum=struct.unpack('!HHHH',raw[20:28])
    if length<8 or length!=len(raw)-20:raise ValueError('UDP length mismatch')
    if udp_sum and not checksum_valid(src+dst+struct.pack('!BBH',0,17,length)+raw[20:]):raise ValueError('Invalid UDP checksum')
    return dict(src=str(ipaddress.IPv4Address(src)),dst=str(ipaddress.IPv4Address(dst)),source_port=sport,destination_port=dport,
                ip_length=total,udp_length=length,identification=ident,df=bool(fragment&0x4000),ttl=ttl,tos=tos,
                ip_checksum=header_sum,udp_checksum=udp_sum,payload_hex=raw[28:].hex())


def decode_pcap(path):
    data=Path(path).read_bytes()
    if len(data)<24 or struct.unpack('<IHHIIII',data[:24])!=(0xa1b2c3d4,2,4,0,0,65535,101):raise ValueError('Unsupported PCAP header')
    offset=24;records=[]
    while offset<len(data):
        if len(data)-offset<16:raise ValueError('Truncated PCAP record')
        sec,usec,captured,original=struct.unpack('<IIII',data[offset:offset+16]);offset+=16
        if captured!=original or captured>65535 or usec>=1000000 or usec%1000 or len(data)-offset<captured:raise ValueError('Invalid PCAP record')
        raw=data[offset:offset+captured];offset+=captured
        records.append(dict(at_ms=sec*1000+usec//1000,hex=raw.hex(),decoded=decode_packet(raw)))
    return records


def compare_records(expected,observed):
    return dict(status='match'if expected==observed else'different',expected=expected,observed=observed)
