<?php

namespace App\Http\Controllers\Api;

use App\Contracts\AiInsightGenerator;
use App\Http\Controllers\Controller;
use App\Http\Requests\StoreAiInsightRequest;
use App\Http\Resources\AiInsightResource;
use App\Models\AiInsight;
use App\Models\CommunityRiskReport;

class AiInsightController extends Controller
{
    public function __construct(
        private readonly AiInsightGenerator $aiInsightGenerator,
    ) {}

    public function store(StoreAiInsightRequest $request)
    {
        $validated = $request->validated();

        $report = CommunityRiskReport::query()
            ->findOrFail($validated['report_id']);

        $insightType = $validated['insight_type'] ?? 'community_risk_summary';

        $generationResult = $this->aiInsightGenerator->generate(
            report: $report,
            insightType: $insightType,
        );

        $insight = AiInsight::create([
            'community_risk_report_id' => $report->id,
            'insight_type' => $insightType,
            ...$generationResult->toModelAttributes(),
        ]);

        return (new AiInsightResource($insight))
            ->response()
            ->setStatusCode(201);
    }

    public function show(AiInsight $aiInsight): AiInsightResource
    {
        return new AiInsightResource($aiInsight);
    }
}
