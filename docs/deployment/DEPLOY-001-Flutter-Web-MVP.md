# DEPLOY-001 — Flutter Web MVP Deployment

## Status

Completed

## Deployment URL

```text
https://app.dscientia.dev
```

## Deployment Date

```text
2026-07-10
```

## Purpose

This deployment publishes the DscienTia Flutter Web MVP demo to a dedicated application subdomain.

The deployment keeps the main public website separate from the interactive product demo.

## Domain Separation

```text
www.dscientia.dev  → public landing page
app.dscientia.dev  → Flutter Web MVP demo
api.dscientia.dev  → planned Laravel API backend
```

## Deployment Result

The Flutter Web MVP is now live at:

```text
https://app.dscientia.dev
```

The main public website remains available at:

```text
https://www.dscientia.dev
```

This confirms that the deployment separation is working correctly.

## Deployment Scope

This deployment includes:

- DscienTia dashboard;
- community resilience MVP entry point;
- AI Insight demo flow;
- community risk report form;
- mock AI insight result screen.

## Current App URL Behavior

The current Flutter Web deployment uses hash-based routing.

Example:

```text
https://app.dscientia.dev/#/demo
```

This is acceptable for DEPLOY-001 because it improves compatibility with static hosting and shared hosting environments.

Clean path routing can be considered later after the MVP deployment is stable.

## Hosting Provider

```text
Hostinger
```

## Hosting Target

The Flutter Web build output was uploaded to the Hostinger website root for:

```text
app.dscientia.dev
```

Expected hosting structure:

```text
public_html/
├── .htaccess
├── index.html
├── flutter_bootstrap.js
├── main.dart.js
├── assets/
├── canvaskit/
├── icons/
└── manifest.json
```

## DNS Result

The subdomain `app.dscientia.dev` was created and pointed to Hostinger hosting.

The main domain and landing page were not replaced.

## Build Command

Flutter Web release build:

```bash
cd frontend/dscientia_app
flutter clean
flutter pub get
flutter build web --release --base-href /
```

## Upload Method

The generated Flutter Web files from:

```text
frontend/dscientia_app/build/web
```

were compressed into a ZIP file and uploaded to Hostinger File Manager.

The ZIP contents were extracted into the `public_html` folder for `app.dscientia.dev`.

## Verification Checklist

- `https://app.dscientia.dev` loads successfully.
- Dashboard is visible.
- AI Insight entry point is visible.
- Community Risk Report entry point is visible.
- AI Insight demo can be opened.
- Community Risk Report form can be opened.
- Main website `https://www.dscientia.dev` remains unchanged.
- The deployment does not affect `www.dscientia.dev`.
- The backend API subdomain is not deployed yet.

## Current Limitations

- Backend API is not connected yet.
- Authentication is not production-ready.
- AI Insight uses local mock generation.
- IBM/watsonx integration is not active yet.
- The app currently uses hash-based routing.

These limitations are accepted for DEPLOY-001.

## Strategic Importance

DEPLOY-001 gives DscienTia a live MVP demo URL.

This supports:

- IBM Builder preparation;
- portfolio demonstration;
- product validation;
- stakeholder review;
- future integration with `api.dscientia.dev`.

## Next Deployment Milestone

```text
DEPLOY-002 — Prepare api.dscientia.dev for Laravel API backend
```

## Related Documents

- [Deployment Architecture](Deployment-Architecture.md)
- [ADR-005 Deployment Architecture](../adr/ADR-005-Deployment-Architecture.md)
- [AI Insight Architecture](../features/ai-insight/Architecture.md)