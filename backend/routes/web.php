<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

// for rest api
Route::post('/api/getproduct','ApiController@getProduct');
Route::post('/api/insert_tx_cart','ApiController@insert_tx_cart');