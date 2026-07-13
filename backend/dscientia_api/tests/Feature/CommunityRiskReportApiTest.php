<?php

namespace Tests\Feature;

use App\Models\CommunityRiskReport;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class CommunityRiskReportApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_can_create_community_risk_report(): void
    {
        $response = $this->postJson('/api/reports', $this->validPayload());

        $response
            ->assertCreated()
            ->assertJsonPath('data.organization_name', 'Razy Zone International')
            ->assertJsonPath('data.category', 'community_needs')
            ->assertJsonPath('data.urgency', 'medium')
            ->assertJsonPath('data.status', 'open');

        $this->assertDatabaseHas('community_risk_reports', [
            'organization_name' => 'Razy Zone International',
            'category' => 'community_needs',
            'urgency' => 'medium',
            'status' => 'open',
        ]);
    }

    public function test_can_list_community_risk_reports(): void
    {
        CommunityRiskReport::create($this->validPayload());

        $response = $this->getJson('/api/reports');

        $response
            ->assertOk()
            ->assertJsonCount(1, 'data')
            ->assertJsonPath('data.0.organization_name', 'Razy Zone International');
    }

    public function test_can_show_community_risk_report(): void
    {
        $report = CommunityRiskReport::create($this->validPayload());

        $response = $this->getJson("/api/reports/{$report->id}");

        $response
            ->assertOk()
            ->assertJsonPath('data.id', $report->id)
            ->assertJsonPath('data.location', 'Sudan');
    }

    public function test_report_description_is_required(): void
    {
        $payload = $this->validPayload([
            'description' => '',
        ]);

        $response = $this->postJson('/api/reports', $payload);

        $response
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['description']);
    }

    private function validPayload(array $overrides = []): array
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
