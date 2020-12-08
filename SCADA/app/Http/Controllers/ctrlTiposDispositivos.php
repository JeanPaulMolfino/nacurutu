<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;

class ctrlTiposDispositivos extends Controller
{
    public function list_tiposdispositivos()
    {
        $data = json_encode(DB::select("Select * from TiposDispositivos"));
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function get_tipodispositivobyid($id)
    {
        $data = json_encode(DB::select("Select * from TiposDispositivos where id=?", [$id]));
        return response($data, 200)->header('Content-Type', 'application/json');
    }

    public function insert_tipodispositivo($updatetime, $categoria, $proposito)
    {
        DB::insert("insert into tipos_dispositivos (updatetime, categoria, proposito) VALUES (?, ?, ?)", [$updatetime, $categoria, $proposito]);
    }

    public function update_tipodispositivo($id, $updatetime, $categoria, $proposito)
    {
        DB::insert("update tipos_dispositivos set updatetime = ?, categoria = ?, proposito = ? where id = ?", [$updatetime, $categoria, $proposito, $id]);
    }
}
