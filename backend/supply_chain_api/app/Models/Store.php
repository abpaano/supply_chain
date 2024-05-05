<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Store extends Model
{
    protected $fillable = ['name', 'address', 'latitude', 'longitude'];

    public function products() 
    {
        return $this->hasMany(Product::class);
    }
}
