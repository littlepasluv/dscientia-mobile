# DscienTia Development Environment Setup

## Version

v1.0

Date: June 2026

---

# Purpose

This document defines the official development environment for DscienTia.

All contributors, AI coding agents, and future maintainers should follow this setup.

The objective is to ensure consistency across:

* Flutter development
* Laravel development
* PostgreSQL database development
* IBM watsonx integration

---

# Supported Development Platform

Primary Platform:

macOS

Secondary Platforms:

* Linux
* Windows 11

---

# IDE

Official IDE:

JetBrains

Preferred Options:

* IntelliJ IDEA Ultimate
* Android Studio

AI Assistant:

Gemini Agent

---

# Source Control

Git Version:

2.40+

Repository:

GitHub

Branch Strategy:

```text
main
develop

feature/*
bugfix/*
hotfix/*
```

---

# Flutter Environment

## Flutter SDK

Version:

Flutter Stable

Minimum Version:

3.44+

Verify:

```bash
flutter --version
```

---

## Dart SDK

Bundled with Flutter

Verify:

```bash
dart --version
```

---

## Required Flutter Packages

Core Packages:

```yaml
flutter_riverpod
go_router
dio
freezed_annotation
json_annotation
hive
hive_flutter
flutter_secure_storage
```

Development Packages:

```yaml
build_runner
freezed
json_serializable
flutter_lints
```

---

# Android Development

## Android SDK

Minimum SDK:

26

Target SDK:

Latest Stable

Verify:

```bash
flutter doctor
```

---

# iOS Development

Future Phase

Requirements:

* Xcode Latest Stable
* CocoaPods

Verify:

```bash
pod --version
```

---

# Backend Environment

## PHP

Version:

8.4+

Verify:

```bash
php -v
```

---

## Composer

Verify:

```bash
composer --version
```

---

## Laravel

Version:

Laravel 12

Verify:

```bash
php artisan --version
```

---

# Database Environment

## PostgreSQL

Version:

16+

Verify:

```bash
psql --version
```

---

## Database Naming

Development:

```text
dscientia_dev
```

Testing:

```text
dscientia_test
```

Production:

```text
dscientia_prod
```

---

# API Development

## Local API URL

```text
http://localhost:8000/api
```

---

## Authentication

Laravel Sanctum

Authentication Type:

```text
Bearer Token
```

---

# AI Environment

## IBM watsonx

Required Services:

* watsonx.ai
* Granite Foundation Models

---

## Environment Variables

Example:

```env
WATSONX_API_KEY=
WATSONX_PROJECT_ID=
WATSONX_URL=
```

---

# Environment Variables

## Backend

Local development example only. Do not use these values in staging or production.

```env
APP_ENV=local

DB_CONNECTION=pgsql
DB_HOST=127.0.0.1
DB_PORT=5432
DB_DATABASE=dscientia_dev
DB_USERNAME=your_local_postgres_user
DB_PASSWORD=your_local_postgres_password
```

---

## Frontend

Example:

```env
API_BASE_URL=http://localhost:8000/api
```

---

# Flutter Verification Checklist

Verify:

```bash
flutter doctor
```

Expected:

```text
Flutter SDK Installed
Android SDK Installed
No Critical Issues
```

---

# Laravel Verification Checklist

Verify:

```bash
php artisan migrate
```

Expected:

```text
Migration completed successfully
```

---

# PostgreSQL Verification Checklist

Verify:

```bash
psql -U postgres
```

Expected:

```text
Connected successfully
```

---

# IBM watsonx Verification Checklist

Verify:

* API Key available
* Project ID available
* Model access available

Expected:

```text
Successful model invocation
```

---

# Development Readiness Checklist

Before starting implementation:

* Flutter installed
* Dart installed
* Android SDK installed
* Laravel installed
* PostgreSQL installed
* Git configured
* GitHub access confirmed
* IBM watsonx credentials configured

---

# AI Agent Instructions

When generating code:

* Follow Technology Stack Decision document.
* Follow Engineering Standards document.
* Follow Project Structure document.
* Follow Definition of Done document.
* Never introduce technologies outside the approved stack.
* Prefer maintainability over optimization.
* Generate production-quality code.

---

End of Document
