<?php

namespace Tests\Unit;

use App\Exceptions\WatsonxProviderException;
use App\Models\CommunityRiskReport;
use App\Services\AiInsight\WatsonxAiInsightGenerator;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Tests\TestCase;

class WatsonxAiInsightGeneratorTest extends TestCase
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
            'ai.watsonx.retry_attempts' => 1,
            'ai.watsonx.retry_sleep_ms' => 0,
            'ai.watsonx.fallback_to_mock' => true,
            'ai.watsonx.max_tokens' => 600,
            'ai.watsonx.time_limit_ms' => 30000,
        ]);
    }

    public function test_it_generates_mapped_watsonx_result(): void
    {
        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
            ]),

            'https://us-south.ml.cloud.ibm.com/ml/v1/text/chat*' => Http::response([
                'id' => 'chat-provider-test',
                'model_id' => 'ibm/granite-test-model',
                'choices' => [
                    [
                        'index' => 0,
                        'message' => [
                            'role' => 'assistant',
                            'content' => json_encode(
                                [
                                    'risk_level' => 'medium',
                                    'narrative_summary' => 'The report indicates a medium '
                                        .'infrastructure concern.',
                                    'summary_points' => [
                                        'The category is Infrastructure.',
                                        'The location is Magelang.',
                                        'The reported urgency is medium.',
                                    ],
                                    'recommended_actions' => [
                                        'Verify the reported condition.',
                                        'Request supporting documentation.',
                                        'Coordinate a stakeholder review.',
                                    ],
                                    'confidence_score' => 0.78,
                                ],
                                JSON_THROW_ON_ERROR,
                            ),
                        ],
                        'finish_reason' => 'stop',
                    ],
                ],
            ]),
        ]);

        $result = $this->app
            ->make(WatsonxAiInsightGenerator::class)
            ->generate(
                $this->makeReport(),
            );

        $this->assertSame(
            'medium',
            $result->riskLevel,
        );

        $this->assertSame(
            'watsonx',
            $result->modelProvider,
        );

        $this->assertSame(
            'ibm/granite-test-model',
            $result->modelName,
        );

        $this->assertSame(
            'completed',
            $result->status,
        );

        $this->assertSame(
            0.78,
            $result->confidenceScore,
        );

        Http::assertSentCount(2);
    }

    public function test_it_uses_mock_fallback_when_watsonx_fails(): void
    {
        Log::spy();

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
                503,
            ),
        ]);

        $report = $this->makeReport(
            description: 'Sensitive report description that must not be logged.',
        );

        $report->setAttribute(
            'id',
            42,
        );

        $result = $this->app
            ->make(WatsonxAiInsightGenerator::class)
            ->generate($report);

        $this->assertSame(
            'mock-fallback',
            $result->modelProvider,
        );

        $this->assertSame(
            'dscientia-local-mock-v0.1',
            $result->modelName,
        );

        $this->assertSame(
            'completed',
            $result->status,
        );

        Log::shouldHaveReceived('warning')
            ->once()
            ->withArgs(
                function (
                    string $message,
                    array $context,
                ): bool {
                    $encodedContext = json_encode(
                        $context,
                        JSON_THROW_ON_ERROR,
                    );

                    return $message
                        === 'watsonx generation failed; '
                        .'mock fallback activated.'
                        && ($context['provider'] ?? null)
                            === 'watsonx'
                        && ($context['operation'] ?? null)
                            === 'watsonx_chat'
                        && ($context['error_code'] ?? null)
                            === 'http_failure'
                        && ($context['status_code'] ?? null)
                            === 503
                        && ($context['report_id'] ?? null)
                            === 42
                        && ($context['insight_type'] ?? null)
                            === 'community_risk_summary'
                        && ($context['fallback_provider'] ?? null)
                            === 'mock'
                        && ! str_contains(
                            $encodedContext,
                            'sensitive-upstream-detail',
                        )
                        && ! str_contains(
                            $encodedContext,
                            'Sensitive report description',
                        )
                        && ! str_contains(
                            $encodedContext,
                            'test-api-key',
                        )
                        && ! str_contains(
                            $encodedContext,
                            'test-iam-access-token',
                        );
                },
            );

        Http::assertSentCount(2);
    }

    public function test_it_uses_mock_fallback_for_invalid_structured_response(): void
    {
        Log::spy();

        Http::fake([
            'https://iam.cloud.ibm.com/identity/token' => Http::response([
                'access_token' => 'test-iam-access-token',
            ]),

            'https://us-south.ml.cloud.ibm.com/ml/v1/text/chat*' => Http::response([
                'id' => 'chat-invalid-structured-response',
                'model_id' => 'ibm/granite-test-model',
                'choices' => [
                    [
                        'index' => 0,
                        'message' => [
                            'role' => 'assistant',
                            'content' => 'This response is not valid JSON.',
                        ],
                        'finish_reason' => 'stop',
                    ],
                ],
            ]),
        ]);

        $result = $this->app
            ->make(WatsonxAiInsightGenerator::class)
            ->generate(
                $this->makeReport(),
            );

        $this->assertSame(
            'mock-fallback',
            $result->modelProvider,
        );

        $this->assertSame(
            'dscientia-local-mock-v0.1',
            $result->modelName,
        );

        Log::shouldHaveReceived('warning')
            ->once()
            ->withArgs(
                function (
                    string $message,
                    array $context,
                ): bool {
                    return $message
                        === 'watsonx generation failed; '
                        .'mock fallback activated.'
                        && ($context['operation'] ?? null)
                            === 'structured_response_mapping'
                        && ($context['error_code'] ?? null)
                            === 'invalid_structured_response'
                        && ($context['fallback_provider'] ?? null)
                            === 'mock';
                },
            );

        Http::assertSentCount(2);
    }

    public function test_it_uses_mock_fallback_when_project_id_is_missing(): void
    {
        Log::spy();

        config()->set(
            'ai.watsonx.project_id',
            '',
        );

        Http::fake();

        $result = $this->app
            ->make(WatsonxAiInsightGenerator::class)
            ->generate(
                $this->makeReport(),
            );

        $this->assertSame(
            'mock-fallback',
            $result->modelProvider,
        );

        $this->assertSame(
            'dscientia-local-mock-v0.1',
            $result->modelName,
        );

        Log::shouldHaveReceived('warning')
            ->once()
            ->withArgs(
                function (
                    string $message,
                    array $context,
                ): bool {
                    return $message
                        === 'watsonx generation failed; '
                        .'mock fallback activated.'
                        && ($context['operation'] ?? null)
                            === 'watsonx_chat'
                        && ($context['error_code'] ?? null)
                            === 'missing_project_id'
                        && ($context['fallback_provider'] ?? null)
                            === 'mock';
                },
            );

        Http::assertNothingSent();
    }

    public function test_it_throws_sanitized_exception_when_fallback_is_disabled(): void
    {
        config()->set(
            'ai.watsonx.fallback_to_mock',
            false,
        );

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
                503,
            ),
        ]);

        try {
            $this->app
                ->make(WatsonxAiInsightGenerator::class)
                ->generate(
                    $this->makeReport(),
                );

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

            $this->assertStringNotContainsString(
                'sensitive-upstream-detail',
                $exception->getMessage(),
            );

            $this->assertStringNotContainsString(
                'test-api-key',
                $exception->getMessage(),
            );

            $this->assertStringNotContainsString(
                'test-iam-access-token',
                $exception->getMessage(),
            );
        }

        Http::assertSentCount(2);
    }

    private function makeReport(
        string $description =
            'Synthetic report for provider integration testing.',
    ): CommunityRiskReport {
        return new CommunityRiskReport([
            'organization_name' => 'DscienTia',
            'category' => 'Infrastructure',
            'location' => 'Magelang, Central Java',
            'urgency' => 'medium',
            'description' => $description,
            'affected_people_count' => 20,
        ]);
    }
}
