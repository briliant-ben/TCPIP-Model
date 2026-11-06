"""Independent actual classic-PCAP RAW TCP decoding, separate from IR execution."""
import struct
from pathlib import Path
import socket

def checksum_valid(raw):
    total=sum(value*(256 if i%2==0 else 1)for i,value in enumerate(raw))
    while total>>16:total=(total&65535)+(total>>16)
    return total==65535

def decode_packet(raw):
    if len(raw)<40 or raw[0]>>4!=4:raise ValueError('Short/non-IPv4 TCP packet')
    ihl=(raw[0]&15)*4;total=struct.unpack('!H',raw[2:4])[0]
    if ihl<20 or len(raw)<ihl+20 or total!=len(raw)or raw[9]!=6:raise ValueError('Invalid IPv4 TCP extent')
    fragment=struct.unpack('!H',raw[6:8])[0]
    if fragment&0x3fff:raise ValueError('Fragmented TCP not decoded')
    if not checksum_valid(raw[:ihl]):raise ValueError('Invalid IPv4 checksum')
    tcp=raw[ihl:];sport,dport,seq,ack,offset,flags,window,check,urgent=struct.unpack('!HHIIBBHHH',tcp[:20]);header=(offset>>4)*4
    if header<20 or header>len(tcp):raise ValueError('Invalid TCP header extent')
    pseudo=raw[12:20]+struct.pack('!BBH',0,6,len(tcp))
    if not checksum_valid(pseudo+tcp):raise ValueError('Invalid TCP checksum')
    return dict(source=socket.inet_ntoa(raw[12:16]),destination=socket.inet_ntoa(raw[16:20]),source_port=sport,destination_port=dport,seq=seq,ack=ack,flags=flags,window=window,payload_hex=tcp[header:].hex(),options_hex=tcp[20:header].hex(),tcp_header_bytes=header,ip_header_bytes=ihl,ttl=raw[8],ip_id=struct.unpack('!H',raw[4:6])[0],df=bool(fragment&16384),tos=raw[1],urgent=urgent,reserved=offset&15)



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
