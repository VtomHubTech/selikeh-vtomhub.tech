import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:rockman/Bottom_nav.dart';
import 'package:rockman/Helper.dart';
import 'package:rockman/Main_Page.dart';
import 'package:rockman/OTC_Register.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'OTC_Login.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sms_autofill/sms_autofill.dart';

import 'package:http/http.dart' as http;

import '../IP.dart';

class Login_Page extends StatefulWidget {
  const Login_Page({Key? key}) : super(key: key);

  @override
  State<Login_Page> createState() => _Login_PageState();
}

class _Login_PageState extends State<Login_Page> {
  bool passwordVisible = false;
  bool passwordConfirmationVisible = false;
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var emailAddressController = TextEditingController();

  int apiStatusCode = 0;
  String apiMessage = "", isUserLoggedIn = "";
  final Helper helper = new Helper();

  @override
  void initState() {
    _loadSharedPref();
    super.initState();
  }

  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isUserLoggedIn = (prefs.getString('isUserLoggedIn') ?? '');
    });
    if (isUserLoggedIn == "true") {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Bottom_Nav()),
        (Route<dynamic> route) => false,
      );
    }
  }

  void togglePassword() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    var passwordVisible2 = passwordVisible;

    Size size = MediaQuery.of(context).size;

    return Scaffold(
        // backgroundColor: Color.fromARGB(115, 121, 209, 33),

        body: Container(
      child: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          child: Stack(
            children: [
              SizedBox(
                height: size.height,
                child: Image.asset(
                  'assets/images/backgound.png',
                  // #Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                  fit: BoxFit.fitHeight,
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Expanded(
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 7,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
                          child: SizedBox(
                            width: size.width * .9,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: size.width * .15,
                                    bottom: size.width * .1,
                                  ),
                                  child: Text(
                                    'ROKMER PHARMACY',
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white.withOpacity(.8),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 255,
                                  height: 60,
                                  // margin: EdgeInsets.all(20),
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    controller: phoneNumberController,
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Colors.grey,
                                        ),
                                        labelText: "ID Number"),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width: 255,
                                  height: 60,
                                  // margin: EdgeInsets.all(20),
                                  child: TextFormField(
                                    controller: emailAddressController,
                                    // controller: passwordController,
                                    // obscureText: true,
                                    // obscureText: !passwordVisible,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      prefixIcon: Icon(
                                        Icons.lock_outlined,
                                        color: Colors.grey,
                                      ),
                                      labelText: "Email Address",

                                      // hintStyle: heading6.copyWith(color: textGrey),
                                      // suffixIcon: IconButton(
                                      //   color: Colors.grey,
                                      //   splashRadius: 1,
                                      //   icon: Icon(passwordVisible
                                      //       ? Icons.visibility_outlined
                                      //       : Icons.visibility_off_outlined),
                                      // onPressed: togglePassword,
                                    ),
                                  ),
                                ),
                                /* TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.green),
                    )),*/
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                    width: 200,
                                    height: 50,

                                    // margin: EdgeInsets.all(20),
                                    child: MaterialButton(
                                      color: Color.fromARGB(255, 1, 99, 5),
                                      onPressed: () {
                                        // Navigator.push(context,
                                        //     MaterialPageRoute(builder: (context) => OTC_Login()));
                                        _doLogin();
                                      },
                                      child: const Text('Login',
                                          style:
                                              TextStyle(color: Colors.black)),
                                    )),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _doLogin() async {
    if (phoneNumberController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please provide phone number")));
      return;
    }
    if (emailAddressController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please provide Email")));
      return;
    }

    SimpleFontelicoProgressDialog progressDialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "Loading ...",
    );

    String basicAuth = 'Basic' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.login),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': basicAuth,
              "Access-Control-Allow-Origin": "*",
            },
            body: jsonEncode(<String, String>{
              'phoneNumber': phoneNumberController.text.toString(),
              'emailAddress': emailAddressController.text.toString(),
              'auth': IP.Auth
            }))
        .catchError((err) {
      progressDialog.hide();
      helper.alertDialogTitle(
          IP.errorMessageOops, IP.errorMessageSomethingWentWrong, context);
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
      String apiResponse = responseJson["response"].toString();
      String userId = responseJson["response"][0]["UserId"].toString();
      String phoneNumber =
          responseJson["response"][0]["PhoneNumber"].toString();
      String firstName = responseJson["response"][0]["FirstName"].toString();
      String lastName = responseJson["response"][0]["LastName"].toString();
      String emailAddress =
          responseJson["response"][0]["EmailAddress"].toString();
      String merchantId = responseJson["response"][0]["MerchantId"].toString();

      progressDialog.hide();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', userId);
      prefs.setString('phoneNumber', phoneNumber);
      prefs.setString('firstName', firstName);
      prefs.setString('lastName', lastName);
      prefs.setString('emailAddress', emailAddress);
      prefs.setString('merchantId', merchantId);
      prefs.setString('isUserLoggedIn', "true");

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OTC_Login()),
          (Route<dynamic> route) => false);
      //Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNav()));

      //final counter = prefs.getString('phoneNumber') ?? 0;
      //prefs.remove ('counter');
    } else if (apiStatusCode != 200) {
      progressDialog.hide();
      // helper.alertDialogNoTitle('${apiMessage}', context);
      helper.alertDialogNoTitle('${apiMessage}', context);
    }
  }
}
