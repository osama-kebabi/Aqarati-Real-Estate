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
        Schema::table('property_images', function (Blueprint $table) {
          $table->foreign('property_id')//property_id بجدولproperty_image   مرتبط معid بجدول  properties
              ->references('id')
              ->on('properties')
              ->onDelete('cascade');//اذا نحذف العقار لازم تنحذف صوره تلقائيا

        
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
{
    Schema::table('property_images', function (Blueprint $table) {
        $table->dropForeign(['property_id']);
    });
}
};
