<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Relations\HasMany;

class CommunityRiskReport extends Model
{
    use HasFactory;

    protected $fillable = [
        'organization_name',
        'reporter_name',
        'category',
        'location',
        'urgency',
        'description',
        'affected_people_count',
        'status',
        'source_url',
    ];

    protected function casts(): array
    {
        return [
            'affected_people_count' => 'integer',
        ];
    }

    public function aiInsights(): HasMany
    {
        return $this->hasMany(AiInsight::class);
    }
}
