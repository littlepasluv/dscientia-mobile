<?php

namespace App\Services\Watsonx;

use App\Data\AiInsightGenerationResult;
use JsonException;
use UnexpectedValueException;

final class WatsonxInsightResponseMapper
{
    private const ALLOWED_RISK_LEVELS = [
        'low',
        'medium',
        'elevated',
        'high',
        'critical',
    ];

    public function map(array $response): AiInsightGenerationResult
    {
        $finishReason = data_get(
            $response,
            'choices.0.finish_reason',
        );

        if ($finishReason !== 'stop') {
            throw new UnexpectedValueException(
                sprintf(
                    'watsonx response did not finish normally. '
                    .'Received finish_reason: %s.',
                    is_scalar($finishReason)
                        ? (string) $finishReason
                        : 'missing',
                ),
            );
        }

        $content = data_get(
            $response,
            'choices.0.message.content',
        );

        if (! is_string($content) || trim($content) === '') {
            throw new UnexpectedValueException(
                'watsonx response did not contain assistant message content.',
            );
        }

        $payload = $this->decodeJsonContent($content);

        $riskLevel = strtolower(
            $this->requiredString(
                $payload,
                'risk_level',
            ),
        );

        if (! in_array(
            $riskLevel,
            self::ALLOWED_RISK_LEVELS,
            true,
        )) {
            throw new UnexpectedValueException(
                sprintf(
                    'watsonx response contained unsupported risk_level: %s.',
                    $riskLevel,
                ),
            );
        }

        $narrativeSummary = $this->requiredString(
            $payload,
            'narrative_summary',
        );

        $summaryPoints = $this->requiredStringList(
            $payload,
            'summary_points',
        );

        $recommendedActions = $this->requiredStringList(
            $payload,
            'recommended_actions',
        );

        $confidenceScore = $payload['confidence_score'] ?? null;

        if (
            ! is_int($confidenceScore)
            && ! is_float($confidenceScore)
        ) {
            throw new UnexpectedValueException(
                'watsonx confidence_score must be numeric.',
            );
        }

        $confidenceScore = (float) $confidenceScore;

        if (
            $confidenceScore < 0.0
            || $confidenceScore > 1.0
        ) {
            throw new UnexpectedValueException(
                'watsonx confidence_score must be between 0.0 and 1.0.',
            );
        }

        $modelName = data_get(
            $response,
            'model_id',
            config('ai.watsonx.model_id'),
        );

        if (! is_string($modelName) || trim($modelName) === '') {
            throw new UnexpectedValueException(
                'watsonx response did not identify the model.',
            );
        }

        return new AiInsightGenerationResult(
            riskLevel: $riskLevel,
            narrativeSummary: $narrativeSummary,
            summaryPoints: $summaryPoints,
            recommendedActions: $recommendedActions,
            confidenceScore: $confidenceScore,
            modelProvider: 'watsonx',
            modelName: trim($modelName),
            status: 'completed',
        );
    }

    private function decodeJsonContent(string $content): array
    {
        $content = trim($content);

        if (
            preg_match(
                '/\A```(?:json)?\s*(.*?)\s*```\z/is',
                $content,
                $matches,
            ) === 1
        ) {
            $content = trim($matches[1]);
        }

        try {
            $payload = json_decode(
                $content,
                true,
                512,
                JSON_THROW_ON_ERROR,
            );
        } catch (JsonException $exception) {
            throw new UnexpectedValueException(
                'watsonx assistant content was not valid JSON.',
                previous: $exception,
            );
        }

        if (! is_array($payload)) {
            throw new UnexpectedValueException(
                'watsonx assistant content was not a JSON object.',
            );
        }

        return $payload;
    }

    private function requiredString(
        array $payload,
        string $key,
    ): string {
        $value = $payload[$key] ?? null;

        if (! is_string($value) || trim($value) === '') {
            throw new UnexpectedValueException(
                sprintf(
                    'watsonx response field %s must be a non-empty string.',
                    $key,
                ),
            );
        }

        return trim($value);
    }

    private function requiredStringList(
        array $payload,
        string $key,
    ): array {
        $value = $payload[$key] ?? null;

        if (! is_array($value)) {
            throw new UnexpectedValueException(
                sprintf(
                    'watsonx response field %s must be an array.',
                    $key,
                ),
            );
        }

        if (count($value) < 3 || count($value) > 7) {
            throw new UnexpectedValueException(
                sprintf(
                    'watsonx response field %s must contain '
                    .'between 3 and 7 items.',
                    $key,
                ),
            );
        }

        $normalizedItems = [];

        foreach ($value as $item) {
            if (! is_string($item) || trim($item) === '') {
                throw new UnexpectedValueException(
                    sprintf(
                        'watsonx response field %s must contain '
                        .'only non-empty strings.',
                        $key,
                    ),
                );
            }

            $normalizedItems[] = trim($item);
        }

        return $normalizedItems;
    }
}
