<?php

namespace Tests\Feature;

use App\Models\AiInsight;
use App\Models\CommunityRiskReport;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class AiInsightApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_can_generate_mock_ai_insight_from_report(): void
    {
        $report = CommunityRiskReport::create($this->validReportPayload());

        $response = $this->postJson('/api/ai-insights', [
            'report_id' => $report->id,
            'insight_type' => 'community_risk_summary',
        ]);

        $response
            ->assertCreated()
            ->assertJsonPath('data.report_id', $report->id)
            ->assertJsonPath('data.insight_type', 'community_risk_summary')
            ->assertJsonPath('data.risk_level', 'elevated')
            ->assertJsonPath('data.model_provider', 'mock')
            ->assertJsonPath('data.status', 'completed')
            ->assertJsonStructure([
                'data' => [
                    'id',
                    'report_id',
                    'risk_level',
                    'narrative_summary',
                    'summary_points',
                    'recommended_actions',
                    'confidence_score',
                    'model_provider',
                    'model_name',
                    'status',
                ],
            ]);

        $this->assertDatabaseHas('ai_insights', [
            'community_risk_report_id' => $report->id,
            'insight_type' => 'community_risk_summary',
            'risk_level' => 'elevated',
            'model_provider' => 'mock',
            'status' => 'completed',
        ]);
    }

    public function test_can_show_mock_ai_insight(): void
    {
        $report = CommunityRiskReport::create($this->validReportPayload());

        $insight = AiInsight::create([
            'community_risk_report_id' => $report->id,
            'insight_type' => 'community_risk_summary',
            'risk_level' => 'medium',
            'narrative_summary' => 'Mock summary for testing community risk insight.',
            'summary_points' => [
                'Reported category: community_needs',
                'Reported urgency: medium',
            ],
            'recommended_actions' => [
                'Review the report.',
                'Contact the reporting organization.',
            ],
            'confidence_score' => 0.72,
            'model_provider' => 'mock',
            'model_name' => 'dscientia-local-mock-v0.1',
            'status' => 'completed',
        ]);

        $response = $this->getJson("/api/ai-insights/{$insight->id}");

        $response
            ->assertOk()
            ->assertJsonPath('data.id', $insight->id)
            ->assertJsonPath('data.report_id', $report->id)
            ->assertJsonPath('data.model_name', 'dscientia-local-mock-v0.1');
    }

    public function test_report_id_must_exist(): void
    {
        $response = $this->postJson('/api/ai-insights', [
            'report_id' => 999999,
            'insight_type' => 'community_risk_summary',
        ]);

        $response
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['report_id']);
    }

    private function validReportPayload(array $overrides = []): array
    {
        return array_merge([
            'organization_name' => 'Razy Zone International',
            'reporter_name' => 'Prio Nugroho',
            'category' => 'community_needs',
            'location' => 'Sudan',
            'urgency' => 'medium',
            'description' => 'Community members reported urgent local needs that require documentation, coordination, and follow-up action.',
            'affected_people_count' => 120,
            'source_url' => 'https://app.dscientia.dev',
        ], $overrides);
    }
}
