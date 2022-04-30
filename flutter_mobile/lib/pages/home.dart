import 'package:flutter/material.dart';
import 'package:flutter_mobile/pages/cart.dart';

import '../controller/product_controller.dart';
import '../models/product_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<ProductModel>> futureProduct;
  final _searchController = TextEditingController();
  late bool loading = true;

  String urlPhoto = "http://192.168.70.6:999/backend/public/";

  @override
  void initState() {
    super.initState();
    futureProduct = ProductController.getAllProduct('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Ecommerce'),
        actions: [
          InkWell(
            onTap:(){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> CartPage()));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.shopping_cart
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // welcome
              Welcome(),

              // search
              Search(),

              // list product
              SizedBox(height: 10,),
              Text('List Product'),
              ListProduct(),
            ],
          ),
        ),
      ),
    );
  }

  // welcome
  Widget Welcome() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Text('Welcome Username'),
    );
  }

  // search
  Widget Search() {
    return Container(
      margin: EdgeInsets.all(8.0),
      width: 500,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // input search
          Container(
            width: 100,
            height: 50,
            transform: Matrix4.translationValues(0, 0, 0),
            child: TextFormField(
              autofocus: false,
              controller: _searchController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search Product...",
              ),
            ),
          ),

          // button search
          InkWell(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: searchProduct,
            child: Container(
              transform: Matrix4.translationValues(0, 0, 0),
              width: 90,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  'Search',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // list product
  Widget ListProduct() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      margin: EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: FutureBuilder<List<ProductModel>>(
            future: futureProduct,
            builder: (context, snapshot) {
              if (snapshot.hasData) {      
                return GridView.builder(
                  itemCount: snapshot.data!.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (_, index) => Padding(
                      padding: EdgeInsets.all(10),
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
                              child: Text("${snapshot.data?[index].price}"),
                            ),
                            Padding(
                              padding: EdgeInsets.all(7),
                              child: InkWell(
                                onTap: (){
                                  addCart(snapshot.data?[index].product_id, 1, snapshot.data?[index].price, 1);
                                },
                                child: Container(
                                  width: 100,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.pink[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Add To Cart',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  // function
  void searchProduct() {
    String search = _searchController.text;
    futureProduct = ProductController.getAllProduct(search.toString());
  }

  // function
  Future<void> addCart(int? product_id, int? qty, int? price, int? user_id) async {
    // print("product id : ${product_id}");
    // print("qty : ${qty}");
    // print("price : ${price}");

    var insert = ProductController.addToCart(product_id, qty, price, user_id);
    // print(insert);
    // if(insert == "ok"){
    //   print("success");
    // }
  }

}
