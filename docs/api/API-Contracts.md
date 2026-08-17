# API Contracts

## Purpose

This document defines the API contracts for the DscienTia AI Insight MVP.

The APIs provide communication between:

* Flutter Mobile Application
* Laravel Backend Platform
* IBM watsonx AI Services

The objective is to ensure consistent integration across the application while supporting future scalability, AI intelligence capabilities, and cross-platform expansion.

This document serves as the primary reference for:

* Mobile development
* Backend implementation
* AI integration
* Security enforcement
* Future API versioning

---

# API Design Principles

## REST-First Architecture

The MVP uses REST APIs as the primary communication mechanism.

Benefits:

* Simple implementation
* Flutter compatibility
* Clear resource structure
* Easy future expansion

---

## JSON Standardization

All requests and responses use JSON.

Example Response:

```json
{
  "success": true,
  "message": "Request completed successfully",
  "data": {}
}
```

---

## Versioning Strategy

All endpoints are versioned.

Example:

```text
/api/v1
```

Future versions:

```text
/api/v2
/api/v3
```

Backward compatibility should be maintained whenever possible.

---

## Authentication Strategy

Authentication uses JWT Bearer Tokens.

Example:

```http
Authorization: Bearer <token>
```

---

# API Architecture

```text
Flutter Mobile App
        │
        ▼
Laravel API Gateway
        │
        ├── Authentication Service
        ├── Project Service
        ├── Report Service
        ├── Dashboard Service
        ├── Notification Service
        └── AI Intelligence Service
                     │
                     ▼
              IBM watsonx.ai
```

---

# Base URLs

## Development

```text
http://localhost:8000/api/v1
```

## Staging

```text
https://staging-api.dscientia.dev/api/v1
```

## Production

```text
https://api.dscientia.dev/api/v1
```

---

# Standard Response Format

## Success Response

```json
{
  "success": true,
  "message": "Operation successful",
  "data": {}
}
```

---

## Error Response

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request"
  }
}
```

---

# Authentication APIs

## Login

### Endpoint

```http
POST /auth/login
```

### Request

```json
{
  "email": "user@example.com",
  "password": "password"
}
```

### Response

```json
{
  "success": true,
  "token": "jwt_token",
  "user": {
    "id": 1,
    "name": "John Doe",
    "role": "Volunteer"
  }
}
```

---

## Logout

### Endpoint

```http
POST /auth/logout
```

---

## Current User

### Endpoint

```http
GET /auth/me
```

---

# Dashboard APIs

## Dashboard Summary

### Endpoint

```http
GET /dashboard
```

### Response

```json
{
  "activeProjects": 14,
  "reportsSubmitted": 245,
  "riskAlerts": 8,
  "aiInsights": 22
}
```

---

# Project APIs

## List Projects

### Endpoint

```http
GET /projects
```

---

## Project Detail

### Endpoint

```http
GET /projects/{projectId}
```

---

## Project Metrics

### Endpoint

```http
GET /projects/{projectId}/metrics
```

---

# Report APIs

## Create Report

### Endpoint

```http
POST /reports
```

### Request

```json
{
  "title": "Water Supply Issue",
  "description": "Water shortages reported by community members",
  "communityId": 12,
  "location": "Bandung",
  "attachments": []
}
```

### Response

```json
{
  "success": true,
  "reportId": 101
}
```

---

## List Reports

### Endpoint

```http
GET /reports
```

---

## Report Detail

### Endpoint

```http
GET /reports/{reportId}
```

---

## Update Report

### Endpoint

```http
PUT /reports/{reportId}
```

---

# AI Intelligence APIs

The following APIs interact with the DscienTia AI Intelligence Layer
through the backend provider abstraction.

The current production environment uses the deterministic Mock Provider.
The IBM watsonx provider is implemented as a separate integration path
and remains pending controlled live verification.

---

## Generate AI Insight

### Endpoint

```http
POST /ai/insights/generate
```

### Request

```json
{
  "reportId": 101
}
```

### Response

```json
{
  "summary": "Water shortage incidents increased during the last 30 days.",
  "confidenceScore": 0.89,
  "generatedAt": "2026-07-01T08:00:00Z"
}
```

---

## Retrieve AI Insight

### Endpoint

```http
GET /ai/insights/{insightId}
```

---

## List AI Insights

### Endpoint

```http
GET /ai/insights
```

---

# Risk Assessment APIs

## Generate Risk Assessment

### Endpoint

```http
POST /ai/risks/generate
```

### Request

```json
{
  "communityId": 12
}
```

---

## Get Risk Assessment

### Endpoint

```http
GET /ai/risks/{communityId}
```

### Response

```json
{
  "riskLevel": "High",
  "confidenceScore": 0.92,
  "summary": "Repeated water shortage reports detected."
}
```

---

# Recommendation APIs

## Generate Recommendations

### Endpoint

```http
POST /ai/recommendations/generate
```

---

## Get Recommendations

### Endpoint

```http
GET /ai/recommendations/{communityId}
```

### Response

```json
{
  "recommendations": [
    {
      "priority": "High",
      "action": "Coordinate emergency water distribution."
    },
    {
      "priority": "Medium",
      "action": "Conduct infrastructure assessment."
    }
  ]
}
```

---

# Notification APIs

## List Notifications

### Endpoint

```http
GET /notifications
```

---

## Mark Notification as Read

### Endpoint

```http
PATCH /notifications/{notificationId}
```

---

# Internal AI Service APIs

The following APIs are internal-only and are not exposed to mobile clients.

---

## Generate Insight

```http
POST /internal/ai/generate-insight
```

---

## Generate Risk Score

```http
POST /internal/ai/generate-risk-score
```

---

## Generate Recommendation

```http
POST /internal/ai/generate-recommendation
```

---

# Security Requirements

All APIs must support:

* HTTPS
* JWT Authentication
* Role-Based Access Control (RBAC)
* Input Validation
* Request Logging
* Rate Limiting
* Secure Error Handling

---

# MVP Scope

Included:

* Authentication
* Dashboard
* Project Viewing
* Report Submission
* AI Insight Generation
* Risk Assessment
* Recommendation Generation
* Notifications

Excluded:

* Public APIs
* Third-Party Integrations
* Donor APIs
* Advanced Predictive Analytics APIs
* Multi-Tenant Organization APIs

---

# Future API Expansion

## AI Assistant API

```http
POST /ai/chat
```

Conversational community intelligence assistant.

---

## Predictive Analytics API

```http
POST /ai/predict
```

Forecast future community risks.

---

## Geospatial Intelligence API

```http
GET /ai/geospatial
```

Location-based community intelligence.

---

# Version

API Contracts v0.1

Milestone:

v0.6 AI Insight MVP

Created: June 2026

Related Documents:

* MVP Scope
* User Flows
* Screen Specifications
* AI Insight Workflow
* Data Models
* System Architecture
* IBM WatsonX Integration
