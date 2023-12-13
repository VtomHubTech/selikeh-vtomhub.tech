import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:rockman/OTC_Register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_fontellico_progress_dialog/simple_fontico_loading.dart';
import 'package:image_picker/image_picker.dart';
import '../Helper.dart';
import '../IP.dart';
import '../theme.dart';
import 'Customers_List.dart';

class Register_Customer extends StatefulWidget {
  const Register_Customer({Key? key}) : super(key: key);

  @override
  State<Register_Customer> createState() => _Register_CustomerState();
}

class _Register_CustomerState extends State<Register_Customer> {

  File? image;



  String base64Image = "";
  var fullNameController = TextEditingController();
  var shopNameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var locationController = TextEditingController();
  // var locationController2 = TextEditingController();
  var cardController = TextEditingController();
  var repfullNameController = TextEditingController();
  var repPhoneNumberController = TextEditingController();
  var gpsController  = TextEditingController();


  int apiStatusCode = 0;
  String apiMessage = "",
      qrCode = "";
  double long = 0,
      lat = 0;


  @override
  void initState() {
    // _loadSharedPref();
    // cardController.text = pType;
    super.initState();
  }


  final Helper helper = new Helper();

  String pType = 'Ghana Card';

  // List of items in our dropdown menu
  var items = [
    'Ghana Card',
    'Voters ID',
    'Passport',
    'Driver License'

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Register Customer"),
        ),
        body: SingleChildScrollView(
          child: Ui(),
        )
    );
  }

  Widget Ui() {
    return Container(
        color: Colors.white.withOpacity(0.5),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[


              SizedBox(height: 10,)
              , Text(
                'Create Client',
                textAlign: TextAlign.center,
                style: heading2.copyWith(
                    fontSize: 15,
                    color: textBlack, fontStyle: FontStyle.italic),
              ),

              Container(
                child: image != null
                    ? Image.file(image!, width: 80, height: 80,)
                    : CircleAvatar(
                  radius: 50.0,
                  backgroundColor: Colors.transparent,
                  // backgroundImage: Image.imageFile!,
                  child: IconButton(onPressed: () {
                    _modalPopupDialog(context);
                  }, icon: Icon(Icons.add_a_photo_outlined)),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Add Client Image"),
                ],
              ),
              // child:
              //
              // GestureDetector(
              //   onTap: () {
              //    _modalPopupDialog(context);
              //   },
              //   child: const CircleAvatar(
              //     maxRadius: 45.0,
              //
              //     backgroundColor: Colors.transparent,
              //     // backgroundImage: NetworkImage(),
              //     child: Icon(Icons.add_a_photo_outlined,color: Colors.black,),
              //   ),
              // ),
              //   )
              // ),

              SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  child: TextField(
                     controller: fullNameController,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Owners Full Name',
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  child: TextField(
                    controller:phoneNumberController,

                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // filled: true,
                      labelText: 'Owners Phone Number',
                    ),
                  )),



              SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  child: TextField(
                     controller: shopNameController,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),

                      labelText: 'Shop Name',
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // filled: true,
                      labelText: 'Email Address',
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  child: TextField(
                    controller: repfullNameController,

                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Reps Full Name',
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  child: TextField(
                     controller:repPhoneNumberController,

                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // filled: true,
                      labelText: 'Reps Phone Number',
                    ),
                  )),




              SizedBox(
                height: 20,
              ),
              // MaterialButton(onPressed: (){
              //   Navigator.push(context, MaterialPageRoute(builder: (context)=>
              //       PlacePicker(
              //         apiK
              //       )
              //   ))

              // }),
              Container(
                  width: 300,
                  child: TextField(
                    controller: locationController,

                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // filled: true,
                      labelText: 'Location',
                    ),
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                  width: 300,
                  child: TextField(
                     controller:gpsController,

                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // filled: true,
                      labelText: 'GPS Digital Number',
                    ),
                  )),

              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                ),
                child: DropdownButton(
                  elevation: 10,

                  // Initial Value
                  value: pType,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      pType = newValue!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  width: 300,
                  child: TextField(
                    controller: cardController,

                    // obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      // filled: true,
                      labelText: pType,
                    ),
                  )),


              SizedBox(
                height: 30,
              ),
              MaterialButton(
                elevation: 10,
                height: 50,
                minWidth: 70,
                color: Colors.black,
                textColor: Colors.white,
                splashColor: Colors.orangeAccent,
                child: new Text('Create'),
                onPressed: () {
                  _register();
                },
              ),
            ]
        ));
  }


  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;

        // imageFile = File(image.path);

      });
    } on PlatformException catch (e) {
    print('Failed to pick image: $e');
    }
  }
  _modalPopupDialog(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: new Icon(Icons.photo_camera_back),
                title: new Text('Gallery upload'),
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: new Icon(Icons.camera),
                title: new Text('Camera upload'),
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: new Icon(Icons.cancel),
                title: new Text('Remove profile image'),
                onTap: () {
                  // _removeProfilePic();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  Future<void> _register() async {

    File imageFile = new File(image!.path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    base64Image = base64Encode(imageBytes);
    print(base64Image);

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = (prefs.getString('userId') ?? '');

    if (base64Image.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please provide Image")));
      return;
    }

    if (fullNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please provide your fullname")));
      return;
    }
    if (repfullNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please provide your reps fullname")));
      return;
    }
    if (repPhoneNumberController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please provide your reps Number")));
      return;
    }
    if (shopNameController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please provide your shop name")));
      return;
    }
    if (emailController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please provide email")));
      return;
    }
    if (phoneNumberController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please provide phone number")));
      return;
    }

    if (locationController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please provide location")));
      return;
    }
    if (gpsController.text.toString().isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Please provide digital Address")));
      return;
    }

    SimpleFontelicoProgressDialog progressDialog =
    SimpleFontelicoProgressDialog(context: context, barrierDimisable: true);
    progressDialog.show(
      message: "Loading ...",
    );

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${IP.APIusername}:${IP.APIpassword}'));
    final response = await http
        .post(Uri.parse(IP.register),
        headers: {
          'Content': 'application/x-www-form-urlencoded',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': basicAuth,
        },
        body: jsonEncode(<String, String>{
          // 'fullName': fullNameController.text,
          // 'shopName': shopNameController.text,
          // 'emailAddress': emailController.text,
          // 'phoneNumber': phoneNumberController.text,
          // 'idType': pType.toString(),
          // 'ghanaCardNumber': cardController.text,
          // 'address': locationController.text,
          // 'repFullName' : repfullNameController.text,
          // 'repPhoneNumber': repPhoneNumberController.text,
          // 'googleMap': gpsController.text,
          // 'salesId': userId,
          // 'userId' : userId,
          // 'action' : 'create',
          //  'image' : base64Image,




        "salesId": userId,
        "action":"create",
        "fullName": fullNameController.text.toString(),
        "shopName": shopNameController.text.toString(),
        "emailAddress": emailController.text.toString(),
        "phoneNumber": phoneNumberController.text.toString(),
        "idType": pType.toString(),
        "ghanaCardNumber": cardController.text.toString(),
        "address": locationController.text.toString(),
        "repFullName" : repfullNameController.text.toString(),
        "repPhoneNumber": repPhoneNumberController.text.toString(),
        "googleMap": gpsController.text.toString(),
        "userId" : userId,
        "image" : base64Image,
        'auth': '${IP.Auth}'
        }))
        .catchError((err) {
      progressDialog.hide();
      helper.alertDialogTitle('something went wrong',
          IP.errorMessageSomethingWentWrong, context);
    });

    if (response.statusCode != 200) {
      progressDialog.hide();
      helper.alertDialogTitle('${IP.errorMessageOops}',
          '${IP.errorMessageSomethingWentWrong}', context);
    }

    final responseJson = jsonDecode(response.body);
    apiStatusCode = responseJson["statusCode"].toInt();
    apiMessage = responseJson["message"].toString();


    if (apiStatusCode == 200) {
      final responseJson = jsonDecode(response.body);
      // String RphoneNumber = responseJson["response"][0]["PhoneNumber"].toString();

      progressDialog.hide();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('RphoneNumber', RphoneNumber);

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => OTC_Page(
        strPhoneNumber: phoneNumberController.text.toString(),
      )));
              // (Route<dynamic> route) => false);

      // showDialog(
      //     context: context,
      //     builder: (BuildContext context) {
      //       return AlertDialog(
      //         content: Text(apiMessage),
      //         actions: [
      //           TextButton(
      //             child: Text("Okay"),
      //             onPressed: () {
      //               // Navigator.pop(context);
      //               Navigator.push(context, MaterialPageRoute(builder: (context)=> OTC_Page()));
      //
      //
      //               fullNameController.text = "";
      //               phoneNumberController.text = "";
      //               shopNameController.text = "";
      //               emailController.text = "";
      //               repPhoneNumberController.text ="";
      //               repfullNameController.text = "";
      //               cardController.text = "";
      //               locationController.text = "";
      //               gpsController.text = "";
      //
      //
      //               // pinController.text = "";
      //             },
      //           )
      //         ],
      //       );
      //     });

      // Navigator.push(
      //     context, MaterialPageRoute(builder: (context) => OTC_Login()));
      // Navigator.push(context, MaterialPageRoute(builder: (context) => Customer_Page(clientId: "", fullName: '', shopName: '', emailAddress: '', cPhoneNumber: '', ghanaCardNumber: '', address: '', status: '', image: '')));

      //final counter = prefs.getString('phoneNumber') ?? 0;
      //prefs.remove ('counter');
    } else if (apiStatusCode != 200) {
      progressDialog.hide();
      helper.alertDialogNoTitle("${apiMessage}", context);
    }
  }


}