import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:rockman/Customer/Customer_Page.dart';
import 'package:rockman/Customer/Todo_list.dart';
import 'package:rockman/Customer/searchCustomer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:http/http.dart' as http;

import '../Helper.dart';
import '../IP.dart';
import '../shop_model.dart';
import '../ttt.dart';

class Shops extends StatefulWidget {
  // Shops({required this.selectedClient});
  //  String? selectedClient;

  @override
  State<Shops> createState() => _ShopsState();
}

class _ShopsState extends State<Shops> {
  // String value;
  // _SelectServiceState(this.value);
  // String card;
  int apiStatusCode = 0;
  String numberOfClient = "";

  //   int apiStatusCode = 0;
  // String apiMessage = "",phoneNumber = "";
  late Future<List<shopModel>> _func;
  @override
  void initState() {
    _func = _getShop();
    Timer(Duration(seconds: 1), () {
      setState(() {
        loadSharedPref();
      });
    });
    super.initState();
  }

  String userId = "",
      // phoneNumber = "",
      apiMessage = "",
      firstName = "",
      clientId = "",
      serviceName = "",
      cardNumber = "",
      department = "",
      organization = "",
      serviceDetails = "",
      availability = "",
      phoneNumber = "",
      name = "";
  final Helper helper = Helper();
  loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('userId') ?? '');
      // serviceId = (prefs.getString('serviceId') ?? '');
      // serviceName = (prefs.getString('serviceName') ?? '');
      // serviceDetails = (prefs.getString('serviceDetails') ?? '');
      cardNumber = (prefs.getString('cardNumber') ?? '');
      phoneNumber = (prefs.getString('phoneNumber') ?? '');
      numberOfClient = (prefs.getString('numberOfClient') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Shops'),
        leading: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text(
                numberOfClient,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),

        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => ToDo())));
                  },
                  icon: Icon(Icons.task)),
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) => Search())));
                  },
                  icon: Icon(Icons.search))
            ],
          )
        ],

        // backgroundColor: Colors.black,
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
                    Text('${Helper.noData}'),
                  ]);
                } else if (data.hasData) {
                  var items = data.data as List<shopModel>;
                  return ListView.builder(
                      itemCount: items == null ? 0 : items.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
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
                                        // gradient: LinearGradient(
                                        //   colors: [Colors.red, Colors.red],
                                        //   begin: Alignment.bottomLeft,
                                        //   end: Alignment.topRight,
                                        // ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50)),

                                        // image: DecorationImage(
                                        //   image: AssetImage(
                                        //     "assets/images/ec.png",
                                        //   ),
                                        //   fit: BoxFit.fill,
                                        // ),

                                        // color: Colors.black,
                                      ),
                                      child: Card(
                                        child: ListTile(
                                          title: Text(
                                            items[index].shopName.toString(),
                                            style: TextStyle(
                                                // fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20),
                                          ),
                                          onTap: () async {
                                            // Navigator.push(context, MaterialPageRoute(builder: (context)=> ttt(clientId: items[index].clientId.toString(),
                                            //
                                            // )));

                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Customer_Page(
                                                        fullName: items[index]
                                                            .fullName
                                                            .toString(),
                                                        shopName: items[index]
                                                            .shopName
                                                            .toString(),
                                                        emailAddress:
                                                            items[index]
                                                                .emailAddress
                                                                .toString(),
                                                        cPhoneNumber:
                                                            items[index]
                                                                .cPhoneNumber
                                                                .toString(),
                                                        ghanaCardNumber:
                                                            items[index]
                                                                .ghanaCardNumber
                                                                .toString(),
                                                        address: items[index]
                                                            .address
                                                            .toString(),
                                                        status: items[index]
                                                            .status
                                                            .toString(),
                                                        image: items[index]
                                                            .image
                                                            .toString(),
                                                        strClientId:
                                                            items[index]
                                                                .clientId
                                                                .toString(),
                                                      )),
                                            );
                                          },
                                          trailing: Container(
                                            child: Stack(
                                              children: [
                                                Text(
                                                  "${items[index].status.toString()}",
                                                  style: TextStyle(
                                                      color: Colors.blue),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                // Icon(Icons.verified,color:Colors.blue)
                                              ],
                                            ),
                                          ),
                                          leading: Icon(Icons.storefront),
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

  Future<List<shopModel>> _getShop() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.manageClient),
            headers: {
              'Content': 'application/x-www-form-urlencoded',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': basicAuth,
            },
            body: jsonEncode(<String, String>{
              'userId': userId,
              'salesId': userId,
              'action': 'view',
              'auth': "${IP.Auth}"
            }))
        .catchError((err) {
      //progressDialog.hide();
      helper.alertDialogTitle(Helper.errorMessageSomethingWentWrong,
          Helper.errorMessageSomethingWentWrong, context);
    });
    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      String apiResponse = responseJson["response"].toString();

      String numberOfClient = responseJson["NumberOfClient"].toString();
      clientId = responseJson["response"][0]["ClientId"].toString();
      // String clientId = responseJson["response"][0]["ClientId"].toString();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('numberOfClient', numberOfClient);
      List responseList = json.decode(response.body)["response"];
      return responseList.map((data) => shopModel.fromJson(data)).toList();
    }

    // final responseJson = jsonDecode(response.body);
    // apiStatusCode = responseJson["statusCode"].toInt();
    // apiMessage = responseJson["message"].toString();
    //
    // if (apiStatusCode == 200) {
    //   final responseJson = jsonDecode(response.body);
    //   String apiResponse = responseJson["response"].toString();
    //   String actor = responseJson["response"][0]["Actor"].toString();
    //   String userId = responseJson["response"][0]["UserId"].toString();
    //   String fullName = responseJson["response"][0]["Name"].toString();
    //   String organization = responseJson["response"][0]["Organization"]
    //       .toString();
    //   String department = responseJson["response"][0]["Department"].toString();
    //   String cardNumber = responseJson["response"][0]["CardNumber"].toString();
    //
    //   // progressDialog.hide();
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   prefs.setString('actor', actor);
    //   prefs.setString('userId', userId);
    //   prefs.setString('fullName', fullName);
    //   prefs.setString('organization', organization);
    //   prefs.setString('department', department);
    //   prefs.setString('cardNumber', cardNumber);
    //
    //
    //   //Navigator.push(context, MaterialPageRoute(builder: (context) => Church_Admin_Select_Organization2()));
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => child_details()),
    //   );

    else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

