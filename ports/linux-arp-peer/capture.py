"""Independent Ethernet ARP classic-PCAP decoder; never an encoder/subject."""
import struct
from pathlib import Path
from examples.arp_observe import decode_frame


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
