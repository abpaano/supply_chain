<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\Inventory; 
use Illuminate\Support\Facades\DB; 

class InventoryController extends Controller
{
    public function getQuantityByProductId($product_id): JsonResponse
    {
        $inventory = Inventory::where('product_id', $product_id)
                      ->select('quantity')
                      ->first();

        if (!$inventory) {
            return response()->json([
                'message' => 'Inventory not found for this product.'
            ], 404); 
        }

        return response()->json([
            'quantity' => $inventory->quantity
        ]);
    }
    public function getQuantities(Request $request): JsonResponse
{
    $productIds = explode(',', $request->query('product_ids'));

    // Fetch quantities
    $quantities = DB::table('inventory') 
                    ->whereIn('product_id', $productIds)
                    ->select('product_id', 'quantity')
                    ->get()
                    ->keyBy('product_id'); // Create a map keyed by product_id

    // Format response
    $response = [];
    foreach ($productIds as $productId) {
        $response[$productId] = $quantities->get($productId)?->quantity ?? 0; // Handle missing quantities
    }

    return response()->json($response);
}
}
