# DscienTia — Submission Architecture Overview

## System Flow

```mermaid
flowchart LR
    U[Community User] --> F[Flutter Web Application]

    F -->|HTTPS REST API| L[Laravel 12 Backend]

    L --> R[(Community Reports)]
    L --> I[(Structured AI Insights)]

    L --> P{AI Provider Abstraction}

    P --> M[Verified Mock Provider]
    P --> W[IBM watsonx.ai Provider]

    W --> IAM[IBM Cloud IAM]
    W --> G[IBM Granite Model]

    L --> E[Sanitized Logs and Evidence]

    B[IBM Bob] -->|Architecture and Readiness Review| C[DscienTia Repository]
