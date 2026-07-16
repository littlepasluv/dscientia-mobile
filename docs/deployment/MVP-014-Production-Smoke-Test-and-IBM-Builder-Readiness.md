# MVP-014 — Production Smoke Test and IBM Builder Readiness

**Project:** DscienTia Mobile
**Repository:** `littlepasluv/dscientia-mobile`
**Branch:** `feature/flutter-foundation`
**Production baseline commit:** `06090ed`
**Evaluation date:** 2026-07-14
**Status:** In Progress

---

## 1. Objective

MVP-014 verifies that the deployed DscienTia Mobile MVP remains operational across its public landing page, Flutter Web application, Laravel API, MySQL persistence layer, and backend AI insight flow.

This milestone also records the application's readiness for a future IBM watsonx integration and provides an honest distinction between:

* a production-deployed MVP;
* an end-to-end backend-connected AI insight flow;
* a mock AI provider used for controlled MVP validation; and
* a real IBM watsonx-powered implementation.

---

## 2. Production Architecture Under Test

| Component           | Production address            | Responsibility                                       |
| ------------------- | ----------------------------- | ---------------------------------------------------- |
| Public landing page | `www.dscientia.dev`           | Public project introduction                          |
| Flutter Web MVP     | `app.dscientia.dev`           | Community report submission and insight presentation |
| Laravel API         | `api.dscientia.dev`           | Report persistence and AI insight orchestration      |
| MySQL               | Hostinger production database | Persistent report and insight storage                |
| Current AI provider | `mock`                        | Deterministic backend AI insight simulation          |

The current production environment intentionally uses:

```env
DSCIENTIA_AI_PROVIDER=mock
```

The application must not yet be described as powered by IBM watsonx.

---

## 3. Acceptance Criteria

MVP-014 is complete when:

1. All three public production subdomains are reachable over HTTPS.
2. The Laravel health endpoint returns a successful response.
3. A synthetic community report can be created in production.
4. The created report can be retrieved from production storage.
5. A backend AI insight can be generated for the report.
6. The generated insight can be retrieved from production storage.
7. The response identifies the current provider as `mock`.
8. The Flutter Web report flow reaches the backend result screen.
9. The result screen displays the `Backend AI Insight` indicator.
10. No blocking CORS, TLS, JavaScript, API, or routing error appears.
11. Test evidence and final readiness status are documented.
12. No production secret is exposed in Flutter Web assets, browser storage, screenshots, logs, or Git history.

---

## 4. Automated Production Smoke Test

Run:

```bash
./scripts/smoke/production-smoke-test.sh
```

Record the result:

* [x] `www.dscientia.dev` returned HTTP 200.
* [x] `app.dscientia.dev` returned HTTP 200.
* [x] `GET /api/health` succeeded.
* [x] `POST /api/reports` created a report.
* [x] A valid production report ID was returned.
* [x] `GET /api/reports/{id}` retrieved the report.
* [x] `POST /api/ai-insights` created an AI insight.
* [x] A valid AI insight ID was returned.
* [x] `GET /api/ai-insights/{id}` retrieved the insight.
* [x] `model_provider` was `mock`.
* [x] `model_name` was present.
* [x] AI insight `status` was `completed`.
* [x] `risk_level` was present.
* [x] The script ended with `MVP-014 AUTOMATED SMOKE TEST PASSED`.

### Recorded automated-test evidence

**Test timestamp:** 2026-07-14T14:14:11Z
**Report ID:** 6
**AI insight ID:** 6
**Provider:** mock
**Model:** dscientia-local-mock-v0.1
**Insight status:** completed
**Risk level:** medium
**Log file:** `docs/evidence/mvp-014/production-smoke-test-2026-07-14-run-03.log`

---

## 5. Flutter Web Manual Smoke Test

Open:

```text
https://app.dscientia.dev
```

Use a clearly synthetic report so it can be distinguished from genuine community reports.

Suggested test data:

| Field       | Test value                                                          |
| ----------- | ------------------------------------------------------------------- |
| Title       | MVP-014 Flutter production smoke test                               |
| Category    | Infrastructure                                                      |
| Location    | Magelang, Central Java                                              |
| Description | Synthetic report submitted to verify the DscienTia production flow. |
| Urgency     | Medium                                                              |

