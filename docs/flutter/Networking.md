# Networking

**Project:** DscienTia Mobile Application

**Version:** v0.8 Foundation Architecture

**Status:** Official Standard

---

# Purpose

This document defines the official networking architecture for the DscienTia Flutter application.

The application uses **Dio** as the primary HTTP client for communicating with backend services.

All network communication must follow the standards defined in this document.

---

# Objectives

The networking layer is designed to:

* Centralize HTTP communication.
* Improve maintainability.
* Standardize API requests.
* Support authentication.
* Support request interception.
* Simplify testing.
* Enable offline-first architecture.
* Ensure consistent AI-generated implementations.

---

# Architecture Position

```text
Presentation

↓

Provider

↓

Repository

↓

Datasource

↓

Network Service (Dio)

↓

REST API
```

Only the datasource layer communicates directly with Dio.

---

# Network Layer Structure

The networking implementation resides inside:

```text
lib/

core/

network/
```

Recommended structure:

```text
core/

network/

api_client.dart

dio_client.dart

interceptors/

authentication_interceptor.dart

logging_interceptor.dart

retry_interceptor.dart
```

---

# Responsibilities

The networking layer is responsible for:

* Sending HTTP requests.
* Receiving HTTP responses.
* Applying authentication headers.
* Configuring timeouts.
* Handling retries.
* Logging requests.
* Logging responses.
* Mapping HTTP failures.

The networking layer is **not** responsible for:

* Business logic.
* UI rendering.
* Navigation.
* State management.

---

# Request Flow

Every request follows the same lifecycle.

```text
Screen

↓

Provider

↓

Repository

↓

Datasource

↓

Dio

↓

REST API
```

Responses follow the reverse path.

---

# Authentication

Authentication headers are injected automatically through an interceptor.

Individual repositories should never manually attach authentication tokens.

Future authentication methods may include:

* Bearer Token
* Refresh Token
* OAuth
* API Key

---

# Base Configuration

The application should define:

* Base URL
* Connection timeout
* Receive timeout
* Send timeout
* Default headers

These values should be configured centrally inside the networking layer.

---

# Interceptors

The networking layer supports multiple interceptors.

Typical interceptor order:

```text
Request

↓

Authentication

↓

Logging

↓

Retry

↓

HTTP Request
```

Response interceptors execute in reverse order.

---

# Error Handling

Network exceptions must be converted into standardized failures.

Raw DioException objects must never propagate beyond the networking layer.

Examples include:

* No Internet Connection
* Timeout
* Unauthorized
* Forbidden
* Not Found
* Server Error
* Unknown Error

---

# Logging

Logging is enabled during development.

Production builds should avoid logging sensitive information.

Examples of sensitive data:

* Access Tokens
* Passwords
* API Keys
* Personally Identifiable Information (PII)

---

# Retry Strategy

Retry behavior should only apply to recoverable failures.

Examples:

* Temporary network interruption.
* Request timeout.
* HTTP 503.

Retrying should never occur for:

* Invalid credentials.
* Validation errors.
* Permission failures.

---

# Dependency Rules

Allowed

```text
Repository

↓

Datasource

↓

Dio
```

Forbidden

```text
Provider

↓

Dio
```

Forbidden

```text
Screen

↓

Dio
```

Forbidden

```text
Widget

↓

HTTP
```

---

# Future Expansion

The networking layer is designed to support:

* Multiple backend services.
* GraphQL integration.
* File uploads.
* Streaming APIs.
* WebSocket communication.
* Offline synchronization.

No architectural changes should be required when these capabilities are introduced.

---

# Engineering Rules

Every API request must:

* Use Dio.
* Use centralized configuration.
* Use interceptors.
* Respect timeout policies.
* Return standardized failures.
* Avoid duplicate HTTP implementations.

---

# Relationship with Other Documents

This document should be read together with:

* Flutter-Architecture.md
* Repository-Pattern.md
* Error-Handling.md
* State-Management.md

Together these documents define the official networking architecture for the DscienTia Flutter application.
