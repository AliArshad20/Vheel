import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:veeluser/auth/auth_screen.dart';
import 'package:veeluser/screens/dashboard_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '...';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isLoggedIn=false;
  userIdSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (preferences.containsKey('Id')) {
      setState(() {
        isLoggedIn=true;
      });;
    }
  }

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () async{
      await userIdSP();
      print(isLoggedIn);
      if(isLoggedIn==true){
        Navigator.pushReplacementNamed(context, Dashboard.routeName);
      }
      if(isLoggedIn==false) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => AuthScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: 100.h,
          width: 100.w,
          color: Colors.black,
          child: Center(
              child: Image.asset(
            'assets/splash_logo.png',
          ))),
    );
  }
}
