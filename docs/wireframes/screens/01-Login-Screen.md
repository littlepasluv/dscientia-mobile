# Login Screen

## Purpose

The Login Screen serves as the primary entry point into the DscienTia Mobile application.

It enables users to securely access the platform and their role-specific features.

The screen should be simple, accessible, and optimized for mobile devices operating in both urban and low-connectivity environments.

---

# User Roles

Supported user roles:

- Volunteer
- Community Leader
- NGO Program Manager
- Researcher
- System Administrator

Authentication determines which dashboard and features are available after login.

---

# Goals

The Login Screen should allow users to:

- Access their account securely
- Recover forgotten credentials
- Register a new account
- Stay signed in on trusted devices
- Access the platform quickly with minimal friction

---

# Functional Requirements

## User Login

Users must be able to authenticate using:

- Email Address
- Password

Validation requirements:

- Email must be valid
- Password cannot be empty

---

## Remember Me

Users may choose to remain logged in.

Benefits:

- Faster access
- Reduced login frequency

---

## Forgot Password

Users can initiate password recovery.

Flow:

```text
Forgot Password
      ↓
Enter Email
      ↓
Receive Reset Link
      ↓
Create New Password
```

---

## Registration

New users can create an account.

Required information:

- Full Name
- Email
- Password
- Organization
- Role

---

# Screen Layout

```text
+----------------------------------+
|          DscienTia Logo          |
|                                  |
|  Community Impact Intelligence   |
|                                  |
|  Email Address                   |
|  [___________________________]   |
|                                  |
|  Password                        |
|  [___________________________]   |
|                                  |
|  [ ] Remember Me                 |
|                                  |
|      [ Login Button ]            |
|                                  |
|      Forgot Password?            |
|                                  |
|----------------------------------|
| Don't have an account?           |
| Register                         |
+----------------------------------+
```

---

# UI Components

## Branding Section

Displays:

- DscienTia Logo
- Tagline

Example tagline:

"Transforming Community Data into Impact Intelligence"

---

## Email Field

Purpose:

Collect user email.

Validation:

- Required
- Valid email format

---

## Password Field

Purpose:

Collect password securely.

Features:

- Masked input
- Show / Hide Password Toggle

---

## Login Button

Primary call-to-action.

Behavior:

- Disabled when fields are empty
- Shows loading indicator during authentication

---

## Forgot Password Link

Navigates to password recovery flow.

---

## Register Link

Navigates to registration screen.

---

# Error States

## Invalid Credentials

Message:

"Incorrect email or password."

---

## Network Error

Message:

"Unable to connect. Please check your internet connection."

---

## Server Error

Message:

"Something went wrong. Please try again later."

---

# Offline Considerations

If no internet connection is available:

- Existing authenticated users may access cached content
- New login attempts require connectivity

---

# Security Requirements

Authentication must support:

- Secure password storage
- HTTPS communication
- Token-based authentication

Future enhancements:

- Multi-Factor Authentication
- Google Sign-In
- Microsoft Sign-In

---

# User Flow

```text
Launch App
     ↓
Login Screen
     ↓
Authentication
     ↓
Role Detection
     ↓
Role-Based Dashboard
```

---

# Success Criteria

The Login Screen is considered successful when:

- Users can authenticate in less than 30 seconds
- Authentication success rate exceeds 95%
- Password recovery can be completed independently
- Mobile usability remains high across devices

---

# Related Documents

- Product Vision
- User Personas
- Information Architecture
- System Architecture

---

# Version

Wireframe v0.4

Screen ID: WF-01

Created: June 2026