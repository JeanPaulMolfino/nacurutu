<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ctrlSensores extends Controller
{
    public function get_sensorbytipo($id_tipo)
    {
        $data = json_encode(DB::select("Select d.id_sensor_secundario as id, d.unidadmedida, d.grafica, d.nombre from dispositivos as d where d.id_tipo=?", [$id_tipo]), JSON_UNESCAPED_UNICODE);
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function insert_sensor($id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre)
    {
        DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, grafica, nombre) VALUES (?,?,?,?,?))", [$id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre]);
    }

    
    public function update_dispositivo($id, $id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre)
    {
        DB::update("update dispositivo set id_tipo = ?, id_sensor_secundario = ?, unidadmedida = ?, grafica = ?, nombre = ? where id = ?", [$id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre, $id]);
    }

    //ToDo unnecessary
    /*public function baja_sensor($identificador)
    {
        DB::update("update dispositivos set actividad = '0' where identificador = ?", [$identificador]);
    }*/
}
