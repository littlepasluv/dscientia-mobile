<?php

$allowedOrigins = array_filter(
    array_map(
        'trim',
        explode(',', env(
            'DSCIENTIA_CORS_ALLOWED_ORIGINS',
            'https://app.dscientia.dev,https://www.dscientia.dev,http://localhost:3000,http://localhost:4173,http://localhost:5000,http://localhost:5440,http://localhost:5444,http://localhost:8080'
        ))
    )
);

return [
    'paths' => [
        'api/*',
        'sanctum/csrf-cookie',
    ],

    'allowed_methods' => ['*'],

    'allowed_origins' => $allowedOrigins,

    'allowed_origins_patterns' => [],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => false,
];
