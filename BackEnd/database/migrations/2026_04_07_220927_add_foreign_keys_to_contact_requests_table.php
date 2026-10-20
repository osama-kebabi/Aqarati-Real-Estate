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
        Schema::table('contact_requests', function (Blueprint $table) {
           $table->foreign('property_id')//
              ->references('id')
              ->on('properties')
              ->onDelete('cascade');
           $table->foreign('tenant_id')//
              ->references('id')
              ->on('users')
              ->onDelete('cascade');//
           $table->foreign('owner_id')
              ->references('id')
              ->on('users')
              ->onDelete('cascade');
        });
    }

    /**
     * Reverse the migrations.
     */
   public function down(): void
{
    Schema::table('contact_requests', function (Blueprint $table) {
        $table->dropForeign(['property_id']);
        $table->dropForeign(['tenant_id']);
        $table->dropForeign(['owner_id']);
    });
}
};
