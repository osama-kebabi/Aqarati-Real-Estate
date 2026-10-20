<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class University extends Model
{
    protected $fillable = ['name','city'];

    public function students()
    {
        return $this->hasMany(User::class);

    }
    public function properties()
    {
        return $this->hasMany(Property::class);

    }
}
