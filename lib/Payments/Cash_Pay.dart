import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rockman/Bottom_nav.dart';
import 'package:rockman/Customer/Customer_Page.dart';
import 'package:rockman/Customer/Customers_List.dart';
import 'package:rockman/Helper.dart';
import 'package:rockman/PDF/pdfpage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../IP.dart';

class Cash_Pay extends StatefulWidget {
  Cash_Pay({
    required this.selectedClientId,
    required this.phoneNumber,
    required this.product,
    required this.quantity,
  });
  String? selectedClientId;
  String? phoneNumber;
  String? product;
  String? quantity;

  @override
  State<Cash_Pay> createState() => _Cash_PayState();
}

class _Cash_PayState extends State<Cash_Pay> {
  final Helper helper = new Helper();
  int apiStatusCode = 0;
  String apiMessage = "";
  String totalPricee = "";
  String orderId = "";

  var payCashController = TextEditingController();
  var referenceController = TextEditingController();
  var repsNameController = TextEditingController();
  var discountProductController = TextEditingController();
  var discountQuantityController = TextEditingController();

  @override
  void initState() {
    // payCashController.text = totalPricee;
    _loadSharedPref();
    super.initState();
  }

  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      payCashController.text = (prefs.getString('totalPricee') ?? '');
      orderId = (prefs.getString('orderId') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cash Payment'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 50,),
              // Text('Sage',style: TextStyle(color: Colors.green,fontSize: 40,fontWeight:FontWeight.bold),),

              SizedBox(
                height: 30,
              ),
              Text(
                'Cash Payment ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 20,
              ),

              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: TextField(
                  enabled: false,
                  focusNode: FocusNode(),
                  controller: payCashController,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.call,color: Colors.grey,),
                      labelText: "Amount"),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: TextField(
                  controller: repsNameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.call,color: Colors.grey,),
                      labelText: "reps Name"),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: TextField(
                  controller: discountProductController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.call,color: Colors.grey,),
                      labelText: "Discount Product Name"),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: TextField(
                  controller: discountQuantityController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.call,color: Colors.grey,),
                      labelText: "Discount Quantity"),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: TextField(
                  controller: referenceController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.call,color: Colors.grey,),
                      labelText: "Reference"),
                ),
              ),

              SizedBox(
                height: 25,
              ),
              Container(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      _payCash();
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>OTC_Page()));
                    },
                    child:
                        Text('Submit', style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _payCash() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');
    // String clientId = (prefs.getString('clientId') ?? '');
    if (repsNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please provide Reps Name")));
      return;
    }

    SimpleFontelicoProgressDialog progressDialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "Loading ...",
    );

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.managePurchase),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': '$basicAuth',
            },
            body: jsonEncode(<String, String>{
              "action": "payByCash",
              "salesId": userId,
              "clientId": "${widget.selectedClientId}",
              "reference": referenceController.text.toString(),
              'repFullName': repsNameController.text.toString(),
              "amountPaid": payCashController.text.toString(),
              "phoneNumber": "${widget.phoneNumber}",
              "orderId": orderId,
              'auth': '${IP.Auth}'
            }))
        .catchError((err) {
      progressDialog.hide();
      helper.alertDialogTitle('${IP.errorMessageOops}',
          '${IP.errorMessageSomethingWentWrong}', context);
    });

    if (response.statusCode != 200) {
      progressDialog.hide();
      helper.alertDialogTitle('${IP.errorMessageOops}',
          '${IP.errorMessageSomethingWentWrong}', context);
    }

    final responseJson = jsonDecode(response.body);
    apiStatusCode = responseJson["statusCode"].toInt();
    apiMessage = responseJson["message"].toString();

    if (apiStatusCode == 200) {
      final responseJson = jsonDecode(response.body);

      progressDialog.hide();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      /*     showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("To complete payment click on Finish"),
              actions: [
                TextButton(
                  child: Text("Finish Payment"),
                  onPressed: () {
                    _purchase();
                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> Bottom_Nav()),
                    //         (Route<dynamic> route) => false);


                     payCashController.text = "";
                     referenceController.text = "";
                    // pinController.text = "";
                  },
                )
              ],
            );
          });*/
      setState(() {
        _purchase();
      });

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => OTC_Login()));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Customer_Page(clientId: "", fullName: '', shopName: '', emailAddress: '', cPhoneNumber: '', ghanaCardNumber: '', address: '', status: '', image: '')));

      //final counter = prefs.getString('phoneNumber') ?? 0;
      //prefs.remove ('counter');
    } else if (apiStatusCode != 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle("${apiMessage}", context);
    }
  }

  Future<void> _purchase() async {
    // if (chequeNoController.text.toString().isEmpty) {
    //   helper.snackBarNotification("Please provide Valid Cheque Number", context);
    //   return;
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');
    String orderId = (prefs.getString('orderId') ?? '');

    SimpleFontelicoProgressDialog progressDialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "Loading ...",
    );

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.managePurchase),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': '$basicAuth',
            },
            body: jsonEncode(<String, String>{
              "action": "purchase",
              "salesId": userId,
              "salesPerson": userId,
              "clientId": "${widget.selectedClientId}",
              "clientName": "${widget.selectedClientId}",
              "orderId": orderId,
              "phoneNumber": "${widget.phoneNumber}",
              "purchaseType": "Instant",
              "paymentMode": "cash",
              "discountProduct": discountProductController.text.toString(),
              "discountQuantity": discountQuantityController.text.toString(),
              'auth': '${IP.Auth}'
            }))
        .catchError((err) {
      progressDialog.hide();
      helper.alertDialogTitle('${IP.errorMessageOops}',
          '${IP.errorMessageSomethingWentWrong}', context);
    });

    if (response.statusCode != 200) {
      progressDialog.hide();
      helper.alertDialogTitle('${IP.errorMessageOops}',
          '${IP.errorMessageSomethingWentWrong}', context);
    }

    final responseJson = jsonDecode(response.body);
    apiStatusCode = responseJson["statusCode"].toInt();
    apiMessage = responseJson["message"].toString();

    if (apiStatusCode == 200) {
      final responseJson = jsonDecode(response.body);

      progressDialog.hide();
      SharedPreferences prefs = await SharedPreferences.getInstance();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Bottom_Nav()),
          (Route<dynamic> route) => false);

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => OTC_Login()));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Customer_Page(clientId: "", fullName: '', shopName: '', emailAddress: '', cPhoneNumber: '', ghanaCardNumber: '', address: '', status: '', image: '')));

      //final counter = prefs.getString('phoneNumber') ?? 0;
      //prefs.remove ('counter');
    } else if (apiStatusCode != 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle("${apiMessage}", context);
    }
  }
}