Verify:

* [x] The Flutter Web application loads without a blank screen.
* [x] The report form is visible and usable.
* [x] Required form fields can be completed.
* [x] The Submit action does not create duplicate requests.
* [x] A visible loading or processing state is displayed.
* [x] The application sends the report to the production Laravel API.
* [x] The application navigates to the result screen.
* [x] The result screen displays `Backend AI Insight`.
* [x] The generated summary is not empty.
* [x] The risk level is displayed.
* [x] Suggested community action content is displayed.
* [x] Navigating back does not crash the application.
* [x] Refreshing the application does not produce an unrecoverable blank screen.
* [x] Browser developer tools show no blocking CORS error.
* [x] Browser developer tools show no uncaught application exception.
* [x] Network requests use `https://api.dscientia.dev`.
* [x] No request is sent to a localhost development address.


### Browser evidence

* [x] Screenshot of the report form.
* [x] Screenshot of the submitted result.
* [x] Screenshot showing `Backend AI Insight`.
* [x] Screenshot or note showing successful API requests in the Network panel.
* [x] Browser and version recorded.

**Browser tested:** Google Chrome 150, Incognito mode on macOS Sequoia 15.7.7
**Device or viewport:** Desktop browser; evidence screenshot resolution 2047 × 1279 pixels
**Manual test result:** Passed

---

## 6. Security and Configuration Check

* [x] Production uses HTTPS for landing, application, and API traffic.
* [x] Laravel production debugging is disabled.
* [x] `.env` is not publicly accessible.
* [x] Production database credentials are not committed to Git.
* [x] Future IBM API credentials are not present in Flutter source code.
* [x] Future IBM API credentials are not included in Flutter build artifacts.
* [x] Future IBM API calls will be performed only by the Laravel backend.
* [x] Current provider selection is controlled by server-side configuration.
* [x] The production environment intentionally remains on `mock`.
* [x] Smoke-test evidence contains no secret or authentication token.

> Verification note: No IBM credential patterns were detected in the Flutter
> source or the deployed production `main.dart.js` bundle. A local Flutter Web
> build directory was not present during verification.

---

## 7. Production Readiness Result

### Current verified capabilities

* Public DscienTia landing page is deployed.
* Flutter Web MVP is deployed.
* Laravel production API is deployed.
* Production MySQL migrations have completed.
* Reports can be persisted through the API.
* AI insight records can be generated through the API.
* Flutter Web can communicate with the production API.
* The result screen can present backend-generated insight data.
* AI provider selection is separated from the Flutter client.
* The current mock provider supplies repeatable MVP behavior.

### Current readiness classification

**Production deployment readiness:** Ready for MVP demonstration
**Backend integration readiness:** Ready
**Database readiness:** Ready
**Flutter-to-backend readiness:** Ready
**Mock AI demonstration readiness:** Ready
**IBM watsonx integration readiness:** Architecture ready, provider implementation pending
**IBM-powered production status:** Not yet active

---

## 8. IBM Builder Readiness Matrix

| Capability                                    | Status  | Evidence or remaining work                            |
| --------------------------------------------- | ------- | ----------------------------------------------------- |
| Public problem statement and project identity | Ready   | Public landing page                                   |
| Demonstrable Flutter Web application          | Ready   | `app.dscientia.dev`                                   |
| Public production API                         | Ready   | `api.dscientia.dev`                                   |
| Persistent production database                | Ready   | Hostinger MySQL and completed migrations              |
| End-to-end report workflow                    | Ready   | Flutter report submission to Laravel                  |
| Backend-generated insight workflow            | Ready   | AI insight API and result screen                      |
| Provider abstraction                          | Ready   | `DSCIENTIA_AI_PROVIDER` configuration                 |
| Deterministic fallback provider               | Ready   | `mock` provider                                       |
| IBM integration contract                      | Ready   | MVP-010 contract                                      |
| IBM Cloud credentials                         | Pending | Must be created and stored server-side                |
| IBM watsonx project or space configuration    | Pending | Project or space identifier required                  |
| IBM regional API endpoint                     | Pending | Must match the selected IBM Cloud region              |
| Foundation model selection                    | Pending | Model must be selected and documented                 |
| Laravel watsonx provider implementation       | Pending | Replace mock generation with IBM API invocation       |
| IBM response mapping                          | Pending | Map model output into the existing insight contract   |
| Timeout and retry handling                    | Pending | Required for external-provider failures               |
| Safe fallback behavior                        | Pending | Preserve controlled mock or error fallback            |
| Prompt and response guardrails                | Pending | Validate structured, safe, non-authoritative output   |
| Provider observability                        | Pending | Record provider, model, latency, and failure metadata |
| Real IBM integration evidence                 | Pending | Screenshots, logs, and response metadata required     |
| IBM-powered production demonstration          | Pending | Only valid after the real provider is deployed        |

