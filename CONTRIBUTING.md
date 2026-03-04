# Contributing

## Principles

- Be truthful: no fabricated metrics, dates, screenshots, or claims.
- Mark unknowns as `Unavailable` or `TBD`.
- Keep business logic changes separate from evidence/governance updates where possible.

## Branching and Commits

- Use descriptive branches for scoped work.
- Prefer one clean commit at day close for daily syncs:
  - `feat(<scope>): daily evidence sync YYYY-MM-DD`
  - `chore(<scope>): daily evidence sync YYYY-MM-DD`

## Minimum Evidence For Any Non-Trivial Change

1. Update `CHANGELOG.md` (`[Unreleased]`).
2. Add or update ADR/demo/metrics/postmortem artifacts as applicable.
3. Update daily worklog (`docs/worklog/YYYY-MM-DD.md`).
4. Run `./scripts/check-evidence.sh`.

## Pull Requests

Use the PR template and include:
- summary + linked issue,
- user impact,
- test evidence,
- risks/rollback,
- evidence artifact links.
