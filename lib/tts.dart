import 'package:flutter/material.dart';


class tts extends StatefulWidget {
  tts({
    required this.clientId
});
  String? clientId;

  @override
  State<tts> createState() => _ttsState();
}

class _ttsState extends State<tts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text("${widget.clientId}"),
      ),
    );
  }
}
