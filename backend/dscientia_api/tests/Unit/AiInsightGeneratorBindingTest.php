<?php

namespace Tests\Unit;

use App\Contracts\AiInsightGenerator;
use App\Services\AiInsight\MockAiInsightGenerator;
use App\Services\AiInsight\WatsonxAiInsightGenerator;
use Tests\TestCase;

class AiInsightGeneratorBindingTest extends TestCase
{
    public function test_default_ai_insight_generator_is_mock(): void
    {
        config()->set('ai.provider', 'mock');

        $generator = $this->app->make(AiInsightGenerator::class);

        $this->assertInstanceOf(MockAiInsightGenerator::class, $generator);
    }

    public function test_watsonx_ai_insight_generator_can_be_selected(): void
    {
        config()->set('ai.provider', 'watsonx');

        $generator = $this->app->make(AiInsightGenerator::class);

        $this->assertInstanceOf(WatsonxAiInsightGenerator::class, $generator);
    }
}
