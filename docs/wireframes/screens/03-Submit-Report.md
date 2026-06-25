# Submit Report Screen

## Purpose

The Submit Report Screen enables volunteers, community leaders, and field staff to capture structured community information directly from the field.

This screen serves as the primary data collection mechanism of DscienTia.

The quality of reports submitted through this module directly influences:

* Impact Monitoring
* Risk Detection
* Recommendation Generation
* Community Intelligence

---

# Objectives

Users should be able to:

* Create new field reports
* Upload supporting evidence
* Record community observations
* Capture geographic information
* Submit reports quickly in low-connectivity environments

---

# Supported Users

## Volunteer

Primary Use:

* Submit field observations
* Upload photos
* Record activity outcomes

---

## Community Leader

Primary Use:

* Validate local issues
* Escalate concerns
* Submit community updates

---

## NGO Program Manager

Primary Use:

* Submit monitoring reports
* Record project progress
* Document interventions

---

# Screen Layout

```text
+--------------------------------------------------+
| Submit New Report                                |
+--------------------------------------------------+

| Report Title                                     |
| [____________________________________________]   |

| Category                                         |
| [Select Category ▼]                              |

| Community                                        |
| [Select Community ▼]                             |

| Project                                           |
| [Select Project ▼]                               |

| Description                                      |
| [ Multi-line Text Area ]                         |

| Severity Level                                   |
| ( ) Low                                          |
| ( ) Medium                                       |
| ( ) High                                         |
| ( ) Critical                                     |

| Upload Photos                                    |
| [ Add Image ]                                    |

| GPS Location                                     |
| [ Capture Location ]                             |

| Estimated Impact                                 |
| [____________________________________________]   |

|--------------------------------------------------|

| [ Save Draft ]      [ Submit Report ]            |

+--------------------------------------------------+
```

---

# Report Categories

Users must categorize each report.

Available categories:

* Community Issue
* Survey Result
* Project Update
* Incident Report
* Resource Distribution
* Community Feedback
* Environmental Observation
* Health Observation

Future categories may be added dynamically.

---

# Report Fields

## Report Title

Purpose:

Provide a short summary of the report.

Examples:

* Water shortage observed in Village A
* Community training completed
* Flood risk identified near river area

Requirements:

* Required
* Maximum 120 characters

---

## Community Selection

Purpose:

Identify the affected community.

Required:

Yes

Selection Method:

Dropdown search

---

## Project Selection

Purpose:

Associate the report with a project.

Required:

Optional in MVP

Future:

AI-assisted project matching

---

## Description

Purpose:

Provide detailed field observations.

Requirements:

* Required
* Multi-line text

Examples:

Observed three households experiencing water shortages during the past two weeks. Community members reported declining access to clean water.

---

## Severity Level

Purpose:

Provide an initial risk assessment by the reporter.

Options:

* Low
* Medium
* High
* Critical

Used by:

* AI Risk Detection
* Project Prioritization

---

## Media Attachments

Purpose:

Provide evidence.

Supported Formats:

* JPG
* PNG

Future Support:

* Video
* Audio
* PDF

Examples:

* Infrastructure damage
* Community activities
* Resource distribution evidence

---

## GPS Location

Purpose:

Capture geographic coordinates.

Methods:

* Automatic detection
* Manual adjustment

Future Integration:

* Community maps
* Geospatial intelligence

---

## Estimated Impact

Purpose:

Allow users to estimate affected beneficiaries.

Examples:

* 15 households
* 40 students
* Entire village population

Optional during MVP.

---

# AI-Assisted Features

## AI Draft Summary

Purpose:

Automatically summarize long descriptions.

Example:

Input:

Several households reported lack of clean water due to damaged infrastructure.

Output:

Water access disruption affecting multiple households.

---

## AI Category Suggestion

Purpose:

Recommend report category automatically.

Example:

Input:

Flooding observed near river.

Suggested Category:

Environmental Observation

---

## AI Severity Recommendation

Purpose:

Recommend risk level.

Example:

Repeated reports of water shortages.

Suggested Severity:

High

---

# Validation Rules

Before submission:

Required:

* Title
* Category
* Community
* Description

Optional:

* Project
* Photo
* GPS
* Impact Estimate

---

# Submission Workflow

```text
Create Report
      ↓
Validate Fields
      ↓
Save Draft OR Submit
      ↓
Store Locally
      ↓
Sync with Server
      ↓
AI Processing
      ↓
Insight Generation
```

---

# Offline-First Support

The screen must support:

* Draft creation offline
* Offline photo storage
* Local validation
* Automatic synchronization

Status indicators:

* Draft Saved
* Pending Sync
* Synced Successfully

---

# Success Criteria

The Submit Report Screen is successful when:

* Users can complete a report in under five minutes
* Reports contain sufficient information for AI analysis
* Offline submission reliability exceeds 95%
* Photo uploads remain simple and intuitive

---

# Future Enhancements

Planned features:

* Voice-to-Text Reporting
* AI-Assisted Report Writing
* Multi-Photo Upload
* Video Evidence
* Real-Time Translation
* Smart Form Recommendations

---

# Related Documents

* Product Vision
* User Personas
* Domain Model
* Information Architecture
* System Architecture

---

# Version

Wireframe v0.4

Screen ID: WF-03

Created: June 2026
