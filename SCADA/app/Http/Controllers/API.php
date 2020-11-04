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


}
