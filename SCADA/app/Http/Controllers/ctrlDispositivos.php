<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;

class ctrlDispositivos extends Controller
{
    public function get_dispositivobyid($id)
    {
        $data = json_encode(DB::select("Select d.id, d.actividad, d.ubicacion, td.categoria, d.ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as td where td.id = d.id_tipo and d.id=?", [$id]));
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function get_dispositivobyidentificador($identificador)
    {
        $data = json_encode(DB::select("Select d.id, d.actividad, d.ubicacion, td.categoria, d.ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as td where td.id = d.id_tipo and d.identificador=?", [$identificador]));
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function get_ultima_actualizacionbyidentificador($identificador)
    {
        $data = json_encode(DB::select("Select d.ultima_actualizacion from dispositivos where d.identificador=?", [$identificador]));
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function get_latestmedidasbydispositivo($identificador)
    {
        $max_date = DB::select("select max(m.tiempo) as tiempo from medidas as m inner join dispositivos as d where m.id_dispositivo = d.id and d.identificador = ?", [$identificador])[0]->tiempo;
        $data = json_encode(DB::select("select m.lectura, s.nombre, s.unidadmedida from dispositivos as d inner join medidas as m inner join sensores as s inner join tipos_dispositivos as tp where d.id = m.id_dispositivo and m.id_sensor = s.id_sensor_secundario and s.id_tipo = tp.id and d.identificador = ? and m.tiempo = ?", [$identificador, $max_date]), JSON_UNESCAPED_UNICODE);
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function insert_dispositivo(Request $request, $ubicacion, $fecha_alta, $id_tipo, $marca, $modelo, $identificador)
    {
        DB::insert("insert into dispositivos (actividad, ubicacion, fecha_alta, id_tipo, marca, modelo, ultima_actualizacion, identificador) values ('1', ?, ?, ?, ?, ?, '1900-01-01 00:00:00', ?)", [$ubicacion, $fecha_alta, $id_tipo, $marca, $modelo, $identificador]);
    }

    public function update_dispositivo($id, $ubicacion, $id_tipo, $marca, $modelo, $identificador)
    {
        DB::update("update dispositivos set ubicacion = ?, id_tipo = ?, marca = ?, modelo = ?, identificador = ? where id = ?", [$ubicacion, $id_tipo, $marca, $modelo, $identificador, $id]);
    }

    public function baja_dispositivo($identificador)
    {
        DB::update("update dispositivos set actividad = '0' where identificador = ?", [$identificador]);
    }

    public function alta_dispositivo($identificador)
    {
        DB::update("update dispositivos set actividad = '1' where identificador = ?", [$identificador]);
    }
}
