<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class devtestController extends Controller
{
    function index(){
        echo "Hi!";
        //pos si quiero sacar algo de la base de datos
        //return DB::select("Select * from frutas");
    }
}
