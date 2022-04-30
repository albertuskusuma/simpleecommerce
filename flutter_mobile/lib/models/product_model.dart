import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductModel 
{
  // object 
  int? product_id;
  String? name;
  String? photo;
  int? price;

  // constructor
  ProductModel({
    this.product_id,
    this.name,
    this.photo,
    this.price
  });

  // convert json object from API
  factory ProductModel.createProduct(Map<String, dynamic> object){
    // return convert
    return ProductModel(
      product_id: object['product_id'],
      name:object['name'],
      photo:object['photo'],
      price:object['price']
    );
  }
}