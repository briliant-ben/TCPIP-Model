# Frozen-driver hardening, server DeepSeek0021

Original TAR SHA256 473e9e5e715bc424374144667d5a37037ad5a895dca66aaa2b129aebafe3bfae.
Accepted test source SHA256 2acaef526cea3060c339a01a7278858f8db118412fbcd25426cafea522b1998c.
Round0:4 executed unittests/4 instrumented calls into actual frozen driver,
0errors/0failures/0skips. No driver/model modification. Repository adaptation only
adds port import path before exchange import; original complete source retained.
Positive exact peer-receipt order/count + raw bytes + full thread cleanup, then
native model_gap evidence preservation, malformedtimer rejection and backwards
clock rejection. All negative tests invoke actualdriver and inspect own evidence.
Mocks do not prove actual process liveness; sockets are synthetic AF_UNIX only.
No real TCP, generated C, compiler, protocol or Linux proof follows from these.
