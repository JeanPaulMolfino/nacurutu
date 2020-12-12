<?php

use App\Http\Controllers\API;
use App\Http\Controllers\ctrlDispositivos;
use App\Http\Controllers\ctrlSensores;
use App\Http\Controllers\ctrlTiposDispositivos;
use App\Http\Controllers\devtestController;
use App\Http\Controllers\DummyDeviceController;
use App\Http\Controllers\endpoints;
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

Route::get('testvue', function () {
    return view('testvue');
});

Route::get('dummyDevice', [DummyDeviceController::class, "index"]);

Route::get('endpoints/get:dispositivos', [endpoints::class, "get_dispositivos"]);
Route::get('endpoints/get:dispositivos_tipos', [endpoints::class, "get_dispositivos_tipos"]);
Route::get('endpoints/get:sensores', [endpoints::class, "get_sensores"]);
///Route::get('endpoints/get:sensores_tipos', [endpoints::class, "get_sensores_tipos"]);

Route::get('endpoints/get:sensoresbydispositivo/{id}', [endpoints::class, "get_sensoresbydispositivo"]);
Route::get('endpoints/get:medidasbydispositivo/{iddispositivo}/{idsensor}/{finicio}/{ffin}', [endpoints::class, "get_medidasbydispositivo"]);

Route::get('dispositivos/get:get_dispositivobyid/{id}', [ctrlDispositivos::class, "get_dispositivobyid"]);
Route::get('dispositivos/get:get_dispositivobyidentificador/{identificador}', [ctrlDispositivos::class, "get_dispositivobyidentificador"]);
Route::get('dispositivos/get:get_latestmedidasbydispositivo/{identificador}', [ctrlDispositivos::class, "get_latestmedidasbydispositivo"]);
Route::get('dispositivos/get:get_ultima_actualizacionbyidentificador/{identificador}', [ctrlDispositivos::class, "get_ultima_actualizacionbyidentificador"]);
Route::post('dispositivos/post:insert_dispositivo/{ubicacion}/{fecha_alta}/{id_tipo}/{marca}/{modelo}/{identificador}', [ctrlDispositivos::class, "insert_dispositivo"]);
Route::put('dispositivos/put:update_dispositivo/{ubicacion}/{id_tipo}/{marca}/{modelo}/{identificador}', [ctrlDispositivos::class, "update_dispositivo"]);
Route::put('dispositivos/put:baja_dispositivo/{identificador}', [ctrlDispositivos::class, "baja_dispositivo"]);
Route::put('dispositivos/put:alta_dispositivo/{identificador}', [ctrlDispositivos::class, "alta_dispositivo"]);

Route::get('tiposdispositivos/get:get_tiposdispositivos/', [ctrlTiposDispositivos::class, "list_tiposdispositivos"]);
Route::get('tiposdispositivos/get:get_tipodispositivobyid/{id}', [ctrlTiposDispositivos::class, "get_tipodispositivobyid"]);
Route::post('tiposdispositivos/post:insert_tipodispositivo/{updatetime}/{categoria}/{proposito}', [ctrlTiposDispositivos::class, "insert_tipodispositivo"]);
Route::put('tiposdispositivos/put:update_tipodispositivo/{id}/{updatetime}/{categoria}/{proposito}', [ctrlTiposDispositivos::class, "update_tipodispositivo"]);

Route::get('sensores/get:get_sensoresbytipo/{id_tipo}', [ctrlSensores::class, "get_sensorbytipo"]);
Route::post('sensores/post:insert_sensores/{id_tipo}/{id_sensor_secundario}/{unidadmedida}/{grafica}/{nombre}', [ctrlSensores::class, "insert_sensor"]);
Route::put('sensores/put:update_sensores/{id}/{id_tipo}/{id_sensor_secundario}/{unidadmedida}/{grafica}/{nombre}', [ctrlSensores::class, "update_sensor"]);
