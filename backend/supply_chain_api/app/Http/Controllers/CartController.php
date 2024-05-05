<?php

namespace App\Http\Controllers;

use App\Http\Requests\AddToCartRequest;  // We'll create this Request shortly
use App\Models\Cart;
use Illuminate\Http\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB; 

class CartController extends Controller
{
    public function addToCart(AddToCartRequest $request)
    {
        // 1. Input Validation (handled by AddToCartRequest)

        // 2. Retrieve appropriate user or create a session identifier
        $user = $request->user(); // Assuming authentication is in place
        if (!$user) {
            // Handle guest cart logic
            $sessionId = $request->session()->getId(); // Or generate something unique
        }

        // 3. Add or Update Cart Item
        $cart = Cart::updateOrCreate(
            [
                'user_id' => $user ? $user->id : null,
                'session_id' => $sessionId ?? null,
                'product_id' => $request->product_id,
            ],
            ['quantity' => $request->quantity]
        );

        return response()->json([
            'message' => 'Item added to cart',
            'cart' => $cart  // You may want to adjust the payload here
        ], Response::HTTP_CREATED); 
    }

    public function fetchCart(Request $request)
{
    $user = $request->user(); 
    $sessionId = $request->session()->getId(); // Get session ID

    $cart = Cart::where(function ($query) use ($user, $sessionId) {
        if ($user) {
            $query->where('user_id', $user->id);
        } else {
            $query->where('session_id', $sessionId);
        }
    })->get(); 

    // ... Format the data as needed ...

    return response()->json($cart);
}
}
