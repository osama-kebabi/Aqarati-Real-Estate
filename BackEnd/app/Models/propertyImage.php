<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Property;

class PropertyImage extends Model
{
    protected $table = 'property_images';

    protected $fillable = ['property_id', 'image_path', 'is_main'];

    protected $casts = ['is_main' => 'boolean'];

    // 1. إجبار لارافيل على دمج حقل رابط الصورة تلقائياً عند إرسال البيانات كـ JSON للفرونت إند
    protected $appends = ['image_url'];

    // 2. الـ Accessor الذكي الذي يقوم بتوليد الرابط الكامل تلقائياً
    public function getImageUrlAttribute()
    {
        return $this->image_path ? asset('storage/' . $this->image_path) : asset('img/default-property.jpg');
    }

    // علاقة الصورة مع العقار (الكود القديم الخاص بك)
    public function property()
    {
        return $this->belongsTo(Property::class);
    }
}