<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    //status: حالة العقار (pending/approved/rejected) — الافتراضي pending
    public function up(): void
{
    Schema::table('properties', function (Blueprint $table) {
        $table->string('status')->default('pending')->after('student_discount_percentage');
        $table->unsignedBigInteger('approved_by')->nullable()->after('status');
        $table->timestamp('approved_at')->nullable()->after('approved_by');
    });
}
    /**
     * Reverse the migrations.
     */
   public function down(): void
{
    Schema::table('properties', function (Blueprint $table) {
        $table->dropColumn(['status', 'approved_by', 'approved_at']);//approved_by: id الأدمن الذي وافق (nullable)//approved_at: وقت الموافقة (nullable)
    });
}
};
