import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rockman/Products/Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper.dart';
import '../IP.dart';
import '../assignedProduct.dart';
import '../product_model.dart';
import 'Nose_mask_pro.dart';
import 'addToCart.dart';
import 'view_Product.dart';

class Products_Page extends StatefulWidget {

  Products_Page ({
    required this.selectedClientId,
    required this.phoneNumber,
  });
  String? selectedClientId;
  String? phoneNumber;



  @override
  State<Products_Page> createState() => _Products_PageState();
}

class _Products_PageState extends State<Products_Page> {
  int apiStatusCode = 0;

  //   int apiStatusCode = 0;
  // String apiMessage = "",phoneNumber = "";
  late Future<List<assignedProductModel>> _func;

  @override
  void initState() {
    _func = _getProduct();
    Timer(Duration(seconds: 0), () {
      setState(() {
        _loadSharedPref();
        // _doCheckImage();
      });
    });
    super.initState();
  }

  String image = "";

  String userId = "",
      salesId = "",
      apiMessage = "",
      firstName = "",
      productId = "",
      productName = "",
      // price = "",
  // image = "https://via.placeholder.com/150";
      expiredDate = "",
      quantity = "",
      availability = "",
      phoneNumber = "",
      name = "";
  String selectedClientId = "";




  final Helper helper = Helper();

  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedClientId = (prefs.getString('clientId') ?? '');
      productId = (prefs.getString('productId') ?? '');
      productName = (prefs.getString('productName') ?? '');
      // price = (prefs.getString('price') ?? '');
      salesId = (prefs.getString('salesId') ?? '');
      phoneNumber = (prefs.getString('phoneNumber') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Purchase Product"),
        actions: [
          IconButton(

              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String clientId = (prefs.getString('clientId') ?? '');
                Navigator.push(context, MaterialPageRoute(builder: (context) => Cart(selectedClientId: "${widget.selectedClientId}", cProductName: '', productId: '', price: '', status: '', image: '', quantity: '',
                  cQuantity: '', phoneNumber: '${widget.phoneNumber}',)));
                // Navigator.push(context, MaterialPageRoute(builder: (context)=> Cart(
                //   productName: productName, productId: productId, price: price,  image: image, quantity: quantity, status: '', clientId: clientId.toString(),)));
              },
              icon: Icon(
                Icons.shopping_cart_checkout,
              ))
        ],
      ),
      body: Stack(
          children: [
            Container(


              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: FutureBuilder(
                  future: _func,
                  builder: (context, data) {
                    if (data.hasError) {
                      return Column(children: [
                        // SizedBox(height: 100,),
                        Text('no data '),
                      ]);
                    } else if (data.hasData) {
                      var items = data.data as List<assignedProductModel>;
                      return ListView.builder(
                          itemCount: items == null ? 0 : items.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {

                              },
                              child: Container(
                                // height: 80,
                                padding: EdgeInsets.all(5.0),
                                child: Column(
                                  // mainAxisAlignment: MainAxisAlignment.center,
                                  //  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Column(
                                      children: [
                                        // SizedBox(height: 100,),
                                        Container(

                                          decoration: BoxDecoration(


                                            borderRadius: BorderRadius.all(
                                                Radius.circular(50)),


                                          ),

                                          child: Card(
                                            child: ListTile(
                                              title: Text(
                                                items[index].productName
                                                    .toString(),
                                                style: TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              onTap: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Product_Cart(
                                                              productName: items[index]
                                                                  .productName
                                                                  .toString(),
                                                              productId: items[index]
                                                                  .productId
                                                                  .toString(),
                                                              price: items[index]
                                                                  .price
                                                                  .toString(),

                                                              status: items[index]
                                                                  .status
                                                                  .toString(),
                                                              image: items[index]
                                                                  .image
                                                                  .toString(), quantity: '', expiredDate: '', description: '',
                                                              salesId: salesId.toString(), selectedClientId:"${widget.selectedClientId}",
                                                                phoneNumber: '${widget.phoneNumber}', creditedPrice: items[index]
                                                                .creditedPrice
                                                                .toString(),
                                                              ))
                                                );
                                              },
                                              trailing: Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "GHS ${items[index].price
                                                          .toString()} ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color: Colors.black,
                                                          fontSize: 18),),

                                                    SizedBox(height: 5,),

                                                    Text(
                                                      "${items[index].status}",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color: Colors.green,
                                                          fontSize: 10),),
                                                  ],
                                                ),
                                              ),
                                              leading: Container(
                                                height: (85),
                                                child: Image.network(items[index].image.toString()),

                                              ),
                                              subtitle: Text(
                                                  "Quantity  ${items[index]
                                                      .quantity.toString()}"),
                                            ),
                                            elevation: 5,
                                          ),
                                        )
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          });
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ),
          ]),



    );
  }


  Future<List<assignedProductModel>> _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');

    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.viewAll),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(<String, String>{
          'salesId': userId,
          'action': 'viewUserProducts',
          'auth': "${IP.Auth}"
        }))
        .catchError((err) {
      helper.alertDialogTitle(IP.errorMessageOops,
          IP.errorMessageSomethingWentWrong, context);
    });
    // final responseJson = jsonDecode(response.body);
    // apiStatusCode = responseJson["statusCode"].toInt();
    // apiMessage = responseJson["message"].toString();
    //
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      // String apiResponse = responseJson["response"].toString();
      // String productId = responseJson["response"][0]["ProductId"].toString();
      // String productName = responseJson["response"][0]["ProductName"].toString();
      // String  cProductId = responseJson["response"][0]["ProductId"].toString();
      // String  quantity = responseJson["response"][0]["Quantity"].toString();
      // String  price = responseJson["response"][0]["Price"].toString();
      //
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('productId', productId);
      // prefs.setString('cProductId', cProductId);
      // prefs.setString('quantity', quantity);
      // prefs.setString('price', price);

      // prefs.setString('productName', productName);
      List responseList = json.decode(response.body)["response"];
      return responseList
          .map((data) => assignedProductModel.fromJson(data))
          .toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}