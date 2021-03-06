<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class getdataReptilario extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'getdataReptilario';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

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
        $id_tipo = DB::select("select * from tipos_dispositivos where categoria='Reptilario'")[0]->id;
        $dispositivos = DB::select("select d.id, d.identificador, d.id_tipo,DATE_FORMAT(d.ultima_actualizacion,'%Y-%m-%d-%H-%i-%S') as ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as t where d.id_tipo = t.id and d.actividad = 1 and (DATE_ADD(d.ultima_actualizacion, INTERVAL t.updatetime MINUTE) < NOW() and t.categoria = 'Reptilario')");
        $sensores = DB::select("select * from sensores as s where s.id_tipo = ? and s.nombre = ?", [$id_tipo, "Humedad del ambiente"]);
        $fecha = date("Y-m-d H:i:s");
        var_dump($id_tipo);
        var_dump($sensores);
        foreach ($dispositivos as $dispositivo) {
            var_dump($dispositivo);
            
            //Humedad del ambiente 65 a 75%
            DB::insert("insert into medidas (tiempo, lectura, id_dispositivo, id_sensor) values (?, ?, ?, ?)", [$fecha, rand (65,75), $dispositivo->id, $sensores[0]->id_sensor_secundario]);
            DB::update('update dispositivos set ultima_actualizacion = ? where id = ?', [$fecha, $dispositivo->id]);
        }
        return 0;
    }
}
