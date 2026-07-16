#!/usr/bin/env bash

set -Eeuo pipefail

API_BASE="${API_BASE:-https://api.dscientia.dev/api}"
LANDING_URL="${LANDING_URL:-https://www.dscientia.dev}"
APP_URL="${APP_URL:-https://app.dscientia.dev}"
RUN_ID="$(date -u +"%Y%m%dT%H%M%SZ")"

TEMP_DIR="$(mktemp -d)"

cleanup() {
  rm -rf "${TEMP_DIR}"
}

trap cleanup EXIT

pass() {
  printf "PASS: %s\n" "$1"
}

fail() {
  printf "FAIL: %s\n" "$1" >&2
  exit 1
}

require_command() {
  command -v "$1" >/dev/null 2>&1 ||
    fail "Required command is not installed: $1"
}

assert_success_status() {
  local status="$1"
  local description="$2"
  local response_file="${3:-}"

  case "${status}" in
    200|201|202|204)
      pass "${description} returned HTTP ${status}"
      ;;
    *)
      printf "ERROR RESPONSE:
" >&2

      if [[ -n "${response_file}" && -s "${response_file}" ]]; then
        if jq empty "${response_file}" >/dev/null 2>&1; then
          jq . "${response_file}" >&2
        else
          cat "${response_file}" >&2
          printf "
" >&2
        fi
      else
        printf "(empty response body)
" >&2
      fi

      fail "${description} returned unexpected HTTP ${status}"
      ;;
  esac
}

request() {
  local method="$1"
  local url="$2"
  local output_file="$3"
  local payload="${4:-}"

  if [[ -n "${payload}" ]]; then
    curl \
      --silent \
      --show-error \
      --location \
      --output "${output_file}" \
      --write-out "%{http_code}" \
      --request "${method}" \
      --header "Accept: application/json" \
      --header "Content-Type: application/json" \
      --data "${payload}" \
      "${url}"
  else
    curl \
      --silent \
      --show-error \
      --location \
      --output "${output_file}" \
      --write-out "%{http_code}" \
      --request "${method}" \
      --header "Accept: application/json" \
      "${url}"
  fi
}

require_command curl
require_command jq

echo "============================================================"
echo "DscienTia MVP-014 Production Smoke Test"
echo "Run ID:       ${RUN_ID}"
echo "Landing URL:  ${LANDING_URL}"
echo "Flutter URL:  ${APP_URL}"
echo "API base:     ${API_BASE}"
echo "============================================================"
echo

# ------------------------------------------------------------------
# 1. Public web endpoints
# ------------------------------------------------------------------

LANDING_STATUS="$(
  curl \
    --silent \
    --show-error \
    --location \
    --output /dev/null \
    --write-out "%{http_code}" \
    "${LANDING_URL}"
)"

[[ "${LANDING_STATUS}" == "200" ]] ||
  fail "Public landing page returned HTTP ${LANDING_STATUS}"

pass "Public landing page is reachable"

APP_STATUS="$(
  curl \
    --silent \
    --show-error \
    --location \
    --output /dev/null \
    --write-out "%{http_code}" \
    "${APP_URL}"
)"

[[ "${APP_STATUS}" == "200" ]] ||
  fail "Flutter Web application returned HTTP ${APP_STATUS}"

pass "Flutter Web application is reachable"

# ------------------------------------------------------------------
# 2. API health
# ------------------------------------------------------------------

HEALTH_FILE="${TEMP_DIR}/health.json"

HEALTH_STATUS="$(
  request GET "${API_BASE}/health" "${HEALTH_FILE}"
)"

assert_success_status "${HEALTH_STATUS}" "GET /api/health"

echo "Health response:"
jq . "${HEALTH_FILE}"

if jq -e '
  (
    .status //
    .data.status //
    .message //
    ""
  )
  | tostring
  | ascii_downcase
  | contains("ok")
' "${HEALTH_FILE}" >/dev/null; then
  pass "API health response reports OK"
else
  fail "API health response does not contain an OK status"
fi

# ------------------------------------------------------------------
# 3. Create synthetic production report
# ------------------------------------------------------------------

REPORT_PAYLOAD="$(
  jq -cn \
    --arg title "MVP-014 production smoke test ${RUN_ID}" \
    --arg organization_name "DscienTia" \
    --arg category "Infrastructure" \
    --arg location "Magelang, Central Java" \
    --arg description \
      "Synthetic production smoke-test report. This record can be retained as deployment verification evidence." \
    --arg urgency "medium" \
    '{
      title: $title,
      organization_name: $organization_name,
      category: $category,
      location: $location,
      description: $description,
      urgency: $urgency
    }'
)"

echo
echo "Report request payload:"
jq . <<< "${REPORT_PAYLOAD}"

REPORT_FILE="${TEMP_DIR}/report.json"

REPORT_STATUS="$(
  request \
    POST \
    "${API_BASE}/reports" \
    "${REPORT_FILE}" \
    "${REPORT_PAYLOAD}"
)"

