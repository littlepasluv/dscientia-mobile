<?php

return [
    'provider' => env('DSCIENTIA_AI_PROVIDER', 'mock'),

    'watsonx' => [
        'api_key' => env('WATSONX_API_KEY'),
        'project_id' => env('WATSONX_PROJECT_ID'),
        'base_url' => env('WATSONX_BASE_URL', 'https://us-south.ml.cloud.ibm.com'),
        'model_id' => env('WATSONX_MODEL_ID', 'ibm/granite-3-8b-instruct'),
    ],
];
