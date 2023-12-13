import 'package:flutter/material.dart';

class Card_Pay extends StatefulWidget {
  const Card_Pay({Key? key}) : super(key: key);

  @override
  State<Card_Pay> createState() => _Card_PayState();
}

class _Card_PayState extends State<Card_Pay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card Payment'),
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

              SizedBox(height: 30,),
              Text('Card Payment ',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight:FontWeight.normal),),
              SizedBox(height: 20,),



              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Card Number"
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.call,color: Colors.grey,),
                      labelText: "Amount"
                  ),
                ),
              ),

              SizedBox(height: 10,),
              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // prefixIcon: Icon(Icons.call,color: Colors.grey,),
                      labelText: "Reference"
                  ),
                ),
              ),




              SizedBox(height: 25,),
              Container(
                  width: 150,
                  height: 50,
                  child:
                  ElevatedButton(onPressed: (){
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>OTC_Page()));
                  }, child: Text('Pay',style: TextStyle(color: Colors.black)),
                    style: ElevatedButton.styleFrom(primary: Colors.white),
                  )),
            ],
          ),
        ),
      ),


    );
  }
}

