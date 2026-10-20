<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\University;
use App\Models\PropertyImage;
use App\Models\ContactRequest;
use App\Models\Booking;

class Property extends Model
{
    // ✅ FIX #1: fillable كانت فاضية (فيها حرف عربي مكسور) - أضفنا كل الحقول
    protected $fillable = [
        'owner_id',
        'owner_name',
        'owner_phone',
        'owner_email',
        'university_id',
        'title',
        'description',
        'property_type',
        'city',
        'region',
        'district',
        'address',
        'area',
        'latitude',
        'longitude',
        // 'bathrooms',
        'rooms_count',
        // 'bathrooms_count',
        'price',
        'is_available',
        'is_student_friendly',
        'has_student_discount',
        'student_discount_percentage',
        'status',
        'approved_by',
        'approved_at',
        'owner_notified_at',
        'amenities',
        'payment_method',
        'division_accept',
        'division_count',
     
    ];

    protected $casts = [
        'is_available'               => 'boolean',
        'is_student_friendly'        => 'boolean',
        'has_student_discount'       => 'boolean',
        'price'                      => 'decimal:2',
        'student_discount_percentage'=> 'decimal:2',
        'area'                       => 'decimal:2',
        'approved_at'                => 'datetime',
        'owner_notified_at'          => 'datetime',
        'amenities'                =>'array',
       

    ];

    public function owner()
    {
        return $this->belongsTo(User::class, 'owner_id');
    }

    public function university()
    {
        return $this->belongsTo(University::class);
    }

    public function images()
    {
        return $this->hasMany(PropertyImage::class);
    }

    public function contactRequests()
    {
        return $this->hasMany(ContactRequest::class);
    }
    public function bookings()
{
    return $this->hasMany(Booking::class);
}

// عدد السكان الحاليين
public function getCurrentOccupantsAttribute()
{
    return $this->bookings()->where('status', 'accepted')->count();
}
}
