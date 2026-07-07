# Authentication API Contract

| Field | Value |
|------|------|
| **Module** | Authentication |
| **Document** | API Contract |
| **Version** | 1.0 |
| **Status** | Planned |
| **Owner** | DscienTia Mobile Team |
| **Related Sprint** | FL-004 |

---

# 1. Purpose

This document defines the REST API contract used by the Authentication Module.

It specifies:

- endpoints;
- request payloads;
- response payloads;
- HTTP status codes;
- authentication requirements;
- error responses.

The contract serves as the agreement between the Flutter application and the backend API.

---

# 2. Base URL

Development

```text
http://localhost:8000/api
```

Staging

```text
https://staging-api.dscientia.dev/api
```

Production

```text
https://api.dscientia.dev/api
```

---

# 3. Authentication Method

The API uses:

- JWT Access Token
- Refresh Token

Authenticated requests must include:

```http
Authorization: Bearer <access_token>
```

---

# 4. Standard Response Format

Successful response

```json
{
  "success": true,
  "message": "Operation completed successfully.",
  "data": {}
}
```

---

Error response

```json
{
  "success": false,
  "message": "Invalid credentials.",
  "errors": {}
}
```

---

# 5. Endpoints

## POST /auth/login

Authenticate user.

### Request

```json
{
  "email": "user@example.com",
  "password": "password123"
}
```

---

### Success Response

HTTP

```text
200 OK
```

Body

```json
{
  "success": true,
  "message": "Login successful.",
  "data": {
    "access_token": "...",
    "refresh_token": "...",
    "expires_in": 3600,
    "user": {
      "id": 1,
      "name": "John Doe",
      "email": "user@example.com"
    }
  }
}
```

---

## POST /auth/register

Create a new account.

### Request

```json
{
  "name": "John Doe",
  "email": "user@example.com",
  "password": "password123",
  "password_confirmation": "password123"
}
```

---

### Success Response

```text
201 Created
```

```json
{
  "success": true,
  "message": "Registration successful."
}
```

---

## POST /auth/logout

Invalidate current session.

Requires Authentication.

### Headers

```http
Authorization: Bearer <token>
```

---

### Success Response

```text
200 OK
```

```json
{
  "success": true,
  "message": "Logout successful."
}
```

---

## POST /auth/refresh

Refresh Access Token.

### Request

```json
{
  "refresh_token": "..."
}
```

---

### Success Response

```json
{
  "success": true,
  "data": {
    "access_token": "...",
    "expires_in": 3600
  }
}
```

---

## GET /auth/profile

Retrieve authenticated user.

Requires Authentication.

### Success Response

```json
{
  "success": true,
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "user@example.com"
  }
}
```

---

## POST /auth/forgot-password

Request password reset.

### Request

```json
{
  "email": "user@example.com"
}
```

---

### Success Response

```json
{
  "success": true,
  "message": "Password reset email sent."
}
```

---

## POST /auth/reset-password

Reset password.

### Request

```json
{
  "token": "...",
  "email": "user@example.com",
  "password": "newPassword123",
  "password_confirmation": "newPassword123"
}
```

---

### Success Response

```json
{
  "success": true,
  "message": "Password updated."
}
```

---

# 6. HTTP Status Codes

| Code | Meaning |
|------|---------|
| 200 | Success |
| 201 | Resource Created |
| 400 | Bad Request |
| 401 | Unauthorized |
| 403 | Forbidden |
| 404 | Not Found |
| 409 | Conflict |
| 422 | Validation Error |
| 429 | Too Many Requests |
| 500 | Internal Server Error |

---

# 7. Validation Errors

Example

```json
{
  "success": false,
  "message": "Validation failed.",
  "errors": {
    "email": [
      "The email field is required."
    ],
    "password": [
      "Password must be at least 8 characters."
    ]
  }
}
```

---

# 8. Authentication Errors

| Situation | HTTP |
|-----------|------|
| Invalid Credentials | 401 |
| Invalid Token | 401 |
| Expired Token | 401 |
| Refresh Token Expired | 401 |
| Account Disabled | 403 |

---

# 9. Token Lifecycle

```text
Login

↓

Access Token

↓

Protected Requests

↓

Expired

↓

Refresh Token

↓

New Access Token

↓

Continue Session

↓

Refresh Failed

↓

Logout
```

---

# 10. Security Requirements

- HTTPS only in production.
- Access Tokens must never be stored in SharedPreferences.
- Tokens must be stored using Flutter Secure Storage.
- Refresh Tokens must never be exposed in logs.
- Sensitive fields must not be cached.

---

# 11. Versioning

Current API Version

```text
v1
```

Future versions should be introduced using URL versioning.

Example

```text
/api/v2/auth/login
```

---

# 12. Future Endpoints

Potential future additions:

- POST /auth/google
- POST /auth/apple
- POST /auth/mfa
- POST /auth/verify-email
- POST /auth/resend-verification
- DELETE /auth/account

---

# 13. Related Documentation

Feature Documentation

- README.md
- Architecture.md
- User-Flow.md
- Repository.md
- Security.md
- Testing.md

Flutter Documentation

- ../../flutter/Networking.md
- ../../flutter/Repository-Pattern.md

Architecture Decision Records

- ../../adr/ADR-002-Riverpod-State-Management.md
- ../../adr/ADR-003-Repository-Pattern.md