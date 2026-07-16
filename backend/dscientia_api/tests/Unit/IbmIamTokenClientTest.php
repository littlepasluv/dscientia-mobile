<?php

namespace Tests\Unit;

use App\Services\Watsonx\IbmIamTokenClient;
use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;
use LogicException;
use Tests\TestCase;
use UnexpectedValueException;

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
        ]);
    }

    public function test_it_exchanges_api_key_for_access_token(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
                'token_type' => 'Bearer',
                'expires_in' => 3600,
            ]),
        ]);

        $accessToken = (new IbmIamTokenClient)->accessToken();

        $this->assertSame(
            'test-iam-access-token',
            $accessToken,
        );

        Http::assertSent(function (Request $request): bool {
            $contentType = $request->header('Content-Type')[0] ?? '';

            return $request->method() === 'POST'
                && $request->url()
                    === 'https://iam.cloud.ibm.com/identity/token'
                && $request['grant_type']
                    === 'urn:ibm:params:oauth:grant-type:apikey'
                && $request['apikey'] === 'test-api-key'
                && str_starts_with(
                    $contentType,
                    'application/x-www-form-urlencoded',
                );
        });

        Http::assertSentCount(1);
    }

    public function test_it_fails_before_request_when_api_key_is_missing(): void
    {
        config()->set('ai.watsonx.api_key', '');

        Http::fake();

        try {
            (new IbmIamTokenClient)->accessToken();

            $this->fail(
                'Expected a LogicException for a missing API key.'
            );
        } catch (LogicException $exception) {
            $this->assertSame(
                'WATSONX_API_KEY is not configured.',
                $exception->getMessage(),
            );
        }

        Http::assertNothingSent();
    }

    public function test_it_rejects_response_without_access_token(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'token_type' => 'Bearer',
                'expires_in' => 3600,
            ]),
        ]);

        $this->expectException(
            UnexpectedValueException::class
        );

        $this->expectExceptionMessage(
            'IBM IAM response did not contain a valid access_token.'
        );

        (new IbmIamTokenClient)->accessToken();
    }
}
