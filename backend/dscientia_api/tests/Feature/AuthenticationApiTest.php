<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class AuthenticationApiTest extends TestCase
{
    use RefreshDatabase;

    public function test_user_can_register_and_receive_access_token(): void
    {
        $response = $this->postJson('/api/auth/register', [
            'full_name' => 'Prio Test',
            'email' => 'prio@example.com',
            'password' => 'SecurePassword123!',
        ]);

        $response
            ->assertCreated()
            ->assertJsonPath('data.user.email', 'prio@example.com')
            ->assertJsonPath('data.user.full_name', 'Prio Test')
            ->assertJsonPath('data.user.role', 'Volunteer')
            ->assertJsonPath('data.user.is_email_verified', false)
            ->assertJsonStructure([
                'data' => [
                    'user' => [
                        'id',
                        'email',
                        'full_name',
                        'role',
                        'is_email_verified',
                        'created_at',
                    ],
                    'tokens' => [
                        'access_token',
                        'expires_at',
                    ],
                ],
            ])
            ->assertJsonMissingPath('data.tokens.refresh_token');

        $user = User::query()->where('email', 'prio@example.com')->firstOrFail();

        $this->assertTrue(Hash::check('SecurePassword123!', $user->password));
        $this->assertIsString($response->json('data.user.id'));
        $this->assertDatabaseCount('personal_access_tokens', 1);
        $this->assertNotNull($user->tokens()->first()?->expires_at);
    }

    public function test_registration_rejects_duplicate_email(): void
    {
        User::factory()->create(['email' => 'existing@example.com']);

        $this->postJson('/api/auth/register', [
            'full_name' => 'Duplicate User',
            'email' => 'existing@example.com',
            'password' => 'SecurePassword123!',
        ])
            ->assertUnprocessable()
            ->assertJsonValidationErrors(['email']);
    }

    public function test_user_can_login_and_receive_access_token(): void
    {
        User::factory()->create([
            'email' => 'prio@example.com',
            'password' => Hash::make('SecurePassword123!'),
        ]);

        $this->postJson('/api/auth/login', [
            'email' => 'prio@example.com',
            'password' => 'SecurePassword123!',
        ])
            ->assertOk()
            ->assertJsonPath('data.user.email', 'prio@example.com')
            ->assertJsonStructure([
                'data' => [
                    'user',
                    'tokens' => [
                        'access_token',
                        'expires_at',
                    ],
                ],
            ])
            ->assertJsonMissingPath('data.tokens.refresh_token');

        $this->assertDatabaseCount('personal_access_tokens', 1);
    }

    public function test_login_rejects_invalid_credentials(): void
    {
        User::factory()->create([
            'email' => 'prio@example.com',
            'password' => Hash::make('CorrectPassword123!'),
        ]);

        $this->postJson('/api/auth/login', [
            'email' => 'prio@example.com',
            'password' => 'WrongPassword123!',
        ])->assertUnauthorized();

        $this->assertDatabaseCount('personal_access_tokens', 0);
    }

    public function test_authenticated_user_can_read_current_session(): void
    {
        $user = User::factory()->create();
        $token = $user->createToken(
            'dscientia-client',
            ['*'],
            now()->addDays(7),
        )->plainTextToken;

        $this->withToken($token)
            ->getJson('/api/auth/session')
            ->assertOk()
            ->assertJsonPath('data.user.id', (string) $user->id)
            ->assertJsonPath('data.user.email', $user->email)
            ->assertJsonMissingPath('data.tokens');
    }

    public function test_logout_revokes_current_access_token(): void
    {
        $user = User::factory()->create();
        $token = $user->createToken(
            'dscientia-client',
            ['*'],
            now()->addDays(7),
        )->plainTextToken;

        $this->withToken($token)
            ->postJson('/api/auth/logout')
            ->assertNoContent();

        $this->assertDatabaseCount('personal_access_tokens', 0);

        // Simulate a fresh HTTP request after logout.
        $this->app['auth']->forgetGuards();

        $this->withToken($token)
            ->getJson('/api/auth/session')
            ->assertUnauthorized();
    }
}
