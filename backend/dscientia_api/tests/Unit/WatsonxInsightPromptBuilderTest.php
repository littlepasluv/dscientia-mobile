<?php

namespace Tests\Unit;

use App\Models\CommunityRiskReport;
use App\Services\Watsonx\WatsonxInsightPromptBuilder;
use InvalidArgumentException;
use Tests\TestCase;

class WatsonxInsightPromptBuilderTest extends TestCase
{
    public function test_it_builds_structured_messages_with_minimized_report_data(): void
    {
        $report = new CommunityRiskReport([
            'organization_name' => 'DscienTia',
            'reporter_name' => 'Sensitive Reporter Name',
            'category' => 'Infrastructure',
            'location' => 'Magelang, Central Java',
            'urgency' => 'medium',
            'description' => 'A damaged community access road requires review.',
            'affected_people_count' => 120,
            'source_url' => 'https://private.example.test/report',
        ]);

        $messages = (new WatsonxInsightPromptBuilder)
            ->messages($report);

        $this->assertCount(2, $messages);
        $this->assertSame('system', $messages[0]['role']);
        $this->assertSame('user', $messages[1]['role']);

        $this->assertStringContainsString(
            'Return exactly one valid JSON object',
            $messages[0]['content'],
        );

        $userText = $messages[1]['content'][0]['text'];

        $this->assertStringContainsString(
            '"organization_name": "DscienTia"',
            $userText,
        );

        $this->assertStringContainsString(
            '"category": "Infrastructure"',
            $userText,
        );

        $this->assertStringContainsString(
            '"affected_people_count": 120',
            $userText,
        );

        $this->assertStringNotContainsString(
            'Sensitive Reporter Name',
            $userText,
        );

        $this->assertStringNotContainsString(
            'private.example.test',
            $userText,
        );
    }

    public function test_it_rejects_unsupported_insight_type(): void
    {
        $report = new CommunityRiskReport([
            'organization_name' => 'DscienTia',
            'category' => 'Infrastructure',
            'location' => 'Magelang',
            'urgency' => 'medium',
            'description' => 'Synthetic report.',
        ]);

        $this->expectException(
            InvalidArgumentException::class,
        );

        $this->expectExceptionMessage(
            'Unsupported watsonx insight type: unsupported_type.',
        );

        (new WatsonxInsightPromptBuilder)->messages(
            $report,
            'unsupported_type',
        );
    }
}
