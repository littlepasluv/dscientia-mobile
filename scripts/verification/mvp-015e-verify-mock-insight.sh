#!/usr/bin/env bash

set -euo pipefail

INSIGHT_ID="${1:-}"
EXPECTED_REPORT_ID="${2:-}"
API_BASE_URL="${DSCIENTIA_API_BASE_URL:-http://127.0.0.1:8000/api}"

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

[[ "${INSIGHT_ID}" =~ ^[0-9]+$ ]] ||
  fail "Usage: $0 <insight-id> <expected-report-id>"

[[ "${EXPECTED_REPORT_ID}" =~ ^[0-9]+$ ]] ||
  fail "Expected report ID must be an integer."

command -v curl >/dev/null 2>&1 ||
  fail "curl is required."

command -v jq >/dev/null 2>&1 ||
  fail "jq is required."

ENDPOINT="${API_BASE_URL%/}/ai-insights/${INSIGHT_ID}"
RESPONSE_FILE="$(mktemp)"

trap 'rm -f "${RESPONSE_FILE}"' EXIT

HTTP_STATUS="$(
  curl \
    --silent \
    --show-error \
    --output "${RESPONSE_FILE}" \
    --write-out '%{http_code}' \
    --header 'Accept: application/json' \
    "${ENDPOINT}"
)"

[[ "${HTTP_STATUS}" == "200" ]] ||
  fail "Expected HTTP 200, received ${HTTP_STATUS}."

jq --exit-status \
  --argjson expectedInsightId "${INSIGHT_ID}" \
  --argjson expectedReportId "${EXPECTED_REPORT_ID}" \
  '
    .data.id == $expectedInsightId
    and .data.report_id == $expectedReportId
    and .data.insight_type == "community_risk_summary"
    and .data.model_provider == "mock"
    and .data.model_name == "dscientia-local-mock-v0.1"
    and .data.status == "completed"
    and (.data.narrative_summary | type == "string" and length > 0)
    and (.data.summary_points | type == "array" and length > 0)
    and (.data.recommended_actions | type == "array" and length > 0)
    and (.data.confidence_score | type == "number")
    and .data.confidence_score >= 0
    and .data.confidence_score <= 1
  ' "${RESPONSE_FILE}" >/dev/null ||
  fail "Mock insight response did not satisfy the expected contract."

printf 'MVP-015E Mock Insight Verification\n'
printf '=================================\n\n'
printf 'HTTP status                  : %s\n' "${HTTP_STATUS}"
printf 'Insight ID                   : %s\n' \
  "$(jq -r '.data.id' "${RESPONSE_FILE}")"
printf 'Report ID                    : %s\n' \
  "$(jq -r '.data.report_id' "${RESPONSE_FILE}")"
printf 'Insight type                 : %s\n' \
  "$(jq -r '.data.insight_type' "${RESPONSE_FILE}")"
printf 'Risk level                   : %s\n' \
  "$(jq -r '.data.risk_level' "${RESPONSE_FILE}")"
printf 'Model provider               : %s\n' \
  "$(jq -r '.data.model_provider' "${RESPONSE_FILE}")"
printf 'Model name                   : %s\n' \
  "$(jq -r '.data.model_name' "${RESPONSE_FILE}")"
printf 'Status                       : %s\n' \
  "$(jq -r '.data.status' "${RESPONSE_FILE}")"
printf 'Confidence score             : %s\n' \
  "$(jq -r '.data.confidence_score' "${RESPONSE_FILE}")"
printf 'IBM network request          : NO\n'
printf 'Response contract            : PASS\n\n'
printf 'Mock insight verification completed successfully.\n'
