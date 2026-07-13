<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreCommunityRiskReportRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'organization_name' => ['required', 'string', 'max:160'],
            'reporter_name' => ['nullable', 'string', 'max:160'],
            'category' => ['required', 'string', 'max:80'],
            'location' => ['required', 'string', 'max:160'],
            'urgency' => ['required', 'string', 'in:low,medium,high,critical'],
            'description' => ['required', 'string', 'min:20', 'max:5000'],
            'affected_people_count' => ['nullable', 'integer', 'min:0'],
            'status' => ['nullable', 'string', 'in:open,reviewing,resolved'],
            'source_url' => ['nullable', 'url', 'max:2048'],
        ];
    }
}
