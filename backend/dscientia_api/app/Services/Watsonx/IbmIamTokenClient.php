<?php

namespace App\Services\Watsonx;

use App\Exceptions\WatsonxProviderException;
use Illuminate\Http\Client\ConnectionException;
use Illuminate\Http\Client\PendingRequest;
use Illuminate\Http\Client\RequestException;
use Illuminate\Support\Facades\Http;
use Throwable;

final class IbmIamTokenClient
{
    private const API_KEY_GRANT_TYPE =
        'urn:ibm:params:oauth:grant-type:apikey';

    public function __construct(
        private readonly WatsonxRetryPolicy $retryPolicy,
    ) {}

    public function accessToken(): string
    {
        $apiKey = $this->requiredConfig(
            'ai.watsonx.api_key',
            'missing_api_key',
        );

        $iamUrl = $this->requiredConfig(
            'ai.watsonx.iam_url',
            'missing_iam_url',
        );

        try {
            $response = Http::acceptJson()
                ->asForm()
                ->connectTimeout(
                    (int) config(
                        'ai.watsonx.connect_timeout',
                        10,
                    ),
                )
                ->timeout(
                    (int) config(
                        'ai.watsonx.timeout',
                        30,
                    ),
                )
                ->retry(
                    $this->retryPolicy->attempts(),
                    fn (
                        int $attempt,
                        Throwable $exception,
                    ): int => $this->retryPolicy
                        ->sleepMilliseconds($attempt),
                    fn (
                        Throwable $exception,
                        PendingRequest $request,
                    ): bool => $this->retryPolicy
                        ->shouldRetry($exception),
                    throw: true,
                )
                ->post(
                    $iamUrl,
                    [
                        'grant_type' => self::API_KEY_GRANT_TYPE,
                        'apikey' => $apiKey,
                    ],
                )
                ->throw();
        } catch (
            ConnectionException|RequestException $exception
        ) {
            $statusCode = $exception instanceof RequestException
                ? $exception->response->status()
                : null;

            throw WatsonxProviderException::transport(
                operation: 'iam_token_exchange',
                errorCode: $exception instanceof ConnectionException
                        ? 'connection_failure'
                        : 'http_failure',
                statusCode: $statusCode,
                retryable: $this->retryPolicy
                    ->shouldRetry($exception),
                previous: $exception,
            );
        }

        $accessToken = $response->json(
            'access_token',
        );

        if (
            ! is_string($accessToken)
            || trim($accessToken) === ''
        ) {
            throw WatsonxProviderException::invalidResponse(
                operation: 'iam_token_exchange',
                errorCode: 'missing_access_token',
                previous: new \UnexpectedValueException(
                    'IAM response did not include access_token.',
                ),
            );
        }

        return trim($accessToken);
    }

    private function requiredConfig(
        string $configKey,
        string $errorCode,
    ): string {
        $value = trim(
            (string) config($configKey),
        );

        if ($value === '') {
            throw WatsonxProviderException::configuration(
                operation: 'iam_token_exchange',
                errorCode: $errorCode,
            );
        }

        return $value;
    }
}
