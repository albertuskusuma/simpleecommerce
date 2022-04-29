<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateTxDetailOrderTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('tx_detail_order', function (Blueprint $table) {
            $table->bigIncrements('detail_order_id');
            $table->bigInteger('order_id');
            $table->bigInteger('product_id');
            $table->bigInteger('qty');
            $table->bigInteger('total_price');
            $table->string('payment_status');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('tx_detail_order');
    }
}
