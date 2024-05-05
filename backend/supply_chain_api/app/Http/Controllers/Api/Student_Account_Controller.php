<?php

namespace App\Http\Controllers\Api;

use App\Models\Student_Accounts;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Validator;

class Student_Account_Controller extends Controller
{
    public function index_accounts(){
        $students = Student_Accounts::all();
        if ($students->count()>0){
            return response()->json([
                'status'=> 200,
                'student_accounts' => $students 
            ],200);
        }
        else{
            return response()->json([
                'status'=> 404,
                'message' => 'No records' 
            ],404);
        }
       
        
    }
    public function store_accounts(Request $request){
        $validator = Validator::make($request->all(),[
            'uname'=> 'required|string|max:191',
            'password'=> 'required|string|min:6',
        ]); 
        if ($validator->fails()){
            return response()->json([
                'status'=> 422,
                'error'=> $validator->messages()
            ],422);
        }
        else{
            $student = Student_Accounts::create([
                'uname'=> $request->uname,
                'password'=> $request->password,
            ]);

            if ($student){
                return response ()->json([
                    'status'=> 200,
                    'message'=> "Student Account Created Successfully"
                ],200);
            }
            else {
                return response ()->json([
                    'status'=> 500,
                    'message'=> "Student Account Created Unsuccessfully"
                ],500);
            }
        }
    }
}
