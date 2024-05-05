<?php

namespace App\Http\Controllers;

use App\Models\Location;
use Illuminate\Http\JsonResponse; // Import Response class

class LocationController extends Controller
{
    public function getLocations(): JsonResponse
    {
        $locations = Location::all(['latitude', 'longitude']);
        return response()->json($locations);
    }
} 
