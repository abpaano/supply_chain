<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use App\Models\Store;

class StoreController extends Controller
{
    public function getProductsByStore($storeId)
     {
         // 1. Fetch Products (Adapt as needed)
         $products = Product::where('store_id', $storeId) // Assuming 'store_id' column 
                            ->get(); 

         // 2. Return JSON Response
         return response()->json($products);
     }
     public function show($storeId)
     {
         $store = Store::findOrFail($storeId); 
         return response()->json($store); 
     }
     public function showMultiple(Request $request)
{
    $storeIds = explode(',', $request->input('ids')); 

    // Fetch stores with products (using eager loading)
    $stores = Store::whereIn('id', $storeIds)
                   ->with('products') // Load the associated products
                   ->get();

    return response()->json($stores); 
}
}
