<?php

namespace App\Services\AiInsight;

use App\Contracts\AiInsightGenerator;
use App\Data\AiInsightGenerationResult;
use App\Exceptions\WatsonxProviderException;
use App\Models\CommunityRiskReport;
use App\Services\Watsonx\WatsonxHttpClient;
use App\Services\Watsonx\WatsonxInsightPromptBuilder;
use App\Services\Watsonx\WatsonxInsightResponseMapper;
use Illuminate\Support\Facades\Log;
use UnexpectedValueException;

final class WatsonxAiInsightGenerator implements AiInsightGenerator
{
    public function __construct(
        private readonly WatsonxHttpClient $httpClient,
        private readonly WatsonxInsightPromptBuilder $promptBuilder,
        private readonly WatsonxInsightResponseMapper $responseMapper,
        private readonly MockAiInsightGenerator $fallbackGenerator,
    ) {}

    public function generate(
        CommunityRiskReport $report,
        string $insightType = 'community_risk_summary',
    ): AiInsightGenerationResult {
        $messages = $this->promptBuilder->messages(
            $report,
            $insightType,
        );

        try {
            $response = $this->httpClient->chat($messages);

            return $this->responseMapper->map($response);
        } catch (WatsonxProviderException $exception) {
            return $this->fallbackOrThrow(
                $report,
                $insightType,
                $exception,
            );
        } catch (UnexpectedValueException $exception) {
            return $this->fallbackOrThrow(
                $report,
                $insightType,
                WatsonxProviderException::invalidResponse(
                    operation: 'structured_response_mapping',
                    errorCode: 'invalid_structured_response',
                    previous: $exception,
                ),
            );
        }
    }

    private function fallbackOrThrow(
        CommunityRiskReport $report,
        string $insightType,
        WatsonxProviderException $exception,
    ): AiInsightGenerationResult {
        if (! (bool) config('ai.watsonx.fallback_to_mock', true)) {
            throw $exception;
        }

        Log::warning(
            'watsonx generation failed; mock fallback activated.',
            [
                ...$exception->context(),
                'report_id' => $report->getKey(),
                'insight_type' => $insightType,
                'fallback_provider' => 'mock',
            ],
        );

        $fallbackResult = $this->fallbackGenerator->generate(
            $report,
            $insightType,
        );

        return new AiInsightGenerationResult(
            riskLevel: $fallbackResult->riskLevel,
            narrativeSummary: $fallbackResult->narrativeSummary,
            summaryPoints: $fallbackResult->summaryPoints,
            recommendedActions: $fallbackResult->recommendedActions,
            confidenceScore: $fallbackResult->confidenceScore,
            modelProvider: 'mock-fallback',
            modelName: $fallbackResult->modelName,
            status: 'completed',
        );
    }
}
