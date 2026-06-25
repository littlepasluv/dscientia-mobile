# Acceptance Criteria

## Purpose

This document defines the acceptance criteria for the DscienTia AI Insight MVP.

Acceptance criteria establish measurable conditions that must be satisfied before the MVP can be considered complete.

This document serves as the primary validation checklist for:

* Product Readiness
* Engineering Readiness
* AI Readiness
* IBM AI Builder Challenge Demonstration

---

# MVP Objective

The primary objective of the MVP is to demonstrate how DscienTia transforms community reports into actionable intelligence using IBM Granite models.

The MVP must successfully:

1. Collect community reports
2. Store report data
3. Generate AI insights
4. Assess community risks
5. Generate recommendations
6. Present intelligence through a mobile dashboard

---

# Functional Requirements

## User Authentication

### Acceptance Criteria

The system shall allow users to:

* Register an account
* Login
* Logout
* Maintain session state

### Success Conditions

✔ User successfully logs in

✔ User successfully logs out

✔ Invalid credentials display an error

---

## Dashboard

### Acceptance Criteria

The dashboard shall display:

* Assigned projects
* Recent reports
* AI insights
* Risk indicators

### Success Conditions

✔ Dashboard loads successfully

✔ AI insight card is displayed

✔ Risk level is visible

---

## Report Submission

### Acceptance Criteria

Users shall be able to:

* Create reports
* Add descriptions
* Select categories
* Submit reports

### Success Conditions

✔ Report is stored

✔ Submission confirmation displayed

✔ Report appears in report list

---

## AI Insight Generation

### Acceptance Criteria

The system shall generate:

* Summary
* Confidence score

using IBM Granite.

### Success Conditions

✔ Summary generated

✔ Confidence score returned

✔ Insight displayed in dashboard

---

## Risk Assessment

### Acceptance Criteria

The system shall classify:

* Low
* Medium
* High
* Critical

risk levels.

### Success Conditions

✔ Risk level generated

✔ Confidence score available

✔ Risk displayed in dashboard

---

## Recommendation Generation

### Acceptance Criteria

The system shall provide recommendations.

### Success Conditions

✔ Recommendation generated

✔ Priority assigned

✔ Recommendation displayed

---

## Project Monitoring

### Acceptance Criteria

Users shall be able to view:

* Project details
* Progress status
* Related reports

### Success Conditions

✔ Project page loads

✔ Metrics displayed

✔ Related reports visible

---

# AI Requirements

## AI Insight Quality

The generated summary shall:

* Be relevant
* Be understandable
* Reflect submitted data

### Success Conditions

✔ Summary references report content

✔ No fabricated statistics

✔ No unsupported conclusions

---

## Risk Classification

The risk assessment shall:

* Use report context
* Use scoring model
* Produce explainable results

### Success Conditions

✔ Risk reasoning available

✔ Confidence score available

---

## Recommendation Quality

Recommendations shall:

* Address identified risks
* Be actionable
* Be practical

### Success Conditions

✔ Recommendation linked to risk

✔ Recommendation includes next action

---

# User Experience Requirements

## Mobile Responsiveness

### Acceptance Criteria

The application shall support:

* Android
* iOS

### Success Conditions

✔ Layout adapts correctly

✔ Navigation works

---

## Loading Performance

### Acceptance Criteria

Common actions should complete quickly.

### Targets

| Action                | Target   |
| --------------------- | -------- |
| Login                 | < 3 sec  |
| Dashboard Load        | < 3 sec  |
| Report Submission     | < 5 sec  |
| AI Insight Generation | < 10 sec |

---

# Offline Requirements

## Draft Reports

### Acceptance Criteria

Users shall be able to save reports locally.

### Success Conditions

✔ Draft saved

✔ Draft restored

---

## Synchronization

### Acceptance Criteria

Reports shall sync after connectivity returns.

### Success Conditions

✔ Pending report synchronized

✔ No duplicate records

---

# Security Requirements

## Authentication

### Acceptance Criteria

Only authenticated users may access protected resources.

### Success Conditions

✔ Unauthorized requests blocked

---

## API Security

### Acceptance Criteria

Protected endpoints require valid tokens.

### Success Conditions

✔ Invalid token rejected

✔ Expired token rejected

---

# IBM Granite Requirements

## Insight Generation

### Acceptance Criteria

IBM Granite shall generate:

* AI Insight Summary

### Success Conditions

✔ Valid response returned

✔ JSON structure valid

---

## Risk Assessment

### Acceptance Criteria

IBM Granite shall evaluate risk levels.

### Success Conditions

✔ Risk level generated

✔ Explanation provided

---

## Recommendation Generation

### Acceptance Criteria

IBM Granite shall generate recommendations.

### Success Conditions

✔ Recommendation returned

✔ Priority assigned

---

# Demo Readiness Requirements

The hackathon demo must demonstrate:

### Scenario 1

Volunteer submits report.

Expected Outcome:

✔ Report stored

✔ AI insight generated

---

### Scenario 2

Risk identified.

Expected Outcome:

✔ Risk level displayed

✔ Recommendation generated

---

### Scenario 3

NGO manager reviews dashboard.

Expected Outcome:

✔ Insight visible

✔ Risk visible

✔ Recommendation visible

---

# MVP Completion Checklist

## Product

* [ ] MVP Scope Completed
* [ ] User Flows Implemented
* [ ] Screen Specifications Implemented

---

## Backend

* [ ] API Contracts Implemented
* [ ] Database Models Implemented

---

## AI

* [ ] AI Insight Generation Working
* [ ] Risk Assessment Working
* [ ] Recommendation Generation Working

---

## IBM Integration

* [ ] WatsonX Connected
* [ ] Granite Model Connected
* [ ] Prompt Templates Implemented

---

## Demo

* [ ] Demo Scenario Prepared
* [ ] Demo Dataset Prepared
* [ ] Demo Script Prepared

---

# Definition of Done

The MVP is considered complete when:

1. All critical acceptance criteria pass.
2. AI insights are generated successfully.
3. Risk assessments are generated successfully.
4. Recommendations are generated successfully.
5. Demo scenarios execute without failure.

---

# Version

Acceptance Criteria v0.1

Milestone:

v0.6 AI Insight MVP

Created: June 2026

Related Documents:

* MVP Scope
* User Flows
* API Contracts
* AI Insight Workflow
* AI Prompt Templates
* IBM WatsonX Integration
