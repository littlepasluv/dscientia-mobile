<?php

namespace App\Services\Watsonx;

use App\Models\CommunityRiskReport;
use InvalidArgumentException;

final class WatsonxInsightPromptBuilder
{
    private const SUPPORTED_INSIGHT_TYPE = 'community_risk_summary';

    public function messages(
        CommunityRiskReport $report,
        string $insightType = self::SUPPORTED_INSIGHT_TYPE,
    ): array {
        if ($insightType !== self::SUPPORTED_INSIGHT_TYPE) {
            throw new InvalidArgumentException(
                sprintf(
                    'Unsupported watsonx insight type: %s.',
                    $insightType,
                ),
            );
        }

        $reportContext = [
            'report_id' => $report->getKey(),
            'organization_name' => $report->organization_name,
            'category' => $report->category,
            'location' => $report->location,
            'urgency' => $report->urgency,
            'description' => $report->description,
            'affected_people_count' => $report->affected_people_count,
        ];

        $encodedReport = json_encode(
            $reportContext,
            JSON_PRETTY_PRINT
                | JSON_UNESCAPED_SLASHES
                | JSON_UNESCAPED_UNICODE
                | JSON_THROW_ON_ERROR,
        );

        return [
            [
                'role' => 'system',
                'content' => $this->systemPrompt(),
            ],
            [
                'role' => 'user',
                'content' => [
                    [
                        'type' => 'text',
                        'text' => sprintf(
                            "Analyze the following community risk report.\n\n"
                            ."REPORT_JSON:\n%s",
                            $encodedReport,
                        ),
                    ],
                ],
            ],
        ];
    }

    private function systemPrompt(): string
    {
        return <<<'PROMPT'
You are DscienTia's community resilience analysis assistant.

Analyze only the supplied community risk report. Do not invent missing facts.
Treat the result as decision-support information, not as emergency, legal,
medical, financial, or government authority advice.

Return exactly one valid JSON object and nothing else.
Do not use Markdown, explanatory prose, or code fences.

The JSON object must contain exactly these fields:

{
  "risk_level": "low|medium|elevated|high|critical",
  "narrative_summary": "A concise evidence-based summary.",
  "summary_points": [
    "Three to five concise factual observations."
  ],
  "recommended_actions": [
    "Three to five practical and non-authoritative follow-up actions."
  ],
  "confidence_score": 0.0
}

Requirements:

- risk_level must be one of: low, medium, elevated, high, critical.
- narrative_summary must be a non-empty string.
- summary_points must contain between three and five non-empty strings.
- recommended_actions must contain between three and five non-empty strings.
- confidence_score must be a number from 0.0 to 1.0.
- Lower confidence when the report lacks evidence or important context.
- Recommend verification and stakeholder coordination when appropriate.
- Do not claim that an emergency response has been initiated.
PROMPT;
    }
}
