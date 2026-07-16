<?php

namespace App\Services\Watsonx;

use App\Exceptions\WatsonxProviderException;
use Illuminate\Http\Client\ConnectionException;
use Illuminate\Http\Client\PendingRequest;
use Illuminate\Http\Client\RequestException;
use Illuminate\Support\Facades\Http;
use LogicException;
use Throwable;

final class WatsonxHttpClient
{
    public function __construct(
        private readonly IbmIamTokenClient $iamTokenClient,
        private readonly WatsonxRetryPolicy $retryPolicy,
    ) {}

    public function chat(
        array $messages,
        ?string $modelId = null,
    ): array {
        if ($messages === []) {
            throw new LogicException(
                'The watsonx chat request requires at least one message.',
            );
        }

        $projectId = $this->requiredConfig(
            'ai.watsonx.project_id',
            'missing_project_id',
        );

        $baseUrl = rtrim(
            $this->requiredConfig(
                'ai.watsonx.base_url',
                'missing_base_url',
            ),
            '/',
        );

        $apiVersion = $this->requiredConfig(
            'ai.watsonx.api_version',
            'missing_api_version',
        );

        $resolvedModelId = trim(
            $modelId
                ?? (string) config(
                    'ai.watsonx.model_id',
                ),
        );

        if ($resolvedModelId === '') {
            throw WatsonxProviderException::configuration(
                operation: 'watsonx_chat',
                errorCode: 'missing_model_id',
            );
        }

        $accessToken =
            $this->iamTokenClient->accessToken();

        try {
            $response = Http::acceptJson()
                ->withToken($accessToken)
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
                ->withQueryParameters([
                    'version' => $apiVersion,
                ])
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
                    $baseUrl.'/ml/v1/text/chat',
                    [
                        'model_id' => $resolvedModelId,
                        'project_id' => $projectId,
                        'messages' => $messages,
                        'max_tokens' => (int) config(
                            'ai.watsonx.max_tokens',
                            600,
                        ),
                        'time_limit' => (int) config(
                            'ai.watsonx.time_limit_ms',
                            30000,
                        ),
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
                operation: 'watsonx_chat',
                errorCode: $exception instanceof ConnectionException
                        ? 'connection_failure'
                        : 'http_failure',
                statusCode: $statusCode,
                retryable: $this->retryPolicy
                    ->shouldRetry($exception),
                previous: $exception,
            );
        }

        $responseData = $response->json();

        if (! is_array($responseData)) {
            throw WatsonxProviderException::invalidResponse(
                operation: 'watsonx_chat',
                errorCode: 'invalid_json_response',
                previous: new \UnexpectedValueException(
                    'watsonx response was not a JSON object.',
                ),
            );
        }

        return $responseData;
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
                operation: 'watsonx_chat',
                errorCode: $errorCode,
            );
        }

        return $value;
    }
}
