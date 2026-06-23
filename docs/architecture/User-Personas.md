# User Personas

## Purpose

This document defines the primary users of DscienTia Mobile and their needs, goals, challenges, and expected interactions with the platform.

Understanding user personas helps guide:

- Mobile application design
- User experience (UX) decisions
- Feature prioritization
- Accessibility considerations
- Future AI-assisted functionality

---

# Persona 1: NGO Program Manager

## Profile

**Name:** Sarah Rahman

**Role:** Program Manager

**Organization Type:** NGO / Foundation

**Age Range:** 30–50

**Technical Proficiency:** Intermediate

---

## Responsibilities

- Manage social impact programs
- Monitor project progress
- Coordinate with community leaders
- Prepare reports for donors and stakeholders
- Track organizational KPIs

---

## Goals

- Monitor projects in real time
- Measure program outcomes accurately
- Generate donor-ready reports efficiently
- Improve decision-making using reliable data

---

## Pain Points

- Data scattered across multiple platforms
- Manual report compilation
- Delayed field updates
- Limited visibility into project performance

---

## Needs

- Executive dashboard
- Impact analytics
- Project monitoring tools
- Exportable reports
- Notification system for critical updates

---

## Success Criteria

- Reduced reporting time
- Improved project visibility
- Better donor communication
- Evidence-based decision making

---

# Persona 2: Community Leader

## Profile

**Name:** Budi Santoso

**Role:** Community Coordinator

**Organization Type:** Community Group

**Age Range:** 25–55

**Technical Proficiency:** Basic to Intermediate

---

## Responsibilities

- Coordinate local community activities
- Identify community needs
- Report local issues
- Communicate with NGOs and partners
- Support volunteer activities

---

## Goals

- Easily report community conditions
- Track project progress
- Receive support quickly
- Improve local participation

---

## Pain Points

- Reporting processes are often complicated
- Limited internet connectivity
- Lack of centralized communication
- Difficulty tracking submitted reports

---

## Needs

- Mobile-first interface
- Offline data collection
- Simple reporting forms
- Community activity tracking
- Progress updates

---

## Success Criteria

- Faster issue reporting
- Increased community engagement
- Improved communication with organizations
- Better project coordination

---

# Persona 3: Volunteer

## Profile

**Name:** Maya Putri

**Role:** Volunteer

**Organization Type:** Community Volunteer Network

**Age Range:** 18–35

**Technical Proficiency:** Intermediate

---

## Responsibilities

- Collect field data
- Conduct surveys
- Document activities
- Upload photos and evidence
- Support community programs

---

## Goals

- Submit reports quickly
- Document activities efficiently
- Participate in community initiatives
- Track assigned tasks

---

## Pain Points

- Long and repetitive forms
- Poor mobile experience
- Unstable internet connection
- Time-consuming reporting processes

---

## Needs

- Fast reporting workflow
- Offline-first functionality
- Photo and media uploads
- Task management
- Mobile notifications

---

## Success Criteria

- Faster report submission
- Reduced administrative workload
- Improved volunteer participation
- Better activity documentation

---

# Persona 4: Social Researcher

## Profile

**Name:** Dr. Ahmad Wijaya

**Role:** Researcher / Data Analyst

**Organization Type:** University / Research Institution

**Age Range:** 25–60

**Technical Proficiency:** Advanced

---

## Responsibilities

- Analyze community data
- Evaluate program effectiveness
- Produce evidence-based recommendations
- Conduct impact assessments

---

## Goals

- Access reliable structured data
- Analyze trends and outcomes
- Generate actionable insights
- Support policy recommendations

---

## Pain Points

- Inconsistent data quality
- Missing field information
- Limited access to historical records
- Time-consuming data cleaning

---

## Needs

- Structured datasets
- Data export functionality
- Historical data access
- Analytics and visualization tools

---

## Success Criteria

- Improved data quality
- Faster analysis workflows
- More accurate impact evaluations
- Better evidence generation

---

# Persona Relationship Map

```text
                    ┌─────────────────────┐
                    │ NGO Program Manager │
                    └──────────┬──────────┘
                               │
                               │ manages
                               │
                    ┌──────────▼──────────┐
                    │      Project        │
                    └──────────┬──────────┘
                               │
        ┌──────────────────────┼──────────────────────┐
        │                      │                      │
        │ coordinates          │ reports             │ analyzes
        │                      │                      │
┌───────▼────────┐    ┌────────▼────────┐    ┌───────▼────────┐
│ Community      │    │ Volunteer       │    │ Researcher     │
│ Leader         │    │                  │    │                │
└────────────────┘    └─────────────────┘    └────────────────┘
```

---

# Design Implications

## High Priority Requirements

### Mobile First

The application must be optimized for smartphones and tablets.

### Offline First

Users should be able to submit and store data without continuous internet access.

### Simple Reporting

Data collection and reporting workflows must minimize user effort.

### Real-Time Visibility

Project stakeholders should receive timely updates and notifications.

### Data-Driven Insights

The platform should gradually evolve toward analytics and AI-assisted recommendations.

---

# Future Personas

Potential future users:

- Government Agencies
- Donors
- Social Enterprises
- Corporate CSR Teams
- Development Consultants

---

# Version

User Personas v0.3

Created: June 2026

Related Documents:

- Product Vision
- ADR-001 Mobile Platform Strategy
- Domain Model