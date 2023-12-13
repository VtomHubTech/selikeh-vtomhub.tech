import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rockman/Products/Cart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper.dart';
import '../IP.dart';
import '../cartModel.dart';
import 'Nose_mask_pro.dart';
import 'addToCart.dart';
import 'view_Product.dart';

class P extends StatefulWidget {

  P({required this.clientId,

  });

  String? clientId;


  @override
  State<P> createState() => _PState();
}

class _PState extends State<P> {
  int apiStatusCode = 0;

  //   int apiStatusCode = 0;
  // String apiMessage = "",phoneNumber = "";
  late Future<List<cartModel>> _func;

  @override
  void initState() {
    _func = _getProduct();
    Timer(Duration(seconds: 0), () {
      setState(() {
        loadSharedPref();
        // _doCheckImage();
      });
    });
    super.initState();
  }

  String image = "https://via.placeholder.com/150";

  String userId = "",
      salesId = "",
      apiMessage = "",
      firstName = "",
      cProductId = "",
      cProductName = "",
      unitPrice = "",
  // image = "https://via.placeholder.com/150";
      totalPrice = "",
      quantity = "",
      availability = "",
      phoneNumber = "",
      clientId = "",
      cQuantity = "",
  cartId = "";

  final Helper helper = Helper();

  loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      clientId = (prefs.getString('clientId') ?? '');
      cProductId = (prefs.getString('cProductId') ?? '');
      cProductName = (prefs.getString('cProductName') ?? '');
      unitPrice = (prefs.getString('UnitPrice') ?? '');
      salesId = (prefs.getString('salesId') ?? '');
      cQuantity = (prefs.getString('cQuantity') ?? '');
      cartId = (prefs.getString('cartId') ?? '');

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.clientId}"),
        actions: [
          IconButton(

              onPressed: () async {
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
                      var items = data.data as List<cartModel>;
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
                                                items[index].cProductName
                                                    .toString(),
                                                style: TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              onTap: () async {

                                              },
                                              trailing: Container(
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      "GHS ${items[index].unitPrice
                                                          .toString()} ",
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold,
                                                          color: Colors.black,
                                                          fontSize: 18),),

                                                    SizedBox(height: 5,),

                                                    Text(
                                                      "${items[index].totalPrice}",
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
                                                child: Card(
                                                  child: CircleAvatar(
                                                    // maxRadius: 25.0,
                                                    backgroundImage: NetworkImage(
                                                        image),
                                                    backgroundColor: Colors
                                                        .transparent,
                                                    // backgroundImage:NetworkImage('https://placeimg.com/640/480/any'),
                                                  ),
                                                  elevation: 6.0,
                                                  // shape: CircleBorder(),
                                                  clipBehavior: Clip.antiAlias,
                                                ),
                                              ),
                                              subtitle: Text(
                                                  "Quantity  ${items[index]
                                                      .cQuantity.toString()}"),
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


  Future<List<cartModel>> _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');
    String clientId = (prefs.getString('clientId') ?? '');

    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.managePurchase),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(<String, String>{
          'salesId': 'S2160435',
           'clientId': clientId,
          'action': 'viewAll',
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
      //   setState(() {
      //     image = responseJson["response"][0]["Image"].toString();
      //   });
      List responseList = json.decode(response.body)["response"];
      return responseList
          .map((data) => cartModel.fromJson(data))
          .toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}