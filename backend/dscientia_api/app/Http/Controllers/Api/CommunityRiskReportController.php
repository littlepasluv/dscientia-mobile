<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Http\Requests\StoreCommunityRiskReportRequest;
use App\Http\Resources\CommunityRiskReportResource;
use App\Models\CommunityRiskReport;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;

class CommunityRiskReportController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $reports = CommunityRiskReport::query()
            ->latest()
            ->get();

        return CommunityRiskReportResource::collection($reports);
    }

    public function store(StoreCommunityRiskReportRequest $request)
    {
        $validated = $request->validated();

        $report = CommunityRiskReport::create([
            ...$validated,
            'status' => $validated['status'] ?? 'open',
        ]);

        return (new CommunityRiskReportResource($report))
            ->response()
            ->setStatusCode(201);
    }

    public function show(CommunityRiskReport $report): CommunityRiskReportResource
    {
        return new CommunityRiskReportResource($report);
    }
}
