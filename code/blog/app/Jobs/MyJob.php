<?php

namespace App\Jobs;

use App\Mails\ImportDeliveryOrderSuccessReport;
use App\Models\DeliveryOrderHistory;
use Carbon\Carbon;
use Illuminate\Support\Facades\Mail;
use Log;

class MyJob extends Job
{
    private $name;
    /**
     * Create a new job instance.
     *
     * @param Carbon $currentDate
     */
    public function __construct($_name = "")
    {
         $this->name = $_name;
    }

    /**
     * Execute the job.
     *
     * @return void
     */
    public function handle()
    {
        echo "hello iteration ".$this->name." from job";
    }
}