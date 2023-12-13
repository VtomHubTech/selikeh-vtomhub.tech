import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../Helper.dart';
import '../IP.dart';
import '../momo_verify.dart';

class TopUp_Momo extends StatefulWidget {
  const TopUp_Momo({Key? key}) : super(key: key);

  @override
  _TopUp_MomoState createState() => _TopUp_MomoState();
}

class _TopUp_MomoState extends State<TopUp_Momo> {
  var amountController = TextEditingController();
  var accountController = TextEditingController();
  var referenceController = TextEditingController();
  var pinController = TextEditingController();
  int apiStatusCode1 = 0;
  String apiMessage1 = "";
  int apiStatusCode2 = 0;
  String apiMessage2 = "";
  String totalCashPricee = "";
  String receiverName = "";
  String appPlatform = "";
  String mobileNetwork = "";
  String transactionId = "";
  final Helper helper = new Helper();
  bool editableAccNo = false;
  bool nonEditableAccNo = true;
  int viewEditableAccountNo = 0;

  @override
  void initState() {
    _loadSharedPref();
    super.initState();
  }

  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      amountController.text = (prefs.getString('totalPricee') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MOMO Payment'),
      ),
      backgroundColor: Colors.white,
      /*body: SingleChildScrollView(
        child: _userInterface(),
      ),*/
      //backgroundColor: Colors.green.shade200,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/clipart_background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: _userInterface(),
        ),
      ),
    );
  }

  Widget _userInterface() {
    return Container(
      color: Colors.white.withOpacity(0.5),
      padding: EdgeInsets.all(50.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset(
              'assets/images/icon_momo_transfer.png',
              width: 80,
              height: 80,
            ),

            SizedBox(
              height: 20,
            ),

            Container(
                width: 300,
                child: TextField(
                  enabled: false,
                  focusNode: FocusNode(),
                  enableInteractiveSelection: false,
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(),
                    labelText: 'Amount',
                  ),
                )),
            SizedBox(
              height: 10,
            ),

            // Visibility(
            //   visible: editableAccNo,
            //   child: Container(
            //     width: 300,
            //     child: TextField(
            //       controller: accountController,
            //       keyboardType: TextInputType.number,
            //       decoration: InputDecoration(
            //         fillColor: Colors.white,
            //         filled: true,
            //         border: OutlineInputBorder(),
            //         labelText: 'Mobile Number',
            //       ),
            //     ),
            //   ),
            // ),

            // Visibility(
            //   visible: nonEditableAccNo,
            //   child:
            Container(
              width: 300,
              child: TextField(
                // enabled: false,
                // focusNode: FocusNode(),
                // enableInteractiveSelection: false,
                controller: accountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // fillColor: Colors.white,
                  // filled: true,
                  border: OutlineInputBorder(),
                  labelText: 'Mobile Number',
                ),
              ),
            ),
            // ),

            SizedBox(
              height: 10,
            ),

            Container(
              width: 300,
              child: TextField(
                controller: pinController,
                maxLength: 4,
                obscureText: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(),
                  labelText: 'PIN',
                ),
              ),
            ),

            SizedBox(
              height: 10,
              // width: 200,
            ),

            Container(
                // width: 100,
                child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/momo_icon_mtn.png',
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  elevation: 10,
                  height: 50,
                  minWidth: 60,
                  color: Colors.orange,
                  textColor: Colors.white,
                  splashColor: Colors.orangeAccent,
                  child: new Text('          MTN Mobile Money          '),
                  onPressed: () {
                    mobileNetwork = "MTN";
                    doMomoTopUp();
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),

            SizedBox(
              height: 15,
              // width: 200,
            ),

            Container(
                child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/momo_icon_airtel.png',
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  elevation: 10,
                  height: 50,
                  minWidth: 60,
                  color: Colors.red,
                  textColor: Colors.white,
                  splashColor: Colors.redAccent,
                  child: new Text('          Airtel Mobile Money          '),
                  onPressed: () {
                    mobileNetwork = "Airtel";
                    doMomoTopUp();
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),

            SizedBox(
              height: 15,
              // width: 200,
            ),

            Container(
                child: Row(
              children: <Widget>[
                Image.asset(
                  'assets/images/momo_icon_tigo.png',
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  elevation: 10,
                  height: 50,
                  minWidth: 60,
                  color: Colors.blue,
                  textColor: Colors.white,
                  splashColor: Colors.blueAccent,
                  child: new Text('          Tigo Mobile Money          '),
                  onPressed: () {
                    mobileNetwork = "Tigo";
                    doMomoTopUp();
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),

            SizedBox(
              height: 15,
            ),

            Container(
                child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _enableEditing();
                  },
                  child: Image.asset(
                    'assets/images/vodafone_money.png',
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                MaterialButton(
                  elevation: 10,
                  height: 50,
                  minWidth: 60,
                  color: Colors.red,
                  textColor: Colors.white,
                  splashColor: Colors.redAccent,
                  child: new Text('              Vodafone Cash             '),
                  onPressed: () {
                    mobileNetwork = "Vodafone";
                    doMomoTopUp();
                  },
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            )),

            SizedBox(
              height: 100,
            ),

            //Text('All Networks', style: heading5.copyWith(color: Colors.grey,fontSize: 15 ),),
          ]),
    );
  }

  Future<void> doMomoTopUp() async {
    // if (Platform.isAndroid) {
    //   appPlatform = "Android";
    // }
    // if (Platform.isIOS) {
    //   appPlatform = "IOS";
    // }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');
    String phoneNumber = (prefs.getString('phoneNumber') ?? '');
    String merchantId = (prefs.getString('merchantId') ?? '');

    if (amountController.text.toString().isEmpty) {
      helper.snackBarNotification("Please provide amount", context);
      return;
    }
    if (accountController.text.toString().isEmpty) {
      helper.snackBarNotification("Please provide mobile number", context);
      return;
    }
    if (pinController.text.toString().isEmpty) {
      helper.snackBarNotification("Please provide your vtom PIN", context);
      return;
    }

    SimpleFontelicoProgressDialog progressDialog =
        SimpleFontelicoProgressDialog(
            context: context, barrierDimisable: false);
    progressDialog.show(
      message: "loading ...",
    );

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusernamee}:${IP.APIpasswordd}'));
    final response = await http
        .post(
            Uri.parse(
                "https://vtpayportal.online/vtomHub/vtomPay/api/merchant/receiveMomo"),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': '$basicAuth',
            },
            body: jsonEncode(<String, String>{
              'merchantId': merchantId,
              'momoNumber': accountController.text.toString(),
              'amount': amountController.text.toString(),
              'passCode': pinController.text.toString(),
              'network': mobileNetwork,
              'platform': appPlatform,
              "feeOnCustomer": "1",
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
    apiStatusCode2 = responseJson["statusCode"].toInt();
    apiMessage2 = responseJson["message"].toString();

    if (apiStatusCode2 == 200) {
      progressDialog.hide();
      final responseJson = jsonDecode(response.body);
      String apiResponse = responseJson["response"].toString();
      String userId = responseJson["response"][0]["Reference"].toString();
      String phoneNumber = responseJson["response"][0]["MerchantId"].toString();
      transactionId = responseJson["response"][0]["TransactionId"].toString();

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TopUp_Momo_Verify(
                    strTransactionId: transactionId,
                  )));
    } else if (apiStatusCode2 != 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle('${apiMessage2}', context);
    }
  }

  void _enableEditing() {
    if (viewEditableAccountNo > 18) {
      setState(() {
        accountController.text = "";
        editableAccNo = true;
        nonEditableAccNo = false;
      });
    } else {
      setState(() {
        viewEditableAccountNo++;
      });
    }
  }
}