// Future<void> _createQue() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   String adminId = (prefs.getString('userId') ?? '');
//
//   if (cardNumberController.text.toString().isEmpty) {
//     helper.flushBar("Warning",
//         "Please provide client phone number / card number", context);
//     return;
//   }
//
//   SimpleFontelicoProgressDialog progressDialog =
//   SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
//   progressDialog.show(
//     message: "Loading ...",
//   );
//
//   String basicAuth = 'Basic ' +
//       base64Encode(
//           utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
//   final response = await http
//       .post(Uri.parse(ApiUrl.adminManageQue),
//       headers: {
//         'Content': 'application/x-www-form-urlencoded',
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': '$basicAuth',
//         "Access-Control-Allow-Origin":
//         "*", // Required for CORS support to work
//       },
//       body: jsonEncode(<String, String>{
//         // 'cardNumber': cardNumberController.text.toString(),
//         'adminId': '$adminId',
//         'department': departmentName,
//         'service': serviceName.toString(),
//         'cardNumber': value,
//         'action': 'create',
//         'auth': '${ApiUrl.Auth}'
//       }))
//       .catchError((err) {
//     progressDialog.hide();
//     helper.alertDialogTitle(Helper.errorMessageOops,
//         Helper.errorMessageSomethingWentWrong, context);
//   });
//
//   if (response.statusCode != 200) {
//     progressDialog.hide();
//     helper.alertDialogTitle(Helper.errorMessageOops,
//         Helper.errorMessageSomethingWentWrong, context);
//   }
//
//   final responseJson = jsonDecode(response.body);
//   apiStatusCode = responseJson["statusCode"].toInt();
//   apiMessage = responseJson["message"].toString();
//
//   if (apiStatusCode == 200) {
//     progressDialog.hide();
//     helper.flushBar("Success", apiMessage, context);
//
//     serviceName = serviceName.toString();
//     // cardNumber = "";
//   } else if (apiStatusCode != 200) {
//     progressDialog.hide();
//     helper.alertDialogNoTitle(apiMessage, context);
//   }
//   Navigator.push(
//       context, MaterialPageRoute(builder: (context) => Present_Card()));
//
// }

//   Future<void> _createQue() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String adminId = (prefs.getString('userId') ?? '');
//     String cardNumber = (prefs.getString('cardNumberId') ?? '');
//     String serviceName = (prefs.getString('service') ?? '');
//     String departmentName = (prefs.getString('departmentName') ?? '');

//     SimpleFontelicoProgressDialog progressDialog =
//         SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
//     progressDialog.show(
//       message: "Loading ...",
//     );

//     String basicAuth = 'Basic ' +
//         base64Encode(
//             utf8.encode('${ApiUrl.APIusername}:${ApiUrl.APIpassword}'));
//     final response = await http
//         .post(Uri.parse(ApiUrl.adminManageQue),
//             headers: {
//               'Content': 'application/x-www-form-urlencoded',
//               'Content-Type': 'application/json',
//               'Accept': 'application/json',
//               'Authorization': '$basicAuth',
//               "Access-Control-Allow-Origin":
//                   "*", // Required for CORS support to wor
//             },
//             body: jsonEncode(<String, String>{
//               'adminId': '$adminId',
//               'serviceName': ServiceName,
//               'departmentName': departmentName,
//               'action': 'create',
//               'cardNumber': value,
//               'auth': '${ApiUrl.Auth}'
//             }))
//         .catchError((err) {
//       progressDialog.hide();
//       helper.alertDialogTitle(Helper.errorMessageOops,
//           Helper.errorMessageSomethingWentWrong, context);
//     });

//     if (response.statusCode != 200) {
//       progressDialog.hide();
//       helper.alertDialogTitle(Helper.errorMessageOops,
//           Helper.errorMessageSomethingWentWrong, context);
//     }

//     final responseJson = jsonDecode(response.body);
//     apiStatusCode = responseJson["statusCode"].toInt();
//     apiMessage = responseJson["message"].toString();

//     if (apiStatusCode == 200) {
//       progressDialog.hide();
//       helper.flushBar("Success", apiMessage, context);
//       // speak(apiCall);

//       Navigator.push(
//           context, MaterialPageRoute(builder: (context) => Present_Card()));

//       // serviceController.text = "";
//       //  cardNumberController.text = "";
//     } else if (apiStatusCode != 200) {
//       progressDialog.hide();
//       helper.alertDialogNoTitle(apiMessage, context);
//     }
//   }
// }
}
