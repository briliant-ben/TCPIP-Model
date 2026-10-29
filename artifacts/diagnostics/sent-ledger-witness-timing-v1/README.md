# Initial short-segment witness timing hypothesis

The first candidates incorrectly chose both two-byte segments at 21ms for a four-byte advertised window. The retained real capture sends the second short segment after ACK instead. These failed hypotheses and original checker are retained here.

The corrected alternatives in artifacts/lwip-service/segmentation-witnesses match all wire frames and timed service callbacks for partial-only-no-callback and partial-then-full. For duplicate-future-no-credit, automatic model Limited Transmit sends the queued segment at 30ms while the capture waits until 40ms; that wire Difference is retained even though timed callback chunks match. This is a finite policy/composition gap, not evidence of an RFC bug or a proof that no alternative schedule exists. No original canonical oracle, raw capture or Difference is rewritten, and these alternatives reuse existing independent executions rather than claiming new C runs.
