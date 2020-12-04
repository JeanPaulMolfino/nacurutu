<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class endpoints extends Controller
{
    public function get_dispositivos()
    {
        return json_encode(DB::select("Select d.id, d.actividad, d.ubicacion, td.categoria, d.ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as td where td.id = d.id_tipo"));
    }

    public function get_sensoresbydispositivo($id)
    {
        return json_encode(DB::select("Select s.* from dispositivos as d inner join tipos_dispositivos as td inner join sensores as s where td.id = d.id_tipo and td.id = s.id_tipo and d.id=".$id), JSON_UNESCAPED_UNICODE);
    }
}
