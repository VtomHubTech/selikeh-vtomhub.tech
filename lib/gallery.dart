// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key}) : super(key: key);
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   File? _imagefile;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Image Picker Demo'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             if (_imagefile != null)
//               Image.file(
//                 _imagefile!,
//                 width: 300,
//                 height: 300,
//               ),
//             Align(
//               alignment: Alignment.center,
//               child: ElevatedButton(
//                   onPressed: () {
//                     _pickFromGallery();
//                   },
//                   child: const Text('Pick Image From Gallery')),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _pickFromGallery() async {
//     PickedFile? image = await ImagePicker.platform
//         .pickImage(source: ImageSource.gallery, imageQuality: 100);
//     setState(() {
//       _imagefile = File(image!.path);
//     });
//   }
// }
