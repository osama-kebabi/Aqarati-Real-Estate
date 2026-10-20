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
        $table->foreign('owner_id')
              ->references('id')
              ->on('users')
              ->onDelete('cascade');

        $table->foreign('university_id')
              ->references('id')
              ->on('universities')
              ->onDelete('set null');
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('properties', function (Blueprint $table) {
            $table->dropForeign(['owner_id']);
            $table->dropForeign(['university_id']);
            //
        });
    }
};
