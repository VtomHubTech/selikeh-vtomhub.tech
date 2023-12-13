import 'package:flutter/material.dart';

class Customer_History extends StatefulWidget {
  const Customer_History({Key? key}) : super(key: key);

  @override
  State<Customer_History> createState() => _Customer_HistoryState();
}

class _Customer_HistoryState extends State<Customer_History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
    );
  }
}
