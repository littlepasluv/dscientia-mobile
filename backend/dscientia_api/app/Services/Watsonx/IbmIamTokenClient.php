<?php

namespace App\Services\Watsonx;

use Illuminate\Support\Facades\Http;
use LogicException;
use UnexpectedValueException;

final class IbmIamTokenClient
{
    private const API_KEY_GRANT_TYPE =
        'urn:ibm:params:oauth:grant-type:apikey';

    public function accessToken(): string
    {
        $apiKey = trim((string) config('ai.watsonx.api_key'));

        if ($apiKey === '') {
            throw new LogicException(
                'WATSONX_API_KEY is not configured.'
            );
        }

        $iamUrl = trim((string) config('ai.watsonx.iam_url'));

        if ($iamUrl === '') {
            throw new LogicException(
                'WATSONX_IAM_URL is not configured.'
            );
        }

        $response = Http::acceptJson()
            ->asForm()
            ->connectTimeout(
                (int) config('ai.watsonx.connect_timeout', 10)
            )
            ->timeout(
                (int) config('ai.watsonx.timeout', 30)
            )
            ->post($iamUrl, [
                'grant_type' => self::API_KEY_GRANT_TYPE,
                'apikey' => $apiKey,
            ])
            ->throw();

        $accessToken = $response->json('access_token');

        if (! is_string($accessToken) || trim($accessToken) === '') {
            throw new UnexpectedValueException(
                'IBM IAM response did not contain a valid access_token.'
            );
        }

        return $accessToken;
    }
}
