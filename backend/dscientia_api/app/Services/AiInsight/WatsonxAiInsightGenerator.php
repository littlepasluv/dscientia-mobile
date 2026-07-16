<?php

namespace App\Services\AiInsight;

use App\Contracts\AiInsightGenerator;
use App\Data\AiInsightGenerationResult;
use App\Models\CommunityRiskReport;
use App\Services\Watsonx\WatsonxHttpClient;
use App\Services\Watsonx\WatsonxInsightPromptBuilder;
use App\Services\Watsonx\WatsonxInsightResponseMapper;

final class WatsonxAiInsightGenerator implements AiInsightGenerator
{
    public function __construct(
        private readonly WatsonxHttpClient $httpClient,
        private readonly WatsonxInsightPromptBuilder $promptBuilder,
        private readonly WatsonxInsightResponseMapper $responseMapper,
    ) {}

    public function generate(
        CommunityRiskReport $report,
        string $insightType = 'community_risk_summary',
    ): AiInsightGenerationResult {
        $messages = $this->promptBuilder->messages(
            $report,
            $insightType,
        );

        $response = $this->httpClient->chat($messages);

        return $this->responseMapper->map($response);
    }
}
