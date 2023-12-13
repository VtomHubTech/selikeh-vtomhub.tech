import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:rockman/Customer/Customers_List.dart';
import 'package:rockman/Helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../IP.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  Helper helper = new Helper();
  String apiMessage = "";
  int apiStatusCode = 0;
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            // filled: true,
            hintText: "Enter client Name",
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                search_();
              },
              icon: Icon(Icons.search))
        ],
      ),
    );
  }

  Future<void> search_() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');

    SimpleFontelicoProgressDialog progressDialog =
        SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "Loading ...",
    );

    String basicAuth = 'Basic' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.manageClient),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': basicAuth,
              "Access-Control-Allow-Origin": "*",
            },
            body: jsonEncode(<String, String>{
              "userId": userId,
              "salesId": userId,
              "action": "searchClient",
              "clientId": searchController.text.toString(),
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
      // String apiResponse = responseJson["response"].toString();
      // String userId = responseJson["response"][0]["UserId"].toString();
      // String phoneNumber = responseJson["response"][0]["PhoneNumber"].toString();
      // String firstName = responseJson["response"][0]["FirstName"].toString();
      // String lastName = responseJson["response"][0]["LastName"].toString();
      // String emailAddress = responseJson["response"][0]["EmailAddress"].toString();
      // String merchantId = responseJson["response"][0]["MerchantId"].toString();

      progressDialog.hide();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('userId', userId);
      // prefs.setString('phoneNumber', phoneNumber);
      // prefs.setString('firstName', firstName);
      // prefs.setString('lastName', lastName);
      // prefs.setString('emailAddress', emailAddress);
      // prefs.setString('merchantId', merchantId);
      // prefs.setString('isUserLoggedIn', "true");

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Shops()),
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
