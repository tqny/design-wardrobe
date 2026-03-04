#!/usr/bin/env bash
set -euo pipefail

MODE="all"

if [[ "${1:-}" == "--mode" ]]; then
  MODE="${2:-all}"
elif [[ -n "${1:-}" ]]; then
  MODE="$1"
fi

fail() {
  echo "[evidence-check] FAIL: $1" >&2
  exit 1
}

require_file() {
  local file="$1"
  [[ -f "$file" ]] || fail "missing file: $file"
}

require_dir() {
  local dir="$1"
  [[ -d "$dir" ]] || fail "missing directory: $dir"
}

require_section() {
  local file="$1"
  local section="$2"
  grep -Eq "^##[[:space:]]+$section$" "$file" || fail "missing section '## $section' in $file"
}

check_bootstrap() {
  require_file "README.md"
  require_file "CHANGELOG.md"
  require_file "CONTRIBUTING.md"
  require_file "docs/EVIDENCE_STANDARD.md"

  require_dir "docs/worklog"
  require_dir "docs/adr"
  require_dir "docs/demos"
  require_dir "docs/metrics"
  require_dir "docs/postmortems"
  require_dir "docs/templates"
  require_dir "docs/research"

  require_file "docs/adr/0000-template.md"
  require_file "docs/demos/DEMO_LOG_TEMPLATE.md"
  require_file "docs/metrics/WEEKLY_METRICS_TEMPLATE.md"
  require_file "docs/postmortems/TEMPLATE.md"
  require_file "docs/templates/PROJECT_CASE_STUDY_TEMPLATE.md"
  require_file "docs/templates/EXECUTION_RHYTHM_CHECKLIST.md"

  require_file ".github/PULL_REQUEST_TEMPLATE.md"
  require_file ".github/ISSUE_TEMPLATE/feature_request.md"
  require_file ".github/ISSUE_TEMPLATE/bug_report.md"
  require_file ".github/ISSUE_TEMPLATE/config.yml"
  require_file ".github/workflows/evidence-check.yml"

  require_file "scripts/check-evidence.sh"
  grep -Eq "^## \[Unreleased\]" CHANGELOG.md || fail "CHANGELOG.md missing [Unreleased] section"
}

check_sections() {
  require_section "docs/EVIDENCE_STANDARD.md" "Purpose"
  require_section "docs/EVIDENCE_STANDARD.md" "Truthfulness Rules"
  require_section "docs/EVIDENCE_STANDARD.md" "Required Sections By Artifact"
}

check_retro() {
  require_file "docs/research/RETRO_GAPS.md"
  require_file "docs/metrics/2026-W10-retrospective.md"
  require_file "docs/demos/2026-03-03-retro-demo-log.md"
  require_file "docs/postmortems/2026-03-03-no-verified-retro-incident.md"
  grep -q "Recorded retrospectively on 2026-03-03" CHANGELOG.md || fail "CHANGELOG retrospective marker missing"

  local adr_count
  adr_count="$(find docs/adr -type f -name '*.md' ! -name '0000-template.md' | wc -l | tr -d ' ')"
  [[ "${adr_count}" -ge 1 ]] || fail "expected at least one non-template ADR"
}

check_daily() {
  local worklog_count
  worklog_count="$(find docs/worklog -type f -name '20*.md' | wc -l | tr -d ' ')"
  [[ "${worklog_count}" -ge 1 ]] || fail "expected at least one dated worklog entry in docs/worklog/"

  local latest_worklog
  latest_worklog="$(ls -1 docs/worklog/20*.md 2>/dev/null | sort | tail -n 1 || true)"
  [[ -n "${latest_worklog}" ]] || fail "could not resolve latest worklog file"

  require_section "${latest_worklog}" "Plan"
  require_section "${latest_worklog}" "Execution"
  require_section "${latest_worklog}" "Validation"
  require_section "${latest_worklog}" "Next"
}

check_pr() {
  require_file ".github/PULL_REQUEST_TEMPLATE.md"
  require_section ".github/PULL_REQUEST_TEMPLATE.md" "Summary"
  require_section ".github/PULL_REQUEST_TEMPLATE.md" "Linked Issue"
  require_section ".github/PULL_REQUEST_TEMPLATE.md" "User Impact"
  require_section ".github/PULL_REQUEST_TEMPLATE.md" "Test Evidence"
  require_section ".github/PULL_REQUEST_TEMPLATE.md" "Risks and Rollback"
  require_section ".github/PULL_REQUEST_TEMPLATE.md" "Evidence Artifacts"
}

case "${MODE}" in
  bootstrap)
    check_bootstrap
    check_sections
    ;;
  retro)
    check_bootstrap
    check_sections
    check_retro
    ;;
  daily)
    check_bootstrap
    check_sections
    check_daily
    ;;
  pr)
    check_bootstrap
    check_sections
    check_pr
    ;;
  all)
    check_bootstrap
    check_sections
    check_retro
    check_daily
    check_pr
    ;;
  *)
    fail "unsupported mode: ${MODE} (expected bootstrap|retro|daily|pr|all)"
    ;;
esac

echo "[evidence-check] PASS (${MODE})"
