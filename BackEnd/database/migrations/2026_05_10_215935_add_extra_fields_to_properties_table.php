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
                 $table->decimal('area', 10, 2)->nullable()->after('address');
            // $table->integer('bedrooms')->nullable()->after('area');
            // $table->integer('bathrooms')->nullable()->after('bedrooms');
            $table->string('district')->nullable()->after('region');
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
