<?php
namespace App\Configs;

use Illuminate\Support\Facades\Storage;

class configController
{
    public function readConfig(){
        return Storage::disk('configs')->get('ejemplo.json');        
    }

    public function writeConfig(){
        $data = [
            "name" => "nombre",
            "title" => "titulo"
        ];
        Storage::disk('configs')->put('ejemplo.json', json_encode($data));
    }

}
