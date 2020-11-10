<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\devtestController;
use App\Http\Controllers\API;
/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('testvue', function () {
    return view('testvue');
});

Route::get('test', [devtestController::class, "index"]);
Route::get('post', [API::class, "testrequest"]);
Route::get('writeJSON', [API::class, "writeJSON"]);
Route::get('readJSON', [API::class, "readJSON"]);