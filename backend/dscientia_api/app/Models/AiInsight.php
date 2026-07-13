<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\BelongsTo;

class AiInsight extends Model
{
    protected $fillable = [
        'community_risk_report_id',
        'insight_type',
        'risk_level',
        'narrative_summary',
        'summary_points',
        'recommended_actions',
        'confidence_score',
        'model_provider',
        'model_name',
        'status',
    ];

    protected function casts(): array
    {
        return [
            'summary_points' => 'array',
            'recommended_actions' => 'array',
            'confidence_score' => 'float',
        ];
    }

    public function report(): BelongsTo
    {
        return $this->belongsTo(CommunityRiskReport::class, 'community_risk_report_id');
    }
}
