# Evidence Standard

## Purpose

Make delivery auditable for external reviewers by linking claims to artifacts.

## Required Artifact Types

- `CHANGELOG.md` (`[Unreleased]` always current)
- ADRs in `docs/adr/`
- Demo logs in `docs/demos/`
- Metrics snapshots in `docs/metrics/`
- Postmortems in `docs/postmortems/`
- Daily worklog in `docs/worklog/`

## Truthfulness Rules

- Never infer certainty where evidence is missing.
- Use `Unavailable` when data cannot be reconstructed.
- Use `TBD` for future collection items.

## Required Sections By Artifact

### ADR
- `Status`
- `Context`
- `Decision`
- `Consequences`

### Demo Log
- `Goal`
- `Environment`
- `Steps`
- `Result`
- `Evidence`

### Weekly Metrics
- `Week`
- `Outputs`
- `Quality`
- `Delivery`
- `Risks`

### Postmortem
- `Summary`
- `Impact`
- `Timeline`
- `Root Cause`
- `Actions`

### Worklog
- `Plan`
- `Execution`
- `Validation`
- `Next`

## Validation

Run:

```bash
./scripts/check-evidence.sh
```

CI also enforces this via `.github/workflows/evidence-check.yml`.
