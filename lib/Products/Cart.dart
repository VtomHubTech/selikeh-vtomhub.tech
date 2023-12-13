import 'dart:async';
import 'dart:convert';
import 'package:awesome_number_picker/awesome_number_picker.dart';
import 'package:flutter/material.dart';
import 'package:rockman/Payments/Payment_Model.dart';
import 'package:rockman/Products/Products.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../Helper.dart';
import '../IP.dart';
import '../cartModel.dart';
import '../purchase.dart';
import 'discountModel.dart';

class Cart extends StatefulWidget {
  Cart(
      {required this.cProductName,
      required this.productId,
      required this.price,
      required this.status,
      required this.image,
      required this.quantity,
      required this.selectedClientId,
      required this.phoneNumber,
      required this.cQuantity});

  String cProductName = "";
  String productId = "";
  String price = "";
  String status = "";
  String image = "";
  String quantity = "";
  String phoneNumber = "";
  String selectedClientId = "";
  String cQuantity = "";

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int _counter = 0;

  String cProductName = "";
  String cProductId = "";
  String cQuantity = "";
  String description = "";
  String cartId = "";
  String image = "";
  String expiredDate = "";
  String clientId = "";
  String unitPrice = "";
  String totalPrice = "";
  String userId = "";
  String apiMessage = "";

  var quantityController = TextEditingController();

  final Helper helper = new Helper();
  final controller = ScrollController();
  double offset = 0;

  int apiStatusCode = 0;

  //   int apiStatusCode = 0;
  // String apiMessage = "",phoneNumber = "";
  late Future<List<cartModel>> _func;
  late Future<List<disModel>> _func2;

