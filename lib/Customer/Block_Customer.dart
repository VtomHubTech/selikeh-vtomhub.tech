import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Block_Customer extends StatefulWidget {
  const Block_Customer({Key? key}) : super(key: key);

  @override
  State<Block_Customer> createState() => _Block_CustomerState();
}

class _Block_CustomerState extends State<Block_Customer> {
  String numberOfClient = "";
  // @override
  // void initState() {
  //   super.initState();
  //   _loadSharedPref();
  // }

  // _loadSharedPref() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     totalAmountReceivedToday =
  //         (prefs.getString('totalAmountReceivedToday') ?? '');
  //     totalAmountReceived = (prefs.getString('totalAmountReceived') ?? '');
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Block Customer'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 70,
              ),
              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      labelText: "Name"),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: 255,
                height: 60,
                // margin: EdgeInsets.all(20),
                child: const TextField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.code,
                        color: Colors.grey,
                      ),
                      labelText: "ID Number"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 255,
                height: 60,
                child: const TextField(
                  // obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(
                        Icons.report,
                        color: Colors.grey,
                      ),
                      labelText: "State Reason"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: 200,
                  height: 50,

                  // margin: EdgeInsets.all(20),
                  child: MaterialButton(
                    onPressed: () {
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const OTC_Page()));
                    },
                    child: const Text('Submit',
                        style: TextStyle(color: Colors.black)),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
