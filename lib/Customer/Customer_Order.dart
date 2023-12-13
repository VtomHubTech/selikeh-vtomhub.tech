// import 'package:flutter/material.dart';
// import 'package:rockman/Products/addToCart.dart';
// import 'package:rockman/Products/Products.dart';
//
// class Customer_Order extends StatefulWidget {
//   const Customer_Order({Key? key}) : super(key: key);
//
//   @override
//   State<Customer_Order> createState() => _Customer_OrderState();
// }
//
// class _Customer_OrderState extends State<Customer_Order> {
//   bool _isVisible = true;
//
//   void showToast() {
//     setState(() {
//       _isVisible = !_isVisible;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Advanced Order'),
//       ),
//       body: SingleChildScrollView(
//         child: _userInterface(),
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         label: const Text('Add A.O'),
//         icon: const Icon(Icons.add),
//         onPressed: () {
//           Navigator.push(context,
//               MaterialPageRoute(builder: (context) => const Products_Page()));
//         },
//       ),
//     );
//   }
//
//   Widget _userInterface() {
//     return Container(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             SizedBox(
//               height: 20,
//             ),
//             Visibility(
//               visible: _isVisible,
//               child: Card(
//                   child: ListTile(
//                 leading: IconButton(
//                     onPressed: () {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) => Product_Cart()));
//                     },
//                     icon: const Icon(
//                       Icons.production_quantity_limits,
//                       color: Colors.red,
//                     )),
//                 title: Text('Paracetamol'),
//                 trailing: IconButton(
//                     onPressed: showToast, icon: Icon(Icons.cancel_outlined)),
//                 subtitle: Text('Quantity: 3 Box'),
//               )),
//             ),
//             Card(
//                 child: ListTile(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Product_Cart()));
//                   },
//                   icon: const Icon(
//                     Icons.production_quantity_limits,
//                     color: Colors.red,
//                   )),
//               title: Text('Product Z'),
//               trailing: IconButton(
//                   onPressed: () {}, icon: Icon(Icons.cancel_outlined)),
//               subtitle: Text('Quantity: 18 Box'),
//             )),
//             Card(
//                 child: ListTile(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Product_Cart()));
//                   },
//                   icon: const Icon(
//                     Icons.production_quantity_limits,
//                     color: Colors.red,
//                   )),
//               title: Text('Product E'),
//               trailing: IconButton(
//                   onPressed: () {}, icon: Icon(Icons.cancel_outlined)),
//               subtitle: Text('Quantity: 1 Box'),
//             )),
//             Card(
//                 child: ListTile(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Product_Cart()));
//                   },
//                   icon: const Icon(
//                     Icons.production_quantity_limits,
//                     color: Colors.red,
//                   )),
//               title: Text('Injection'),
//               trailing: IconButton(
//                   onPressed: () {}, icon: Icon(Icons.cancel_outlined)),
//               subtitle: Text('Quantity: 6 Box'),
//             )),
//             Card(
//                 child: ListTile(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Product_Cart()));
//                   },
//                   icon: const Icon(
//                     Icons.production_quantity_limits,
//                     color: Colors.red,
//                   )),
//               title: Text('NoseMask'),
//               trailing: IconButton(
//                   onPressed: () {}, icon: Icon(Icons.cancel_outlined)),
//             )),
//             Card(
//                 child: ListTile(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Product_Cart()));
//                   },
//                   icon: const Icon(
//                     Icons.production_quantity_limits,
//                     color: Colors.red,
//                   )),
//               title: Text('Product B'),
//               trailing: IconButton(
//                   onPressed: () {}, icon: Icon(Icons.cancel_outlined)),
//               subtitle: Text('Quantity: 9 Box'),
//             )),
//             Card(
//                 child: ListTile(
//               leading: IconButton(
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => Product_Cart()));
//                   },
//                   icon: const Icon(
//                     Icons.production_quantity_limits,
//                     color: Colors.red,
//                   )),
//               title: Text('Vitamin C'),
//               trailing: IconButton(
//                   onPressed: () {}, icon: Icon(Icons.cancel_outlined)),
//               subtitle: Text('Quantity: 1 Box'),
//             )),
//           ]),
//     );
//   }
// }
