import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rockman/Bottom_nav.dart';
import 'package:rockman/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'Helper.dart';
import 'IP.dart';

class TopUp_Momo_Verify extends StatefulWidget {
  TopUp_Momo_Verify({required this.strTransactionId});

  String strTransactionId;

  @override
  _TopUp_Momo_VerifyState createState() => _TopUp_Momo_VerifyState();
}

class _TopUp_Momo_VerifyState extends State<TopUp_Momo_Verify> {
  int apiStatusCode = 0;
  String apiMessage = "";
  final Helper helper = new Helper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Top Up'),
      ),
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
      padding: EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 80,
          ),
          Text(
            'To Complete Top up, \n Please wait for a pop up \n and approve debit or go to\n your Mobile Money wallet \nand Complete pending \n approval. After debit is \n Successful, click the\n payment Button below.',
            style: heading2.copyWith(
                color: textBlack, fontStyle: FontStyle.italic),
          ),
          SizedBox(
            width: 10,
          ),
          MaterialButton(
            elevation: 15,
            height: 40,
            minWidth: 70,
            color: Colors.blue,
            textColor: Colors.white,
            child: Text("          Verify Payment            "),
            onPressed: () {
              _verifyTopUp();
            },
          ),
          SizedBox(
            height: 500,
          ),
        ],
      ),
    );
  }

  Future<void> _verifyTopUp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String merchantId = (prefs.getString('merchantId') ?? '');

    SimpleFontelicoProgressDialog progressDialog =
        SimpleFontelicoProgressDialog(
            context: context, barrierDimisable: false);
    progressDialog.show(
      message: "verifying  ...",
    );

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusernamee}:${IP.APIpasswordd}'));
    final response = await http
        .post(
            Uri.parse(
                "https://vtpayportal.online/vtomHub/vtomPay/api/merchant/receiveMomoCheck"),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': '$basicAuth',
            },
            body: jsonEncode(<String, String>{
              'transactionId': widget.strTransactionId,
              'merchantId': merchantId,
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
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: Text(apiMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Bottom_Nav()),
                  (Route<dynamic> route) => false,
                )
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
    } else if (apiStatusCode != 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle('${apiMessage}', context);
    }
  }
}
