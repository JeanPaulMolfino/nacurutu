<?php

use App\Http\Controllers\API;
use App\Http\Controllers\devtestController;
use App\Http\Controllers\DummyDeviceController;
use App\Http\Controllers\endpoints;
use App\Http\Controllers\ctrlDispositivos;
use Illuminate\Support\Facades\Route;

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

Route::get('chart1Data', [API::class, "chartData"]);
Route::get('chart1Plot', function () {
    return view('chart1Plot');
});

Route::get('dummyDevice', [DummyDeviceController::class, "index"]);

Route::get('endpoints/get:dispositivos', [endpoints::class, "get_dispositivos"]);
Route::get('endpoints/get:dispositivos_tipos', [endpoints::class, "get_dispositivos_tipos"]);
Route::get('endpoints/get:sensores', [endpoints::class, "get_sensores"]);
///Route::get('endpoints/get:sensores_tipos', [endpoints::class, "get_sensores_tipos"]);

Route::get('endpoints/get:sensoresbydispositivo/{id}', [endpoints::class, "get_sensoresbydispositivo"]);
Route::get('endpoints/get:medidasbydispositivo/{iddispositivo}/{idsensor}/{finicio}/{ffin}', [endpoints::class, "get_medidasbydispositivo"]);


Route::post('dispositivos/post:insert_dispositivo/{ubicacion}/{fecha_alta}/{id_tipo}/{marca}/{modelo}/{identificador}', [ctrlDispositivos::class, "insert_dispositivo"]);
Route::put('dispositivos/put:baja_dispositivo/{identificador}', [ctrlDispositivos::class, "baja_dispositivo"]);
Route::put('dispositivos/put:alta_dispositivo/{identificador}', [ctrlDispositivos::class, "alta_dispositivo"]);
