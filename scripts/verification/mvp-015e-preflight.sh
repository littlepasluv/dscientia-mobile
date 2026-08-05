#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/../.." && pwd)"
APP_DIR="${REPO_ROOT}/backend/dscientia_api"

fail() {
  printf 'ERROR: %s\n' "$1" >&2
  exit 1
}

[[ -d "${APP_DIR}" ]] || fail "Laravel application directory was not found."
[[ -f "${APP_DIR}/artisan" ]] || fail "artisan was not found."
[[ -f "${APP_DIR}/vendor/autoload.php" ]] || fail "Composer dependencies are not installed."
[[ -f "${APP_DIR}/.env" ]] || fail "Local .env was not found."

export DSCIENCIA_PREFLIGHT_APP_DIR="${APP_DIR}"

php <<'PHP'
<?php

declare(strict_types=1);

$appDirectory = getenv('DSCIENCIA_PREFLIGHT_APP_DIR');

if (!is_string($appDirectory) || $appDirectory === '') {
    fwrite(STDERR, "ERROR: Application directory is unavailable.\n");
    exit(1);
}

chdir($appDirectory);

require $appDirectory.'/vendor/autoload.php';

$app = require $appDirectory.'/bootstrap/app.php';

/** @var \Illuminate\Contracts\Console\Kernel $kernel */
$kernel = $app->make(\Illuminate\Contracts\Console\Kernel::class);
$kernel->bootstrap();

/**
 * Never print secret values from this script.
 */
function configured(mixed $value): bool
{
    return is_string($value) && trim($value) !== '';
}

function booleanValue(mixed $value): ?bool
{
    if (is_bool($value)) {
        return $value;
    }

    return filter_var(
        $value,
        FILTER_VALIDATE_BOOLEAN,
        FILTER_NULL_ON_FAILURE
    );
}

$appEnvironment = (string) app()->environment();
$provider = (string) config('ai.provider', '');
$fallbackToMock = booleanValue(
    config('ai.watsonx.fallback_to_mock')
);

$apiKeyConfigured = configured(
    config('ai.watsonx.api_key')
);

$projectIdConfigured = configured(
    config('ai.watsonx.project_id')
);

$baseUrl = (string) config('ai.watsonx.base_url', '');
$modelIdConfigured = configured(
    config('ai.watsonx.model_id')
);

$iamUrl = (string) config('ai.watsonx.iam_url', '');
$apiVersionConfigured = configured(
    config('ai.watsonx.api_version')
);

$checks = [
    [
        'label' => 'Environment is local',
        'passed' => $appEnvironment === 'local',
        'display' => $appEnvironment !== '' ? $appEnvironment : 'not configured',
    ],
    [
        'label' => 'Provider is watsonx',
        'passed' => $provider === 'watsonx',
        'display' => $provider !== '' ? $provider : 'not configured',
    ],
    [
        'label' => 'Mock fallback disabled',
        'passed' => $fallbackToMock === false,
        'display' => $fallbackToMock === false
            ? 'disabled'
            : ($fallbackToMock === true ? 'enabled' : 'invalid'),
    ],
    [
        'label' => 'IBM Cloud API key',
        'passed' => $apiKeyConfigured,
        'display' => $apiKeyConfigured ? 'configured' : 'missing',
    ],
    [
        'label' => 'watsonx project ID',
        'passed' => $projectIdConfigured,
        'display' => $projectIdConfigured ? 'configured' : 'missing',
    ],
    [
        'label' => 'watsonx base URL',
        'passed' => str_starts_with($baseUrl, 'https://'),
        'display' => str_starts_with($baseUrl, 'https://')
            ? 'configured with HTTPS'
            : 'missing or invalid',
    ],
    [
        'label' => 'IBM IAM URL',
        'passed' => str_starts_with($iamUrl, 'https://'),
        'display' => str_starts_with($iamUrl, 'https://')
            ? 'configured with HTTPS'
            : 'missing or invalid',
    ],
    [
        'label' => 'watsonx API version',
        'passed' => $apiVersionConfigured,
        'display' => $apiVersionConfigured ? 'configured' : 'missing',
    ],
    [
        'label' => 'watsonx model ID',
        'passed' => $modelIdConfigured,
        'display' => $modelIdConfigured ? 'configured' : 'missing',
    ],
];

echo "MVP-015E Controlled Verification Preflight\n";
echo "=========================================\n\n";

$allPassed = true;

foreach ($checks as $check) {
    $status = $check['passed'] ? 'PASS' : 'BLOCKED';

    printf(
        "%-30s : %-7s (%s)\n",
        $check['label'],
        $status,
        $check['display']
    );

    if (!$check['passed']) {
        $allPassed = false;
    }
}

echo "\n";

if (!$allPassed) {
    echo "Ready for IBM request          : NO\n";
    echo "Network request performed      : NO\n";
    echo "Secret values displayed        : NO\n";
    echo "\nThis is expected until controlled local credentials are configured.\n";

    exit(2);
}

echo "Ready for IBM request          : YES\n";
echo "Network request performed      : NO\n";
echo "Secret values displayed        : NO\n";
echo "\nPreflight passed. This script did not contact IBM.\n";
PHP
