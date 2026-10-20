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
    Schema::table('users', function (Blueprint $table) {
        $table->string('phone')->nullable()->after('email');
        $table->string('role')->default('tenant')->after('phone');
        $table->string('tenant_type')->nullable()->after('role');
        $table->unsignedBigInteger('university_id')->nullable()->after('tenant_type');
    });
}
    /**
     * Reverse the migrations.
     */
    public function down(): void
{
    Schema::table('users', function (Blueprint $table) {
        $table->dropColumn(['phone', 'role', 'tenant_type', 'university_id']);
    });
}
};
