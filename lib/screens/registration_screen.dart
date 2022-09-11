import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:image_picker/image_picker.dart';
import '../models/userdata.dart';
import 'dashboard_screen.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'RegistrationScreen';

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String userImageUrl = '';
  String userId = '';

  Future<void> UserInfo(
      String UserId, name1, name2, email, refcode, File image) async {
    final post = http.post(
      Uri.parse(
          'https://veeluser-default-rtdb.firebaseio.com/UserInfo/$UserId.json'),
      body: jsonEncode({
        'UserID': UserId,
        'First Name': name1,
        'Last Name': name2,
        'Email': email,
        'Referral code': refcode,
      }),
    );
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('User Images/' + UserId);
    await ref.putFile(image);
    String imageUrl = await ref.getDownloadURL();

    setState(() {
      userImageUrl = imageUrl;
      userId = UserId;
    });
  }

  final name1 = TextEditingController();
  final name2 = TextEditingController();
  final email = TextEditingController();
  final refCode = TextEditingController();

  UserIdSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('imageUrl', userImageUrl);
    preferences.setString('Id', userId);
    // print(UserIdSP('Name'));
  }

  final LastName = FocusNode();
  final Email = FocusNode();
  final ReferralCode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  void saveForm() async {
    try {
      if (_formKey.currentState!.validate()) {
        if (_formKey.currentState!.validate()) _formKey.currentState!.save();
      }
    }
    catch (error) {
    throw error;
  }
  }
  File? selectedImage;

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  var _isLoading = true;

  // var _isInIt = false;
  //
  void Loading() {
    Timer(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
    // setState(() {
    //   _isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    final phoneNumb = Provider.of<UserData>(context);
    var UserId = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: _isLoading
          ? CircularProgressIndicator()
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 55.0.sp,
                      right: 195.sp,
                      bottom: 12.sp,
                    ),
                    child: Text('Register',
                        style: TextStyle(
                            fontSize: 23.sp, fontWeight: FontWeight.w400)),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            //this right here
                            backgroundColor: Colors.white,

                            // actionsPadding: EdgeInsets.only(right: 28, bottom: 14),
                            actions: [
                              InkWell(
                                  onTap: () {
                                    getImage().then(
                                        (value) => Navigator.pop(context));
                                  },
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        // width: 80.w,
                                        padding: EdgeInsets.only(
                                          top: 14.0.sp,
                                          bottom: 8.sp,
                                        ),
                                        child: Center(
                                          child: SizedBox(
                                              height: 3.5.h,
                                              width: 8.w,
                                              child: selectedImage == null
                                                  ? Image.asset(
                                                      'assets/ic_gallery.png',
                                                      height: 10.sp,
                                                      width: 10.sp,
                                                      fit: BoxFit.fitHeight,
                                                    )
                                                  : Image.file(
                                                      selectedImage!,
                                                      fit: BoxFit.fill,
                                                    )),
                                        ),
                                      ),
                                      Center(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: 12.sp, top: 5.sp),
                                          child: Text('Using Camera'),
     
                                  )),
                            ],
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Container(
                        height: 100.sp,
                        width: 100.sp,
                        // child: GestureDetector(
                        //   onTap: (){
                        //     Navigator.push(context, MaterialPageRoute(builder:(context)=>));
                        //   },
                        child: Container(
                          height: 100,
                          width: 200,
                          child: selectedImage == null
                              ? Image.asset('assets/profile_picture.png')
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(100.sp),
                                  child:
                                      // Image
                                      Image.file(
                                    File(selectedImage!.path),
                                    fit: BoxFit.fill,
                                  )),

                          // child: Image.file(File(selectedImage.path)),
                        ),
                        // child: image == null ? Image.asset('assets/profile_picture.png')
                        //     : Image.file(scrap_img1),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50.sp))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 4.sp,
                  ),
                  Text('Select photo',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20, right: 18, bottom: 10, left: 18),
                            child: TextFormField(
                                controller: "mean",
                                style: TextStyle(fontSize: 19),
                                decoration: InputDecoration(
                                  hintText: 'First Name',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'assets/first_name.png',
                                      height: 2,
                                      width: 1,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  // icon: Icon(Icons.email_outlined),
                                  // labelText: 'Email',
                                ),
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(LastName);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your first name';
                                  }
                                  // if (value.length < 3) {
                                  //   return 'Please provide name with at least three characters';
                                  // }
                                  // if (value.length > 16) {
                                  //   return 'Please provide a valid first name';
                                  // }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 18, bottom: 10, left: 18),
                            child: TextFormField(
                                controller: name2,
                                style: TextStyle(fontSize: 19),
                                decoration: InputDecoration(
                                  hintText: 'Last Name',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'assets/last_name.png',
                                      height: 1,
                                      width: 1,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  // icon: Icon(Icons.email_outlined),
                                  // labelText: 'Email',
                                ),
                                focusNode: LastName,
                                keyboardType: TextInputType.name,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context).requestFocus(Email);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter your last name';
                                  }
                                  // if (value.length < 3) {
                                  //   return 'Please provide name with at least three characters';
                                  // }
                                  // if (value.length > 16) {
                                  //   return 'Please provide a valid last name';
                                  // }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 18, bottom: 10, left: 18),
                            child: TextFormField(
                                controller: enterMail,
                                style: TextStyle(fontSize: 19),
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      'assets/email.png',
                                      height: 1,
                                      width: 1,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  // icon: Icon(Icons.email_outlined),
                                  // labelText: 'Email',
                                ),
                                focusNode: Email,
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(ReferralCode);
                                },
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter an email';
                                  }
                                  if (!value.endsWith('.com') ||
                                      !value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                }),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 18, bottom: 10, left: 18),
                            child: TextFormField(
                                controller: refCode,
                                style: TextStyle(fontSize: 19),
                                decoration: InputDecoration(
                                  hintText: 'ID',
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 15.0,
                                        right: 15,
                                        top: 15,
                                        bottom: 15),
                                    child: Container(
                                      height: 0.8.sp,
                                      width: 0.1.sp,
                                      color: Colors.black,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  // icon: Icon(Icons.email_outlined),
                                  // labelText: 'Email',
                                ),
                                focusNode: ReferralCode,
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                // onFieldSubmitted: (_) {
                                //   FocusScope.of(context).requestFocus(ReferralCode);
                                // },
                                validator: (value) {
                                  // if (value!.isEmpty) {
                                  //   return 'Please enter referral code';
                                  // }
                                }),
                          ),
                          SizedBox(
                            height: 1.7.h,
                          ),
                          Container(
                            height: 5.8.h,
                            padding:
                                EdgeInsets.only(left: 14.0.sp, right: 14.sp),
                            child: ElevatedButton(
                              onPressed: () async {
                                
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black),
                                minimumSize:
                                    MaterialStateProperty.all(Size(92.w, 5.h)),
                              )
                ],
              ),
            ),
    );
  }
}
