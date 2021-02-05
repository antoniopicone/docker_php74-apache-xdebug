<?php

namespace App\Http\Controllers;

use App\Jobs\MyJob;
use App\Models\User;

use Illuminate\Support\Facades\Queue;


// Ciao
class ExampleController extends Controller
{
    /**
     * Create a new controller instance.
     *
     * @return void 
     */
    public function __construct()
    {
        //
    }

    public function showAllUser()
    {
        // dispatch(new MyJob("Antonio"))->onQueue('default');

        for($i=0; $i<=10; $i++){
            Queue::push(new MyJob($i));
            echo "successfully push";
        }
    
        return response()->json("done");
        // response()->json(User::all());
    }

    //
}

