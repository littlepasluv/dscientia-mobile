<?php

namespace App\Exceptions;

use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use RuntimeException;
use Throwable;

final class WatsonxProviderException extends RuntimeException
{
    private const PUBLIC_MESSAGE =
        'AI insight generation is temporarily unavailable.';

    public function __construct(
        public readonly string $operation,
        public readonly string $errorCode,
        public readonly ?int $statusCode = null,
        public readonly bool $retryable = false,
        ?Throwable $previous = null,
    ) {
        parent::__construct(
            self::PUBLIC_MESSAGE,
            previous: $previous,
        );
    }

    public static function configuration(
        string $operation,
        string $errorCode,
    ): self {
        return new self(
            operation: $operation,
            errorCode: $errorCode,
            retryable: false,
        );
    }

    public static function transport(
        string $operation,
        string $errorCode,
        ?int $statusCode,
        bool $retryable,
        Throwable $previous,
    ): self {
        return new self(
            operation: $operation,
            errorCode: $errorCode,
            statusCode: $statusCode,
            retryable: $retryable,
            previous: $previous,
        );
    }

    public static function invalidResponse(
        string $operation,
        string $errorCode,
        Throwable $previous,
    ): self {
        return new self(
            operation: $operation,
            errorCode: $errorCode,
            retryable: false,
            previous: $previous,
        );
    }

    public function context(): array
    {
        return array_filter(
            [
                'provider' => 'watsonx',
                'operation' => $this->operation,
                'error_code' => $this->errorCode,
                'status_code' => $this->statusCode,
                'retryable' => $this->retryable,
            ],
            static fn (mixed $value): bool => $value !== null,
        );
    }

    public function report(): bool
    {
        Log::error(
            'watsonx provider operation failed.',
            $this->context(),
        );

        return true;
    }

    public function render(Request $request): JsonResponse|bool
    {
        if (! $request->expectsJson()) {
            return false;
        }

        return response()->json(
            [
                'message' => self::PUBLIC_MESSAGE,
                'error' => [
                    'code' => 'AI_PROVIDER_UNAVAILABLE',
                ],
            ],
            503,
        );
    }
}
