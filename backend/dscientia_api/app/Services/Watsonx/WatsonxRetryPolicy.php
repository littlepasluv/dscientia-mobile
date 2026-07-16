<?php

namespace App\Services\Watsonx;

use Illuminate\Http\Client\ConnectionException;
use Illuminate\Http\Client\RequestException;
use Throwable;

final class WatsonxRetryPolicy
{
    private const RETRYABLE_STATUS_CODES = [
        408,
        425,
        429,
    ];

    public function attempts(): int
    {
        return max(
            1,
            (int) config(
                'ai.watsonx.retry_attempts',
                3,
            ),
        );
    }

    public function sleepMilliseconds(int $attempt): int
    {
        $baseDelay = max(
            0,
            (int) config(
                'ai.watsonx.retry_sleep_ms',
                250,
            ),
        );

        $multiplier = 2 ** max(
            0,
            $attempt - 1,
        );

        return min(
            $baseDelay * $multiplier,
            5000,
        );
    }

    public function shouldRetry(Throwable $exception): bool
    {
        if ($exception instanceof ConnectionException) {
            return true;
        }

        if (! $exception instanceof RequestException) {
            return false;
        }

        $statusCode = $exception->response->status();

        return in_array(
            $statusCode,
            self::RETRYABLE_STATUS_CODES,
            true,
        ) || $statusCode >= 500;
    }
}
