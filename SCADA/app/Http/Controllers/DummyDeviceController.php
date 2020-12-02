<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Configs\configController;

class DummyDeviceController extends Controller
{
	/**
		https://stackoverflow.com/questions/38107085/laravel-5-how-to-use-get-parameter-from-url-with-controllers-sign-in-method
			?ID_DEV=EM1234&oh=iop
			?oh=iop&ID_DEV=EM1234  ?comienzop del query, & los siguientes params van con ampersand
		PHP's random function allows you to only use integer limits, but you can then divide the resulting random number by 10.
		rand(12, 57) / 10
	**/

	

    public function index(Request $request){

		function randCustom(int $min, int $max, int $tenthOrder){
			return rand($min*$tenthOrder, $max*$tenthOrder) / $tenthOrder;
		}
		
		$req_devID;
		$req_mode;
		$req_timestamp;

		$req_devID = $request->query('ID_DEV');
		$req_mode = $request->query('MODE');

		if(!$req_devID || !$req_mode){
			return "INVALID REQUEST: ID_DEV and MODE needed";
		}
		if($req_mode === 'SINCE'){
			$req_timestamp = $request->query('T');
			if(!$req_timestamp){
				return "INVALID REQUEST: T needed";
			}
		}

		//$url = $request->fullUrl();
		//request()->has('r')
		//$data = 'DummyDeviceController';
		//$data = $data.'[2020-12-01-23-59-59]; [26]; [30]; [98]; [1200]; Irrad_solar[ 1000]; [50]; [20]; [120];Ind_pluvio [mm / m^2]';
		//$data = $req_devID; //.$url.$data;
		//$data = $data;
		$data = '[2020-12-01-23-59-59]; [26]; [30]; [98]; [1200]; Irrad_solar[ 1000]; [50]; [20]; [120];Ind_pluvio [mm / m^2]';
		//ID_DEV=EM1234&MODE=SINCE&T=2020-10-18-20-30-04
		return strval(randCustom(1200, 1300, 1));
		return response($data, 200) ->header('Content-Type', 'text/plain');

	}

	
	/**
	 * 
	 El mecanismo de operación de la Estación Meteorológica (EM), es el siguinte:

* El período de tiempo de envío de datos es configurable y por defecto establecido como mínimo en 10 minutos, para cumplir
 con las especificaciones estándares internacionales en materia de muestreo de datos meteorológicos.

* La estación puede consolidar datos "diez minutales" almacenarlos localmente y reportar transcurrido un período
 de reconexión. Por defecto se ha establecido el mismo en 30 minutos, de modo que en cada reconexión se transmiten 3 juegos de datos o grupos de muestras.

* Cada estación u otro elemento que reporte datos es identificado con una cadena ID_DISPOSITIVO, que es única dentro de la
 red de elementos que reportan datos y que serán asignados a criterio de quien administre la red de información.

* La estación se conecta a un servidor web, usando protocolos HTTP/HTTPS, donde haciendo un POST transmite la información mencionada.
Del lado del servidor, un servicio se encarga de recibir los datos, que serán almacenados en un directorio común DATA/IN donde el
 archivo se genera con un nombre que sigue la siguiente estructura:

ID_DISPOSITIVO--YYYY-MM-DD-HH-mm-ss.txt

* Dentro de cada archivo se encontrará siempre la siguiente descripción:
1) La primera línea contiene el nombre de los campos y unidades utilizadas
En general, siempre deberían ser las mismas unidades, pero esto actúa como elemento contralor de chequeo. 
Por ejemplo, para asegurar que la temperatura siempre viene en Celsius, si cambiara a Farenheit, podría ser detectado y reportado el cambio como posible error.

TIMESTAMP[YYYY-MM-DD-HH-mm-ss]; T_amb[ ºC]; T_int[ºC]; Humedad[%]; Pres_atm[HPa]; Irrad_solar[ W/m^2]; Irrad_UV[W/m^2]; Vel_viento[m/s]; Dir_viento[Grados, respecto al Norte];Ind_pluvio [mm / m^2]

Los valores decimales utilizan el "punto", como separador decimal,, ej: 3.1416
Recordar: 1 atmósfera [atm] =   1 013,25 Hectopascal [hPa]

2) Las siguientes líneas contienen la información propiamente

Ejemplo de registro de datos:

2020-10-18-20-30-04; 14; 15; 63; 1016.82;  0.02; 0.00; 12.43; 37; 0.0031

* Cada vez que el servicio web consume los datos, éstos son depositados en un archivo que corresponde al registro del mes en curso,
 por ejemplo, en este caso estarán agregándose las líneas en:

DATA/REC/ID_DISPOSITIVO--YYYY-MM.txt

* Cuando este paso se ha concretado, el servicio web, mueve el archivo procesado a la ruta:

DATA/LOG/YYYY-MM/

* Para recabar datos de manera segura, se ha desarrollado un servicio al que se le solicitan los datos, que son devueltos en el formato especificado.
La ventaja sobre la lectura directa, es que el servicio resuelve posibles problemas de concurrencia.

data-request.php?ID_DEV=....&MODE=

El parámetro ID_DEV refiere al identificador de dispositivo.
Mientras que MODE establece el volumen de información a transmitir:
	ALL: Trae todo el registro histórico disponible
	YEAR: Retorna todos los registros del año en curso
	MONTH: Hace lo propio con los registros del mes
	DAY: Devuelve todos los registros del dia en curso
	SINCE: Indica que se le pasará otro parámetro, donde se especifica el instante a partir del cual debe enviar los registros posteriores.
		Especificando entonces un TIMESTAMP.
Ejemplo: data-request.php?ID_DEV=EM1234&MODE=SINCE&T=2020-10-18-20-30-04

	 **/
/*
    public function testrequest(Request $request){
        return "";
    }
    public function writeJSON(Request $request){
        $a = new configController;
        $a->writeConfig();
        return "DONE";
    }

    public function readJSON(Request $request){
        $a = new configController;
        return $a->readConfig();
    }

    public function chartData(Request $request){
        $data = '{
            "chart": { "labels": ["First", "Second", "Third"] },
            "datasets": [
                { "name": "Sample 1", "values": [10, 3, 7] },
                { "name": "Sample 2", "values": [1, 6, 2] }
            ]
        }';

        //return response(json_encode($data), 200) ->header('Content-Type', 'application/json');
        return response($data, 200) ->header('Content-Type', 'application/json');


        //$a = new configController;
       // return $a->readConfig();

                //Content-Type: application/json; charset=utf-8 json_encode($data);
    }
*/


}
