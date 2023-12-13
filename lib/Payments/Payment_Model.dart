import 'package:flutter/material.dart';
import 'Card_Pay.dart';
import 'Cash_Pay.dart';
import 'Cheque_Pay.dart';
import 'Momo_Pay.dart';

class Payment_Model extends StatefulWidget {
  Payment_Model({
    required this.selectedClientId,
    required this.phoneNumber,
    required this.product,
    required this.quantity,
  });
  String? selectedClientId;
  String? phoneNumber;
  String? product;
  String? quantity;

  @override
  State<Payment_Model> createState() => _Payment_ModelState();
}

class _Payment_ModelState extends State<Payment_Model> {
  String totalPrice = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Model'),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: 50,),
              // Text('Sage',style: TextStyle(color: Colors.green,fontSize: 40,fontWeight:FontWeight.bold),),

              SizedBox(
                height: 50,
              ),
              Text(
                'Choose Payment type ',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(
                height: 30,
              ),

              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 50,
                // margin: EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TopUp_Momo()));
                  },
                  icon: Icon(
                    Icons.phone_android,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Mobile Money',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              // Container(
              //     width: 300,
              //     height: 50,
              //   child:
              //   ElevatedButton.icon(onPressed: (){
              //       Navigator.push(context, MaterialPageRoute(builder: (context)=>Bank_Pay()));
              //   },
              //     icon: Icon(Icons.house_sharp,color: Colors.black,),
              //     label: Text('Bank',style: TextStyle(color: Colors.black),),
              //     style: ElevatedButton.styleFrom(primary: Colors.white),

              //   ),),
              // SizedBox(height: 10,),

              Container(
                width: 300,
                height: 50,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cash_Pay(
                                  selectedClientId: widget.selectedClientId,
                                  phoneNumber: '${widget.phoneNumber}',
                                  product: widget.product.toString(),
                                  quantity: widget.quantity.toString(),
                                )));
                  },
                  icon: Icon(
                    Icons.attach_money_sharp,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Cash',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: 300,
                height: 50,

                // margin: EdgeInsets.all(20),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Cheque_Pay(
                                  selectedClientId: widget.selectedClientId,
                                  phoneNumber: '${widget.phoneNumber}',
                                )));
                  },
                  icon: Icon(
                    Icons.money,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Cheque',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(primary: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),

      // floatingActionButton: FloatingActionButton.extended(
      //   label: Text('Login'),
      //     icon: Icon(Icons.arrow_forward),
      //     onPressed: (){},
      //
      //   ),
    );
  }
}
