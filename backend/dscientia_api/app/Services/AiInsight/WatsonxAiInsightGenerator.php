<?php

namespace App\Services\AiInsight;

use App\Contracts\AiInsightGenerator;
use App\Data\AiInsightGenerationResult;
use App\Models\CommunityRiskReport;
use LogicException;

final class WatsonxAiInsightGenerator implements AiInsightGenerator
{
    public function generate(
        CommunityRiskReport $report,
        string $insightType = 'community_risk_summary',
    ): AiInsightGenerationResult {
        throw new LogicException(
            'IBM watsonx generation is not implemented yet. '
            .'Keep DSCIENTIA_AI_PROVIDER=mock until the real provider, '
            .'response validation, and fallback handling are complete.'
        );
    }
}
