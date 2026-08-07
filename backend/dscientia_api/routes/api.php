<?php

use App\Http\Controllers\Api\AiInsightController;
use App\Http\Controllers\Api\AuthenticationController;
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

Route::prefix('auth')->group(function () {
    Route::post('/register', [AuthenticationController::class, 'register']);
    Route::post('/login', [AuthenticationController::class, 'login']);

    Route::middleware('auth:sanctum')->group(function () {
        Route::get('/session', [AuthenticationController::class, 'session']);
        Route::post('/logout', [AuthenticationController::class, 'logout']);
    });
});

Route::apiResource('reports', CommunityRiskReportController::class)
    ->only(['index', 'store', 'show']);

Route::apiResource('ai-insights', AiInsightController::class)
    ->only(['store', 'show']);
