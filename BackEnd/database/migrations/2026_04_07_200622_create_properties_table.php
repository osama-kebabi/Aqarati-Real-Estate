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
    Schema::create('properties', function (Blueprint $table) {
        $table->id();//1
        $table->unsignedBigInteger('owner_id');//2
        $table->unsignedBigInteger('university_id')->nullable();//3
        $table->string('title');//4
        $table->text('description');//5
        $table->string('property_type');//6
        $table->string('city');//7
        $table->string('region');//8المنطقة
        $table->string('address');//9
        $table->decimal('latitude', 10, 7)->nullable();//10 احداثيات الموقع
        $table->decimal('longitude', 10, 7)->nullable();//11احداثيات الموقع
        $table->integer('rooms_count');//12
        // $table->integer('bathrooms_count');//13
        $table->integer('bathrooms_count')->nullable()->default(0);
        $table->decimal('price', 10, 2);//14 لحد العشر خانات +خانتين بعد الفاصلة
        $table->boolean('is_available')->default(true);//15
        $table->boolean('is_student_friendly')->default(false);//16 مناسب للطلاب
        $table->boolean('has_student_discount')->default(false);//17خصم الطلاب
        $table->decimal('student_discount_percentage', 5, 2)->nullable();//18 نسبة الخصم
        $table->timestamps();
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('properties');
    }
};
