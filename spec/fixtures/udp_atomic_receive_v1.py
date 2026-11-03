"""Offline independent atomic-ID fixtures; no IR/subject output is an oracle input."""
import json
from udp_wire_receive_v1 import packet,fix_ip


def oracle():
    cases={}
    for name,ident,data in [('id-one',1,b''),('id-1234',0x1234,b'\0\x80\xff'),('id-ffff',65535,b'\xff\0')]:
        raw=bytearray(packet(data));raw[4:6]=ident.to_bytes(2,'big');raw=fix_ip(bytes(raw))
        cases[name]=dict(hex=raw.hex(),data=list(data),disposition='deliver',repeat=1)
    cases['same-id-twice']={**cases['id-1234'],'repeat':2}
    bad=bytearray.fromhex(cases['id-one']['hex']);bad[4:6]=b'\x12\x34'
    cases['id-checksum-still-required']=dict(hex=bad.hex(),data=[],disposition='drop_ip_checksum',repeat=1)
    gaps={}
    for name,flags in [('fragment',0x6000),('non-atomic',0)]:
        raw=bytearray.fromhex(cases['id-1234']['hex']);raw[6:8]=flags.to_bytes(2,'big');gaps[name]=fix_ip(bytes(raw)).hex()
    return dict(schema='udp-atomic-id-oracle-v1',basis='RFC6864 4/4.1; checksum remains RFC791/1122',cases=cases,model_gaps=gaps)


if __name__=='__main__':print(json.dumps(oracle(),indent=2))
