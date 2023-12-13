import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rockman/Customer/Customers_List.dart';
import 'package:rockman/Customer/Register_Customer.dart';
import 'package:rockman/Main_Page.dart';

class Bottom_Nav extends StatefulWidget {
  const Bottom_Nav({Key? key}) : super(key: key);

  @override
  State<Bottom_Nav> createState() => _Bottom_NavState();
}

class _Bottom_NavState extends State<Bottom_Nav> {
  int _selectedIndex = 0;
  List<Widget> _widgetoptions = <Widget>[
    Main_Page(),
   Shops(),
    Register_Customer(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: _widgetoptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home),
              label: 'Home',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.store_mall_directory_outlined,
              ),
              label: 'Shops',
              backgroundColor: Colors.green,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add),
              label: 'Add Shop',
              backgroundColor: Colors.green,
            ),
          ],
          
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ));
  }
}
