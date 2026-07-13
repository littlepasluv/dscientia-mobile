<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('community_risk_reports', function (Blueprint $table) {
            $table->id();
            $table->string('organization_name');
            $table->string('reporter_name')->nullable();
            $table->string('category');
            $table->string('location');
            $table->string('urgency');
            $table->text('description');
            $table->unsignedInteger('affected_people_count')->nullable();
            $table->string('status')->default('open');
            $table->string('source_url')->nullable();
            $table->timestamps();

            $table->index('category');
            $table->index('urgency');
            $table->index('status');
            $table->index('created_at');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('community_risk_reports');
    }
};
