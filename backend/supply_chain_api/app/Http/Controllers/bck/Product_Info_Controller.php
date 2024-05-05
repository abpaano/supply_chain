<?php

namespace App\Http\Controllers\Api;

use App\Models\Product_Info;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

class Product_Info_Controller extends Controller
{
    public function product_info(){
        $product = Product_Info::all();
        if ($product->count()>0){
            return response()->json([
                'status'=> 200,
                'tbl_supply_chain' => $product 
            ],200);
        }
        else{
            return response()->json([
                'status'=> 404,
                'message' => 'No records' 
            ],404);
        }
       
        
    }
    public function store_product(Request $request){
        $validator = Validator::make($request->all(),[
            'product_name'=> 'required|string|max:191',
            'category'=> 'required|string|max:191',
            'quantity'=> 'numeric',
            'price'=> 'numeric',
            'unit'=> 'required|string|max:191',
            'produced_from'=> 'required|string|max:191',
            'description'=> 'required|string|max:191',
        ]); 
        if ($validator->fails()){
            return response()->json([
                'status'=> 422,
                'error'=> $validator->messages()
            ],422);
        }
        else{
            $student = Product_Info::create([
                'product_name'=> $request->product_name,
                'category'=> $request->category,
                'quantity'=> $request->quantity,
                'price'=> $request->price,
                'unit'=> $request->unit,
                'produced_from'=> $request->produced_from,
                'description'=> $request->description,
            ]);

            if ($student){
                return response ()->json([
                    'status'=> 200,
                    'message'=> "Product Added Successfully"
                ],200);
            }
            else {
                return response ()->json([
                    'status'=> 500,
                    'message'=> "Unsuccessfull Entry"
                ],500);
            }
        }
    }
}
