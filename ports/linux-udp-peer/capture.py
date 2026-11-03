"""Independent actual classic-PCAP RAW UDP decoding, separate from IR execution."""
import struct
from pathlib import Path
from protocol_lab.udp_observe import decode_packet


def records(path):
    raw=Path(path).read_bytes()
    magics={b'\xd4\xc3\xb2\xa1':('<',1000),b'\xa1\xb2\xc3\xd4':('>',1000),b'\x4d\x3c\xb2\xa1':('<',1),b'\xa1\xb2\x3c\x4d':('>',1)}
    if len(raw)<24 or raw[:4]not in magics:raise ValueError('Invalid classic PCAP')
    endian,factor=magics[raw[:4]]
    major,minor,zone,accuracy,snap,link=struct.unpack(endian+'HHIIII',raw[4:24])
    if (major,minor)!=(2,4)or link!=101 or snap<=0:raise ValueError('Expected raw-IP PCAP')
    offset=24;previous=-1;result=[]
    while offset<len(raw):
        if offset+16>len(raw):raise ValueError('Truncated PCAP record')
        sec,frac,size,original=struct.unpack(endian+'IIII',raw[offset:offset+16]);offset+=16
        stamp=sec*1000000000+frac*factor
        if frac>=1000000000//factor or size!=original or size>snap or offset+size>len(raw)or stamp<previous:raise ValueError('Invalid PCAP packet/time')
        packet=raw[offset:offset+size];offset+=size;previous=stamp
        result.append(dict(timestamp_ns=stamp,hex=packet.hex(),decoded=decode_packet(packet)))
    return result
