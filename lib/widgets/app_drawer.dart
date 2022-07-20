import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:veeluser/auth/auth_screen.dart';
import 'package:veeluser/map/gogglemap.dart';
import 'package:veeluser/screens/dashboard_screen.dart';
import 'package:veeluser/screens/getride_screen.dart';
import 'package:veeluser/screens/payment_history.dart';
import 'package:veeluser/screens/scheduledrides_screen.dart';
import 'package:veeluser/screens/support_screen.dart';
import 'package:veeluser/screens/wallet_screen.dart';
import 'package:provider/provider.dart';

import '../screens/history_screen.dart';

class appDrawer extends StatefulWidget {
  static const routeName = 'Draw...';

  @override
  State<appDrawer> createState() => _appDrawerState();
}

class _appDrawerState extends State<appDrawer> {
  String imgUrl = '';
  String userId = '';

  Future<void> getUrlSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String Url = await preferences.getString('imageUrl').toString();
    String UserID = await preferences.getString('Id').toString();
    setState(() {
      userId = UserID;
      imgUrl = Url;
    });
  }

  var loading = true;

  Loading() {
    setState(() {
      if (imgUrl != null) loading = false;
    });
  }

  // String imgurl1 = '';
  Future<void> clearSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  @override
  void didChangeDependencies() async {
    await getUrlSP();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Drawer(
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 42.sp, left: 5.sp),
                    height: 63.sp,
                    width: 64.sp,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(50.sp))),
                    child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        child:userId.isEmpty? Center(child: CircularProgressIndicator()):Image.network(
                            'https://firebasestorage.googleapis.com/v0/b/veeluser.appspot.com/o/User%20Images%2F${userId}?alt=media&token=bebd1f56-9557-43ab-9cf9-63a2869b06b5',
                            fit: BoxFit.cover)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 68.0, left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'VEEL Cash',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 58.0),
                          child: Text(
                            '0.Pkr',
                            style: TextStyle(
                              fontSize: 21,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 5.7.h,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Dashboard.routeName);
                },
                child: Container(
                  height: 6.h,
                  width: 100.w,
                  child: GridTileBar(
                    title: Padding(
                      padding: EdgeInsets.only(left: 5.6.sp),
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    leading: Padding(
                      padding: EdgeInsets.only(
                          left: 14.0, top: 6, bottom: 6, right: 10.sp),
                      child: Image.asset('assets/dashboard.png'),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(context,MaterialPageRoute(builder:(context)=>MapSample()));
                },
                child: Container(
                  height: 6.h,
                  width: 100.w,
                  child: GridTileBar(
                    title: Padding(
                      padding: EdgeInsets.only(left: 5.6.sp),
                      child: Text(
                        'Find Ride',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(
                          left: 10.0, top: 6, bottom: 6, right: 10),
                      child: Image.asset('assets/current_ride.png'),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, RidesHistory.routeName);
                },
                child: Container(
                  height: 6.h,
                  child: GridTileBar(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'My Rides',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, top: 6, bottom: 6, right: 10),
                      child: Image.asset('assets/ride_history_icon.png'),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, Wallet.routeName);
                },
                child: SizedBox(
                  height: 6.h,
                  child: GridTileBar(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Wallet',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, top: 6, bottom: 6, right: 10),
                      child: Image.asset('assets/wallet.png'),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, ScheduledRides.routeName);
                },
                child: Container(
                  height: 6.h,
                  child: GridTileBar(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Schedule Ride',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, top: 6, bottom: 6, right: 10),
                      child: Image.asset('assets/schedule_rides_icon.png'),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, PaymentHistory.routeName);
                },
                child: Container(
                  height: 6.h,
                  child: GridTileBar(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Payments',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, top: 6, bottom: 6, right: 10),
                      child: Image.asset('assets/covid_check_logo.png'),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Support.routeName);
                },
                child: Container(
                  height: 6.h,
                  child: GridTileBar(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Support',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, top: 6, bottom: 6, right: 10),
                      child: Image.asset('assets/suport.png'),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  clearSP();
                  Navigator.pushReplacementNamed(context, AuthScreen.routeName);
                },
                child: Container(
                  height: 6.h,
                  child: GridTileBar(
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Logout',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(
                          left: 14.0, top: 6, bottom: 6, right: 10),
                      child: Image.asset('assets/log_out.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
