# DscienTia Technology Stack Decision

## Version

v1.0

Date: June 2026

---

# Purpose

This document defines the official technology stack for DscienTia.

All future implementation decisions should align with this stack unless formally revised.

---

# Architectural Principles

The platform must be:

* Mobile-first
* AI-native
* Cloud-ready
* Modular
* Open-source friendly
* IBM watsonx compatible

---

# Frontend

## Framework

Flutter

Reason:

* Single codebase
* Android support
* Future iOS support
* Excellent developer productivity

---

## Language

Dart

---

## State Management

Riverpod

Reason:

* Predictable state management
* Testability
* Dependency injection support

---

## Navigation

GoRouter

Reason:

* Declarative routing
* Deep linking support
* Scalable navigation architecture

---

## Local Storage

Hive

Purpose:

* Offline caching
* Draft reports
* Local user preferences

---

# Backend

## Framework

Laravel 12

Reason:

* Mature ecosystem
* Strong API development capabilities
* Fast MVP delivery

---

## Language

PHP 8.4+

---

## Authentication

Laravel Sanctum

Purpose:

* Mobile token authentication
* API security

---

# Database

## Primary Database

PostgreSQL

Reason:

* Relational consistency
* JSON support
* Future analytics compatibility

---

# AI Layer

## AI Platform

IBM watsonx

---

## Foundation Models

IBM Granite Models

Primary Usage:

* Insight generation
* Risk assessment
* Recommendation generation

---

# Infrastructure

## Source Control

GitHub

---

## CI/CD

GitHub Actions

---

## Hosting

Phase 1:

Render / Railway

Phase 2:

IBM Cloud

---

# Monitoring

Future Phase

* Sentry
* Laravel Telescope
* OpenTelemetry

---

# Official Stack Summary

Frontend:

Flutter + Riverpod + GoRouter

Backend:

Laravel 12 + Sanctum

Database:

PostgreSQL

AI:

IBM watsonx + Granite

Repository:

GitHub

CI/CD:

GitHub Actions

---

End of Document
