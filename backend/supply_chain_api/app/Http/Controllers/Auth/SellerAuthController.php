<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Seller;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class SellerAuthController extends Controller
{
    public function login(Request $request)
    {
        // 1. Validate credentials
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        // 2. Find Seller
        $seller = Seller::where('email', $request->email)->first();
        if (!$seller || $seller->password !== $request->password) {  
            throw ValidationException::withMessages([
                'email' => ['The provided credentials are incorrect.'],
            ]);
        }
        
        $token = $seller->createToken('seller_auth_token')->plainTextToken;

        return response()->json([
            'seller' => $seller,
            'access_token' => $token,
            'token_type' => 'Bearer',
        ]);
    }
}
