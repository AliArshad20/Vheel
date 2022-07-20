import 'dart:async';
import 'dart:convert';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:veeluser/models/userdata.dart';
import 'package:veeluser/screens/dashboard_screen.dart';
import 'package:veeluser/screens/getride_screen.dart';
import 'package:veeluser/screens/registration_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class AuthHandler extends StatefulWidget {
  static const routeName = '///';

  @override
  State<AuthHandler> createState() => _AuthHandlerState();
}

class _AuthHandlerState extends State<AuthHandler> {
  @override
  var loading = true;

  void Loading() {
    setState(() {
      Timer(Duration(seconds: 1), () {
        loading = false;
      });
    });
  }

  // final _phoneNumb = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? userId;
  String? _enteredOtp;

  Future<void> userIdFB() async {
    await userId;
    // await http.post(Uri.parse(
    //     'https://veeluser-default-rtdb.firebaseio.com/UserInfo/$userId.json'));

    try {
      final response = await http.get(Uri.parse(
          'https://veeluser-default-rtdb.firebaseio.com/UserInfo/$userId.json'));

      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      print(userId);
      if (extractedData != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('Id', userId!);
        Navigator.pushNamed(context, Dashboard.routeName);
      }
    } catch (error) {
      Navigator.pushNamed(context, RegistrationScreen.routeName,
          arguments: userId);
    }
  }

  void saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Navigator.pushReplacementNamed(context,
      //     RegistrationScreen.routeName,
      //     arguments: userId);

    } else
      print('error');
  }

  @override
  // void initState() {
  //   userIdFB();
  // TODO: implement initState
  // super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final Id = Provider.of<UserData>(context);
    final _phoneNumb = ModalRoute.of(context)!.settings.arguments as String;
    print(_phoneNumb);
    Loading();
    // final RegPro = Provider.of<UserData>(context);
    return SafeArea(
        child: FirebasePhoneAuthHandler(
      phoneNumber: _phoneNumb,
      // onLoginSuccess: ,
      onLoginSuccess: (userCredential, autoVerified) async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Phone number verified successfully!'),
        ));

        debugPrint(
          autoVerified
              ? "OTP was fetched automatically"
              : "OTP was verified manually",
        );

        debugPrint("Login Success UID: ${userCredential.user?.uid}");
        userId = userCredential.user?.uid;
        print(userId);
      },
      timeOutDuration: Duration(seconds: 30),
      onLoginFailed: (authException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          'Something went wrong',
        )));
        print(authException.message);
        debugPrint(authException.message);
        // handle error further if needed
      },

      builder: (BuildContext, FirebasePhoneAuthService) {
        return Scaffold(
          body: loading
              ? Center(
                  child: CircularProgressIndicator(
                  color: Colors.black,
                ))
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // ScaffoldMessenger.of(context).showSnackBar(
                      // SnackBar(content: Text('Please wait, we are redirecting you for verification'),duration: Duration(seconds: 3),)
                      // );

                      Container(
                        padding: EdgeInsets.only(
                          top: 200.sp,
                          left: 15.sp,
                        ),
                        child: Text(
                            'Please enter verification code we just have sent on  ' +
                                _phoneNumb,
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w400)),
                      ),

                      // Padding(
                      //   padding: const EdgeInsets.only(right: 240.0),
                      //   child: Text('Enter phone number',
                      //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
                      // ),
                      Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Container(
                                height: 9.h,
                                child: TextFormField(
                                  maxLength: 6,
                                  // controller: ,
                                  style: TextStyle(fontSize: 15.sp),
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(8.sp))),
                                  ),
                                  onChanged: (String a) async {
                                    _enteredOtp = a;
                                    if (_enteredOtp!.length == 6) {
                                      final valid =
                                          await FirebasePhoneAuthService
                                              .verifyOTP(otp: _enteredOtp!);

                                      if (!valid) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: Duration(seconds: 1),
                                          content: Text(
                                              'Please enter correct OTP sent to ' +
                                                  _phoneNumb),
                                        ));
                                      }
                                      if (valid) {
                                        // await http.post(Uri.parse(
                                        //     'https://veeluser-default-rtdb.firebaseio.com/UserInfo/$userId.json'));
                                        await userIdFB();
                                      }
                                    }
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      "Please enter your phone number";
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 22.0),
                        child: ElevatedButton(
                          onPressed: () async {
                            saveForm();
                            // await Navigator.pushReplacementNamed(
                            //     context, RegistrationScreen.routeName,
                            //     arguments: userId);
                          },
                          style: ButtonStyle(
                              minimumSize: MaterialStateProperty.all(
                                  Size(272.5.sp, 34.sp)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.black),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))),
                          child: Text('Verify',
                              style: TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w400)),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    ));
  }
}
