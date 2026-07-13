<?php

namespace App\Services\AiInsight;

use App\Contracts\AiInsightGenerator;
use App\Data\AiInsightGenerationResult;
use App\Models\CommunityRiskReport;

final class WatsonxAiInsightGenerator implements AiInsightGenerator
{
    public function generate(
        CommunityRiskReport $report,
        string $insightType = 'community_risk_summary',
    ): AiInsightGenerationResult {
        $modelName = config('ai.watsonx.model_id', 'ibm/granite-placeholder');

        return new AiInsightGenerationResult(
            riskLevel: 'pending_external_model',
            narrativeSummary: sprintf(
                'Watsonx integration contract is ready for report #%s. Real IBM/watsonx generation will be implemented after credentials, project configuration, and prompt governance are finalized.',
                $report->id ?? 'new'
            ),
            summaryPoints: [
                'Provider contract: watsonx',
                'Report category: '.$report->category,
                'Report urgency: '.$report->urgency,
                'Report location: '.$report->location,
            ],
            recommendedActions: [
                'Keep using the mock provider until IBM/watsonx credentials are configured.',
                'Finalize prompt template, safety rules, and response schema before enabling production AI calls.',
                'Store IBM credentials only in server-side environment variables.',
            ],
            confidenceScore: 0.70,
            modelProvider: 'watsonx-placeholder',
            modelName: $modelName,
            status: 'completed',
        );
    }
}
