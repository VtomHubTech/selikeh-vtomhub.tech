import 'package:flutter/material.dart';

class Customer_Balance extends StatefulWidget {
  const Customer_Balance({Key? key}) : super(key: key);

  @override
  State<Customer_Balance> createState() => _Customer_BalanceState();
}

class _Customer_BalanceState extends State<Customer_Balance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance'),
      ),
    );
  }
}
