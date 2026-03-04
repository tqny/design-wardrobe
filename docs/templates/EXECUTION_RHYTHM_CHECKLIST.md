# Execution Rhythm Checklist

## During Day (Local)

- [ ] Keep running notes in `docs/worklog/YYYY-MM-DD.md`
- [ ] Track decisions requiring ADR updates
- [ ] Track evidence artifacts to capture

## Close Day

- [ ] Finalize worklog
- [ ] Update `CHANGELOG.md` (`[Unreleased]`)
- [ ] Add ADR/demo/metrics/postmortem updates as needed
- [ ] Run lint/tests/build (if configured)
- [ ] Run `./scripts/check-evidence.sh`
- [ ] Create one daily sync commit
- [ ] Push and open/update PR
