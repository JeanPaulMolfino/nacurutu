<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class endpoints extends Controller
{
    public function get_dispositivos()
    {
		$data = json_encode(DB::select("Select d.id, d.identificador, d.actividad, d.ubicacion, td.categoria, d.ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as td where td.id = d.id_tipo"));
		return response($data, 200) ->header('Content-Type', 'application/json');
	}
	
	public function get_dispositivos_tipos()
    {
		$data = json_encode(DB::select("Select td.* from tipos_dispositivos as td"));
        return response($data, 200) ->header('Content-Type', 'application/json');
    }

	public function get_sensores()
    {
		$data = json_encode(DB::select("Select s.* from sensores as s"));
		return response($data, 200) ->header('Content-Type', 'application/json');
	}

	public function get_sensores_tipos()
    {
		$data = json_encode(DB::select("Select st.* from sensores_tipos as st"));
        return response($data, 200) ->header('Content-Type', 'application/json');
	}
	
    public function get_sensoresbydispositivo($id)
    {
        return json_encode(DB::select("Select s.* from dispositivos as d inner join tipos_dispositivos as td inner join sensores as s where td.id = d.id_tipo and td.id = s.id_tipo and d.identificador='".$id."'"), JSON_UNESCAPED_UNICODE);
    }

    public function get_medidasbydispositivo(Request $request, $iddispositivo, $idsensor, $finicio, $ffin){
        if($finicio != 'null' && $ffin != 'null'){
            //$finicio[10] = ' ';
            //$ffin[10] = ' ';
            return json_encode(DB::select("select m.lectura, m.tiempo from medidas as m inner join dispositivos as d where m.id_dispositivo=d.id and m.tiempo >='".$finicio."' and m.tiempo <= '".$ffin."' and m.id_sensor=".$idsensor." and d.identificador='".$iddispositivo."'"), JSON_UNESCAPED_UNICODE);
        }
        else if($finicio != 'null' && $ffin === 'null'){
            //$finicio[10] = ' ';
            return json_encode(DB::select("select m.lectura, m.tiempo from medidas as m inner join dispositivos as d where m.id_dispositivo=d.id and m.tiempo >='".$finicio."' and m.id_sensor=".$idsensor." and d.identificador='".$iddispositivo."'"), JSON_UNESCAPED_UNICODE);
        }
        else if($finicio === 'null' && $ffin != 'null'){
            //$ffin[10] = ' ';
            return json_encode(DB::select("select m.lectura, m.tiempo from medidas as m inner join dispositivos as d where m.id_dispositivo=d.id and m.tiempo <='".$ffin."' and m.id_sensor=".$idsensor." and d.identificador='".$iddispositivo."'"), JSON_UNESCAPED_UNICODE);
        } else {
            return json_encode(DB::select("select m.lectura, m.tiempo from medidas as m inner join dispositivos as d where m.id_dispositivo=d.id and m.id_sensor=".$idsensor." and d.identificador='".$iddispositivo."'"), JSON_UNESCAPED_UNICODE);
        }
        //return json_decode(DB::select("Select "));
    }
}
