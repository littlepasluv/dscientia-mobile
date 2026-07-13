<?php

namespace Tests\Unit;

use App\Models\CommunityRiskReport;
use App\Services\AiInsight\MockAiInsightGenerator;
use Tests\TestCase;

class MockAiInsightGeneratorTest extends TestCase
{
    public function test_mock_generator_returns_elevated_risk_for_medium_urgency_with_large_affected_count(): void
    {
        $report = new CommunityRiskReport([
            'organization_name' => 'Razy Zone International',
            'reporter_name' => 'Prio Nugroho',
            'category' => 'community_needs',
            'location' => 'Sudan',
            'urgency' => 'medium',
            'description' => 'Community members reported urgent local needs that require documentation, coordination, and follow-up action.',
            'affected_people_count' => 120,
            'source_url' => 'https://app.dscientia.dev',
        ]);

        $result = (new MockAiInsightGenerator())->generate($report);

        $this->assertSame('elevated', $result->riskLevel);
        $this->assertSame('mock', $result->modelProvider);
        $this->assertSame('dscientia-local-mock-v0.1', $result->modelName);
        $this->assertNotEmpty($result->summaryPoints);
        $this->assertNotEmpty($result->recommendedActions);
    }
}
