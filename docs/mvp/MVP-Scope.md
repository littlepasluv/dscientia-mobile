# AI Insight MVP Scope

## Purpose

This document defines the scope of DscienTia v0.6 AI Insight MVP.

The goal of this milestone is to deliver the first working version of DscienTia Mobile capable of demonstrating the complete AI-powered community impact intelligence workflow.

This MVP is designed for:

- IBM AI Builders Challenge
- Portfolio Demonstration
- Early User Validation
- Technical Feasibility Testing

---

# MVP Vision

The MVP demonstrates how community reports can be transformed into actionable intelligence through AI.

Users can:

1. Submit community reports
2. Review project information
3. View AI-generated insights
4. View risk assessments
5. Receive recommended actions

---

# Core User Flow

```text
Login
  ↓
Dashboard
  ↓
Submit Report
  ↓
AI Analysis
  ↓
Risk Assessment
  ↓
Recommendations
```

---

# Included Features

## Authentication

Features:

- Login Screen
- Logout
- Session Persistence

Supported Roles:

- Volunteer
- Community Leader
- NGO Manager

---

## Dashboard

Features:

- Recent Reports
- Assigned Projects
- AI Insight Summary
- Community Alerts

---

## Report Submission

Features:

- Create Report
- Add Description
- Select Category
- Add Location
- Upload Photo (Mock)
- Submit Report

---

## AI Insight Center

Features:

- Insight Summary
- Confidence Score
- Community Trends
- Report Analysis

---

## Risk Assessment

Features:

- Risk Level
- Risk Explanation
- Confidence Score
- Suggested Priority

Risk Levels:

- Low
- Medium
- High
- Critical

---

## Recommendation Center

Features:

- Recommended Actions
- Priority Ranking
- Suggested Timeline
- Related Risks

---

## Project Detail

Features:

- Project Overview
- Activities
- Impact Metrics
- Related AI Insights

---

# Excluded Features

The following features are intentionally excluded from MVP:

## Messaging

- Chat
- Direct Messages
- Team Collaboration

---

## Donor Features

- Donor Portal
- Donation Tracking
- Funding Analytics

---

## Advanced AI

- Predictive Analytics
- Impact Forecasting
- Autonomous Recommendations

---

## Administration

- Multi-Organization Management
- Advanced User Management

---

# AI Scope

The MVP currently uses deterministic mock AI responses in production.

The IBM/watsonx provider integration boundary is implemented and covered by
automated tests. Controlled live IBM watsonx verification is tracked under
MVP-015E and remains pending the required IBM Cloud access and configuration.

This approach allows validation of:

- User Experience
- Data Flow
- Screen Design
- Navigation Logic

before introducing AI complexity.

---

# Success Criteria

The MVP is considered successful when:

- User can log in
- User can submit a report
- User can navigate all core screens
- AI Insight screen displays analysis
- Risk Assessment screen displays risk level
- Recommendation screen displays actions

---

# Related Documents

- Product Vision
- Information Architecture
- AI Use Cases
- Flutter Project Structure