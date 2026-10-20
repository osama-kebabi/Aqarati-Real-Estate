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
    Schema::create('contact_requests', function (Blueprint $table) {
        $table->id();//رقم طلب التواصل
        $table->unsignedBigInteger('property_id');//رقم العقار الذي يخص هذا الطلب
        $table->unsignedBigInteger('tenant_id');//رقم المستاجر الذي ارسل الطلب
        $table->unsignedBigInteger('owner_id');//رقم صاحب العقار الذي سيستلم الطلب
        $table->string('name');//اسم المرسل
        $table->string('phone');//رقم هاتف المرسل
        $table->text('message');//نص الرسالة الاستفسار
        $table->timestamps();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('contact_requests');
    }
};
