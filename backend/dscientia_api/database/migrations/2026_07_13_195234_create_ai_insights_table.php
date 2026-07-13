<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('ai_insights', function (Blueprint $table) {
            $table->id();
            $table->foreignId('community_risk_report_id')
                ->constrained()
                ->cascadeOnDelete();
            $table->string('insight_type')->default('community_risk_summary');
            $table->string('risk_level');
            $table->text('narrative_summary');
            $table->json('summary_points');
            $table->json('recommended_actions');
            $table->decimal('confidence_score', 5, 2)->default(0.70);
            $table->string('model_provider')->default('mock');
            $table->string('model_name')->default('dscientia-local-mock-v0.1');
            $table->string('status')->default('completed');
            $table->timestamps();

            $table->index('community_risk_report_id');
            $table->index('insight_type');
            $table->index('risk_level');
            $table->index('status');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('ai_insights');
    }
};
