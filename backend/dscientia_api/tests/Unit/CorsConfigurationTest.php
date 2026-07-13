<?php

namespace Tests\Unit;

use Tests\TestCase;

class CorsConfigurationTest extends TestCase
{
    public function test_cors_allows_dscientia_app_domain_by_default(): void
    {
        $allowedOrigins = config('cors.allowed_origins');

        $this->assertContains('https://app.dscientia.dev', $allowedOrigins);
    }

    public function test_cors_supports_local_flutter_development_origins(): void
    {
        $allowedOrigins = config('cors.allowed_origins');

        $this->assertContains('http://localhost:5444', $allowedOrigins);
    }
}
