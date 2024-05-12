<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class CSRFTokenController extends Controller
{
    public function getToken(Request $request)
    {
        $csrfToken = csrf_token();

        return response()->json([
            'csrf_token' => $csrfToken,
        ]);
    }
}

