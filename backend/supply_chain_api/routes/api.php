<?php

use App\Http\Controllers\API\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\InventoryController;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\StoreController;
use App\Http\Controllers\ProductRatingController;
use App\Http\Controllers\StoreRatingController;
use App\Http\Controllers\ConsumerController;
use App\Http\Controllers\CartController;
use App\Http\Controllers\CSRFTokenController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

// Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
//     return $request->user();
// });



/*Route::post('/sanctum/token', [AuthController::class, 'login']);
Route::post('/register', [AuthController::class, 'register']);

Route::middleware(['auth:sanctum'])->group(function () {
    Route::get('/logut', [AuthController::class, 'logout']);
});*/

Route::get('/search', [ProductController::class, 'search']);
Route::get('/products', [ProductController::class, 'index']);
Route::get('/stores/{storeId}/products', [StoreController::class, 'getProductsByStore']);
Route::get('/stores/{storeId}', [StoreController::class, 'show']);
Route::get('/inventory/quantity/{product_id}', [InventoryController::class, 'getQuantityByProductId']); 
Route::get('/reviews/{product}', [ProductRatingController:: class, 'getProductRating']);
Route::get('/store_reviews/{store}', [StoreRatingController::class, 'getStoreRating']);
Route::get('/consumers/{reviewId}', [ConsumerController::class, 'getConsumerByReview']); 
Route::get('/category/{productId}', [ProductController::class, 'getCategoryByProduct']); 
Route::get('/category/{categoryId}/products', [ProductController::class, 'getProductsByCategory']);
Route::get('/products/{id}', [ProductController::class, 'show']); 
Route::post('/cart/add', [CartController::class, 'addToCart']);
Route::get('/cart', [CartController::class, 'fetchCart']);
Route::get('/csrf-token', [CSRFTokenController::class, 'getToken']);
Route::get('/products', [ProductController::class, 'showMultiple']);
Route::get('/stores', [StoreController::class, 'showMultiple']); 
Route::get('/inventory/quantity', [InventoryController::class, 'getQuantities']);
Route::get('/reviews', [ProductRatingController::class, 'getRatings']);



//Route::get('students',[StudentController::class, 'index']);
//Route::post('students',[StudentController::class, 'store']);

//Route::post('students_accounts',[Student_Account_Controller::class, 'store_accounts']);
//Route::get('students_accounts',[Student_Account_Controller::class, 'index_accounts']);

//Route::post('tbl_supply_chain',[Product_Info_Controller::class, 'store_product']);
//Route::get('tbl_supply_chain',[Product_Info_Controller::class, 'product_info']);
/*Route::get('students', function(){
return 'this is student api';
 });*/
