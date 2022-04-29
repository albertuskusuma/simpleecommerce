<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ApiController extends Controller
{
    //
    public function getProduct(Request $request)
    {
        // $search = $request->name;
        $search = "";
        $path = "storage/product/";
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
}
