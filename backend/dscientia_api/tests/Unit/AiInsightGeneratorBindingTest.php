<?php

namespace Tests\Unit;

use App\Contracts\AiInsightGenerator;
use App\Services\AiInsight\MockAiInsightGenerator;
use Tests\TestCase;

class AiInsightGeneratorBindingTest extends TestCase
{
    public function test_default_ai_insight_generator_is_mock(): void
    {
        $generator = $this->app->make(AiInsightGenerator::class);

        $this->assertInstanceOf(MockAiInsightGenerator::class, $generator);
    }
}
