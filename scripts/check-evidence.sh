#!/usr/bin/env bash
set -euo pipefail

MODE="${1:-all}"

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

case "$MODE" in
  bootstrap)
    check_bootstrap
    ;;
  sections)
    check_sections
    ;;
  all)
    check_bootstrap
    check_sections
    ;;
  *)
    fail "unsupported mode: $MODE (expected bootstrap|sections|all)"
    ;;
esac

echo "[evidence-check] PASS ($MODE)"
