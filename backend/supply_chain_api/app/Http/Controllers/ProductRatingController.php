<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Review;

class ProductRatingController extends Controller
{

    public function getProductRating($product_id)
    {
        $ratings = Review::where('product_id', $product_id)
                         ->get(); // Fetch all review data

        return response()->json($ratings->toArray()); 
    }
}
