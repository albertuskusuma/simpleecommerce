<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

use Illuminate\Support\Facades\DB;

class AddColumnInTxCart extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('tx_cart', function (Blueprint $table) {
            //
            DB::statement('ALTER TABLE tx_cart
            add is_delete int(11) default 0
            after total_price,
            add status_checkout int(11) default 0
            after is_delete');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('tx_cart', function (Blueprint $table) {
            //
        });
    }
}
