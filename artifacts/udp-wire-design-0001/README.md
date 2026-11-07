# Unaccepted UDP wire IR design proposal

One bounded new DeepSeek request produced response.json, with receipt/status and
actual lifetime usage in summary.json. The source prompt is tracked separately at
agents/jobs/udp-wire-design-messages.json. This is only a proposal: no new IR
operator, backend implementation, test vector, wire behavior or proof has been
accepted. Do not execute model-generated code or treat gateway completed as an
implementation gate. Controller review and independent validation come next.
Shared lifetime budget remains12 calls;10 have been used. No automatic retry.
