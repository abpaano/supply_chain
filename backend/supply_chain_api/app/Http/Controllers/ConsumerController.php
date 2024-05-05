<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Review;
use App\Models\Consumer; 

class ConsumerController extends Controller
{
    public function getConsumerByReview($user_id)
    {
        $review = Review::find($user_id);

        if (!$review) {
            return response()->json(['error' => 'Review not found'], 404);
        }

        // Fetch consumer directly based on consumer_id
        $consumer = Consumer::where('id', $review->user_id)->first(); 

        if (!$consumer) {
            return response()->json(['error' => 'Consumer not associated with review'], 500); 
        }

        return response()->json($consumer, 200);
    }
}
