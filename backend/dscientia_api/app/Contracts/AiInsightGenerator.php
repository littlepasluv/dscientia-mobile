<?php

namespace App\Contracts;

use App\Data\AiInsightGenerationResult;
use App\Models\CommunityRiskReport;

interface AiInsightGenerator
{
    public function generate(
        CommunityRiskReport $report,
        string $insightType = 'community_risk_summary',
    ): AiInsightGenerationResult;
}
