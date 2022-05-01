<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ApiController extends Controller
{
    //
    public function getProduct(Request $request)
    {
        $search = $request->name;
        // $search = "";
        $path = "uploads/product/";
        $product = DB::select("SELECT product_id, name, photo, price, is_delete
        FROM product WHERE is_delete = 0
        AND name like '%$search%'");

        $data = [];

        // dd($product);
        if(count($product) > 0)
        {
            foreach($product as $k => $v){
                $data[] = array(
                    'product_id' => $v->product_id,
                    'name' => $v->name,
                    'photo' => $path.$v->photo,
                    'price' => $v->price,
                    'is_delete' => $v->is_delete
                );
            }

            // dd($data);

            echo json_encode(array(
                'status'=>200,
                'code' => 0,
                'product'=>$data
            ));
        }

        else
        {
            echo json_encode(array(
                'status'=>200,
                'code' => 1,
                'product'=>[]
            ));
        }
    }

    public function insert_tx_cart(Request $request)
    {
        $product_id = (int) $request->product_id;
        $qty = (int) $request->qty;
        $total_price = (int) $request->price * $qty;
        $user_id = (int) $request->user_id;

        $get_data_by_id = DB::select('Select * from tx_cart
        WHERE is_delete = ?
        AND status_checkout = ?
        AND user_id = ?
        AND product_id = ?',[0,0,$user_id,$product_id]);

        if(count($get_data_by_id) > 0)
        {
            $qty = (int) $get_data_by_id[0]->qty + 1;
            $total_price = (int) $qty * $request->price;
            // echo $qty;
            // echo "<br>";
            // echo $total_price;

            $insert_tx_cart = DB::update('UPDATE tx_cart
            SET product_id = ?,
            qty = ?,
            total_price = ?
            WHERE user_id = ? AND product_id = ?',[$product_id,$qty,$total_price,$user_id,$product_id]);

            if($insert_tx_cart)
            {
                echo json_encode(
                    array(
                        'status'=>200,
                        'code'=>0,
                        'msg'=>'Success Add To Cart'
                    )
                );
            }

            else
            {
                echo json_encode(
                    array(
                        'status'=>200,
                        'code'=>1,
                        'msg' => 'Failed Insert To Cart'
                    )
                );
            }
        }

        else
        {
            $insert_tx_cart = DB::insert('INSERT INTO tx_cart (product_id, qty, total_price, user_id)
            VALUES(?,?,?,?)',[$product_id,$qty,$total_price,$user_id]);

            if($insert_tx_cart)
            {
                echo json_encode(
                    array(
                        'status'=>200,
                        'code'=>0,
                        'msg'=>'Success Add To Cart'
                    )
                );
            }

            else
            {
                echo json_encode(
                    array(
                        'status'=>200,
                        'code'=>1,
                        'msg' => 'Failed Insert To Cart'
                    )
                );
            }
        }
    }

    public function plus_item(Request $request)
    {
        $product_id = $request->product_id;
        $qty = 0;
        $total_price = 0;
        $user_id = $request->user_id;

        $get_data_by_id = DB::select('Select * from tx_cart
        WHERE is_delete = ?
        AND status_checkout = ?
        AND user_id = ?',[0,0,$user_id]);

        if(count($get_data_by_id) > 0){
            //
            $qty = (int) $get_data_by_id[0]->qty + 1;
            $get_product_by_id = DB::select('Select * from product
            WHERE is_delete = ?
            AND product_id = ?',[0, $get_data_by_id[0]->product_id]);


            $total_price = (int) $qty * (int) $get_product_by_id[0]->price;
            // echo $qty;
            // echo "<br>";
            // echo $total_price;

            $insert_tx_cart = DB::update('UPDATE tx_cart
            SET product_id = ?,
            qty = ?,
            total_price = ?
            WHERE user_id = ? AND product_id = ?',[$product_id,$qty,$total_price,$user_id,$product_id]);

            if($insert_tx_cart)
            {
                echo json_encode(
                    array(
                        'status'=>200,
                        'code'=>0,
                        'msg'=>'Success Add To Cart'
                    )
                );
            }

            else
            {
                echo json_encode(
                    array(
                        'status'=>200,
                        'code'=>1,
                        'msg' => 'Failed Insert To Cart'
                    )
                );
            }
        }
    }

    public function minus_item(Request $request)
    {
        $product_id = $request->product_id;
        $qty = 0;
        $total_price = 0;
        $user_id = $request->user_id;

        $get_data_by_id = DB::select('Select * from tx_cart
        WHERE is_delete = ?
        AND status_checkout = ?
        AND user_id = ?',[0,0,$user_id]);

        if(count($get_data_by_id) > 0){
            //

            if((int) $get_data_by_id[0]->qty > 0)
            {
                $qty = (int) $get_data_by_id[0]->qty - 1;
                $get_product_by_id = DB::select('Select * from product
                WHERE is_delete = ?
                AND product_id = ?',[0, $get_data_by_id[0]->product_id]);

                $total_price = (int) $qty * (int) $get_product_by_id[0]->price;
                // echo $qty;
                // echo "<br>";
                // echo $total_price;

                $insert_tx_cart = DB::update('UPDATE tx_cart
                SET product_id = ?,
                qty = ?,
                total_price = ?
                WHERE user_id = ? AND product_id = ?',[$product_id,$qty,$total_price,$user_id,$product_id]);

                if($insert_tx_cart)
                {
                    echo json_encode(
                        array(
                            'status'=>200,
                            'code'=>0,
                            'msg'=>'Success Add To Cart'
                        )
                    );
                }

                else
                {
                    echo json_encode(
                        array(
                            'status'=>200,
                            'code'=>1,
                            'msg' => 'Failed Insert To Cart'
                        )
                    );
                }
            }

            else
            {
                echo json_encode(
                    array(
                        'status'=>200,
                        'code'=>9,
                        'msg' => 'There is no item'
                    )
                );
            }
        }
    }

    public function getCart(Request $request)
    {
        // $user_id = $request->user_id;
        $user_id = 1;
        $path = "uploads/product/";
        $stringData = DB::select("SELECT c.cart_id, c.product_id, p.name, p.photo, c.qty, c.total_price
        FROM `tx_cart` as c
        LEFT JOIN product as p ON c.product_id = p.product_id
        WHERE c.is_delete = 0
        AND c.user_id = ?
        AND c.status_checkout = ?
        AND c.qty > ?",[$user_id,0,0]);

        if(count($stringData) > 0)
        {
            $data = [];
            foreach($stringData as $k => $v){
                $data[] = array(
                    'product_id' => $v->product_id,
                    'cart_id' => $v->cart_id,
                    'name' => $v->name,
                    'photo' => $path.$v->photo,
                    'qty' => $v->qty,
                    'total_price' => $v->total_price
                );
            }

            echo json_encode(array(
                'status'=>200,
                'code' => 0,
                'product'=>$data
            ));
        }

        else
        {
            echo json_encode(array(
                'status'=>200,
                'code' => 1,
                'product'=>[]
            ));
        }
    }

    public function checkout(Request $request)
    {
        $user_id = $request->user_id;

        $checkout = DB::update("Update tx_cart set status_checkout = ?
        WHERE user_id = ? AND status_checkout = 0",[1, $user_id]);

        if($checkout){
            echo json_encode(
                array(
                    'status'=>200,
                    'code'=>0,
                    'msg'=>'Success Checkout'
                )
            );
        }

        else{
            echo json_encode(
                array(
                    'status'=>200,
                    'code'=>1,
                    'msg'=>'Failed Checkout'
                )
            );
        }
    }
}
