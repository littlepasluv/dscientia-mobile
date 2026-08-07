<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Response;
use Illuminate\Support\Facades\Hash;

class AuthenticationController extends Controller
{
    private const TOKEN_NAME = 'dscientia-client';

    private const TOKEN_LIFETIME_DAYS = 7;

    public function register(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'full_name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'string', 'min:8'],
        ]);

        $user = User::query()->create([
            'name' => $validated['full_name'],
            'email' => $validated['email'],
            'password' => $validated['password'],
        ]);

        return response()->json([
            'data' => [
                'user' => $this->userData($user),
                'tokens' => $this->createAccessToken($user),
            ],
        ], 201);
    }

    public function login(Request $request): JsonResponse
    {
        $validated = $request->validate([
            'email' => ['required', 'string', 'email'],
            'password' => ['required', 'string'],
        ]);

        $user = User::query()
            ->where('email', $validated['email'])
            ->first();

        if ($user === null || ! Hash::check($validated['password'], $user->password)) {
            return response()->json([
                'message' => 'Invalid credentials.',
            ], 401);
        }

        return response()->json([
            'data' => [
                'user' => $this->userData($user),
                'tokens' => $this->createAccessToken($user),
            ],
        ]);
    }

    public function session(Request $request): JsonResponse
    {
        return response()->json([
            'data' => [
                'user' => $this->userData($request->user()),
            ],
        ]);
    }

    public function logout(Request $request): Response
    {
        $request->user()->currentAccessToken()?->delete();

        return response()->noContent();
    }

    /**
     * @return array<string, mixed>
     */
    private function userData(User $user): array
    {
        return [
            'id' => (string) $user->id,
            'email' => $user->email,
            'full_name' => $user->name,
            'role' => 'Volunteer',
            'is_email_verified' => $user->email_verified_at !== null,
            'created_at' => $user->created_at?->toISOString(),
        ];
    }

    /**
     * @return array{access_token: string, expires_at: string}
     */
    private function createAccessToken(User $user): array
    {
        $expiresAt = now()->addDays(self::TOKEN_LIFETIME_DAYS);

        $token = $user->createToken(
            self::TOKEN_NAME,
            ['*'],
            $expiresAt,
        );

        return [
            'access_token' => $token->plainTextToken,
            'expires_at' => $expiresAt->toISOString(),
        ];
    }
}
