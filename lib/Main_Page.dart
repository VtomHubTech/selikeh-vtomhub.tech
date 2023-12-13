import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rockman/Products/addToCart.dart';
import 'package:rockman/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:http/http.dart' as http;
import 'IP.dart';
import 'Login_Page.dart';
import 'Products/view_Product.dart';
import 'assignedProduct.dart';
import 'helper.dart';

class Main_Page extends StatefulWidget {
  // SelectService({required this.serviceName});
  // String value;
  // SelectService({required this.value});

  @override
  State<Main_Page> createState() => _Main_PageState();
}

class _Main_PageState extends State<Main_Page> {
  String totalProduct = "";
  // _SelectServiceState(this.value);
  // String card;
  int apiStatusCode = 0;

  late Future<List<assignedProductModel>> _func;

  @override
  void initState() {
    _func = _getProduct();
    Timer(Duration(seconds: 1), () {
      setState(() {
        loadSharedPref();
        // _doCheckImage();
      });
    });
    super.initState();
  }

  String image = "";
  String userId = "",
      // phoneNumber = "",
      apiMessage = "",
      firstName = "",
      productId = "",
      productName = "",
      expiredDate = "",
      quantity = "",
      price = "",
      creditedPrice = "",
      // image = "https://via.placeholder.com/150";
      availability = "",
      phoneNumber = "",
      name = "";
  final Helper helper = Helper();

  loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('userId') ?? '');
      // serviceName = (prefs.getString('serviceName') ?? '');
      // serviceDetails = (prefs.getString('serviceDetails') ?? '');
      totalProduct = (prefs.getString('totalProduct') ?? '');
      phoneNumber = (prefs.getString('phoneNumber') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products '),
        leading: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text(
                totalProduct,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
        // backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    content: Text("Do you want to logout ?"),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => {
                          Navigator.pop(context),
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () =>
                            {Navigator.pop(context), _logOut(context)},
                        child: const Text('Logout'),
                      ),
                    ],
                  ),
                );
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Stack(children: [
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
                          onTap: () {},
                          child: Container(
                            // height: 180,
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
                                            items[index].productName.toString(),
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          onTap: () async {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Carts(
                                                          productName:
                                                              items[index]
                                                                  .productName
                                                                  .toString(),
                                                          productId:
                                                              items[index]
                                                                  .productId
                                                                  .toString(),
                                                          price: items[index]
                                                              .price
                                                              .toString(),
                                                          quantity: items[index]
                                                              .quantity
                                                              .toString(),
                                                          expiredDate:
                                                              items[index]
                                                                  .lastName
                                                                  .toString(),
                                                          description:
                                                              items[index]
                                                                  .description
                                                                  .toString(),
                                                          status: items[index]
                                                              .status
                                                              .toString(),
                                                          image: items[index]
                                                              .image
                                                              .toString(),
                                                        )));
                                          },
                                          trailing: Container(
                                            child: Column(
                                              children: [
                                                Text(
                                                  "GHS ${items[index].price.toString()} ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black,
                                                      fontSize: 18),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "${items[index].status}",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.green,
                                                      fontSize: 10),
                                                ),
                                              ],
                                            ),
                                          ),
                                          leading: Container(
                                            child: Image.network(
                                                items[index].image.toString()),
                                            // child: Image.network("https://vtpayportal.online/vtomHub/other/rokmer/uploads/images/P80048.jpg"),
                                            height: (85),
                                          ),
                                          subtitle: Text(
                                              "Quantity  ${items[index].quantity.toString()}"),
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
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
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
              // 'cardNumber': cardNumber,
              'action': 'viewUserProducts',
              'auth': "${IP.Auth}"
            }))
        .catchError((err) {
      helper.alertDialogTitle(
          IP.errorMessageOops, IP.errorMessageSomethingWentWrong, context);
    });
    final responseJson = jsonDecode(response.body);
    String image = responseJson["response"][0]["Image"].toString();
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('image', image);
    //
    if (response.statusCode == 200) {
      String totalProduct = responseJson["totalProduct"].toString();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('totalProduct', totalProduct);
      List responseList = json.decode(response.body)["response"];
      return responseList
          .map((data) => assignedProductModel.fromJson(data))
          .toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  _logOut(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userId');
    prefs.remove('clientId');
    prefs.remove('merchantId');
    prefs.remove('phoneNumber');
    prefs.remove('emailAddress');
    prefs.remove('isUserLoggedIn');

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Login_Page()),
        (Route<dynamic> route) => false);
  }

  // Future<void> _doCheckImage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String userId = (prefs.getString('userId') ?? '');
  //
  //   String basicAuth = 'Basic ' +
  //       base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
  //   final response = await http
  //       .post(Uri.parse(IP.manageProduct),
  //       headers: {
  //         'Content': 'application/x-www-form-urlencoded',
  //         'Content-Type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': '$basicAuth',
  //       },
  //       body: jsonEncode(<String, String>{
  //         'salesId': userId,
  //         'action': 'view',
  //         'auth': '${IP.Auth}'
  //       }))
  //       .catchError((err) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(IP.errorMessageSomethingWentWrong)));
  //   });
  //
  //   if (response.statusCode != 200) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(IP.errorMessageSomethingWentWrong)));
  //   }
  //
  //   final responseJson = jsonDecode(response.body);
  //   apiStatusCode = responseJson["statusCode"].toInt();
  //   apiMessage = responseJson["message"].toString();
  //
  //   if (apiStatusCode == 200) {
  //     setState(() {
  //       image = responseJson["response"][0]["Image"].toString();
  //     });
  //   } else if (apiStatusCode != 200) {
  //     //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(apiMessage)));
  //
  //   }
  // }
}
