<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class AiInsightResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'report_id' => $this->community_risk_report_id,
            'insight_type' => $this->insight_type,
            'risk_level' => $this->risk_level,
            'narrative_summary' => $this->narrative_summary,
            'summary_points' => $this->summary_points,
            'recommended_actions' => $this->recommended_actions,
            'confidence_score' => $this->confidence_score,
            'model_provider' => $this->model_provider,
            'model_name' => $this->model_name,
            'status' => $this->status,
            'created_at' => $this->created_at?->toIso8601String(),
            'updated_at' => $this->updated_at?->toIso8601String(),
        ];
    }
}
