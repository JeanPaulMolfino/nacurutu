<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class getdataReptilarioBad extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'command:name';

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
        $id_tipo = DB::select("select * from tipos_dispositivos where categoria='Reptilario'");
        $dispositivos = DB::select("select d.id, d.identificador, d.id_tipo,DATE_FORMAT(d.ultima_actualizacion,'%Y-%m-%d-%H-%i-%S') as ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as t where d.id_tipo = t.id and d.actividad = 1 and (DATE_ADD(d.ultima_actualizacion, INTERVAL t.updatetime MINUTE) < NOW() and t.categoria = 'Reptilario')");
        $sensores = DB::select("select * from sensores as s inner join where id_tipo = ? and nombre = '?'", [$id_tipo, "Humedad del ambiente"]);
        foreach ($dispositivos as $dispositivo) {
            var_dump($dispositivo);
            //Humedad del ambiente 65 a 75%
            $fecha = date("Y/m/d H:i:s");
            DB::insert('insert into medidas (tiempo, lectura, id_dispositivo, id_sensor) values (?, ?, ?, ?)', [$fecha, 90, $dispositivo->id, $sensores[0]->id]);
            DB::update('update dispositivos set ultima_actualizacion = ? where id = ?', [$fecha, $dispositivo->id]);
        }
        return 0;
    }
}
