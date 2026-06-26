# API Specification v1

## Purpose

This document defines the REST API specification for the DscienTia AI Insight MVP.

The API enables communication between:

* Flutter Mobile Application
* Laravel Backend Services
* PostgreSQL Database
* IBM watsonx AI Services

This specification serves as the foundation for backend implementation, frontend integration, and future API expansion.

---

# API Design Principles

The DscienTia API follows these principles:

## RESTful Design

Resources are exposed through predictable REST endpoints.

Example:

```text
GET /projects
POST /reports
GET /insights
```

---

## JSON-Based Communication

All requests and responses use JSON.

Content Type:

```http
Content-Type: application/json
```

---

## Secure by Default

Protected endpoints require authentication.

Authorization:

```http
Authorization: Bearer <token>
```

---

## Versioning Strategy

Initial version:

```text
/api/v1
```

Example:

```text
/api/v1/projects
```

---

# Authentication API

## Login

### Endpoint

```http
POST /api/v1/auth/login
```

### Request

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

### Response

```json
{
  "token": "jwt_token",
  "user": {
    "id": "uuid",
    "name": "John Doe",
    "role": "Volunteer"
  }
}
```

---

## Logout

### Endpoint

```http
POST /api/v1/auth/logout
```

### Response

```json
{
  "message": "Logout successful"
}
```

---

## Current User

### Endpoint

```http
GET /api/v1/auth/me
```

### Response

```json
{
  "id": "uuid",
  "name": "John Doe",
  "email": "john@example.com",
  "role": "Volunteer"
}
```

---

# Project API

## List Projects

### Endpoint

```http
GET /api/v1/projects
```

### Response

```json
[
  {
    "id": "uuid",
    "title": "Water Access Initiative",
    "status": "Active",
    "progress": 65
  }
]
```

---

## Project Detail

### Endpoint

```http
GET /api/v1/projects/{id}
```

### Response

```json
{
  "id": "uuid",
  "title": "Water Access Initiative",
  "description": "Improve water accessibility",
  "status": "Active",
  "progress": 65,
  "community": "Village A"
}
```

---

# Report API

## Submit Report

### Endpoint

```http
POST /api/v1/reports
```

### Request

```json
{
  "project_id": "uuid",
  "title": "Water Supply Issue",
  "description": "Residents report shortage",
  "category": "Infrastructure",
  "location": "Village A"
}
```

### Response

```json
{
  "id": "uuid",
  "status": "Submitted"
}
```

---

## List Reports

### Endpoint

```http
GET /api/v1/reports
```

### Response

```json
[
  {
    "id": "uuid",
    "title": "Water Supply Issue",
    "status": "Under Review"
  }
]
```

---

## Report Detail

### Endpoint

```http
GET /api/v1/reports/{id}
```

### Response

```json
{
  "id": "uuid",
  "title": "Water Supply Issue",
  "description": "Residents report shortage",
  "status": "Approved",
  "submitted_at": "2026-06-25T10:00:00Z"
}
```

---

# AI Insight API

## List AI Insights

### Endpoint

```http
GET /api/v1/insights
```

### Response

```json
[
  {
    "id": "uuid",
    "summary": "Water-related complaints increased 27%",
    "confidence": 0.89
  }
]
```

---

## AI Insight Detail

### Endpoint

```http
GET /api/v1/insights/{id}
```

### Response

```json
{
  "id": "uuid",
  "summary": "Water-related complaints increased 27%",
  "risk_level": "Medium",
  "confidence": 0.89,
  "generated_at": "2026-06-25T10:00:00Z"
}
```

---

# Risk Assessment API

## List Risks

### Endpoint

```http
GET /api/v1/risks
```

### Response

```json
[
  {
    "id": "uuid",
    "community": "Village A",
    "risk_level": "Medium",
    "confidence": 0.82
  }
]
```

---

## Risk Detail

### Endpoint

```http
GET /api/v1/risks/{id}
```

### Response

```json
{
  "id": "uuid",
  "community": "Village A",
  "risk_level": "Medium",
  "observation": "Increasing water complaints",
  "confidence": 0.82
}
```

---

# Recommendation API

## List Recommendations

### Endpoint

```http
GET /api/v1/recommendations
```

### Response

```json
[
  {
    "id": "uuid",
    "priority": "High",
    "recommendation": "Coordinate emergency water distribution"
  }
]
```

---

## Recommendation Detail

### Endpoint

```http
GET /api/v1/recommendations/{id}
```

### Response

```json
{
  "id": "uuid",
  "priority": "High",
  "recommendation": "Coordinate emergency water distribution",
  "status": "Pending"
}
```

---

# Notification API

## List Notifications

### Endpoint

```http
GET /api/v1/notifications
```

### Response

```json
[
  {
    "id": "uuid",
    "title": "Risk Alert",
    "message": "Water shortage detected"
  }
]
```

---

# Error Handling

## Standard Error Format

```json
{
  "error": true,
  "message": "Resource not found",
  "code": 404
}
```

---

# HTTP Status Codes

| Code | Meaning          |
| ---- | ---------------- |
| 200  | Success          |
| 201  | Created          |
| 400  | Bad Request      |
| 401  | Unauthorized     |
| 403  | Forbidden        |
| 404  | Not Found        |
| 422  | Validation Error |
| 500  | Server Error     |

---

# MVP API Scope

Included:

✓ Authentication

✓ Projects

✓ Reports

✓ AI Insights

✓ Risk Assessments

✓ Recommendations

✓ Notifications

Excluded:

✗ File Upload Service

✗ Chat Service

✗ Donor Portal APIs

✗ Multi-Tenant APIs

✗ Public APIs

---

# Future API Evolution

Phase 2:

* GraphQL Support
* AI Feedback Endpoints
* Batch Analytics APIs

Phase 3:

* Research APIs
* Predictive Impact APIs
* External Organization Integrations

---

# Version

API Specification v1

Created: June 2026

Related Documents:

* ERD v1
* API Contracts
* System Architecture
* Flutter Project Structure
* AI Insight Workflow
