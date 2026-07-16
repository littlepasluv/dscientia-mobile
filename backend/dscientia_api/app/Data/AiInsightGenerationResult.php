<?php

namespace App\Data;

final readonly class AiInsightGenerationResult
{
    public function __construct(
        public string $riskLevel,
        public string $narrativeSummary,
        public array $summaryPoints,
        public array $recommendedActions,
        public float $confidenceScore,
        public string $modelProvider,
        public string $modelName,
        public string $status = 'completed',
    ) {}

    public function toModelAttributes(): array
    {
        return [
            'risk_level' => $this->riskLevel,
            'narrative_summary' => $this->narrativeSummary,
            'summary_points' => $this->summaryPoints,
            'recommended_actions' => $this->recommendedActions,
            'confidence_score' => $this->confidenceScore,
            'model_provider' => $this->modelProvider,
            'model_name' => $this->modelName,
            'status' => $this->status,
        ];
    }
}
