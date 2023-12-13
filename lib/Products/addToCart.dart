// ignore_for_file: deprecated_member_use
import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rockman/Helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:http/http.dart' as http;
import '../Customer/Register_Customer.dart';
import '../IP.dart';
import '../Payments/Payment_Model.dart';
import 'Cart.dart';
import 'Nose_mask_pro.dart';


class Product_Cart extends StatefulWidget {
  Product_Cart({required this.productName, required this.productId, required this.price, required this. quantity, required this.expiredDate,
    required this.description, required this.status, required this.image,required this.salesId,
    required this.selectedClientId, required this.phoneNumber, required this.creditedPrice
  });

  String productName = "";
  String productId = "";
  String price = "";
  String creditedPrice = "";
  String quantity = "";
  String description = "";
  String status = "";
  String image = "";
  String expiredDate = "";
  String salesId = "";
  String selectedClientId = "";
  String phoneNumber = "";

  @override
  State<Product_Cart> createState() => _Product_CartState();
}

class _Product_CartState extends State<Product_Cart> {


  // String productName = "";
  String department = "";
  String organization = "";
  String cardNumber = "";
  String userId = "";
  var childNameController = TextEditingController();
  var childCardNumberController = TextEditingController();
  var uAController = TextEditingController();
  String productName = "";
  String productId = "";
  String quantity = "";
  String description = "";
  String status = "";
  String image = "";
  String salesId = "";
  String clientId = "";
  String expiredDate = "";
  int apiStatusCode = 0;
  String apiMessage = "";


  String unitPriceA = "";
  String unitPriceB = "";

  final Helper helper = new Helper();

  @override
  void initState() {
    super.initState();
    _getProductData();
    // _getBalance();
    // _doCheckProfilePic();
    // _getPrepaidCards();
  }



  _getProductData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    productId = (prefs.getString('productId') ?? '');
    productName = (prefs.getString('productName') ?? '');
    quantity = (prefs.getString('quantity') ?? '');

    description = (prefs.getString('description') ?? '');
    userId = (prefs.getString('userId') ?? '');
    clientId = (prefs.getString('clientId') ?? '');

    unitPriceA = widget.price;
    unitPriceB = widget.creditedPrice;


