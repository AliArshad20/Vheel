// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';
//
// class GalleryImage extends StatefulWidget {
//   ImagePicker picker = ImagePicker();
//
// // XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//
//
//   @override
//   State<GalleryImage> createState() => _GalleryImageState();
// }
//
// class _GalleryImageState extends State<GalleryImage> {
//
//   XFile? scrap_img1;
//   var type;
//   var image;
//   var _image;
//   var imagePicker = new ImagePicker();
//
//
//   // pickImage(ImageSource imageType) async {
//   //   try {
//   //     final photo = await ImagePicker().pickImage(source: imageType);
//   //     if (photo == null) return;
//   //     setState(() {
//   //       final tempImage = XFile(photo.path);
//   //       scrap_img1 = tempImage;
//   //     });
//   //   } catch (error) {
//   //     debugPrint(error.toString());
//   //   }
//   // }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: 100,
//           width: 100,
//           child: Column(
//             children: [
//               ElevatedButton(
//                   onPressed: () async{
//                     var source = type == ImageSource.gallery
//                         ? ImageSource.camera
//                         : ImageSource.gallery;
//                     XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);
//                     setState(() {
//                       _image = File(image!.path);
//                     });
//                   },
//                   child: Image.file(_image)),
//             ],
//           )
//         ),
//       ),
//     );
//   }
// }
//
//
//
// // XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
// Future PickImge() async {
//   await ImagePicker().pickImage(source: ImageSource.gallery);
// }
