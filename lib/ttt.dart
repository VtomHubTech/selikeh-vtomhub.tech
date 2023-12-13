import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ttt extends StatefulWidget {
  ttt({required this.clientId

});
  String? clientId;

  @override
  State<ttt> createState() => _tttState();
}

class _tttState extends State<ttt> {
  String clientId = "";
  @override
  void initState() {
    super.initState();
    _getUserData();

    // _doCheckProfilePic();
    // _getPrepaidCards();
  }
  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();



    clientId = (prefs.getString('clientId') ?? '');


    Timer (Duration(seconds:0),() {
      setState(() {

      });
    });

    // _getBalance();

    // _wards();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(

        child:
        Column(
          children:[
            
          Center(child: GestureDetector
          
            (
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> ttt(clientId: clientId.toString(),)));
            },
              child:
          Text("${widget.clientId}")))
            ]
        ),
      ),
    );
  }
}
