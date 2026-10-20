<?php

namespace App\Models;
use Illuminate\Database\Eloquent\Model;
use App\Models\Property;
use App\Models\User;

class ContactRequest extends Model
{
   protected $table = 'contact_requests';
   protected $fillable = [
    'property_id',
    'tenant_id',
    'owner_id',
    'name',
    'phone',
    'message',
     'is_read' ,
      'reply', 
      'replied_at',
   ];

   public function property()
   {
    return $this->belongsTo(Property::class);
   }

   public function tenant()
   {
    return $this->belongsTo(User::class, 'tenant_id');
   }

   public function owner()
   {
    return $this->belongsTo(User::class ,'owner_id');
   }

}
