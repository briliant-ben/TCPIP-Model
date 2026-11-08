"""Independent post-observation checks; never invoked to drive the subject."""
import importlib.util
from pathlib import Path
import struct
from protocol_lab.udp_observe import checksum_valid, decode_packet

ROOT=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('independent_ipv4_echo_oracle',ROOT/'ports/linux-ipv4-endpoint-peer/oracle.py')
echo=importlib.util.module_from_spec(spec);spec.loader.exec_module(echo)


def ipv4_frame(raw, direction):
    if direction not in ('ingress','egress') or len(raw)<34 or raw[12:14]!=b'\x08\x00':
        raise ValueError('Invalid declared Ethernet/IPv4 observation')
    subject,peer=bytes.fromhex('020000000001'),bytes.fromhex('020000000002')
    if raw[:12] != (subject+peer if direction=='ingress' else peer+subject):
        raise ValueError('Observed MAC tuple mismatch')
    total=struct.unpack('!H',raw[16:18])[0]
    if not 20<=total<=1500 or len(raw)not in (14+total,14+max(46,total)):
        raise ValueError('Observed IPv4 extent mismatch')
    if direction=='egress' and len(raw)!=14+max(46,total):
        raise ValueError('Generated Ethernet output was not canonically padded')
    if any(raw[14+total:]):raise ValueError('Unexpected nonzero padding')
    ip=raw[14:14+total]
    if ip[0]!=69 or ip[1]!=0 or ip[8]==0 or struct.unpack('!H',ip[6:8])[0]!=16384 or not checksum_valid(ip[:20]):
        raise ValueError('Invalid finite atomic IPv4 header/checksum')
    local,remote=bytes([192,0,2,1]),bytes([192,0,2,2])
    if ip[12:20]!=(remote+local if direction=='ingress' else local+remote):
        raise ValueError('Observed IPv4 address tuple mismatch')
    segment=ip[20:];protocol=ip[9]
    if protocol==6:
        if len(segment)<20 or not 20<=(segment[12]>>4)*4<=len(segment):
            raise ValueError('Invalid TCP header extent')
        if not checksum_valid(ip[12:20]+struct.pack('!BBH',0,6,len(segment))+segment):
            raise ValueError('Invalid independent TCP checksum')
    elif protocol==17:
        decode_packet(ip)
    elif protocol==1:
        if len(segment)<8 or not checksum_valid(segment):raise ValueError('Invalid ICMP checksum')
    else:raise ValueError('Unsupported positive-run IPv4 protocol')
    return ip


def service_records(links,config):
    udp,icmp=[],[]
    for item in links:
        raw=bytes.fromhex(item['raw'])
        if raw[12:14]!=b'\x08\x00':continue
        ip=ipv4_frame(raw,item['direction'])
        if ip[9]==17:udp.append((item['direction'],decode_packet(ip)))
        if ip[9]==1:icmp.append((item['direction'],ip))
    if len(udp)!=6 or len(icmp)!=6:raise ValueError('Expected exactly three UDP and three Echo exchanges')
    for i,case in enumerate(config['payloads']):
        outgoing,incoming=udp[2*i:2*i+2]
        if (outgoing[0],incoming[0])!=('egress','ingress'):raise ValueError('UDP frame order mismatch')
        for direction,decoded in (outgoing,incoming):
            if decoded['payload_hex']!=case['hex']:raise ValueError('Frozen independent UDP payload mismatch')
            expected=(40000,8080)if direction=='egress'else(8080,40000)
            if (decoded['source_port'],decoded['destination_port'])!=expected:raise ValueError('UDP port tuple mismatch')
            if direction=='egress'and decoded['udp_checksum']==0:raise ValueError('Generated UDP checksum absent despite enabled profile')
    for i,case in enumerate(config['echoes']):
        request,reply=icmp[2*i:2*i+2]
        if (request[0],reply[0])!=('ingress','egress'):raise ValueError('Echo frame order mismatch')
        if len(request[1])!=28+case['data_bytes']:raise ValueError('Frozen Echo size mismatch')
        echo.assert_echo(request[1],reply[1])
    return dict(UDP_exchanges=3, ICMP_echo_exchanges=3, original_IP_TCP_UDP_ICMP_checksums_verified=True,
                exact_Echo_bytes_preserved=True, full_protocol_or_compiler_proof=False)
