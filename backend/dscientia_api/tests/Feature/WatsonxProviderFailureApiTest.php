<?php

namespace Tests\Feature;

use App\Models\CommunityRiskReport;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Http;
use Tests\TestCase;

class WatsonxProviderFailureApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_provider_failure_returns_sanitized_503_when_fallback_is_disabled(): void
    {
        Http::preventStrayRequests();

        config()->set([
            'ai.provider' => 'watsonx',
            'ai.watsonx.api_key' => 'test-api-key',
            'ai.watsonx.project_id' => 'test-project-id',
            'ai.watsonx.iam_url' => 'https://iam.cloud.ibm.com/identity/token',
            'ai.watsonx.base_url' => 'https://us-south.ml.cloud.ibm.com',
            'ai.watsonx.api_version' => '2024-10-08',
            'ai.watsonx.model_id' => 'ibm/granite-test-model',
            'ai.watsonx.retry_attempts' => 1,
            'ai.watsonx.retry_sleep_ms' => 0,
            'ai.watsonx.fallback_to_mock' => false,
        ]);

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

        $report = CommunityRiskReport::create([
            'organization_name' => 'DscienTia',
            'category' => 'Infrastructure',
            'location' => 'Magelang, Central Java',
            'urgency' => 'medium',
            'description' => 'Synthetic provider failure test.',
            'affected_people_count' => 20,
        ]);

        $response = $this->postJson(
            '/api/ai-insights',
            [
                'report_id' => $report->id,
                'insight_type' => 'community_risk_summary',
            ],
        );

        $response
            ->assertStatus(503)
            ->assertJsonPath(
                'message',
                'AI insight generation is temporarily unavailable.',
            )
            ->assertJsonPath(
                'error.code',
                'AI_PROVIDER_UNAVAILABLE',
            );

        $this->assertStringNotContainsString(
            'sensitive-upstream-detail',
            $response->getContent(),
        );

        $this->assertStringNotContainsString(
            'test-api-key',
            $response->getContent(),
        );
    }
}
