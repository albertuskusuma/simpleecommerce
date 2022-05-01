import 'package:flutter_mobile/models/cart_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

class ProductController{

  // function get all products
  static Future<List<ProductModel>> getAllProduct(String name) async{
    // define api url
    String apiURL = "http://192.168.100.9/backend/api/getproduct";

    var apiResult = await http.post(Uri.parse(apiURL),body:{'name':name});
    // get object
    var jsonObject = json.decode(apiResult.body);

    // print(apiResult.body);
    
    // casting list of object using Map
    List<dynamic> listProduct = (jsonObject as Map<String, dynamic>)['product'];

    List<ProductModel> product = [];
    
    // array push
    for(int i = 0; i < listProduct.length; i++)
    {
      // push object to Model
      product.add(ProductModel.createProduct(listProduct[i]));
    }

    // return data
    return product;
  }
  
  // function add to cart
  static Future<String> addToCart(int? product_id, int? qty, int? price, int? user_id) async {
    String apiURL = "http://192.168.100.9/backend/api/insert_tx_cart";

    var apiResult = await http.post(Uri.parse(apiURL),body:{
    "product_id":product_id.toString(), 
    "qty":qty.toString(),
    "price":price.toString(),
    "user_id":user_id.toString()
    });

    // print(apiResult.body);

    if(apiResult.statusCode == 200){
     var r = json.decode(apiResult.body);
      return (r['code'].toString());
    }
    else{
      var r = json.decode(apiResult.body);
      return (r['code'].toString());
    }

    // return "ok";
  }

  // function get cart
  static Future<List<CartModel>> getCartProduct(int? user_id) async {
    String apiURL = "http://192.168.100.9/backend/api/getCart";

    var apiResult = await http.post(Uri.parse(apiURL),body:{"user_id":user_id.toString()});
    if(apiResult.statusCode == 200){

      var jsonObject = json.decode(apiResult.body);
      List<dynamic> list = (jsonObject as Map<String, dynamic>)['product'];

      List<CartModel> listpush = [];

      for(int i=0; i < list.length; i++){
        listpush.add(CartModel.createProduct(list[i]));
      }

      return listpush;
    }
    else{
      return [];
    }
  }

  // function plus item
  static Future<String> plusItem(int? product_id, int? user_id) async {
    String apiURL = "http://192.168.100.9/backend/api/plusItem";

    var result = await http.post(Uri.parse(apiURL),body: {
      "product_id":product_id.toString(),
      "user_id":user_id.toString()
    });

    // print(result);

    if(result.statusCode == 200){
      var r = json.decode(result.body);
      print(r['code'].toString());
      return (r['code'].toString());
    }else{
      var r = json.decode(result.body);
      return (r['code'].toString());
    }
  }

  // function minus Item
  static Future<String> minusItem(int? product_id, int? user_id) async {
    String apiURL = "http://192.168.100.9/backend/api/minusItem";

    var result = await http.post(Uri.parse(apiURL),body: {
      "product_id" : product_id.toString(),
      "user_id":user_id.toString()
    });

    if(result.statusCode == 200){
      var r = json.decode(result.body);
      // print(r['code']);
      return (r['code'].toString());
    }else{
      var r = json.decode(result.body);
      return (r['code'].toString());
    }
  }

}