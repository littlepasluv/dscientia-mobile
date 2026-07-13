<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CommunityRiskReportResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'organization_name' => $this->organization_name,
            'reporter_name' => $this->reporter_name,
            'category' => $this->category,
            'location' => $this->location,
            'urgency' => $this->urgency,
            'description' => $this->description,
            'affected_people_count' => $this->affected_people_count,
            'status' => $this->status,
            'source_url' => $this->source_url,
            'created_at' => $this->created_at?->toIso8601String(),
            'updated_at' => $this->updated_at?->toIso8601String(),
        ];
    }
}
