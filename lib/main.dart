import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:sizer/sizer.dart';
import 'package:veeluser/map/gmap.dart';
// import 'package:veeluser/map/gogglemap.dart';
import 'package:veeluser/models/userdata.dart';
import 'package:veeluser/auth/auth_screen.dart';
// import 'package:veeluser/payment_methood/paypal.dart';
import 'package:veeluser/screens/getride_screen.dart';
import 'package:veeluser/screens/history_screen.dart';
import 'package:veeluser/screens/registration_screen.dart';
import 'package:veeluser/screens/payment_history.dart';
import 'package:veeluser/screens/splash_screen.dart';
import 'package:veeluser/screens/support_screen.dart';
import 'auth/aliauth.dart';
import 'screens/dashboard_screen.dart';
import 'screens/scheduledrides_screen.dart';
import 'screens/wallet_screen.dart';
import 'widgets/app_drawer.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
firebaseInitialize;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: () {
      return ChangeNotifierProvider(
          create: (_) => UserData(),
          child: FirebasePhoneAuthProvider(
              child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            // home: PaymentMethood(),

            initialRoute: '/',
            routes: {
              '/': (BuildContext ctx) => SplashScreen(),
              AuthScreen.routeName: (BuildContext ctx) => AuthScreen(),
              AuthHandler.routeName: (BuildContext context) => AuthHandler(),
              RegistrationScreen.routeName: (BuildContext ctx) =>
                  RegistrationScreen(),
              Dashboard.routeName: (BuildContext ctx) => Dashboard(),
              appDrawer.routeName: (BuildContext ctx) => appDrawer(),
              PaymentHistory.routeName: (BuildContext ctx) => PaymentHistory(),
              Wallet.routeName: (BuildContext ctx) => Wallet(),
              ScheduledRides.routeName: (BuildContext ctx) => ScheduledRides(),
              Support.routeName:(BuildContext context)=>Support(),
              RidesHistory.routeName:(BuildContext context)=>RidesHistory(),
              // FindRide.routeName:(BuildContext context)=>FindRide(),
              VeelMap.routeName:(BuildContext context)=>VeelMap(),
            },
          )));
    });
  }
}
