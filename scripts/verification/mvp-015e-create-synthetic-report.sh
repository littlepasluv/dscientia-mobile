#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURE_FILE="${SCRIPT_DIR}/fixtures/community-risk-report.synthetic.json"

API_BASE_URL="${DSCIENTIA_API_BASE_URL:-http://127.0.0.1:8000/api}"
REPORT_ENDPOINT="${API_BASE_URL%/}/reports"

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

command -v curl >/dev/null 2>&1 ||
  fail "curl is required."

command -v jq >/dev/null 2>&1 ||
  fail "jq is required."

[[ -f "${FIXTURE_FILE}" ]] ||
  fail "Synthetic fixture was not found: ${FIXTURE_FILE}"

jq empty "${FIXTURE_FILE}" >/dev/null 2>&1 ||
  fail "Synthetic fixture contains invalid JSON."

RESPONSE_FILE="$(mktemp)"
trap 'rm -f "${RESPONSE_FILE}"' EXIT

printf 'MVP-015E Synthetic Report Creation\n'
printf '=================================\n\n'
printf 'API endpoint                 : %s\n' "${REPORT_ENDPOINT}"
printf 'Fixture                      : synthetic, non-personal data\n'
printf 'AI endpoint invoked          : NO\n'
printf 'IBM network request          : NO\n\n'

HTTP_STATUS="$(
  curl \
    --silent \
    --show-error \
    --output "${RESPONSE_FILE}" \
    --write-out '%{http_code}' \
    --request POST \
    --header 'Accept: application/json' \
    --header 'Content-Type: application/json' \
    --data-binary "@${FIXTURE_FILE}" \
    "${REPORT_ENDPOINT}"
)"

if [[ "${HTTP_STATUS}" != "201" ]]; then
  printf 'HTTP status                 : %s\n' "${HTTP_STATUS}" >&2
  printf 'API response:\n' >&2

  jq . "${RESPONSE_FILE}" 2>/dev/null ||
    cat "${RESPONSE_FILE}" >&2

  fail "Synthetic report creation failed."
fi

REPORT_ID="$(
  jq --exit-status --raw-output '.data.id' "${RESPONSE_FILE}"
)" || fail "The API response does not contain data.id."

printf 'HTTP status                 : %s\n' "${HTTP_STATUS}"
printf 'Report ID                   : %s\n' "${REPORT_ID}"
printf 'Organization                : %s\n' \
  "$(jq -r '.data.organization_name' "${RESPONSE_FILE}")"
printf 'Location                    : %s\n' \
  "$(jq -r '.data.location' "${RESPONSE_FILE}")"
printf 'Urgency                     : %s\n' \
  "$(jq -r '.data.urgency' "${RESPONSE_FILE}")"
printf 'Status                      : %s\n' \
  "$(jq -r '.data.status' "${RESPONSE_FILE}")"

printf '\nSynthetic report created successfully.\n'
printf 'Use this report ID for a later controlled insight request.\n'
