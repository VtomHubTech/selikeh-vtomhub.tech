import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import '../Helper.dart';
import '../IP.dart';
import '../Payments/Payment_Model.dart';
import '../Products/AnC_Cart.dart';
import '../Products/AnC_addCart.dart';
import '../Products/Cart.dart';
import '../advancedModel.dart';

class Customer_Credit extends StatefulWidget {
  Customer_Credit({
    required this.selectedClientId,
    required this.phoneNumber,
});
  String? selectedClientId;
  String? phoneNumber;


  @override
  State<Customer_Credit> createState() => _Customer_CreditState();
}

class _Customer_CreditState extends State<Customer_Credit> {

  int apiStatusCode = 0;
  late Future<List<advancedModel>> _func;
  String apiMessage = "";
  @override
  void initState() {
    _func = _getcred();
    // _loadSharedPref();
    Timer(Duration(seconds: 1), () {
      setState(() { });
    });
    super.initState();
  }
  final Helper helper = Helper();
  // String selectedClientId = "";

  // _loadSharedPref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     selectedClientId = (prefs.getString('strClientId') ?? '');
  //
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Credited Product ${widget.selectedClientId}"),
      ),

      body: Stack(
          children:[
            Container(

              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child:FutureBuilder(
                  future: _func,
                  builder: (context, data) {
                    if (data.hasError) {
                      return Column(children: [
                        // SizedBox(height: 100,),
                        Text('${Helper.noData}'),
                      ]);
                    } else if (data.hasData) {
                      var items = data.data as List<advancedModel>;
                      return ListView.builder(
                          itemCount: items == null ? 0 : items.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                               /* Navigator.push(context, MaterialPageRoute(builder: (context) => AnC_Cart(selectedClientId: "${widget.selectedClientId}", cProductName: items[index]
                                    .productName
                                    .toString(),
                                  productId: '',
                                  price: items[index]
                                      .totalPrice
                                      .toString(), status: '',
                                  image: "", quantity: '', cQuantity: '',
                                  phoneNumber: '${widget.phoneNumber}',)));*/


                              },
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
                                            borderRadius: BorderRadius.all(Radius.circular(50)),


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
                                                items[index].productName.toString(),

                                                style: TextStyle(
                                                  // fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                    fontSize: 20),
                                              ),
                                              onTap: () async {


                                             /*   _addCart(items[index]
                                                    .productName
                                                    .toString(),
                                                    items[index]
                                                        .totalPrice
                                                        .toString(),
                                                    items[index]
                                                        .quantity
                                                        .toString()

                                                );*/
                                           /*     _addCart(items[index]
                                                          .productName
                                                          .toString(),
                                                    items[index]
                                                          .unitPrice
                                                          .toString());

*/
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => AnC_AddToCart(productName: items[index]
                                                      .productName
                                                      .toString(), productId: items[index]
                                                      .productId
                                                      .toString(),
                                                    price: items[index]
                                                        .totalPrice
                                                        .toString(),
                                                    quantity: items[index]
                                                        .quantity
                                                        .toString(),
                                                    expiredDate: items[index]
                                                        .datePurchase
                                                        .toString(),
                                                    description: items[index]
                                                        .description
                                                        .toString(), status: '',
                                                    image: items[index]
                                                        .image
                                                        .toString(), salesId: '', selectedClientId: '${widget.selectedClientId}',
                                                    phoneNumber: '${widget.phoneNumber}', creditedPrice: '',)),
                                                );
                                              },
                                              trailing: Text("GHS ${items[index].totalPrice
                                                  .toString()} ",
                                                style: TextStyle(
                                                    fontWeight: FontWeight
                                                        .bold,
                                                    color: Colors.black,
                                                    fontSize: 18),),
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
          ]  ),
    );

  }



  Future<List<advancedModel>> _getcred() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');
    String clientId = (prefs.getString('shopClientId') ?? '');

    String basicAuth = 'Basic ' +
        base64Encode(
            utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.viewAll),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(<String, String>{
          "action":"viewByPurchaseType",
          "purchaseType":"Credited",
          "salesId": userId,
          "clientId": "${widget.selectedClientId}",
          'auth': "${IP.Auth}"
        }))
        .catchError((err) {
      //progressDialog.hide();
      helper.alertDialogTitle(Helper.errorMessageOops,
          Helper.errorMessageSomethingWentWrong, context);
    });

    if (response.statusCode == 200) {
      List responseList = json.decode(response.body)["response"];
      return responseList
          .map((data) => advancedModel.fromJson(data))
          .toList();

    }


    else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<void> _addCart(String productName, String totalPrice, String quantity) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String clientId = (prefs.getString('clientId') ?? '');
    String userId = (prefs.getString('userId') ?? '');
    String price = (prefs.getString('price') ?? '');
    String productName = (prefs.getString('productName') ?? '');


    SimpleFontelicoProgressDialog progressDialog =
    SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "Loading ...",
    );

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
          "productName": productName,
          "quantity": quantity,
          "unitPrice": totalPrice,
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => AnC_Cart(selectedClientId: "${widget.selectedClientId}", cProductName: productName.toString(),
        productId: '',
        price: totalPrice.toString(), status: '',
        image: "", quantity: '', cQuantity: '',
         phoneNumber: '${widget.phoneNumber}',)));

      // _addCart(productName, unitPrice);

      // Navigator.push(
      //
      //     context, MaterialPageRoute(builder: (context) => Cart(productName: productName, productId: productId, price: price, status: status, image: image, quantity: quantity, clientId: clientId.toString(),)));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Cart(selectedClientId: widget.selectedClientId, cProductName: '', productId: '', price: '', status: '', image: '', quantity: '', cQuantity: '',)));

      //final counter = prefs.getString('phoneNumber') ?? 0;
      //prefs.remove ('counter');
    } else if (apiStatusCode != 200) {
      // progressDialog.hide();
      helper.alertDialogNoTitle('${apiMessage}', context);
    }
  }




}
