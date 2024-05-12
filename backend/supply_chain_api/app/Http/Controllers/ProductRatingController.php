<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Review;
use Illuminate\Support\Facades\DB;

class ProductRatingController extends Controller
{

    public function getProductRating($product_id)
    {
        $ratings = Review::where('product_id', $product_id)
                         ->get(); // Fetch all review data

        return response()->json($ratings->toArray()); 
    }
    public function getRatings(Request $request)
{
    $productIds = explode(',', $request->query('product_ids'));

    $reviews = DB::table('reviews')
                ->whereIn('product_id', $productIds)
                ->get(); 

   // Structure response (assuming you want reviews grouped by product ID)
   $response = [];
   foreach ($reviews as $review) {
       $productId = $review->product_id;
       $response[$productId][] = (array) $review;
       //$response[$productId][] = $review->toArray(); // Add other relevant review fields
   }

   return response()->json($response);
}
}
