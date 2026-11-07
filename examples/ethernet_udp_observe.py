"""Independent Ethernet-II IPv4/UDP output observer, never a subject codec."""
import struct
from protocol_lab.udp_observe import decode_packet


def decode_frame(frame):
    if not 60<=len(frame)<=1514 or frame[12:14]!=b'\x08\0':raise ValueError('Outside Ethernet-II IPv4 output shape')
    length=struct.unpack('!H',frame[16:18])[0]
    if length<28 or len(frame)!=14+max(46,length):raise ValueError('Ethernet/IP length or padding differs')
    if any(frame[14+length:]):raise ValueError('Nonzero Ethernet padding')
    decoded=decode_packet(frame[14:14+length])
    return dict(destination=frame[:6].hex(),source=frame[6:12].hex(),ethertype=2048,padding_bytes=len(frame)-14-length,ip_udp=decoded)
