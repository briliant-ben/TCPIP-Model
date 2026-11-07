"""Independent Ethernet-II/ARP observation only; never a protocol implementation."""
import ipaddress
import struct


def decode_frame(raw):
    if len(raw)<42:raise ValueError('Short Ethernet ARP frame')
    dst,src,etype,hardware,protocol,hlen,plen,opcode,sha,spa,tha,tpa=struct.unpack('!6s6sHHHBBH6s4s6s4s',raw[:42])
    if (etype,hardware,protocol,hlen,plen)!=(0x0806,1,0x0800,6,4)or opcode not in (1,2):raise ValueError('Unsupported Ethernet ARP format')
    return dict(destination=dst.hex(),source=src.hex(),opcode=opcode,sender_mac=sha.hex(),sender_ip=str(ipaddress.IPv4Address(spa)),target_mac=tha.hex(),target_ip=str(ipaddress.IPv4Address(tpa)),padding_hex=raw[42:].hex())
