<?php

return [
    'provider' => env('DSCIENTIA_AI_PROVIDER', 'mock'),

    'watsonx' => [
        'api_key' => env('WATSONX_API_KEY'),
        'project_id' => env('WATSONX_PROJECT_ID'),

        'iam_url' => env(
            'WATSONX_IAM_URL',
            'https://iam.cloud.ibm.com/identity/token',
        ),

        'base_url' => env(
            'WATSONX_BASE_URL',
            'https://us-south.ml.cloud.ibm.com',
        ),

        'api_version' => env(
            'WATSONX_API_VERSION',
            '2024-10-08',
        ),

        'model_id' => env(
            'WATSONX_MODEL_ID',
            'ibm/granite-3-8b-instruct',
        ),

        'connect_timeout' => (int) env(
            'WATSONX_CONNECT_TIMEOUT',
            10,
        ),

        'timeout' => (int) env(
            'WATSONX_TIMEOUT',
            30,
        ),

        'retry_attempts' => max(
            1,
            (int) env('WATSONX_RETRY_ATTEMPTS', 3),
        ),

        'retry_sleep_ms' => max(
            0,
            (int) env('WATSONX_RETRY_SLEEP_MS', 250),
        ),

        'fallback_to_mock' => filter_var(
            env('WATSONX_FALLBACK_TO_MOCK', true),
            FILTER_VALIDATE_BOOL,
        ),

        'max_tokens' => (int) env(
            'WATSONX_MAX_TOKENS',
            600,
        ),

        'time_limit_ms' => (int) env(
            'WATSONX_TIME_LIMIT_MS',
            30000,
        ),
    ],
];
