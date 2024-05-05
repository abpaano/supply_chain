<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\StoreReview;

class StoreRatingController extends Controller
{
    public function getStoreRating($store_id)
    {
        $ratings = StoreReview::where('store_id', $store_id)
                         ->get(); // Fetch all review data

        return response()->json($ratings->toArray()); 
    }
}
