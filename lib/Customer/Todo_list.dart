import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rockman/Customer/taskmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../Helper.dart';
import '../IP.dart';

class ToDo extends StatefulWidget {
  const ToDo({super.key});

  @override
  State<ToDo> createState() => _ToDoState();
}

class _ToDoState extends State<ToDo> {
  late Future<List<taskModel>> _func;
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

  final Helper helper = Helper();
  String totalTask = "";
  String userId = "";

  loadSharedPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = (prefs.getString('userId') ?? '');
      totalTask = (prefs.getString('totalTask') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To Do List'),
        leading: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Container(
            width: 5,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.black, borderRadius: BorderRadius.circular(50)),
            child: Center(
              child: Text(
                totalTask.replaceAll("null", "0"),
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),

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
                  var items = data.data as List<taskModel>;
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
                                          },
                                          trailing: Container(
                                            child: Stack(
                                              children: [
                                                Text(
                                                  "${items[index].address.toString()}",
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
                                          leading:
                                              Icon(Icons.task_alt_outlined),
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

  Future<List<taskModel>> _getShop() async {
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
      String totalTask = responseJson["TotalTask"].toString();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('totalTask', totalTask);
      List responseList = json.decode(response.body)["response"];
      return responseList.map((data) => taskModel.fromJson(data)).toList();
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }
}
