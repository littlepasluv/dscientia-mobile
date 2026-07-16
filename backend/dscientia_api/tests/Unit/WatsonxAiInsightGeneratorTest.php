<?php

namespace Tests\Unit;

use App\Models\CommunityRiskReport;
use App\Services\AiInsight\WatsonxAiInsightGenerator;
use Illuminate\Support\Facades\Http;
use LogicException;
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

        $report = new CommunityRiskReport([
            'organization_name' => 'DscienTia',
            'category' => 'Infrastructure',
            'location' => 'Magelang, Central Java',
            'urgency' => 'medium',
            'description' => 'Synthetic report for provider integration testing.',
            'affected_people_count' => 20,
        ]);

        $generator = $this->app->make(
            WatsonxAiInsightGenerator::class,
        );

        $result = $generator->generate($report);

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

        Http::assertSentCount(2);
    }

    public function test_it_fails_closed_when_project_id_is_missing(): void
    {
        config()->set(
            'ai.watsonx.project_id',
            '',
        );

        Http::fake();

        $report = new CommunityRiskReport([
            'organization_name' => 'DscienTia',
            'category' => 'Infrastructure',
            'location' => 'Magelang',
            'urgency' => 'medium',
            'description' => 'Synthetic missing configuration test.',
        ]);

        try {
            $this->app
                ->make(WatsonxAiInsightGenerator::class)
                ->generate($report);

            $this->fail(
                'Expected a LogicException for missing project ID.',
            );
        } catch (LogicException $exception) {
            $this->assertSame(
                'WATSONX_PROJECT_ID is not configured.',
                $exception->getMessage(),
            );
        }

        Http::assertNothingSent();
    }
}
