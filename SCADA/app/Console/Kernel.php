<?php

namespace App\Console;

use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;

class Kernel extends ConsoleKernel
{
    /**
     * The Artisan commands provided by your application.
     *
     * @var array
     */
    protected $commands = [
        //
    ];

    /**
     * Define the application's command schedule.
     *
     * @param  \Illuminate\Console\Scheduling\Schedule  $schedule
     * @return void
     */
    protected function schedule(Schedule $schedule)
    {
        $schedule->command('get:devicedata') //Con esto elegimos que comando ejecutar
        ->everyMinute() //Con esto la frecuencia
        ->withoutOverlapping() //Con esto definimos de que si va a ejecutar, que evite ejecutarla si ya esta corriendo un llamado a esta funcion
        ->runInBackground(); //Con esto definimos que si hay algun otro comando, que corra en paralelo. Dejando así que las otras tareas pendientes se hagan
    }

    /**
     * Register the commands for the application.
     *
     * @return void
     */
    protected function commands()
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
