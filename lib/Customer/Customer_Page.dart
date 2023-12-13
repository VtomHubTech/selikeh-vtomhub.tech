import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/services.dart';
import 'package:rockman/AdvancedPage.dart';
import 'package:rockman/Customer/Todo_list.dart';
import 'package:rockman/PDF/pdfpage.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

import '../Navigation_Dr.dart';
import '../Products/Products.dart';
import 'package:rockman/IP.dart';
import 'package:rockman/Helper.dart';
import 'Block_Customer.dart';
import 'Customer_Balance.dart';
import 'Customer_Credit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Customer_Order.dart';
import 'Customers_History.dart';

class Customer_Page extends StatefulWidget {
  Customer_Page({
    required this.strClientId,
    required this.fullName,
    required this.shopName,
    required this.emailAddress,
    required this.cPhoneNumber,
    required this.ghanaCardNumber,
    required this.address,
    required this.status,
    required this.image,
  });

  String? strClientId;
  String? fullName;
  String? shopName;
  String? emailAddress;
  String? cPhoneNumber;
  String? ghanaCardNumber;
  String? address;
  String? status;
  String image = "";

  @override
  State<Customer_Page> createState() => _Customer_PageState();
}

class _Customer_PageState extends State<Customer_Page> {
  String firstName = "";
  // String phoneNumber = "";
  // String emailAddress = "";
  String lastName = "";
  String? strClientId;
  String? fullName;
  String? shopName;
  String? emailAddress;
  String? cPhoneNumber;
  String? ghanaCardNumber;
  String? address;
  String? status;
  // String image = "https://via.placeholder.com/150";

  // @override
  // void initState() {
  //   super.initState();
  //   _loadSharedPref();
  // }

  String apiMessage = "";
  int apiStatusCode = 0;
  final Helper helper = new Helper();

  @override
  void initState() {
    // _func = _getProduct();
    Timer(Duration(seconds: 1), () {
      setState(() {
        _loadSharedPref();
        widget.image;
        // _doCheckImage();
      });
    });
    super.initState();
  }

