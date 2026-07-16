<?php

namespace Tests\Unit;

use App\Models\CommunityRiskReport;
use App\Services\AiInsight\WatsonxAiInsightGenerator;
use LogicException;
use Tests\TestCase;

class WatsonxAiInsightGeneratorTest extends TestCase
{
    public function test_placeholder_does_not_claim_successful_ibm_generation(): void
    {
        $report = new CommunityRiskReport([
            'organization_name' => 'DscienTia',
            'category' => 'Infrastructure',
            'location' => 'Magelang, Central Java',
            'urgency' => 'medium',
            'description' => 'Synthetic report for watsonx provider safety testing.',
        ]);

        $this->expectException(LogicException::class);
        $this->expectExceptionMessage(
            'IBM watsonx generation is not implemented yet.'
        );

        (new WatsonxAiInsightGenerator)->generate($report);
    }
}
