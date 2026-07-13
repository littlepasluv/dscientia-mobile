<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreAiInsightRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'report_id' => ['required', 'integer', 'exists:community_risk_reports,id'],
            'insight_type' => ['nullable', 'string', 'in:community_risk_summary'],
        ];
    }
}
