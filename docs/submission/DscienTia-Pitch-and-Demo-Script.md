# DscienTia — Pitch and Demo Script

## 1–2 Minute Project Pitch

Hello, my name is Prio Kus Nugroho, and I am the founder and product architect
of DscienTia.

Community organizations often collect important information through scattered
spreadsheets, messaging applications, and manual reports. This makes it
difficult to identify emerging risks, compare community needs, and make timely,
evidence-based decisions.

DscienTia is an AI-assisted social data platform designed to transform
community-generated reports into structured risk assessments, concise
summaries, and recommended actions.

A community member or organization can submit a structured report containing
the issue category, location, urgency, description, and estimated number of
people affected. The Laravel backend validates and stores the report, then
passes it through an AI provider abstraction that produces a structured
community-risk insight.

The current verified application uses a transparent mock provider for safe
development and demonstration. An IBM watsonx provider has also been
implemented with IBM IAM authentication, structured prompt handling, response
mapping, retries, sanitized logging, and controlled-verification safeguards.
Its live verification remains pending approved IBM Cloud access.

IBM Bob has supported the project through repository analysis, architecture
review, implementation planning, and watsonx-readiness assessment.

DscienTia is not intended to replace human decision-makers. Its purpose is to
help NGOs, community leaders, and researchers organize social data, identify
priorities, and make more transparent and responsible decisions.

My long-term vision is to develop DscienTia into a responsible Community Impact
Intelligence Platform combining social data science, ethical AI, geospatial
analysis, and community resilience research.

---

## 90-Second Demo Walkthrough

### Scene 1 — Introduction

Show the DscienTia main dashboard.

Narration:

> This is DscienTia, an AI-assisted social data and community-resilience
> platform. The dashboard provides access to reports, risk insights, and
> recommended community actions.

### Scene 2 — Submit a report

Open the Community Risk Report form.

Narration:

> A user can submit a structured community report containing a report title,
> category, location, urgency, description, and estimated number of people
> affected.

Use only synthetic demonstration data.

### Scene 3 — Backend processing

Submit the report and briefly explain the architecture.

Narration:

> The Flutter application sends the report through HTTPS to a Laravel REST API.
> The backend validates and stores the report before passing it to the AI
> provider abstraction.

### Scene 4 — Structured insight

Show the AI Insight Result page.

Narration:

> DscienTia converts the report into a structured insight containing a risk
> level, narrative summary, key findings, recommended actions, confidence
> score, and provider metadata.

Point to:

- Risk Summary
- Priority Assessment
- Suggested Community Action
- Confidence Score
- Model Provider

### Scene 5 — Provider transparency

Show the provider label.

Narration:

> The current demonstration transparently identifies the verified mock
> provider. The IBM watsonx provider implementation is complete, while its
> controlled live verification is pending approved IBM Cloud access.

### Scene 6 — IBM Bob

Show the IBM Bob readiness-review screenshot.

Narration:

> IBM Bob has been used as an AI software-development partner for architecture
> review, implementation planning, safety analysis, and watsonx verification
> readiness.

### Scene 7 — Closing

Return to the dashboard.

Narration:

> DscienTia demonstrates how responsible AI and social data science can help
> communities transform fragmented observations into clearer, more actionable,
> and accountable decisions.

---

## Demo Safety Checklist

Before recording:

- use only synthetic reports;
- keep production configured with the mock provider;
- do not show `.env` files or credentials;
- do not claim live watsonx verification;
- hide browser bookmarks, email accounts, and profile information;
- show the provider metadata clearly;
- keep the demo between 60 and 90 seconds;
- record at readable zoom and resolution.

## Suggested Recording Order

```text
Main Dashboard
→ Submit Report
→ Successful Report Creation
→ AI Insight Result
→ Provider Metadata
→ IBM Bob Review Evidence
→ Closing Dashboard
```
