import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rockman/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:http/http.dart' as http;
import 'package:pin_code_fields/pin_code_fields.dart';

import 'Bottom_nav.dart';
import 'Helper.dart';
import 'IP.dart';
class OTC_Login extends StatefulWidget {
  const OTC_Login({Key? key}) : super(key: key);

  @override
  _OTC_LoginState createState() => _OTC_LoginState();
}

class _OTC_LoginState extends State<OTC_Login> {
  var otcController = TextEditingController();
  int apiStatusCode1 = 0;
  String apiMessage1 = "";
  int apiStatusCode2 = 0;
  String apiMessage2 = "";
  final Helper helper = new Helper();


  @override
  void initState() {
     _getOTC();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: _userInterface(),
      ),
    );
  }

  Widget _userInterface() {
    return Container(
        color: Colors.white.withOpacity(0.5),
        padding: EdgeInsets.all(40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                'Confirm OTC Code',
                textAlign: TextAlign.center,
                style: heading2.copyWith(color: textBlack),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                decoration: BoxDecoration(
                  color: textWhiteGrey,
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child:  PinCodeTextField(
                  controller: otcController,
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 4,
                  // obscureText: true,
                  // obscuringCharacter: '*',

                  // blinkWhenObscuring: true,
                  // animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "Validate me";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.blueAccent,
                      inactiveFillColor: Colors.white),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  // errorAnimationController: errorController,
                  // controller: textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      // currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              MaterialButton(
                elevation: 15,
                color: Colors.blue,
                textColor: Colors.white,
                child: Text("Verify OTC"),
                onPressed: () {
                   _verifyOTC();
                },
              ),
             SizedBox(height: 20,),

             TextButton(onPressed: (){
               _getOTC();
             }, child: Text("RESEND OTC")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  // Text(
                  //   'Resend OTC',
                  //   style:
                  //       regular16pt.copyWith(color: Colors.black, fontSize: 15),
                  // ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ]));
  }

  Future<void> _getOTC() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
     String emailAddress = (prefs.getString('emailAddress') ?? '');
    String phoneNumber = (prefs.getString('phoneNumber') ?? '');

    SimpleFontelicoProgressDialog progressDialog =
    SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "Sending OTC ...",
    );

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.getOTC),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
        },
        body: jsonEncode(<String, String>{
          // 'appHash': '${IP.hashedSignature}',
          'phoneNumber': phoneNumber,
          'auth': '${IP.Auth}',
          'email': emailAddress,
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
    apiStatusCode1 = responseJson["statusCode"].toInt();
    apiMessage1 = responseJson["message"].toString();

    if (apiStatusCode1 == 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle('${apiMessage1}', context);
    } else if (apiStatusCode1 != 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle('${apiMessage1}', context);
    }
  }

  Future<void> _verifyOTC() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // String email = (prefs.getString('email') ?? '');
    String phoneNumber = (prefs.getString('phoneNumber') ?? '');

    if (otcController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please provide OTC")));
      return;
    }

    SimpleFontelicoProgressDialog progressDialog =
    SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "verifying OTC ...",
    );

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.verifyOTC),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': '$basicAuth',
        },
        body: jsonEncode(<String, String>{
          'phoneNumber': phoneNumber,
          // 'email': email,
          'code': otcController.text,
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
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('isUserLoggedIn', "true");

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Bottom_Nav()),
            (Route<dynamic> route) => false,
      );
      //Navigator.pop(context,);

    } else if (apiStatusCode2 != 200) {
      progressDialog.hide();
      helper.alertDialogTitle('${IP.errorMessageOops}',
          '${IP.errorMessageSomethingWentWrong}', context);
    }
  }
}
