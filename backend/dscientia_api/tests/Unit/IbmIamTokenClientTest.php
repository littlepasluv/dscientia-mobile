<?php

namespace Tests\Unit;

use App\Exceptions\WatsonxProviderException;
use App\Services\Watsonx\IbmIamTokenClient;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;
use Tests\TestCase;

class IbmIamTokenClientTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Http::preventStrayRequests();

        config()->set([
            'ai.watsonx.api_key' => 'test-api-key',
            'ai.watsonx.iam_url' => 'https://iam.cloud.ibm.com/identity/token',
            'ai.watsonx.connect_timeout' => 10,
            'ai.watsonx.timeout' => 30,
            'ai.watsonx.retry_attempts' => 3,
            'ai.watsonx.retry_sleep_ms' => 0,
        ]);
    }

    public function test_it_exchanges_api_key_for_access_token(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
                'expires_in' => 3600,
            ]),
        ]);

        $accessToken = $this->app
            ->make(IbmIamTokenClient::class)
            ->accessToken();

        $this->assertSame(
            'test-iam-access-token',
            $accessToken,
        );

        Http::assertSent(
            function (Request $request): bool {
                return $request->url()
                    === 'https://iam.cloud.ibm.com/identity/token'
                    && $request->method() === 'POST'
                    && $request['grant_type']
                        === 'urn:ibm:params:oauth:grant-type:apikey'
                    && $request['apikey'] === 'test-api-key';
            },
        );

        Http::assertSentCount(1);
    }

    public function test_it_rejects_missing_api_key_without_sending_request(): void
    {
        config()->set(
            'ai.watsonx.api_key',
            '',
        );

        try {
            $this->app
                ->make(IbmIamTokenClient::class)
                ->accessToken();

            $this->fail(
                'Expected WatsonxProviderException.',
            );
        } catch (WatsonxProviderException $exception) {
            $this->assertSame(
                'iam_token_exchange',
                $exception->operation,
            );

            $this->assertSame(
                'missing_api_key',
                $exception->errorCode,
            );

            $this->assertFalse(
                $exception->retryable,
            );

            $this->assertSame(
                'AI insight generation is temporarily unavailable.',
                $exception->getMessage(),
            );
        }

        Http::assertNothingSent();
    }

    public function test_it_rejects_response_without_access_token(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'expires_in' => 3600,
            ]),
        ]);

        try {
            $this->app
                ->make(IbmIamTokenClient::class)
                ->accessToken();

            $this->fail(
                'Expected WatsonxProviderException.',
            );
        } catch (WatsonxProviderException $exception) {
            $this->assertSame(
                'iam_token_exchange',
                $exception->operation,
            );

            $this->assertSame(
                'missing_access_token',
                $exception->errorCode,
            );

            $this->assertFalse(
                $exception->retryable,
            );

            $this->assertSame(
                'AI insight generation is temporarily unavailable.',
                $exception->getMessage(),
            );
        }

        Http::assertSentCount(1);
    }

    public function test_it_retries_transient_iam_failure(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::sequence()
                ->push(
                    [
                        'error' => 'temporarily unavailable',
                    ],
                    503,
                )
                ->push([
                    'access_token' => 'test-iam-access-token',
                ]),
        ]);

        $accessToken = $this->app
            ->make(IbmIamTokenClient::class)
            ->accessToken();

        $this->assertSame(
            'test-iam-access-token',
            $accessToken,
        );

        Http::assertSentCount(2);
    }

    public function test_it_does_not_retry_non_retryable_iam_error(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response(
                [
                    'error' => 'sensitive-upstream-detail',
                ],
                401,
            ),
        ]);

        try {
            $this->app
                ->make(IbmIamTokenClient::class)
                ->accessToken();

            $this->fail(
                'Expected WatsonxProviderException.',
            );
        } catch (WatsonxProviderException $exception) {
            $this->assertSame(
                'iam_token_exchange',
                $exception->operation,
            );

            $this->assertSame(
                'http_failure',
                $exception->errorCode,
            );

            $this->assertSame(
                401,
                $exception->statusCode,
            );

            $this->assertFalse(
                $exception->retryable,
            );

            $this->assertSame(
                'AI insight generation is temporarily unavailable.',
                $exception->getMessage(),
            );

            $this->assertStringNotContainsString(
                'sensitive-upstream-detail',
                $exception->getMessage(),
            );

            $this->assertStringNotContainsString(
                'test-api-key',
                $exception->getMessage(),
            );
        }

        Http::assertSentCount(1);
    }
}
