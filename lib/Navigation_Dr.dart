// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:rockman/Customer/Customer_Balance.dart';
// import 'package:rockman/Customer/Customer_Credit.dart';
// import 'package:rockman/Customer/Customer_Order.dart';
// import 'package:rockman/Customer/Customers_History.dart';
// import 'package:rockman/Products/Products.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class Navigation_Drawer extends StatefulWidget {
//
//
//
//
//   @override
//   State<Navigation_Drawer> createState() => _Navigation_DrawerState();
// }
//
// class _Navigation_DrawerState extends State<Navigation_Drawer> {
//
//   String image = "https://via.placeholder.com/150";
//   String? clientId;
//
//   String shopName = "";
//
//   String? cPhoneNumber;
//   String? status;
//
//
//
//   @override
//   void initState() {
//     super.initState();
//     _loadSharedPref();
//   }
//
//   _loadSharedPref() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//
//       shopName = (prefs.getString('shopName') ?? '');
//       cPhoneNumber = (prefs.getString('cPhoneNumber') ?? '');
//       // clientId = (prefs.getString('clientId') ?? '');
//       image = (prefs.getString('image') ?? '');
//     });
//   }
//   File? pimage;
//
//   @override
//   Widget build(BuildContext context) => Drawer(
//           child: Container(
//         width: 100,
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               buildHeader(context),
//               buildMenuItems(context),
//             ],
//           ),
//         ),
//       ));
//   Widget buildHeader(BuildContext context) => Container(
//         color: Colors.green.shade300,
//         padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
//         child: Column(
//           children: [
//             SizedBox(
//               height: 20,
//             ),
//             ClipOval(
//
//               child: SizedBox.fromSize(
//                   size: Size.fromRadius(60),
//                   child: pimage != null
//                       ? Image.file(pimage!, width: 60, height: 60)
//                       : CircleAvatar(
//
//                     radius: 60.0,
//                     backgroundImage: NetworkImage(image),
//                     backgroundColor: Colors.transparent,
//                   )
//                 // : Image.asset("assets/images/profile.png",height: 100, width: 100),
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Text("Shop name"),
//             SizedBox(
//               height: 8,
//             )
//           ],
//         ),
//       );
//
//   Widget buildMenuItems(BuildContext context) => Container(
//       padding: EdgeInsets.all(15),
//       child: Wrap(
//         runSpacing: 15,
//         children: [
//           SizedBox(
//             height: 30,
//           ),
//           ListTile(
//             leading: Icon(Icons.add),
//             title: Text("Product"),
//             onTap: () async{
//               SharedPreferences prefs = await SharedPreferences.getInstance();
//               String clientId = (prefs.getString('clientId') ?? '');
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Products_Page(selectedClientId: '', )));
//             },
//           ),
//           // Divider(
//           //   color: Colors.grey, height: 1,
//           // ),
//
//           // Divider(color: Colors.grey,height: 1,),
//           ListTile(
//             leading: Icon(Icons.more_vert),
//             title: Text('Statement'),
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Customer_History()));
//             },
//           ),
//           // Divider(color: Colors.grey,height: 1,),
//
//           ListTile(
//             leading: Icon(Icons.production_quantity_limits_rounded),
//             title: Text('Advanced Order'),
//             onTap: () {
//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (context) => Customer_Order()));
//             },
//           ),
//           //  Divider(color: Colors.grey,height: 1,),
//           ListTile(
//             leading: Icon(Icons.credit_card_off),
//             title: Text('Credited Items'),
//             onTap: () {
//               Navigator.push(context,
//                   MaterialPageRoute(builder: (context) => Customer_Credit()));
//             },
//           ),
//         ],
//       ));
// }
