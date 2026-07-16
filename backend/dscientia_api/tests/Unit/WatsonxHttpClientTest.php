<?php

namespace Tests\Unit;

use App\Exceptions\WatsonxProviderException;
use App\Services\Watsonx\WatsonxHttpClient;
use Illuminate\Http\Client\Request;
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
            'ai.watsonx.model_id' => 'ibm/granite-test-model',
            'ai.watsonx.connect_timeout' => 10,
            'ai.watsonx.timeout' => 30,
            'ai.watsonx.retry_attempts' => 3,
            'ai.watsonx.retry_sleep_ms' => 0,
            'ai.watsonx.max_tokens' => 600,
            'ai.watsonx.time_limit_ms' => 30000,
        ]);
    }

    public function test_it_sends_chat_request_and_returns_json_response(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
            ]),

            'https://us-south.ml.cloud.ibm.com/ml/v1/text/chat*' => Http::response([
                'id' => 'chat-test-001',
                'model_id' => 'ibm/granite-test-model',
                'choices' => [
                    [
                        'index' => 0,
                        'message' => [
                            'role' => 'assistant',
                            'content' => '{}',
                        ],
                        'finish_reason' => 'stop',
                    ],
                ],
            ]),
        ]);

        $messages = [
            [
                'role' => 'system',
                'content' => 'Return valid JSON.',
            ],
            [
                'role' => 'user',
                'content' => 'Analyze this report.',
            ],
        ];

        $response = $this->app
            ->make(WatsonxHttpClient::class)
            ->chat($messages);

        $this->assertSame(
            'chat-test-001',
            $response['id'],
        );

        $this->assertSame(
            'ibm/granite-test-model',
            $response['model_id'],
        );

        Http::assertSent(
            function (Request $request) use ($messages): bool {
                if (
                    ! str_starts_with(
                        $request->url(),
                        'https://us-south.ml.cloud.ibm.com/'
                        .'ml/v1/text/chat',
                    )
                ) {
                    return false;
                }

                $queryString = parse_url(
                    $request->url(),
                    PHP_URL_QUERY,
                );

                parse_str(
                    is_string($queryString)
                        ? $queryString
                        : '',
                    $queryParameters,
                );

                return $request->method() === 'POST'
                    && $request->hasHeader(
                        'Authorization',
                        'Bearer test-iam-access-token',
                    )
                    && ($queryParameters['version'] ?? null)
                        === '2024-10-08'
                    && $request['model_id']
                        === 'ibm/granite-test-model'
                    && $request['project_id']
                        === 'test-project-id'
                    && $request['messages'] === $messages
                    && $request['max_tokens'] === 600
                    && $request['time_limit'] === 30000;
            },
        );

        Http::assertSentCount(2);
    }

    public function test_it_rejects_empty_messages_without_sending_request(): void
    {
        try {
            $this->app
                ->make(WatsonxHttpClient::class)
                ->chat([]);

            $this->fail(
                'Expected LogicException.',
            );
        } catch (LogicException $exception) {
            $this->assertSame(
                'The watsonx chat request requires at least one message.',
                $exception->getMessage(),
            );
        }

        Http::assertNothingSent();
    }

    public function test_it_rejects_missing_project_id_without_sending_request(): void
    {
        config()->set(
            'ai.watsonx.project_id',
            '',
        );

        try {
            $this->app
                ->make(WatsonxHttpClient::class)
                ->chat([
                    [
                        'role' => 'user',
                        'content' => 'Configuration test.',
                    ],
                ]);

            $this->fail(
                'Expected WatsonxProviderException.',
            );
        } catch (WatsonxProviderException $exception) {
            $this->assertSame(
                'watsonx_chat',
                $exception->operation,
            );

            $this->assertSame(
                'missing_project_id',
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

    public function test_it_rejects_non_json_chat_response(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
            ]),

            'https://us-south.ml.cloud.ibm.com/ml/v1/text/chat*' => Http::response(
                'not-json',
                200,
                [
                    'Content-Type' => 'text/plain',
                ],
            ),
        ]);

        try {
            $this->app
                ->make(WatsonxHttpClient::class)
                ->chat([
                    [
                        'role' => 'user',
                        'content' => 'Invalid response test.',
                    ],
                ]);

            $this->fail(
                'Expected WatsonxProviderException.',
            );
        } catch (WatsonxProviderException $exception) {
            $this->assertSame(
                'watsonx_chat',
                $exception->operation,
            );

            $this->assertSame(
                'invalid_json_response',
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

        Http::assertSentCount(2);
    }

    public function test_it_retries_transient_chat_failure(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
            ]),

            'https://us-south.ml.cloud.ibm.com/ml/v1/text/chat*' => Http::sequence()
                ->push(
                    [
                        'errors' => [
                            [
                                'message' => 'temporarily unavailable',
                            ],
                        ],
                    ],
                    503,
                )
                ->push([
                    'id' => 'chat-retry-success',
                    'model_id' => 'ibm/granite-test-model',
                    'choices' => [],
                ]),
        ]);

        $response = $this->app
            ->make(WatsonxHttpClient::class)
            ->chat([
                [
                    'role' => 'user',
                    'content' => 'Retry test.',
                ],
            ]);

        $this->assertSame(
            'chat-retry-success',
            $response['id'],
        );

        // One IAM request and two watsonx chat attempts.
        Http::assertSentCount(3);
    }

    public function test_it_does_not_retry_non_retryable_chat_error(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
            ]),

            'https://us-south.ml.cloud.ibm.com/ml/v1/text/chat*' => Http::response(
                [
                    'errors' => [
                        [
                            'message' => 'sensitive-upstream-detail',
                        ],
                    ],
                ],
                401,
            ),
        ]);

        try {
            $this->app
                ->make(WatsonxHttpClient::class)
                ->chat([
                    [
                        'role' => 'user',
                        'content' => 'Unauthorized test.',
                    ],
                ]);

            $this->fail(
                'Expected WatsonxProviderException.',
            );
        } catch (WatsonxProviderException $exception) {
            $this->assertSame(
                'watsonx_chat',
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
                'test-iam-access-token',
                $exception->getMessage(),
            );
        }

        // One IAM request and one watsonx chat request.
        Http::assertSentCount(2);
    }

    public function test_it_throws_after_all_transient_retries_fail(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
            ]),

            'https://us-south.ml.cloud.ibm.com/ml/v1/text/chat*' => Http::sequence()
                ->push(
                    ['error' => 'temporary failure one'],
                    503,
                )
                ->push(
                    ['error' => 'temporary failure two'],
                    503,
                )
                ->push(
                    ['error' => 'temporary failure three'],
                    503,
                ),
        ]);

        try {
            $this->app
                ->make(WatsonxHttpClient::class)
                ->chat([
                    [
                        'role' => 'user',
                        'content' => 'Exhausted retry test.',
                    ],
                ]);

            $this->fail(
                'Expected WatsonxProviderException.',
            );
        } catch (WatsonxProviderException $exception) {
            $this->assertSame(
                'watsonx_chat',
                $exception->operation,
            );

            $this->assertSame(
                'http_failure',
                $exception->errorCode,
            );

            $this->assertSame(
                503,
                $exception->statusCode,
            );

            $this->assertTrue(
                $exception->retryable,
            );

            $this->assertSame(
                'AI insight generation is temporarily unavailable.',
                $exception->getMessage(),
            );
        }

        // One IAM request and three watsonx attempts.
        Http::assertSentCount(4);
    }
}
