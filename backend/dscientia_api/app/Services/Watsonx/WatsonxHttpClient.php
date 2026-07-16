<?php

namespace App\Services\Watsonx;

use Illuminate\Support\Facades\Http;
use LogicException;
use UnexpectedValueException;

final class WatsonxHttpClient
{
    public function __construct(
        private readonly IbmIamTokenClient $iamTokenClient,
    ) {}

    public function chat(
        array $messages,
        ?string $modelId = null,
    ): array {
        if ($messages === []) {
            throw new LogicException(
                'The watsonx chat request requires at least one message.'
            );
        }

        $projectId = trim(
            (string) config('ai.watsonx.project_id')
        );

        if ($projectId === '') {
            throw new LogicException(
                'WATSONX_PROJECT_ID is not configured.'
            );
        }

        $baseUrl = rtrim(
            trim((string) config('ai.watsonx.base_url')),
            '/',
        );

        if ($baseUrl === '') {
            throw new LogicException(
                'WATSONX_BASE_URL is not configured.'
            );
        }

        $apiVersion = trim(
            (string) config('ai.watsonx.api_version')
        );

        if ($apiVersion === '') {
            throw new LogicException(
                'WATSONX_API_VERSION is not configured.'
            );
        }

        $resolvedModelId = trim(
            $modelId ?? (string) config('ai.watsonx.model_id')
        );

        if ($resolvedModelId === '') {
            throw new LogicException(
                'WATSONX_MODEL_ID is not configured.'
            );
        }

        $response = Http::acceptJson()
            ->withToken($this->iamTokenClient->accessToken())
            ->connectTimeout(
                (int) config('ai.watsonx.connect_timeout', 10)
            )
            ->timeout(
                (int) config('ai.watsonx.timeout', 30)
            )
            ->withQueryParameters([
                'version' => $apiVersion,
            ])
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

        $responseData = $response->json();

        if (! is_array($responseData)) {
            throw new UnexpectedValueException(
                'watsonx chat response was not a valid JSON object.'
            );
        }

        return $responseData;
    }
}
