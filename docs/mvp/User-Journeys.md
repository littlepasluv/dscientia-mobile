# User Journeys

## Purpose

This document defines the primary user journeys for the DscienTia AI Insight MVP.

The goal is to understand how users interact with the platform from login to AI-powered decision support.

These journeys guide:

- UX Design
- Flutter Screen Development
- Navigation Structure
- API Requirements
- AI Workflow Design

---

# User Roles

The MVP supports three primary user roles:

- Volunteer
- Community Leader
- NGO Manager

Each role interacts with the platform differently.

---

# Journey 1: Volunteer Report Submission

## Goal

Allow volunteers to submit field observations that can later be analyzed by AI.

---

## Flow

```text
Login
  ↓
Dashboard
  ↓
Submit Report
  ↓
Review Submission
  ↓
Confirmation
```

---

## Detailed Steps

### Step 1: Login

User enters:

- Email
- Password

System validates credentials.

Outcome:

User enters Dashboard.

---

### Step 2: Dashboard

User views:

- Assigned projects
- Recent reports
- Community updates

Action:

Tap "Submit Report"

---

### Step 3: Submit Report

User enters:

- Report Title
- Description
- Category
- Location
- Photo (optional)

Action:

Tap Submit.

---

### Step 4: Review Submission

System displays:

- Entered data
- Validation results

Action:

Confirm submission.

---

### Step 5: Confirmation

System displays:

- Report ID
- Submission status

Outcome:

Report enters analysis pipeline.

---

# Journey 2: AI Insight Review

## Goal

Allow users to understand AI-generated analysis from submitted reports.

---

## Flow

```text
Dashboard
  ↓
AI Insight Center
  ↓
Insight Detail
```

---

## Detailed Steps

### Step 1: Dashboard

User sees:

- Insight Summary Card
- Recent Community Trends

Action:

Open AI Insight Center.

---

### Step 2: AI Insight Center

User views:

- Insight Summary
- Confidence Score
- Related Reports

Action:

Open Insight Detail.

---

### Step 3: Insight Detail

User reviews:

- Summary
- Detected Patterns
- AI Explanation

Outcome:

User understands community conditions.

---

# Journey 3: Risk Assessment Review

## Goal

Help decision-makers identify emerging community risks.

---

## Flow

```text
Dashboard
  ↓
Risk Assessment
  ↓
Risk Detail
```

---

## Detailed Steps

### Step 1: Dashboard

User sees:

- Active Risks
- Risk Notifications

Action:

Open Risk Assessment.

---

### Step 2: Risk Assessment

User views:

- Risk Level
- Confidence Score
- Affected Communities

Action:

Select Risk.

---

### Step 3: Risk Detail

User reviews:

- Risk Description
- Evidence
- Related Reports

Outcome:

User understands urgency level.

---

# Journey 4: Recommendation Review

## Goal

Provide actionable guidance after risk detection.

---

## Flow

```text
Dashboard
  ↓
Recommendation Center
  ↓
Recommendation Detail
```

---

## Detailed Steps

### Step 1: Dashboard

User sees:

- Recommended Actions

Action:

Open Recommendation Center.

---

### Step 2: Recommendation Center

User views:

- Recommendations
- Priority Levels
- Suggested Timeline

Action:

Open Recommendation Detail.

---

### Step 3: Recommendation Detail

User reviews:

- Action Description
- Expected Impact
- Supporting Evidence

Outcome:

User can plan interventions.

---

# Journey 5: NGO Manager Monitoring

## Goal

Allow NGO managers to monitor projects and community intelligence.

---

## Flow

```text
Login
  ↓
Dashboard
  ↓
Project Detail
  ↓
AI Insights
  ↓
Risk Assessment
  ↓
Recommendations
```

---

## Detailed Steps

### Dashboard

Displays:

- Project Status
- Recent Reports
- Active Risks
- Recommendations

---

### Project Detail

Displays:

- Activities
- Impact Metrics
- Community Information

---

### AI Insight

Displays:

- Trend Analysis
- Report Summaries

---

### Risk Assessment

Displays:

- Emerging Risks
- Priority Levels

---

### Recommendation Center

Displays:

- Suggested Actions
- Implementation Priorities

Outcome:

Managers gain decision support intelligence.

---

# MVP Journey Coverage

The MVP implementation will focus on:

✓ Volunteer Report Submission

✓ AI Insight Review

✓ Risk Assessment Review

✓ Recommendation Review

✓ NGO Manager Monitoring

---

# Success Criteria

A user can:

- Login successfully
- Submit a report
- View AI Insight
- View Risk Assessment
- View Recommendation
- Navigate between all MVP screens

without requiring external assistance.

---

# Related Documents

- MVP Scope
- Information Architecture
- Navigation Flows
- Flutter Project Structure