<?php

namespace App\Http\Controllers;

use App\Http\Requests\AddToCartRequest;
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
    //$user = $request->user(); // Assuming authentication is in place
    $userId = $request->user_id;
    if (!$userId) {
        // Handle guest cart logic
        $sessionId = $request->session()->getId(); // Or generate something unique
    }

    // 3. Check if the product already exists in the cart
    $existingCart = Cart::where('user_id', $userId ? $userId : null)
                        ->where('session_id', $sessionId ?? null)
                        ->where('product_id', $request->product_id)
                        ->first();

    // 4. Add or Update Cart Item
    if ($existingCart) {
        // If the product already exists, increment the quantity
        $existingCart->increment('quantity', $request->quantity);
        $cart = $existingCart;
    } else {
        // Otherwise, create a new cart item
        $cart = Cart::create([
            'user_id' => $userId ? $userId : null,
            'session_id' => $sessionId ?? null,
            'product_id' => $request->product_id,
            'quantity' => $request->quantity
        ]);
    }

    return response()->json([
        'message' => 'Item added to cart',
        'cart' => $cart  // You may want to adjust the payload here
    ], Response::HTTP_CREATED); 
}

    public function fetchCart(Request $request, $id)
    {
        //$sessionId = $request->session()->getId(); // Get session ID

        if (is_numeric($id)) {
            // If numeric, assume it's a user ID
            $cart = Cart::where('user_id', $id)->get();
        } else {
            // Otherwise, assume it's a session ID
            $cart = Cart::where('session_id', $id)->get();
        }

        // ... Format the data as needed ...

        return response()->json($cart);
    }
}