assert_success_status \
  "${REPORT_STATUS}" \
  "POST /api/reports" \
  "${REPORT_FILE}"

echo
echo "Report response:"
jq . "${REPORT_FILE}"

REPORT_ID="$(
  jq -r '
    .data.id //
    .report.id //
    .id //
    empty
  ' "${REPORT_FILE}"
)"

[[ -n "${REPORT_ID}" && "${REPORT_ID}" != "null" ]] ||
  fail "POST /api/reports did not return a report ID"

pass "Production report created with ID ${REPORT_ID}"

# ------------------------------------------------------------------
# 4. Read persisted report
# ------------------------------------------------------------------

REPORT_GET_FILE="${TEMP_DIR}/report-get.json"

REPORT_GET_STATUS="$(
  request \
    GET \
    "${API_BASE}/reports/${REPORT_ID}" \
    "${REPORT_GET_FILE}"
)"

assert_success_status \
  "${REPORT_GET_STATUS}" \
  "GET /api/reports/${REPORT_ID}"

echo
echo "Persisted report response:"
jq . "${REPORT_GET_FILE}"

pass "Created report is retrievable from production storage"

# ------------------------------------------------------------------
# 5. Generate backend AI insight
# ------------------------------------------------------------------

INSIGHT_PAYLOAD="$(
  jq -cn \
    --argjson report_id "${REPORT_ID}" \
    '{
      report_id: $report_id
    }'
)"

INSIGHT_FILE="${TEMP_DIR}/insight.json"

INSIGHT_STATUS="$(
  request \
    POST \
    "${API_BASE}/ai-insights" \
    "${INSIGHT_FILE}" \
    "${INSIGHT_PAYLOAD}"
)"

assert_success_status "${INSIGHT_STATUS}" "POST /api/ai-insights"

echo
echo "AI insight response:"
jq . "${INSIGHT_FILE}"

INSIGHT_ID="$(
  jq -r '
    .data.id //
    .ai_insight.id //
    .id //
    empty
  ' "${INSIGHT_FILE}"
)"

[[ -n "${INSIGHT_ID}" && "${INSIGHT_ID}" != "null" ]] ||
  fail "POST /api/ai-insights did not return an insight ID"

pass "AI insight created with ID ${INSIGHT_ID}"

PROVIDER="$(
  jq -r '
    .data.model_provider //
    .ai_insight.model_provider //
    .model_provider //
    empty
  ' "${INSIGHT_FILE}"
)"

MODEL_NAME="$(
  jq -r '
    .data.model_name //
    .ai_insight.model_name //
    .model_name //
    empty
  ' "${INSIGHT_FILE}"
)"

INSIGHT_STATE="$(
  jq -r '
    .data.status //
    .ai_insight.status //
    .status //
    empty
  ' "${INSIGHT_FILE}"
)"

RISK_LEVEL="$(
  jq -r '
    .data.risk_level //
    .ai_insight.risk_level //
    .risk_level //
    empty
  ' "${INSIGHT_FILE}"
)"

[[ "${PROVIDER}" == "mock" ]] ||
  fail "Expected production model_provider=mock, received '${PROVIDER}'"

pass "Expected production AI provider is active: ${PROVIDER}"

[[ -n "${MODEL_NAME}" ]] ||
  fail "AI insight response does not include model_name"

pass "AI model metadata is present: ${MODEL_NAME}"

[[ "${INSIGHT_STATE}" == "completed" ]] ||
  fail "Expected AI insight status=completed, received '${INSIGHT_STATE}'"

pass "AI insight completed successfully"

[[ -n "${RISK_LEVEL}" ]] ||
  fail "AI insight response does not include risk_level"

pass "AI insight includes risk level: ${RISK_LEVEL}"

# ------------------------------------------------------------------
# 6. Read persisted insight
# ------------------------------------------------------------------

INSIGHT_GET_FILE="${TEMP_DIR}/insight-get.json"

INSIGHT_GET_STATUS="$(
  request \
    GET \
    "${API_BASE}/ai-insights/${INSIGHT_ID}" \
    "${INSIGHT_GET_FILE}"
)"

assert_success_status \
  "${INSIGHT_GET_STATUS}" \
  "GET /api/ai-insights/${INSIGHT_ID}"

echo
echo "Persisted AI insight response:"
jq . "${INSIGHT_GET_FILE}"

pass "Created AI insight is retrievable from production storage"

echo
echo "============================================================"
echo "MVP-014 AUTOMATED SMOKE TEST PASSED"
echo
echo "Report ID:       ${REPORT_ID}"
echo "AI insight ID:   ${INSIGHT_ID}"
echo "Provider:        ${PROVIDER}"
echo "Model:           ${MODEL_NAME}"
echo "Insight status:  ${INSIGHT_STATE}"
echo "Risk level:      ${RISK_LEVEL}"
echo "============================================================"
