<?php

namespace Tests\Unit;

use App\Services\Watsonx\IbmIamTokenClient;
use App\Services\Watsonx\WatsonxHttpClient;
use Illuminate\Http\Client\Request;
use Illuminate\Http\Client\RequestException;
use Illuminate\Support\Facades\Http;
use LogicException;
use Tests\TestCase;

class WatsonxHttpClientTest extends TestCase
{
    protected function setUp(): void
    {
        parent::setUp();

        Http::preventStrayRequests();

        config()->set([
            'ai.watsonx.api_key' => 'test-api-key',
            'ai.watsonx.project_id' => 'test-project-id',
            'ai.watsonx.iam_url' => 'https://iam.cloud.ibm.com/identity/token',
            'ai.watsonx.base_url' => 'https://us-south.ml.cloud.ibm.com',
            'ai.watsonx.api_version' => '2024-10-08',
            'ai.watsonx.model_id' => 'ibm/granite-3-8b-instruct',
            'ai.watsonx.connect_timeout' => 10,
            'ai.watsonx.timeout' => 30,
            'ai.watsonx.max_tokens' => 600,
            'ai.watsonx.time_limit_ms' => 30000,
        ]);
    }

    public function test_it_sends_chat_request_with_iam_token(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
                'token_type' => 'Bearer',
                'expires_in' => 3600,
            ]),
            'https://us-south.ml.cloud.ibm.com/ml/v1/text/chat*' => Http::response([
                'id' => 'chat-test-001',
                'model_id' => 'ibm/granite-3-8b-instruct',
                'choices' => [
                    [
                        'index' => 0,
                        'message' => [
                            'role' => 'assistant',
                            'content' => '{"risk_level":"medium"}',
                        ],
                        'finish_reason' => 'stop',
                    ],
                ],
            ]),
        ]);

        $client = new WatsonxHttpClient(
            new IbmIamTokenClient,
        );

        $response = $client->chat([
            [
                'role' => 'system',
                'content' => 'Return a structured community risk assessment.',
            ],
            [
                'role' => 'user',
                'content' => [
                    [
                        'type' => 'text',
                        'text' => 'Assess an infrastructure report in Magelang.',
                    ],
                ],
            ],
        ]);

        $this->assertSame(
            'chat-test-001',
            $response['id'],
        );

        $this->assertSame(
            '{"risk_level":"medium"}',
            $response['choices'][0]['message']['content'],
        );

        Http::assertSent(function (Request $request): bool {
            return $request->method() === 'POST'
                && str_starts_with(
                    $request->url(),
                    'https://us-south.ml.cloud.ibm.com/'
                    .'ml/v1/text/chat?',
                )
                && str_contains(
                    $request->url(),
                    'version=2024-10-08',
                )
                && $request->hasHeader(
                    'Authorization',
                    'Bearer test-iam-access-token',
                )
                && $request['model_id']
                    === 'ibm/granite-3-8b-instruct'
                && $request['project_id']
                    === 'test-project-id'
                && $request['max_tokens'] === 600
                && $request['time_limit'] === 30000
                && count($request['messages']) === 2;
        });

        Http::assertSentCount(2);
    }

    public function test_it_fails_before_request_when_project_id_is_missing(): void
    {
        config()->set('ai.watsonx.project_id', '');

        Http::fake();

        $client = new WatsonxHttpClient(
            new IbmIamTokenClient,
        );

        try {
            $client->chat([
                [
                    'role' => 'user',
                    'content' => 'Test message.',
                ],
            ]);

            $this->fail(
                'Expected a LogicException for a missing project ID.'
            );
        } catch (LogicException $exception) {
            $this->assertSame(
                'WATSONX_PROJECT_ID is not configured.',
                $exception->getMessage(),
            );
        }

        Http::assertNothingSent();
    }

    public function test_it_throws_for_failed_watsonx_response(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
            ]),
            'https://us-south.ml.cloud.ibm.com/ml/v1/text/chat*' => Http::response([
                'errors' => [
                    [
                        'message' => 'Service temporarily unavailable.',
                    ],
                ],
            ], 503),
        ]);

        $client = new WatsonxHttpClient(
            new IbmIamTokenClient,
        );

        $this->expectException(RequestException::class);

        $client->chat([
            [
                'role' => 'user',
                'content' => 'Test failure handling.',
            ],
        ]);
    }
}
