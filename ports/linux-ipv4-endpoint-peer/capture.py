"""Independent Ethernet ARP UDP and ICMP classic-PCAP decoder; never an encoder/subject."""
import struct
from pathlib import Path
from examples.arp_observe import decode_frame as arp
from protocol_lab.udp_observe import decode_packet as udp
from examples.icmp_observe import decode_packet as icmp

def decode_frame(frame):
    if len(frame)<14:raise ValueError('Short Ethernet frame')
    if frame[12:14]==b"\x08\x06":return dict(kind='arp',fields=arp(frame))
    if frame[12:14]!=b"\x08\0"or len(frame)<34:raise ValueError('Outside selected Ethernet IPv4 channel')
    length=struct.unpack('!H',frame[16:18])[0]
    if length<28 or len(frame)not in (14+length,14+max(46,length))or len(frame)>1514:raise ValueError('Ethernet/IP length mismatch')
    packet=frame[14:14+length];proto=packet[9]
    if proto not in (1,17):raise ValueError('Outside selected UDP/ICMP IPv4 channel')
    return dict(kind='udp'if proto==17 else'icmp',source=frame[6:12].hex(),destination=frame[:6].hex(),padding_hex=frame[14+length:].hex(),fields=(udp if proto==17 else icmp)(packet))


def records(path):
    raw=Path(path).read_bytes();magics={b'\xd4\xc3\xb2\xa1':('<',1000),b'\xa1\xb2\xc3\xd4':('>',1000),b'\x4d\x3c\xb2\xa1':('<',1),b'\xa1\xb2\x3c\x4d':('>',1)}
    if len(raw)<24 or raw[:4]not in magics:raise ValueError('Classic PCAP required')
    endian,factor=magics[raw[:4]];major,minor,zone,accuracy,snap,link=struct.unpack(endian+'HHIIII',raw[4:24])
    if (major,minor)!=(2,4)or snap<=0 or link!=1:raise ValueError('Ethernet PCAP required')
    pos=24;previous=-1;result=[]
    while pos<len(raw):
        if pos+16>len(raw):raise ValueError('Truncated PCAP header')
        sec,frac,n,original=struct.unpack(endian+'IIII',raw[pos:pos+16]);pos+=16;stamp=sec*1000000000+frac*factor
        if frac>=1000000000//factor or n!=original or n>snap or pos+n>len(raw)or stamp<previous:raise ValueError('Invalid PCAP length/time')
        frame=raw[pos:pos+n];pos+=n;previous=stamp
        result.append(dict(timestamp_ns=stamp,hex=frame.hex(),decoded=decode_frame(frame)))
    return result
