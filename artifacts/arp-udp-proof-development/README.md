# Unaccepted development initial-state query

All30 per-rule preservation and enabling checks plus4 overlaps passed, but the
first initialization-nonemptiness query included an unexecuted future-event
search and returned UNKNOWN. Its raw initial-enabled query/report are retained.
The current checker uses the exact suffix-padding branch for initial-state-only
queries: initialization does not depend on a future protocol event. Preservation
queries remain all-typed arbitrary legal prestates/all guards/full selected
actions. The old trial is not promoted; its uncommitted checker source was not
archived, so this diagnostic makes no reproducible passed-checker claim.
