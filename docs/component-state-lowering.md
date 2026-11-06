# Offline component state lowering, v1

This internal IR construction contract moves an IR0.5/0.6 atomic-v1 component's
finite control state into an explicit string variable. It is preparation for
TCP/ARP composition, not a new protocol behavior or runtime Python callback.

The new global state is a single declared label. The added variable initially
contains the original initial state. Each rule requires that variable to equal
its original source, retains its original guard, performs the original actions,
then assigns the original target to the variable. State predicates in expression
positions become equality against that variable. Add a finite-domain invariant.
All other variables, events, messages, timers, guards/actions and their order,
wire byte contracts and source requirements remain unchanged.

Only atomic-v1 components without terminal-state declarations are supported.
Clock/post-target/rational and terminal-state lowering must explicitly reject.
The internal state variable cannot collide with an original variable. This
equivalence concerns default initialization and overrides of original variables;
the added representation variable is not an application initialization control.
Wire/service adapters must not expose an override for it.

Acceptance requires the exact structural transform, original literal scenarios
under the state projection, invalid-domain initialization rejection, and actual
generated C comparison. It is not a universal compiler proof or complete endpoint.
