import 'package:flutter/material.dart';

import '../controller/product_controller.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<CartModel>> futureProduct;
  String urlPhoto = "http://192.168.100.9/backend/public/";

  @override
  void initState() {
    super.initState();
    futureProduct = ProductController.getCartProduct(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // title
              Text('Your Cart'),
              SizedBox(height: 10),
              listCart(),
            ],
          ),
        ),
      ),
    );
  }

  // list cart
  Widget listCart() {
    return Container(
      height: 350,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: FutureBuilder<List<CartModel>>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.length > 0) {
                  return GridView.builder(
                    itemCount: snapshot.data!.length,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        child: Column(
                          children: [
                            Image(
                              height: 30,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  urlPhoto + "${snapshot.data?[index].photo}"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "${snapshot.data?[index].name}",
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(2),
                              child: Text(
                                "${snapshot.data?[index].total_price}",
                              ),
                            ),
                            // row
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      minusItem(
                                          snapshot.data?[index].product_id, 1);
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 25,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.pink[300]),
                                      child: Center(
                                        child: Text(
                                          "-",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    '${snapshot.data?[index].qty}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 16),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      plusItem(
                                          snapshot.data?[index].product_id, 1);
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 25,
                                      child: Center(
                                          child: Text("+",
                                              style: TextStyle(
                                                  color: Colors.white))),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.green[400]),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Text("Empty Cart"),
                  );
                }
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Future<void> plusItem(int? product_id, int? user_id) async {
    // print(product_id);
    // print(user_id);

    ProductController.plusItem(product_id, user_id).then((String result) {
      if (result == 0 || result == "0") {
        setState(() {
          futureProduct = ProductController.getCartProduct(user_id);
        });
      } else {
        print(result);
      }
    });
  }

  Future<void> minusItem(int? product_id, int? user_id) async {
    ProductController.minusItem(product_id, user_id).then((String result) {
      // print(result);
      if (result == 0 || result == "0") {
        setState(() {
          futureProduct = ProductController.getCartProduct(user_id);
        });
      } else {
        print(result);
      }
    });
  }
}
