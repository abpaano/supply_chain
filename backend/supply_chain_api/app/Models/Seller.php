<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Store;

class Seller extends Model
{
    use HasFactory;

    // 1. Fillable Attributes
    protected $fillable = [
        'name',
        'email',
        'password',
        // ... other seller-specific attributes
    ];

    // 2. Hidden Attributes (optional)
    protected $hidden = [
        'password',
        'remember_token', // If applicable
    ];

    // 3. Relationships
    public function stores()
    {
        return $this->hasMany(Store::class); // One seller can have many stores
    }
}
