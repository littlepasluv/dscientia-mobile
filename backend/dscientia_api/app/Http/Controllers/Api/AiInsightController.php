<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreAiInsightRequest;
use App\Http\Resources\AiInsightResource;
use App\Models\AiInsight;
use App\Models\CommunityRiskReport;

class AiInsightController extends Controller
{
    public function store(StoreAiInsightRequest $request)
    {
        $validated = $request->validated();

        $report = CommunityRiskReport::query()
            ->findOrFail($validated['report_id']);

        $insightType = $validated['insight_type'] ?? 'community_risk_summary';
        $riskLevel = $this->resolveRiskLevel($report);

        $insight = AiInsight::create([
            'community_risk_report_id' => $report->id,
            'insight_type' => $insightType,
            'risk_level' => $riskLevel,
            'narrative_summary' => $this->buildNarrativeSummary($report, $riskLevel),
            'summary_points' => $this->buildSummaryPoints($report, $riskLevel),
            'recommended_actions' => $this->buildRecommendedActions($riskLevel),
            'confidence_score' => 0.72,
            'model_provider' => 'mock',
            'model_name' => 'dscientia-local-mock-v0.1',
            'status' => 'completed',
        ]);

        return (new AiInsightResource($insight))
            ->response()
            ->setStatusCode(201);
    }

    public function show(AiInsight $aiInsight): AiInsightResource
    {
        return new AiInsightResource($aiInsight);
    }

    private function resolveRiskLevel(CommunityRiskReport $report): string
    {
        $affectedPeopleCount = $report->affected_people_count ?? 0;

        return match ($report->urgency) {
            'critical' => 'critical',
            'high' => $affectedPeopleCount >= 100 ? 'high' : 'elevated',
            'medium' => $affectedPeopleCount >= 100 ? 'elevated' : 'medium',
            default => 'low',
        };
    }

    private function buildNarrativeSummary(CommunityRiskReport $report, string $riskLevel): string
    {
        return sprintf(
            'The submitted report from %s indicates a %s community resilience concern in %s. The issue is categorized as %s with %s urgency. This mock AI insight recommends structured follow-up, stakeholder coordination, and evidence-based prioritization before escalation.',
            $report->organization_name,
            $riskLevel,
            $report->location,
            $report->category,
            $report->urgency
        );
    }

    private function buildSummaryPoints(CommunityRiskReport $report, string $riskLevel): array
    {
        return [
            'Detected risk level: '.$riskLevel,
            'Reported category: '.$report->category,
            'Reported location: '.$report->location,
            'Reported urgency: '.$report->urgency,
            'Estimated affected people: '.($report->affected_people_count ?? 0),
        ];
    }

    private function buildRecommendedActions(string $riskLevel): array
    {
        return match ($riskLevel) {
            'critical' => [
                'Escalate immediately to emergency coordination stakeholders.',
                'Validate field information through trusted local contacts.',
                'Prepare urgent response documentation and priority action plan.',
            ],
            'high', 'elevated' => [
                'Assign the report for immediate review.',
                'Contact the reporting organization for additional evidence.',
                'Prepare a short intervention plan with timeline and responsible parties.',
            ],
            'medium' => [
                'Monitor the situation and request supporting documentation.',
                'Group this report with similar community needs for prioritization.',
                'Schedule follow-up review with relevant stakeholders.',
            ],
            default => [
                'Keep the report in monitoring status.',
                'Request additional context if the situation changes.',
                'Review again during the next community assessment cycle.',
            ],
        };
    }
}
