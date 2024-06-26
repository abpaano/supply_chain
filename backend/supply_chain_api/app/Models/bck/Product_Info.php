<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product_Info extends Model
{
    use HasFactory;
    protected $table = 'tbl_supply_chain';
    protected $fillable = [
        'product_name',
        'category',
        'quantity',
        'price',
        'unit',
        'produced_from',
        'description'
    ];
}
