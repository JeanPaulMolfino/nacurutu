<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;

class getdataAcuario extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'getdataAcuario';

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
        $dispositivos = DB::select("select d.id, d.identificador, d.id_tipo,DATE_FORMAT(d.ultima_actualizacion,'%Y-%m-%d-%H-%i-%S') as ultima_actualizacion from dispositivos as d inner join tipos_dispositivos as t where d.id_tipo = t.id and d.actividad = 1 and (DATE_ADD(d.ultima_actualizacion, INTERVAL t.updatetime MINUTE) < NOW() and d.id_tipo = 3)");
        //var_dump($dispositivos);
        //itero sobre cada uno de los dispositivos
        $fecha = date("Y/m/d H:i:s");
        foreach ($dispositivos as $dispositivo) {
            var_dump($dispositivo);
            //tempagua 20 Min 25 y Max 27
            //volumen 24 Min 20 y Max 24
            //oxigeno 25 Min 6 y Max 7 de mercurio
            DB::insert('insert into medidas (tiempo, lectura, id_dispositivo, id_sensor) values (?, ?, ?, ?)', [$fecha, rand (25,27), $dispositivo->id, 1]);
            DB::insert('insert into medidas (tiempo, lectura, id_dispositivo, id_sensor) values (?, ?, ?, ?)', [$fecha, rand (20,24), $dispositivo->id, 2]);
            DB::insert('insert into medidas (tiempo, lectura, id_dispositivo, id_sensor) values (?, ?, ?, ?)', [$fecha, rand (6,7), $dispositivo->id, 3]);
            DB::update('update dispositivos set ultima_actualizacion = ? where id = ?', [$fecha, $dispositivo->id]);
        }
        return 0;
    }
}
