<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Configs\configController;

class DummyDeviceController extends Controller
{
	//public string $eol = "\n\r";
	//public string $end = "; ";

	/**
		https://stackoverflow.com/questions/38107085/laravel-5-how-to-use-get-parameter-from-url-with-controllers-sign-in-method
			?ID_DEV=EM1234&oh=iop
			?oh=iop&ID_DEV=EM1234  ?comienzop del query, & los siguientes params van con ampersand
		PHP's random function allows you to only use integer limits, but you can then divide the resulting random number by 10.
		rand(12, 57) / 10
	**/
	public function index(Request $request){

		//$eol = "\n\r";
		//$end = "; ";

		/**
			Devuelve un random entre dos valores, el tercero sirve para generar con decimales si >1 y multiplo de 10.
			Cada 0 en el multiplo de 10 establece un decimal extra.
			@TODO: no se controla que $tenthOrder sea multiplo de 10!!!
		 **/
		function randCustom(int $min, int $max, int $tenthOrder){
			$rand = rand($min*$tenthOrder, $max*$tenthOrder);
			if($rand != 0){
				//return "INVALID min max in randCustom().";
				$rand = $rand / $tenthOrder;
			}

		 	return $rand;
		}

		function generateTimeStamp(){
			
			// mktime(hour, minute, second, month, day, year) 
			//$date = mktime(11, 14, 54, 8, 12, 2014);
			date_default_timezone_set("America/Montevideo"); 
			//$date = time();
			//$date = microtime();

			//date(formato, segundosDesde1970)

			//echo "Created date is " . date("Y-m-dd-h-i-sa", $date);
			//echo "Created date is " . date("Y-m-dd-h-i-sa");

			$randSecond = "";
			$randSecond = randCustom(0, 60, 1);
			//return date("Y-m-d-h-i-s");
			if(strlen($randSecond) <2){
				$randSecond = "0".$randSecond;
			}
			return date("Y-m-d-h-i-").$randSecond ;
		}

		function generateMeteoLine(int $someKindOfIndex){

			$eol = "\r\n";
			$end = "; ";
			$return = "";

			if($someKindOfIndex ===0){
				return "TIMESTAMP[YYYY-MM-DD-HH-mm-ss]; T_amb[ ºC]; T_int[ºC]; Humedad[%]; Pres_atm[HPa]; Irrad_solar[ W/m^2]; Irrad_UV[W/m^2]; Vel_viento[m/s]; Dir_viento[Grados, respecto al Norte];Ind_pluvio [mm / m^2]".$eol;
			}
			//2020-12-02-10-16-07; 6; 47; 80; 007; 095; 072; 709; 2; 0.6166

			$TIMESTAMP = generateTimeStamp();
			$T_amb = randCustom(-5, 50, 1);
			$T_int = randCustom(15, 60, 1);
			$Humedad = randCustom(50, 99, 1);
			$Pres_atm = randCustom(900, 1400, 100); 
			$Irrad_solar = randCustom(0, 2, 100); 
			$Irrad_UV = randCustom(0, 1, 100); 
			$Vel_viento = randCustom(5, 20, 100);
	
			$Dir_viento = randCustom(0, 360, 1);
			$Ind_pluvio = randCustom(0, 1, 10000);

			$return = $TIMESTAMP.$end.$T_amb.$end.$T_int.$end.$Humedad.$end.$Pres_atm.$end.$Irrad_solar.$end.$Irrad_UV.$end.$Vel_viento.$end.$Dir_viento.$end.$Ind_pluvio.$eol;
		 	return $return;
		}

		$req_devID;
		$req_mode;
		$req_timestamp;
		

		$req_devID = $request->query('ID_DEV');
		$req_mode = $request->query('MODE');

		if(!$req_devID || !$req_mode){
			return "INVALID REQUEST: ID_DEV and MODE needed.";
		}
		if($req_mode === 'SINCE'){
			$req_timestamp = $request->query('T');
			if(!$req_timestamp){
				return "INVALID REQUEST: T needed.";
			}
		}

		$data = "";
		for ($i = 0; $i <= 20; $i++) {
			$data = $data.generateMeteoLine($i);
		}

		return response($data, 200) ->header('Content-Type', 'text/plain');
	}
}
