<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class StoreReview extends Model
{
    use HasFactory;

    public function store()
    {
        return $this->belongsTo(Store::class);
    }

    // (Optional) If you have user accounts:
    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
