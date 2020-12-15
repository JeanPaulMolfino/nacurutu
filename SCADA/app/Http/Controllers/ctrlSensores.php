<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

class ctrlSensores extends Controller
{
    public function get_sensorbytipo($id_tipo)
    {
        $data = json_encode(DB::select("Select d.id_sensor_secundario as id, d.unidadmedida, d.grafica, d.nombre from dispositivos as d where d.id_tipo=?", [$id_tipo]), JSON_UNESCAPED_UNICODE);
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function insert_sensor($id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre, $min, $max)
    {
        //DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, grafica, nombre) VALUES (?,?,?,?,?))", [$id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre]);
        if ($min != "null" && $max == "null") {
            DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, grafica, nombre, min) VALUES (?,?,?,?,?,?))", [$id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre, $min]);
        } else if ($min == "null" && $max != "null") {
            DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, grafica, nombre, max) VALUES (?,?,?,?,?,?))", [$id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre, $max]);
        } else {
            DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, grafica, nombre, min, max) VALUES (?,?,?,?,?,?,?))", [$id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre, $min, $max]);
        }

    }

    public function update_sensor($id, $id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre, $min, $max)
    {
        if ($min == "null") {
            $min = null;
        }
        if ($max == "null") {
            $max = null;
        }
        DB::update("update sensores set id_tipo = ?, id_sensor_secundario = ?, unidadmedida = ?, grafica = ?, nombre = ?, min=?, max=? where id = ?", [$id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre, $min, $max, $id]);
    }

    //ToDo unnecessary
    /*public function baja_sensor($identificador)
{
DB::update("update dispositivos set actividad = '0' where identificador = ?", [$identificador]);
}*/
}
