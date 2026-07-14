# DEPLOY-002B — Hostinger API Website and MySQL Setup

## Status

Completed on Hostinger.

## Purpose

This milestone prepares the Hostinger environment for the future Laravel API deployment at:

    https://api.dscientia.dev

This step does not upload or deploy the Laravel backend yet.

## API Subdomain

The API subdomain has been created:

    api.dscientia.dev

## DNS Status

Hostinger shows that the API subdomain is connected.

DNS record:

    Type: A
    Name: api
    Value: 46.202.198.22

DNS propagation may still require some time depending on caching.

## File Manager Status

The website root for api.dscientia.dev is available.

Current structure:

    public_html/
    └── default.php

The default.php file should not be removed until the Laravel deployment package is ready.

## PHP Version

The API website is configured with:

    PHP 8.4

The PHP info screen confirms:

    PHP Version 8.4.20

## MySQL Database

A MySQL database has been created for the Laravel API.

Database name:

    u919039688_dscientia_api

Database user:

    u919039688_dscientia_user

Database password:

    Stored privately. Do not commit or share.

## Future Production Environment Values

The production `.env` file on Hostinger should later use:

    APP_ENV=production
    APP_DEBUG=false
    APP_URL=https://api.dscientia.dev

    DB_CONNECTION=mysql
    DB_DATABASE=u919039688_dscientia_api
    DB_USERNAME=u919039688_dscientia_user
    DB_PASSWORD=<stored privately>
    DB_PORT=3306

The database host must be copied exactly from Hostinger database details.

Do not guess DB_HOST if Hostinger provides a specific hostname.

## Current AI Provider

The backend should initially use:

    DSCIENTIA_AI_PROVIDER=mock

IBM/watsonx credentials are not enabled yet.

## Security Notes

Do not upload or commit:

    .env
    database/database.sqlite
    vendor/
    node_modules/
    production database password
    IBM/watsonx credentials

## Next Milestone

    DEPLOY-002C — Prepare Laravel deployment package for Hostinger
