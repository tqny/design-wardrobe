# Design Wardrobe

Evidence-first repository for building and iterating dashboards/sites with agentic AI while keeping work auditable.

## Case Study Snapshot

### Problem
Teams move quickly with AI, but outside reviewers often cannot verify what was decided, tested, and shipped.

### Approach
Use an evidence-first operating model: every meaningful change links to ADRs, demo logs, metrics snapshots, and changelog entries.

### Outcome Target
A recruiter, collaborator, or reviewer should be able to inspect this repo and trace:
- why a decision happened,
- what changed,
- what was validated,
- what risks remain.

## Evidence Map

- Standard: [`docs/EVIDENCE_STANDARD.md`](docs/EVIDENCE_STANDARD.md)
- Changelog: [`CHANGELOG.md`](CHANGELOG.md)
- ADRs: [`docs/adr/`](docs/adr)
- Demos: [`docs/demos/`](docs/demos)
- Metrics: [`docs/metrics/`](docs/metrics)
- Postmortems: [`docs/postmortems/`](docs/postmortems)
- Worklog: [`docs/worklog/`](docs/worklog)
- Templates: [`docs/templates/`](docs/templates)

## Operating Rhythm

Use daily local execution, then one clean sync commit when closing the day.
See [`CONTRIBUTING.md`](CONTRIBUTING.md) for exact flow.