    Timer(Duration(seconds: 0), () {
      setState(() {

      });
    });
  }
  String pType = 'Cash Price';

  // List of items in our dropdown menu
  var items = [
    'Cash Price',
    'Credited Price',

  ];
  String _message = "";

    @override
    Widget build(BuildContext context) {
      return /*Scaffold(

        body: Container(
          color: Colors.white,
          // padding: EdgeInsets.only(bottom: 20),
          child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(

                    height: 300,
                    child: Image.network(widget.image),
                    // child: Card(
                    //   elevation: 20,
                    // ),

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    child:
                        Column(
                          children: [

                            Text(widget.productName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),),
                           SizedBox(height: 20,),

                           Text("Price ₵${widget.price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),) ,
                    ]
                        ),
                  ),

 Text(widget.status,style: TextStyle(fontWeight: FontWeight.bold,fontSize:15 ,color: Colors.green),),
                    // trailing: Text(widget.quantity,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,),) ,



                    SizedBox(
                      height: 20,
                    ),
                    Text('   '),

                    Container(
                      padding: EdgeInsets.only(left: 40),
                      child: Row(
                        children:[
                      Icon(Icons.star, color: Color.fromARGB(255, 206, 157, 11),),
                      Icon(Icons.star, color: Color.fromARGB(255, 206, 157, 11),),
                      Icon(Icons.star, color: Color.fromARGB(255, 206, 157, 11),),
                      Icon(Icons.star, color: Color.fromARGB(255, 206, 157, 11),),
                      Icon(Icons.star, color: Color.fromARGB(255, 206, 157, 11),),
                  ]
                      ),
                    ),

                  const SizedBox(
                    height: 20,
                  ),
                  // Text("${widget.salesId}"),
                  // Text("${widget.clientId}"),

                      Text('Description \n ${widget.description}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),

                  const SizedBox(
                    height: 10,
                  ),
                  // Text(widget.description),



                  SizedBox(
                    height: 20,
                  ),

                  DropdownButton(

                    // Initial Value
                    value: pType,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: items.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        pType = newValue!;
                      });
                    },
                  ),

                ],
              )

          ),


        ),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text('Add to Cart'),
          icon: const Icon(Icons.add),
          onPressed: () {
            _addCart();

          },
        ),
      );*/

        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            floatingActionButton: FloatingActionButton.extended(
              backgroundColor: Colors.black,
              label: const Text('Add to Cart'),
              icon: const Icon(Icons.add),
              onPressed: () {
                _addCart();

              },
            ),
            body: Container(
              // width: size.width,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        // height:
                        //   400.00,

                        // width: 300,
                        child: Column(
                          // alignment: Alignment.bottomCenter,
                          children: [


                            Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: 20,
                                  top: 10,
                                  right: 20,
                                  bottom: 10,
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      // crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                      IconButton(onPressed: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => Cart(selectedClientId: "${widget.selectedClientId}", cProductName: '', productId: '', price: '', status: '', image: '', quantity: '',
                                          cQuantity: '', phoneNumber: '${widget.phoneNumber}',)));
                                      }, icon: Icon(CupertinoIcons.bag))
                                      ],
                                    ),
                                    Text(
                                      "${widget.productName}",
                                      // overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize:
                                          20,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        top: 10,
                                        right: 10,
                                      ),
                                      child: Text(
                                        "${widget.status}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style:TextStyle(color: Colors.green),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 1,
                                        top: 21,
                                        right: 10,
                                      ),
                                      child: Text(
                                        "₵${widget.price}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style:TextStyle(
                                          color: Colors.black87,
                                          fontSize:
                                          20,
                                          fontFamily: 'Helvetica',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: 1,
                                        top: 15,
                                        right: 10,
                                      ),
                                      child: Text(
                                        "Credited Price: ₵ ${widget.creditedPrice}",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.left,
                                        style:TextStyle(
                                          color: Colors.black87,
                                          fontSize:
                                          14,
                                          fontFamily: 'Helvetica',
                                          // fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20,),

                                    Container(
                                      height:
                                      300.00,

                                      width: 300,
                                      margin: EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child:
                                          Align(
                                            // alignment: Alignment.centerLeft,
                                            child:
                                            Image.network(widget.image,height:290.00 ,width: 320,),


                                          ),



                                    ),


                                  ],
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    Text("Description of Drug", style: TextStyle(fontWeight: FontWeight.bold),),
                    Container(
                      // width:
                      //   334.00,

                      margin: EdgeInsets.only(
                        left: 21,
                        top: 31,
                        right: 21,
                      ),
                      child: Text(
                        "${widget.description}".replaceAll("", "Products from Rokmer Pharmacy ${widget.productName}\n Expired Date: ${widget.expiredDate} "),
                        maxLines: null,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize:
                            14,

                          fontFamily: 'Helvetica',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        child: Text( "Read More",
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize:
                              14,

                            fontFamily: 'Helvetica',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: Padding(
                //     padding: EdgeInsets.only(
                //       left: 20,
                //       right: 20,
                //     ),
                //     child:
                        DropdownButton(

                        // Initial Value
                        value: pType,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            pType = newValue!;
                          });
                        },
                      ),
                    // TextField(
                    //   controller: uAController,
                    //
                    // )
                    // ),
                // ),




                  ],
                ),
              ),
            ),

          ),

        );


    }

  Future<void> _addCart() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String clientId = (prefs.getString('clientId') ?? '');
   String userId = (prefs.getString('userId') ?? '');
    String price = (prefs.getString('price') ?? '');
    String productName = (prefs.getString('productName') ?? '');


    SimpleFontelicoProgressDialog progressDialog =
    SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    // progressDialog.show(
    //   message: "Loading ...",
    // );
    String status;
    if(pType == "Cash Price"){
       status = unitPriceA;

    } else{
     status = unitPriceB;
    }

    setState(() => _message = status);



    if (pType.toString().isEmpty){
      helper.snackBarNotification("please select Purchase Type", context);
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
          "Access-Control-Allow-Origin": "*",
        },
        body: jsonEncode(<String, String>{
          'action': "addToCart",
          'auth': IP.Auth,
          'salesId': userId,
          "productName": "${widget.productName}",
          "priceType": pType.toString(),
          "quantity":"1",
          "unitPrice": _message.toString(),
          "clientId": "${widget.selectedClientId}",
        }))
        .catchError((err) {
      progressDialog.hide();
      helper.alertDialogTitle(IP.errorMessageOops,
          IP.errorMessageSomethingWentWrong, context);
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

      // Navigator.push(
      //
      //     context, MaterialPageRoute(builder: (context) => Cart(productName: productName, productId: productId, price: price, status: status, image: image, quantity: quantity, clientId: clientId.toString(),)));
      Navigator.push(context, MaterialPageRoute(builder: (context) => Cart(selectedClientId: widget.selectedClientId, cProductName: '', productId: '',
        price: _message.toString(), status: '', image: '', quantity: '', cQuantity: '',
        phoneNumber: '${widget.phoneNumber}', )));

      //final counter = prefs.getString('phoneNumber') ?? 0;
      //prefs.remove ('counter');
    } else if (apiStatusCode != 200) {
      // progressDialog.hide();
       helper.alertDialogNoTitle('${apiMessage}', context);
    }
  }
  }
