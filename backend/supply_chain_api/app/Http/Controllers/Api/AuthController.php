<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Consumer;
use Illuminate\Support\Facades\Hash; 


class AuthController extends Controller
{
    public function login(Request $request)
    {
        return [
            "name" => $request->name
        ];
    }

    public function logout()
    {
    }

    public function register(Request $request)
   {
       // 1. Basic Validation (add more as needed)
       $request->validate([
           'name' => 'required', 
           'email' => 'required',
           'password' => 'required',
       ]);

       // 2. Hash the password
       //$hashedPassword = Hash::make($request->password);

       // 3. Create User (adjust based on your User model and role management)
       $user = Consumer::create([
           'name' => $request->name,
           'email' => $request->email,
           'password' => $request->password,
           // ... (Set the user role if required) ...

           /*$user = Consumer::create([
            'name' => 'Test User',
            'email' => 'test@test.com',
            'password' => 'testpassword' // (Don't do this in production!)*/
        ]);

       // 4. Generate Sanctum Token
       $token = $user->createToken('auth_token')->plainTextToken;

       // 5. Success Response
       return response()->json([
           'access_token' => $token,
           'user' => $user, 
       ]); 
   }
}
