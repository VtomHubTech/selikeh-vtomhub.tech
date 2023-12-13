import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rockman/Payments/Payment_Model.dart';
import 'package:rockman/PurchaseTypeModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'Bottom_nav.dart';
import 'Helper.dart';
import 'IP.dart';

class purchaseType extends StatefulWidget {
  purchaseType({
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
  State<purchaseType> createState() => _purchaseTypeState();
}

class _purchaseTypeState extends State<purchaseType> {
  int apiStatusCode = 0;
  String apiMessage = "";
  String totalPricee = "";
  String orderId = "";

  late Future<List<PurchaseModel>> _func;

  final Helper helper = new Helper();
  @override
  void initState() {
    super.initState();
    _loadSharedPref();
    // _doCheckBonus();
    // _doCheckProfilePic();
    _func = _getPurchaseType();
  }

  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      totalPricee = (prefs.getString('totalPricee') ?? '');
      orderId = (prefs.getString('orderId') ?? '');
      // userId = (prefs.getString('userId') ?? '');
      // _getBalance();

      // _wards();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Purchase Type'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Stack(
          children: [
            SizedBox(
              height: 20,
            ),
            tUi(),
            pT(),
          ],
        ),
      ),
    );
  }

  Widget tUi() {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
        child: Container(
          height: 200,
          margin: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
            // color: Colors.blue,
            // color: Color.fromARGB(255, 2, 27, 65),
            gradient: LinearGradient(
              colors: [Colors.teal, Colors.blue],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(20)),

            // image: DecorationImage(
            //   image: AssetImage(
            //     "assets/images/ec.png",
            //   ),
            //   fit: BoxFit.fill,
            // ),

            // color: Colors.black,
          ),
          // padding:
          //     EdgeInsets.only(bottom: 50, left: 10, right: 10, top: 5),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Rockmer Pharmacy",
                      style: TextStyle(
                          fontStyle: FontStyle.italic,
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.w800),
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.blue,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "  TOTAL AMOUNT",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  "GHC ${totalPricee}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  '${orderId}',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontStyle: FontStyle.italic,
                      // fontWeight: FontWeight.bold,
                      letterSpacing: 1.0),
                )
              ]),
        ),
      ),
    );
  }

  Widget pT() => Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 235, left: 20, right: 20),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Payment_Model(
                                  selectedClientId: widget.selectedClientId,
                                  phoneNumber: '${widget.phoneNumber}',
                                  product: widget.product,
                                  quantity: widget.quantity,
                                )));
                  },
                  child: Container(
                    height: 60,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.money,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Instant Payment',
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          )
                        ],
                      ),
                      elevation: 7,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Text(
                            "Are you Sure  You want To \n Purchase Item In Advanced?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => {
                              Navigator.pop(context),
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () => {_advancedPurchase()},
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    height: 70,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.sell_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Advanced Purchased',
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          )
                        ],
                      ),
                      elevation: 7,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        content: Text(
                            "Are you Sure  You want To \n Purchase Item on Credit?"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => {
                              Navigator.pop(context),
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextButton(
                            onPressed: () => {
                              _creditPurchase(),
                            },
                            child: const Text('Yes'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Container(
                    height: 70,
                    child: Card(
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.credit_card_off_outlined,
                            size: 30,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Credited Purchase',
                            style: TextStyle(fontSize: 20, color: Colors.blue),
                          )
                        ],
                      ),
                      elevation: 7,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );

  Future<List<PurchaseModel>> _getPurchaseType() async {
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
              'Authorization': '$basicAuth',
            },
            body: jsonEncode(<String, String>{
              'salesId': userId,
              'action': 'viewPurchaseType',
              'clientId': "${widget.selectedClientId}",
              'auth': "${IP.Auth}"
            }))
        .catchError((err) {
      // progressDialog.hide();
      helper.alertDialogTitle(
          IP.errorMessageOops, IP.errorMessageSomethingWentWrong, context);
    });

    if (response.statusCode == 200) {
      List responseList = json.decode(response.body)["response"];
      return responseList.map((data) => PurchaseModel.fromJson(data)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<void> _advancedPurchase() async {
    // if (chequeNoController.text.toString().isEmpty) {
    //   helper.snackBarNotification("Please provide Valid Cheque Number", context);
    //   return;
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');
    String clientId = (prefs.getString('clientId') ?? '');
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
              'clientId': "${widget.selectedClientId}",
              "clientName": "${widget.selectedClientId}",
              "phoneNumber": "${widget.phoneNumber}",
              "orderId": '${orderId}',
              "purchaseType": "Advanced",
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
      progressDialog.hide();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(apiMessage),
              actions: [
                TextButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Bottom_Nav()),
                        (Route<dynamic> route) => false);
                    // cardNumberController.text = "";
                    // pinController.text = "";
                  },
                ),
              ],
            );
          });
    } else if (apiStatusCode != 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle("${apiMessage}", context);
    }
  }

  Future<void> _creditPurchase() async {
    // if (chequeNoController.text.toString().isEmpty) {
    //   helper.snackBarNotification("Please provide Valid Cheque Number", context);
    //   return;
    // }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');
    String clientId = (prefs.getString('clientId') ?? '');
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
              "purchaseType": "Credited",
              "phoneNumber": "${widget.phoneNumber}",
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
      progressDialog.hide();
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(apiMessage),
              actions: [
                TextButton(
                  child: Text("Okay"),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Bottom_Nav()),
                        (Route<dynamic> route) => false);
                    // pinController.text = "";
                  },
                )
              ],
            );
          });
    } else if (apiStatusCode != 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle("${apiMessage}", context);
    }
  }
}
