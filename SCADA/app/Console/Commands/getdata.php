<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class getdata extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'get:devicedata';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Obtiene todos los datos de los dispositivos. /r/n A partir de su ultima lectura y estando activos';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        //Con esto pretendo que me traiga todos los id de dispositivos que tengan tareas pendientes en conjunto a su ultima medicion
        // o aquellos que ya halla excedido el tiempo de actualizacion desde que se les hizo update
        $dispositivos = DB::select('select d.id, d.ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as t where d.id_tipo = t.id and d.actividad = 1 and (DATE_ADD(d.ultima_actualizacion, INTERVAL t.updatetime MINUTE) < NOW())');

        //itero sobre cada uno de los dispositivos
        foreach ($dispositivos as $dispositivo) {

            //Obtengo la informacion nueva del $dispositivo
            $data = file_get_contents('http://alguna');

            //Si no es vacio
            if ($data != '') {
                $separator = "\r\n"; //Suponiendo que sea este el separador entre mediciones
                $lineas = explode($separator, $data); //lo divido en lineas o de cada lectura

                //Aquí voy a guardar la ultima fecha de los registros
                $ultimaactualizacion = "";

                //Por cada linea
                foreach($lineas as $linea){

                    //Separo cada lectura y su fecha
                    $datos = explode("; ", $linea);

                    //La cantidad de datos
                    $cantidad = count($datos);

                    //Y por cada dato
                    $index = 0;
                    while($index < $cantidad){
                        //Lo inserto en la base de datos
                        DB::insert('insert into medidas (tiempo, lectura, id_dispositivo, id_sensor) values (?, ?, ?, ?)', [$datos[0], $datos[$index+1], $dispositivo[0], $index+1]);
                        $index++;
                    }
                    //Voy sobre escribiendo la ultima actualizacion
                    $ultimaactualizacion = $datos[0];
                }

                //Una ves que termino de insertar todas, actualizo la fecha de su ultima lectura
                DB::update('update dispositivos set ultima_actualizacion = ? where id = ?', [$ultimaactualizacion, $dispositivo[0]]);
                
            }
        }

    }
}