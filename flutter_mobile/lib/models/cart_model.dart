
class CartModel{

  // object
  int? product_id;
  int? cart_id;
  String? name;
  String? photo;
  int? qty;
  int? total_price;

  // constructor
  CartModel({
    this.product_id,
    this.cart_id,
    this.name,
    this.photo,
    this.qty,
    this.total_price
  });

  // convert json object from API
  factory CartModel.createProduct(Map<String, dynamic> object){
    return CartModel(
      product_id: object['product_id'],
      cart_id: object['cart_id'],
      name: object['name'],
      photo: object['photo'],
      qty: object['qty'],
      total_price: object['total_price']
    );
  }
}