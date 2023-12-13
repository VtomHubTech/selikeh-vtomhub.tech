import 'package:flutter/material.dart';

class Bank_Pay extends StatefulWidget {
  const Bank_Pay({Key? key}) : super(key: key);

  @override
  State<Bank_Pay> createState() => _Bank_PayState();
}

class _Bank_PayState extends State<Bank_Pay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bank Payment'),
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
              Text('Bank Payment ',style: TextStyle(color: Colors.black,fontSize: 20,fontWeight:FontWeight.normal),),
              SizedBox(height: 20,),



              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Bank Name"
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


