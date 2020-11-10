<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Configs\configController;

class API extends Controller
{
    public function index(){
        
    }

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

}
