<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
   public function up(): void
{
    Schema::table('properties', function (Blueprint $table) {
        if (!\Schema::hasColumn('properties', 'division_accept')) {
            $table->string('division_accept')->default('no')->after('amenities');
        }
        if (!\Schema::hasColumn('properties', 'division_count')) {
            $table->string('division_count')->nullable()->after('division_accept');
        }
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('properties', function (Blueprint $table) {
            //
        });
    }
};
