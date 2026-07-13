<?php

namespace App\Providers;

use App\Contracts\AiInsightGenerator;
use App\Services\AiInsight\MockAiInsightGenerator;
use App\Services\AiInsight\WatsonxAiInsightGenerator;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    public function register(): void
    {
        $this->app->bind(AiInsightGenerator::class, function () {
            return match (config('ai.provider', 'mock')) {
                'watsonx' => app(WatsonxAiInsightGenerator::class),
                default => app(MockAiInsightGenerator::class),
            };
        });
    }

    public function boot(): void
    {
        //
    }
}