  @override
  void initState() {
    quantityController.text = widget.cQuantity;
    _func = _getProduct();
    // _func2 = fetchDiscount();
    Timer(Duration(seconds: 1), () {
      setState(() {
        _getProductData();
        _counter++;
        // fetchDiscount();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }

  int integerValue = 0;
  double decimalValue = 0;
  List categoryListItem = [];
  var categoryValue;
  _getProductData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cProductId = (prefs.getString('cProductId') ?? '');
    cProductName = (prefs.getString('cProductName') ?? '');
    cQuantity = (prefs.getString('cQuantity') ?? '');
    unitPrice = (prefs.getString('unitPrice') ?? '');
    totalPrice = (prefs.getString('totalPrice') ?? '');
    // cartId = (prefs.getString('cartId') ?? '');
    userId = (prefs.getString('userId') ?? '');
    clientId = (prefs.getString('clientId') ?? '');
  }

  String dropdownvalue = '0';

  // List of items in our dropdown menu
  var items = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          backgroundColor: Color.fromARGB(255, 7, 201, 159),
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return IconButton(
          //         icon: const Icon(Icons.arrow_back_ios),
          //         onPressed: () {
          //           Navigator.pushAndRemoveUntil(
          //               context,
          //               MaterialPageRoute(
          //                   builder: (context) => Products_Page(selectedClientId: "${widget.selectedClientId}",
          //                        )),
          //               (Route<dynamic> route) => false);
          //         });
          //   },
          // ),
          actions: [
            IconButton(
                onPressed: () {
                  deleteAll(cartId, cProductName, unitPrice);
                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> Products_Page(clientId: clientId.toString(), shopName: '',)));
                },
                icon: Icon(Icons.delete)),
          ],
        ),
        body: RefreshIndicator(
            child: Container(
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
                              onTap: () {},
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
                                                items[index]
                                                    .cProductName
                                                    .toString(),
                                                style: TextStyle(
                                                    // fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              onTap: () async {},
                                              trailing: Container(
                                                child: Column(
                                                  children: [
                                                    IconButton(
                                                      onPressed: () {
                                                        delete(
                                                            items[index]
                                                                .cProductName
                                                                .toString(),
                                                            items[index]
                                                                .cartId
                                                                .toString(),
                                                            items[index]
                                                                .cQuantity
                                                                .toString());
                                                      },
                                                      icon: Icon(Icons
                                                          .delete_outline_outlined),
                                                      iconSize: 22,
                                                      color: Colors.red,
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              leading: IconButton(
                                                  onPressed: () async {
                                                    editQuant(
                                                        items[index]
                                                            .cProductName
                                                            .toString(),
                                                        items[index]
                                                            .cartId
                                                            .toString(),
                                                        items[index]
                                                            .cQuantity
                                                            .toString());
                                                  },
                                                  icon: Icon(Icons.add)),
                                              subtitle: Row(
                                                children: [
                                                  Text(
                                                      "GHS ${items[index].unitPrice.toString()}"),
                                                  SizedBox(
                                                    width: 40,
                                                  ),
                                                  Text(
                                                    " ${items[index].cQuantity.toString()} ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.green),
                                                  ),
                                                  Text(
                                                    'Quantity',
                                                  )
                                                ],
                                              ),
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
            onRefresh: () {
              return Future.delayed(Duration(seconds: 1), () {
                setState(() {
                  _func = _getProduct();
                  controller.addListener(onScroll);
                });
              });
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FloatingActionButton.extended(
                label: Text("Discount  ${integerValue}%"),
                backgroundColor: Colors.blue,
                onPressed: () {
                  number();
                },
              ),
              FloatingActionButton(
                onPressed: () {
                  _sum();
                },
                child: Icon(Icons.money),
              ),
            ],
          ),
        ));
  }

  // Future<List<disModel>> fetchDiscount() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String userId = (prefs.getString('userId') ?? '');

  //   SimpleFontelicoProgressDialog progressDialog =
  //       SimpleFontelicoProgressDialog(
  //           context: context, barrierDimisable: false);
  //   progressDialog.show(
  //     message: "loading discount...",
  //   );

  //   String basicAuth = 'Basic ' +
  //       base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
  //   final response = await http
  //       .post(Uri.parse(IP.viewAll),
  //           headers: {
  //             'Content': 'application/x-www-form-urlencoded',
  //             'Content-Type': 'application/json',
  //             'Accept': 'application/json',
  //             'Authorization': '$basicAuth',
  //           },
  //           body: jsonEncode(<String, String>{
  //             'userId': userId,
  //             'salesId': userId,
  //             'auth': "${IP.Auth}",
  //             'action': 'viewDiscount'
  //           }))
  //       .catchError((err) {
  //     progressDialog.hide();
  //     helper.alertDialogTitle(Helper.errorMessageSomethingWentWrong,
  //         Helper.errorMessageSomethingWentWrong, context);
  //   });
  //   if (response.statusCode == 200) {
  //     final responseJson = jsonDecode(response.body);

  //     String apiResponse = responseJson["response"].toString();
  //     String totalTask = responseJson["TotalTask"].toString();

  //     SharedPreferences prefs = await SharedPreferences.getInstance();
  //     prefs.setString('totalTask', totalTask);
  //     List responseList = json.decode(response.body)["response"];
  //     return responseList.map((data) => disModel.fromJson(data)).toList();
  //   } else {
  //     // If that call was not successful, throw an error.
  //     throw Exception('Failed to load post');
  //   }
  // }

  Future<void> _delete(String cartId, String cProductName, String unitPrice,
      String cQuantity) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.manageCart),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': basicAuth,
            },
            body: jsonEncode(<String, String>{
              "action": " deleteItemInCart",
              "salesId": userId,
              "productName": cProductName,
              "quantity": cQuantity,
              "unitPrice": unitPrice,
              "clientId": "${widget.selectedClientId}",
              "cartId": cartId,
              'auth': '${IP.Auth}'
            }))
        .catchError((err) {
      // progressDialog.hide();
      helper.alertDialogTitle(
          'something went wrong}', IP.errorMessageSomethingWentWrong, context);
    });

    if (response.statusCode != 200) {
      // progressDialog.hide();
      helper.alertDialogTitle(
          IP.errorMessageOops, IP.errorMessageSomethingWentWrong, context);
    }

    final responseJson = jsonDecode(response.body);
    apiStatusCode = responseJson["statusCode"].toInt();
    apiMessage = responseJson["message"].toString();

    if (apiStatusCode == 200) {
      // progressDialog.hide();
      helper.flushBar("Success", apiMessage, context);
      setState(() {
        _func = _getProduct();

        // _func = _getProduct();
        //  controller.addListener(onScroll);
      });
    } else if (apiStatusCode != 200) {
// progressDialog.hide();
      helper.alertDialogNoTitle(apiMessage, context);
    }
  }

  Future<void> _deleteAll(String cartId, String cProductName, String unitPrice,
      String cQuantity) async {
    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.manageCart),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': basicAuth,
            },
            body: jsonEncode(<String, String>{
              "action": " deleteAllinCart",
              "salesId": userId,
              "productName": cProductName,
              "quantity": cQuantity,
              "unitPrice": unitPrice,
              "clientId": "${widget.selectedClientId}",
              "cartId": cartId,
              'auth': '${IP.Auth}'
            }))
        .catchError((err) {
      // progressDialog.hide();
      helper.alertDialogTitle(
          'something went wrong}', IP.errorMessageSomethingWentWrong, context);
    });

    if (response.statusCode != 200) {
      // progressDialog.hide();
      helper.alertDialogTitle(
          IP.errorMessageOops, IP.errorMessageSomethingWentWrong, context);
    }

    final responseJson = jsonDecode(response.body);
    apiStatusCode = responseJson["statusCode"].toInt();
    apiMessage = responseJson["message"].toString();

    if (apiStatusCode == 200) {
      // progressDialog.hide();
      helper.flushBar("Success", apiMessage, context);
      setState(() {
        _func = _getProduct();

        // _func = _getProduct();
        //  controller.addListener(onScroll);
      });
    } else if (apiStatusCode != 200) {
// progressDialog.hide();
      helper.alertDialogNoTitle(apiMessage, context);
    }
  }

  Future<List<cartModel>> _getProduct() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');
    String clientId = (prefs.getString('clientId') ?? '');

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.manageCart),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': basicAuth,
            },
            body: jsonEncode(<String, String>{
              'salesId': userId,
              'clientId': "${widget.selectedClientId}",
              'action': 'viewAll',
              'auth': "${IP.Auth}"
            }))
        .catchError((err) {
      helper.alertDialogTitle(
          IP.errorMessageOops, IP.errorMessageSomethingWentWrong, context);
    });
    // final responseJson = jsonDecode(response.body);
    // apiStatusCode = responseJson["statusCode"].toInt();
    // apiMessage = responseJson["message"].toString();
    //
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);

      String apiResponse = responseJson["response"].toString();

      List responseList = json.decode(response.body)["response"];
      return responseList.map((data) => cartModel.fromJson(data)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<void> _quantity(
      String cartId, String cProductName, String unitPrice) async {
    if (quantityController.text.toString().isEmpty) {
      helper.snackBarNotification("Please provide Amount limit", context);
      return;
    }

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.manageCart),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': basicAuth,
            },
            body: jsonEncode(<String, String>{
              "action": "editCart",
              "salesId": userId,
              "productName": cProductName,
              "quantity": quantityController.text.toString(),
              "unitPrice": "${widget.price}",
              "clientId": "${widget.selectedClientId}",
              "cartId": cartId,
              'auth': '${IP.Auth}'
            }))
        .catchError((err) {
      // progressDialog.hide();
      helper.alertDialogTitle(
          'something went wrong}', IP.errorMessageSomethingWentWrong, context);
    });

    if (response.statusCode != 200) {
      // progressDialog.hide();
      helper.alertDialogTitle(
          IP.errorMessageOops, IP.errorMessageSomethingWentWrong, context);
    }

    final responseJson = jsonDecode(response.body);
    apiStatusCode = responseJson["statusCode"].toInt();
    apiMessage = responseJson["message"].toString();

    if (apiStatusCode == 200) {
      // progressDialog.hide();
      helper.flushBar("Success", apiMessage, context);
      setState(() {
        _func = _getProduct();

        // _func = _getProduct();
        //  controller.addListener(onScroll);
      });
    } else if (apiStatusCode != 200) {
// progressDialog.hide();
      helper.alertDialogNoTitle(apiMessage, context);
    }
  }

  Future<void> _sum() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String userId = (prefs.getString('userId') ?? '');

    SimpleFontelicoProgressDialog progressDialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "Loading ...",
    );

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.manageOrderDetails),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': basicAuth,
              "Access-Control-Allow-Origin": "*",
            },
            body: jsonEncode(<String, String>{
              'action': "sellFromCart",
              'discount': integerValue.toString(),
              'auth': IP.Auth,
              'salesId': userId,
              "clientId": "${widget.selectedClientId}",
            }))
        .catchError((err) {
      progressDialog.hide();
      helper.alertDialogTitle(
          IP.errorMessageOops, IP.errorMessageSomethingWentWrong, context);
    });

    if (response.statusCode != 200) {
      // progressDialog.hide();
      helper.alertDialogTitle('${IP.errorMessageOops}',
          '${IP.errorMessageSomethingWentWrong}', context);
    }

    final responseJson = jsonDecode(response.body);
    apiStatusCode = responseJson["statusCode"].toInt();
    apiMessage = responseJson["message"].toString();

    if (apiStatusCode == 200) {
      final responseJson = jsonDecode(response.body);
      String orderId = responseJson["orderId"].toString();
      String totalPricee = responseJson["totalPrice"].toString();

      progressDialog.hide();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('orderId', orderId);
      prefs.setString('totalPricee', totalPricee);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => purchaseType(
                    selectedClientId: widget.selectedClientId,
                    phoneNumber: '${widget.phoneNumber}',
                    product: cProductName.toString(),
                    quantity: cQuantity.toString(),
                  )));

      //final counter = prefs.getString('phoneNumber') ?? 0;
      //prefs.remove ('counter');
    } else if (apiStatusCode != 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle('${apiMessage}', context);
    }
  }

  editQuant(
    String cProductName,
    String cartId,
    String cQuantity,
  ) {
    quantityController.text = cQuantity;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Column(
              children: [
                Text(
                  "${cProductName}",
                ),
                Text(
                  "Change Product Quantity No",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 17),
                ),
              ],
            ),
            content: TextFormField(
              controller: quantityController,
              decoration: InputDecoration(
                  // label: Text("Enter Quantity")
                  ),
            ),
            actions: [
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Update"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _quantity(cartId, cProductName, unitPrice);
                },
              )
            ],
          );
        });
  }

  delete(
    String cProductName,
    String cartId,
    String cQuantity,
  ) {
    quantityController.text = cQuantity;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete"),
            content: Text('Are you sure you want to Delete ${cProductName} '),
            actions: [
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Delete"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _delete(cartId, cProductName, unitPrice, cQuantity);
                },
              )
            ],
          );
        });
  }

  deleteAll(
    String cProductName,
    String cartId,
    String cQuantity,
  ) {
    quantityController.text = cQuantity;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Delete"),
            content:
                Text('Are you sure you want to Delete All Items from Cart'),
            actions: [
              TextButton(
                child: Text("No"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text("Delete"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _deleteAll(cartId, cProductName, unitPrice, cQuantity);
                },
              )
            ],
          );
        });
  }

  number() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Color.fromARGB(174, 255, 255, 255),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 130,
                    child: IntegerNumberPicker(
                      // otherItemsTextStyle: TextStyle(
                      //   color: Colors.black,
                      // ),
                      // pickedItemTextStyle: TextStyle(
                      //   color: Colors.blue,
                      // ),
                      initialValue: 5,
                      minValue: 0,
                      maxValue: 100,
                      onChanged: (i) => setState(() {
                        integerValue = i;
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          );
        });
  }
}
