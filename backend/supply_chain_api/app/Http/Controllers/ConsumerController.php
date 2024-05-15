<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Review;
use App\Models\Consumer; 
use Illuminate\Validation\ValidationException;

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

    public function login(Request $request)
    {
        // 1. Validate credentials
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        // 2. Find Seller
        $consumer = Consumer::where('email', $request->email)->first();
        if (!$consumer || $consumer->password !== $request->password) {  
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }

        //$token = $consumer->createToken('consumer_auth_token')->plainTextToken;

        $consumer->tokens()->where('name', 'auth_token')->delete(); // Remove previous tokens
        $accessToken = $consumer->createToken('auth_token')->plainTextToken;

        return response()->json([
            'consumer' => $consumer,
            'access_token' => $accessToken,
            'token_type' => 'Bearer',
        ]);
    }
}
