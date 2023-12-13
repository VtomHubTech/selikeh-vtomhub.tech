import 'package:flutter/material.dart';
import 'package:flutter_flushbar/flutter_flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';

class Helper {
  var animalList = ['dog', 'cat', 'cow'];

  // function for printing the list of animals
  static const String noData = "No data available ";
  static const String errorMessageSomethingWentWrong = "Please check your internet connectivity";
  static const String noInternet = "No internet access ";
  static const String customerCareNumber = "+233501622411";
  static const String whatsAppNumber       = "+233501647773";
  static const String platform              = "Android";
  static const String errorMessageOops        = "Oops!! 😔";
  static const String applicationCurrentVersion = "1.0";

  void toastSuccessNotification(
    String msg,
  ) {
    Fluttertoast.showToast(
        msg: '${msg}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void toastFailedNotification(
    String msg,
  ) {
    Fluttertoast.showToast(
        msg: '${msg}',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 5,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void snackBarNotification(String msg, BuildContext cxt) {
    ScaffoldMessenger.of(cxt).showSnackBar(SnackBar(content: Text(msg)));
  }

  void alertDialogTitle(String title, String msg, BuildContext cxt) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(msg),
            actions: [
              TextButton(
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void alertDialogNoTitle(String msg, BuildContext cxt,) {
    showDialog(
        context: cxt,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(msg),
            actions: [
              TextButton(
                child: Text("Okay"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void progressDialog(String msg, BuildContext cxt) {
    SimpleFontelicoProgressDialog progressDialog =
        SimpleFontelicoProgressDialog(context: cxt, barrierDimisable: true);
    progressDialog.show(
      message: msg,
    );
  }

  void serverDataRequest() {
    for (var animal in animalList) {
      print(animal);
    }
  }

  void flushBar(String title, String msg, BuildContext cxt) {

    switch(title) {
      case "Success":
        {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
            titleText: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
            messageText: Text(msg,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
          ).show(cxt);
        }
        break;


      case "Error":
        {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.red,
            duration: Duration(seconds: 3),
            titleText: Text(title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
            messageText: Text(msg,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
          ).show(cxt);
        }
        break;


      case "Warning":
        {
          Flushbar(
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.orange,
            duration: Duration(seconds: 3),
            titleText: Text("Oops",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
            messageText: Text(msg,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontFamily: "ShadowsIntoLightTwo"),
            ),
          ).show(cxt);
        }
        break;
    }

  }
}
