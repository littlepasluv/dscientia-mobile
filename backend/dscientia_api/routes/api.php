<?php

use App\Http\Controllers\Api\CommunityRiskReportController;
use Illuminate\Support\Facades\Route;

Route::get('/health', function () {
    return response()->json([
        'data' => [
            'status' => 'ok',
            'service' => 'dscientia-api',
            'version' => '0.1.0',
        ],
    ]);
});

Route::apiResource('reports', CommunityRiskReportController::class)
    ->only(['index', 'store', 'show']);