---

## 9. IBM Integration Boundary

The Flutter application must never receive or store IBM Cloud credentials.

The expected production request path is:

```text
Flutter Web
    → DscienTia Laravel API
        → AI provider interface
            → IBM watsonx provider
                → IBM watsonx API
```

The Laravel backend remains responsible for:

* authenticating with IBM;
* constructing the model request;
* selecting the configured model;
* applying prompt guardrails;
* validating provider responses;
* mapping output into the DscienTia insight schema;
* storing insight metadata;
* handling timeouts and provider failures; and
* preventing provider credentials from reaching the browser.

---

## 10. Honest IBM Builder Positioning

### Approved description before IBM activation

> DscienTia is a live Flutter and Laravel MVP for community risk reporting and backend-generated resilience insights. The production workflow currently uses a deterministic mock AI provider while its provider abstraction and integration contract are prepared for IBM watsonx.

### Description that must not yet be used

> DscienTia is powered by IBM watsonx.

This statement becomes accurate only after:

1. the Laravel watsonx provider is implemented;
2. production credentials and project configuration are active;
3. production insight requests are processed by IBM;
4. response metadata identifies the real IBM provider and model; and
5. the complete production flow is tested again.

---

## 11. Risks and Follow-up Work

| Risk                                 | Current mitigation                                   | Follow-up                             |
| ------------------------------------ | ---------------------------------------------------- | ------------------------------------- |
| External AI provider unavailable     | Mock provider remains available                      | Add controlled fallback policy        |
| Provider output is malformed         | Existing insight contract defines expected structure | Add schema validation                 |
| IBM credential leakage               | Provider invocation remains backend-only             | Review production and Git history     |
| Slow inference                       | Current mock response is deterministic               | Add timeout and latency measurement   |
| Unsupported or unsafe recommendation | MVP output is informational                          | Add explicit prompt and UI guardrails |
| Insufficient community evidence      | Insight contract can represent limited confidence    | Preserve an insufficient-data outcome |
| Production regression                | MVP-014 smoke script is repeatable                   | Run after every production deployment |

---

## 12. Final MVP-014 Verdict

**Automated smoke test:** Passed
**Flutter manual smoke test:** Passed
**Production API and persistence:** Passed
**CORS verification:** Passed
**Backend insight rendering:** Passed
**Security review:** Passed for MVP-014 evidence scope
**Evidence recorded:** Completed

DscienTia Mobile passed its production smoke test across the public
landing page, Flutter Web frontend, Laravel API, MySQL persistence
layer, report workflow, and mock backend AI insight workflow.

The production browser flow successfully created a report and generated
an AI insight through the Laravel backend. Both production POST requests
returned HTTP 201, while their CORS preflight requests returned HTTP 204.

The platform is ready for a controlled IBM Builder MVP demonstration
and technically prepared for IBM watsonx provider implementation.

IBM watsonx is not yet active in production.

### Target completion statement

> DscienTia Mobile passed its production smoke test across the public landing page, Flutter Web frontend, Laravel API, MySQL persistence layer, report workflow, and mock backend AI insight workflow. The platform is ready for a controlled IBM Builder MVP demonstration and technically prepared for IBM watsonx provider implementation. IBM watsonx is not yet active in production.

---

## 13. Completion Evidence

- Production test log: `docs/evidence/mvp-014/production-smoke-test-2026-07-14-run-03.log`
- Flutter report-form screenshot: `docs/evidence/mvp-014/flutter-report-form.png`
- Backend result and browser network verification: `docs/evidence/mvp-014/flutter-backend-flow-with-network.png`
- Final Git commit: This MVP-014 milestone commit; see Git history
- Final commit date: 2026-07-14
