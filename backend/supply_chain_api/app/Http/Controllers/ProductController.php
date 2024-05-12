<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;
use App\Models\Product;

class ProductController extends Controller
{
    public function search(Request $request)
    {
        $searchTerm = $request->query('search');

        $productsQuery = Product::query()
            ->where('name', 'LIKE', "%{$searchTerm}%");

        $products = $productsQuery->with('store')->paginate(15);

        return response()->json($products);
    }
    public function getCategoryByProduct($productId)
    {
        $product = Product::with('categories')->find($productId); 

        if (!$product) {
            return response()->json(['error' => 'Product not found'], 404);
        }

        // Fetch the categories
        $categories = $product->categories;

        // Tailor the response as needed
        return response()->json($categories, 200); 
    }

    public function getProductsByCategory($categoryId)
    {
        $products = Category::find($categoryId)
                            ->products()
                            ->paginate(15); // Assuming you want pagination

        if (!$products) { // Or a more specific check if the category exists
            return response()->json(['error' => 'Products not found for this category'], 404);
        }

        return response()->json($products);
    }

    public function index()
    {
        $products = Product::with('store')->paginate(15); // Assuming you want pagination 
        return response()->json($products);
    }
    public function show($id) 
    {
        $product = Product::findOrFail($id); 
        return response()->json($product); 
    }
    public function showMultiple(Request $request)
{
    $ids = explode(',', $request->input('ids')); // Get IDs from the query string

    $products = Product::whereIn('id', $ids)->get(); 

    return response()->json($products); 
}
}