  _loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      strClientId = (prefs.getString('strClientId') ?? '');
      fullName = (prefs.getString('fullName') ?? '');
      shopName = (prefs.getString('shopName') ?? '');
      cPhoneNumber = (prefs.getString('cPhoneNumber') ?? '');
      ghanaCardNumber = (prefs.getString('ghanaCardNumber') ?? '');
      emailAddress = (prefs.getString('emailAddress') ?? '');
      //image = (prefs.getString('image') ?? '');
      address = (prefs.getString('address') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        title: const Text("PROFILE"),
        centerTitle: true,
        actions: [],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: ((context) => PdfPage(
      //                   clientEmail: widget.emailAddress,
      //                   clientName: widget.shopName,
      //                   product: '',
      //                   quantity: '',
      //                 ))));
      //   },
      //   child: Icon(Icons.picture_as_pdf_outlined),
      // ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          // COLUMN THAT WILL CONTAIN THE PROFILE
          Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage("${widget.image}"),
              ),
              SizedBox(height: 10),
              Text(
                "${widget.fullName}",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text("${widget.shopName}")
            ],
          ),
          const SizedBox(height: 25),
          Row(
            children: [],
          ),
          const SizedBox(height: 10),
          Row(
            children: List.generate(5, (index) {
              return Expanded(
                child: Container(
                  height: 3,
                  margin: EdgeInsets.only(right: index == 4 ? 0 : 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: index == 0 ? Colors.black12 : Colors.black12,
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 180,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              // itemCount: 3,
              itemBuilder: (context, index) {
                // final card = profileCompletionCards[index];
                return Row(
                  children: [
                    SizedBox(
                      width: 160,
                      child: Card(
                        elevation: 7,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.location,
                                size: 30,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${widget.address}",
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      content: Text(
                                          "Clients Address \n${widget.address}"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => {
                                            Navigator.pop(context),
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text("Location"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: Card(
                        elevation: 7,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.phone,
                                size: 30,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${widget.cPhoneNumber}",
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      content: Text(
                                          "Client Phone Number \n${widget.cPhoneNumber}"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => {
                                            Navigator.pop(context),
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text("Contact"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: Card(
                        elevation: 7,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Icon(
                                CupertinoIcons.info,
                                size: 30,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "${widget.strClientId}",
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      content: Text(
                                          "Client Id Number \n${widget.strClientId}"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => {
                                            Navigator.pop(context),
                                          },
                                          child: const Text('Ok'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text("User Id"),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: Card(
                        elevation: 7,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Icon(
                                Icons.task,
                                size: 30,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "To Do",
                                textAlign: TextAlign.center,
                              ),
                              const Spacer(),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      content: Text(
                                          "Do you want to add client to ToDo list ?"),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () => {
                                            Navigator.pop(context),
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () => {
                                            Navigator.pop(context),
                                            _addT(),
                                          },
                                          child: const Text('Add To Task'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                child: Text("Add Task"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) =>
                  const Padding(padding: EdgeInsets.only(right: 5)),
              itemCount: 1,
            ),
          ),
          const SizedBox(height: 35),

          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Products_Page(
                                selectedClientId: widget.strClientId,
                                phoneNumber: '${widget.cPhoneNumber}',
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Icon(Icons.insights),
                      title: Text("Purchase Product"),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AdvancedPage(
                                selectedClientId: widget.strClientId,
                                phoneNumber: "${widget.cPhoneNumber}",
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart_checkout_outlined),
                      title: Text("Advanced Items"),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Customer_Credit(
                                selectedClientId: widget.strClientId,
                                phoneNumber: '${widget.cPhoneNumber}',
                              )));
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Icon(CupertinoIcons.creditcard),
                      title: Text("Credited Items"),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _addT() async {
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
              "clientName": "${widget.strClientId}",
              "userId": userId,
              "salesId": userId,
              "action": "assignDailyTask",
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

      helper.flushBar("Success", apiMessage, context);

      // Navigator.pushAndRemoveUntil(
      //     context,
      //     MaterialPageRoute(builder: (context) => ToDo()),
      //     (Route<dynamic> route) => false);
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

class ProfileCompletionCard {
  final String title;
  final String buttonText;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.buttonText,
    required this.icon,
  });
}

List<ProfileCompletionCard> profileCompletionCards = [
  ProfileCompletionCard(
    title: "Set Your Profile Details",
    icon: CupertinoIcons.person_circle,
    buttonText: "Continue",
  ),
  ProfileCompletionCard(
    title: "Upload your resume",
    icon: CupertinoIcons.doc,
    buttonText: "Upload",
  ),
  ProfileCompletionCard(
    title: "Add your skills",
    icon: CupertinoIcons.square_list,
    buttonText: "Add",
  ),
];

class CustomListTile {
  final IconData icon;
  final String title;
  CustomListTile({
    required this.icon,
    required this.title,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.insights,
    title: "Purchase Product",
  ),
  CustomListTile(
    icon: Icons.shopping_cart_checkout_outlined,
    title: "Advanced Items",
  ),
  CustomListTile(
    title: "Credited Items",
    icon: CupertinoIcons.creditcard,
  ),
  // CustomListTile(
  //   title: "Logout",
  //   icon: CupertinoIcons.arrow_right_arrow_left,
  // ),
];

/* Scaffold(
      appBar: AppBar(
        title: const Text('Customer Page'),
      ),
      // drawer: Navigation_Drawer(
      //
      // ),
      body: Container(
        padding: EdgeInsets.only(left: 10,  right: 10 ,top:20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
              children: [

            Container(

              height: 200 ,
              decoration: BoxDecoration(
                color: Colors.white
              ),
              // padding: EdgeInsets.only(left: 30, top: 16),
              child: Column(

                children: [

                  // Container(
                  //   // child: Image.network("${widget.image}"),
                  // ),

                  Container(

                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      child: Image.network(widget.image),

                    ),
                  ),
                  SizedBox(width: 50,),
                  Text("Client ID: ${widget.strClientId}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),)

                ],
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.only(left: 30,),
              child: Row(
                children: [
                  Text("Shop:", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                  SizedBox(width: 10,),
                  Text("${widget.shopName}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.green),)
                ],
              ),
            ),

            Container(
              padding: EdgeInsets.only(left: 30,top: 15),
              child: Row(
                children: [
                  Text("Contact: ${widget.cPhoneNumber}", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),)
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // Container(
            //     margin: EdgeInsets.all(10),
            //     height: (150),
            //     width: (100),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10.0),
            //       color: Colors.white,
            //       boxShadow: [
            //         BoxShadow(
            //             spreadRadius: 1,
            //             blurRadius: 3,
            //             offset: Offset(0, 6),
            //             color: Colors.black38
            //         )
            //       ]
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       SizedBox(height: 10,),
            //       Icon(Icons.add,size: 30,),
            //
            //       SizedBox(height: 10,),
            //       Text('Purchase \nProduct',
            //         style: TextStyle(fontSize: 20, color: Colors.blue),
            //       ),
            //
            //     ],
            //   ),
            // ),
            const Icon(
              Icons.location_on,
              color: Colors.red,
            ),Text(
              'Location: ${widget.address}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(
              height: 40,
            ),




            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Products_Page(selectedClientId: widget.strClientId,
)));
              },
              child: Container(
                height: 60,
                child: Card(
                  child: Row(children: [
                    SizedBox(width: 20,),
                    Icon(Icons.add,size: 30,),
                    SizedBox(width: 20,),
                    Text('Purchase Product',
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ],),
                  elevation: 7,
                ),

              ),
            ),
            const SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AdvancedPage(selectedClientId: widget.strClientId,)));
              },
              child: Container(
                height: 60,
                child: Card(
                  child: Row(children: [
                    SizedBox(width: 20,),
                    Icon(Icons.production_quantity_limits_rounded,size: 30,),
                    SizedBox(width: 20,),
                    Text('Advanced ${widget.strClientId}',style: TextStyle(fontSize: 20, color: Colors.blue),)
                  ],
                  ),
                  elevation: 7,
                ),

              ),
            ),
            SizedBox(height: 20,),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Customer_Credit(selectedClientId: widget.strClientId,)));
              },
              child: Container(
                height: 60,
                child: Card(
                  child: Row(children: [
                    SizedBox(width: 20,),
                    Icon(Icons.credit_card_off,size: 30,),
                    SizedBox(width: 20,),
                    Text('Credited',style: TextStyle(fontSize: 20, color: Colors.blue),)
                  ],),
                  elevation: 7,
                ),

              ),
            ),
            const SizedBox(
              height: 10,
            ),



            const SizedBox(
              height: 50,
            ),
          ]),
        ),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   label: const Text('PAY'),
      //   icon: const Icon(Icons.money),
      //   onPressed: () {
      //     Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const Payment_Model()));
      //   },
      // ),
    );*/
//   }
// }
