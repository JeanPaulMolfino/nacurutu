<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class ctrlSensores extends Controller
{
    public function get_sensorbytipo($id_tipo)
    {
        $data = json_encode(DB::select("select id, id_tipo, id_sensor_secundario, unidadmedida, nombre, min, max, id_grafica FROM sensores WHERE id_tipo =?", [$id_tipo]), JSON_UNESCAPED_UNICODE);
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function insert_sensor($id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre, $min, $max)
    {
        //DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, grafica, nombre) VALUES (?,?,?,?,?))", [$id_tipo, $id_sensor_secundario, $unidadmedida, $grafica, $nombre]);
        if ($min != "null" && $max == "null") {
            DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, id_grafica, nombre, min) VALUES (?, ?, '".$unidadmedida."', ?, '".$nombre."', ?)", [$id_tipo, $id_sensor_secundario, $grafica, $min]);
        } else if ($min == "null" && $max != "null") {
            DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, id_grafica, nombre, max) VALUES (?, ?, '".$unidadmedida."', ?, '".$nombre."', ?)", [$id_tipo, $id_sensor_secundario, $grafica, $max]);
        } else if($min == "null" && $max == "null"){
            DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, id_grafica, nombre) VALUES (?, ?, '".$unidadmedida."', ?, '".$nombre."')", [$id_tipo, $id_sensor_secundario, $grafica]);
        }else {
            DB::insert("insert into sensores (id_tipo, id_sensor_secundario, unidadmedida, id_grafica, nombre, min, max) VALUES (?, ?, '".$unidadmedida."', ?, '".$nombre."', ?, ?)", [$id_tipo, $id_sensor_secundario, $grafica, $min, $max]);
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
        DB::update("update sensores set id_tipo = ?, id_sensor_secundario = ?, unidadmedida = '".$unidadmedida."', id_grafica = ?, nombre = '".$nombre."', min=?, max=? where id = ?", [$id_tipo, $id_sensor_secundario, $grafica, $min, $max, $id]);
    }

    public function get_sensores_alerta()
    {
        $data = json_encode(DB::select("select d.identificador, td.categoria, s.nombre ,s.min, s.max, m.lectura from sensores as s inner join medidas as m inner join dispositivos as d inner join tipos_dispositivos as td where s.id = m.id_sensor and m.id_dispositivo = d.id and td.id = d.id_tipo and m.tiempo = (select max(mm.tiempo) from medidas as mm WHERE mm.id_dispositivo = d.id) and (m.lectura > s.max or m.lectura < s.min)"), JSON_UNESCAPED_UNICODE);
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function get_graficas()
    {
        $data = json_encode(DB::select("select * from graficas"), JSON_UNESCAPED_UNICODE);
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    //ToDo unnecessary
    /*public function baja_sensor($identificador)
{
DB::update("update dispositivos set actividad = '0' where identificador = ?", [$identificador]);
}*/
}
