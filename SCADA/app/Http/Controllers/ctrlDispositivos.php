<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ctrlDispositivos extends Controller
{
    public function get_dispositivobyid($id)
    {
		$data = json_encode(DB::select("Select d.id, d.actividad, d.ubicacion, td.categoria, d.ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as td where td.id = d.id_tipo and d.id=?", [$id]));
		return response($data, 200) ->header('Content-Type', 'application/json');
    }

    public function get_dispositivobyidentificador($identificador)
    {
		$data = json_encode(DB::select("Select d.id, d.actividad, d.ubicacion, td.categoria, d.ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as td where td.id = d.id_tipo and d.identificador=?", [$identificador]));
		return response($data, 200) ->header('Content-Type', 'application/json');
    }
    
    public function insert_dispositivo($ubicacion, $fecha_alta, $id_tipo, $marca, $modelo, $identificador)
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
