<?php
namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use App\Models\Inventory; 

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
}
