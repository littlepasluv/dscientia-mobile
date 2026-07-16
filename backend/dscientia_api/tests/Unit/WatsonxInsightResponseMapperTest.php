<?php

namespace Tests\Unit;

use App\Services\Watsonx\WatsonxInsightResponseMapper;
use Tests\TestCase;
use UnexpectedValueException;

class WatsonxInsightResponseMapperTest extends TestCase
{
    public function test_it_maps_valid_structured_response(): void
    {
        $mapper = new WatsonxInsightResponseMapper;

        $result = $mapper->map(
            $this->validWatsonxResponse(),
        );

        $this->assertSame(
            'elevated',
            $result->riskLevel,
        );

        $this->assertSame(
            'watsonx',
            $result->modelProvider,
        );

        $this->assertSame(
            'ibm/granite-test-model',
            $result->modelName,
        );

        $this->assertSame(
            0.81,
            $result->confidenceScore,
        );

        $this->assertCount(
            3,
            $result->summaryPoints,
        );

        $this->assertCount(
            3,
            $result->recommendedActions,
        );
    }

    public function test_it_accepts_json_wrapped_in_code_fences(): void
    {
        $response = $this->validWatsonxResponse();

        $content = $response['choices'][0]['message']['content'];

        $response['choices'][0]['message']['content'] =
            "```json\n{$content}\n```";

        $result = (new WatsonxInsightResponseMapper)
            ->map($response);

        $this->assertSame(
            'elevated',
            $result->riskLevel,
        );
    }

    public function test_it_rejects_non_json_content(): void
    {
        $response = $this->validWatsonxResponse();

        $response['choices'][0]['message']['content'] =
            'This is not JSON.';

        $this->expectException(
            UnexpectedValueException::class,
        );

        $this->expectExceptionMessage(
            'watsonx assistant content was not valid JSON.',
        );

        (new WatsonxInsightResponseMapper)
            ->map($response);
    }

    public function test_it_rejects_unsupported_risk_level(): void
    {
        $response = $this->validWatsonxResponse();

        $payload = json_decode(
            $response['choices'][0]['message']['content'],
            true,
            512,
            JSON_THROW_ON_ERROR,
        );

        $payload['risk_level'] = 'extreme';

        $response['choices'][0]['message']['content'] =
            json_encode(
                $payload,
                JSON_THROW_ON_ERROR,
            );

        $this->expectException(
            UnexpectedValueException::class,
        );

        $this->expectExceptionMessage(
            'watsonx response contained unsupported risk_level: extreme.',
        );

        (new WatsonxInsightResponseMapper)
            ->map($response);
    }

    public function test_it_rejects_incomplete_generation(): void
    {
        $response = $this->validWatsonxResponse();

        $response['choices'][0]['finish_reason'] = 'length';

        $this->expectException(
            UnexpectedValueException::class,
        );

        $this->expectExceptionMessage(
            'watsonx response did not finish normally.',
        );

        (new WatsonxInsightResponseMapper)
            ->map($response);
    }

    private function validWatsonxResponse(): array
    {
        return [
            'id' => 'chat-test-001',
            'model_id' => 'ibm/granite-test-model',
            'choices' => [
                [
                    'index' => 0,
                    'message' => [
                        'role' => 'assistant',
                        'content' => json_encode(
                            [
                                'risk_level' => 'elevated',
                                'narrative_summary' => 'The report indicates an elevated '
                                    .'infrastructure concern requiring '
                                    .'verification and coordinated follow-up.',
                                'summary_points' => [
                                    'Infrastructure access is affected.',
                                    'The reported urgency is medium.',
                                    'The report estimates 120 affected people.',
                                ],
                                'recommended_actions' => [
                                    'Verify the condition with local stakeholders.',
                                    'Collect supporting photographs and field notes.',
                                    'Prepare a prioritized follow-up plan.',
                                ],
                                'confidence_score' => 0.81,
                            ],
                            JSON_THROW_ON_ERROR,
                        ),
                    ],
                    'finish_reason' => 'stop',
                ],
            ],
        ];
    }
}
