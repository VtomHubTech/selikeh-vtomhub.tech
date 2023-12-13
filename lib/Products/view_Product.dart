// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Customer/Register_Customer.dart';
import '../Payments/Payment_Model.dart';


class Carts extends StatefulWidget {
 Carts({required this.productName, required this.productId, required this.price, required this. quantity, required this.expiredDate,
    required this.description, required this.status, required this.image
  });

  String productName = "";
  String productId = "";
  String price = "";
  String quantity = "";
  String description = "";
  String status = "";
  String image = "";
  String expiredDate = "";

  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {


  // String productName = "";
  String department = "";
  String organization = "";
  String cardNumber = "";
  String childId = "";
  var childNameController = TextEditingController();
  var childCardNumberController = TextEditingController();
  String productName = "";
  String productId = "";
  String price = "";
  String quantity = "";
  String description = "";
  String status = "";
  String image = "";
  String expiredDate = "";

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
    price = (prefs.getString('price') ?? '');
    description = (prefs.getString('description') ?? '');
    image = (prefs.getString('image') ?? '');


    Timer(Duration(seconds: 0), () {
      setState(() {

      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return      SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,

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

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
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
                    "${widget.description}",

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
                    child: Text(
                      "Learn More",
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





              ],
            ),
          ),
        ),

      ),

    );


  }
    // void showToast() => Fluttertoast.showToast(
    //       msg: "Successfully Added",
    //       fontSize: 20,
    //       gravity: ToastGravity.BOTTOM,
    //     );
    //     void cancleToast() {}
  }
