The original callback<=16 state predicate was too tight for queue16/SMSS4:
after3 bytes of an original4-byte head are ACKed, fill another15 bytes so16 remain
unacked while19 original-record bytes await callback credit. A cumulative ACK
must release19. The retained positive test fails on the historical IR at CB-INV-MASS.
The fixed bound is exactly16+3, with lifetime TCP-credit/partial-prefix relations.
This corrects a model property; no packet oracle, upstream code or C experiment
limit is relaxed. C experiments still accept at most16 total written bytes.
reproduce.py loads the retained gzipped historical IR over hash-checked original
parents, requires the historical failure, and checks current19-byte replay.
The old nine-method success did not include this new boundary. The prototype
induction process was explicitly terminated after the concrete defect; its
termination is not a proof or an environment failure.
