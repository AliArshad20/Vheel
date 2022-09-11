import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veeluser/map/gogglemap.dart';
import 'package:veeluser/models/rides_model.dart';
import 'package:veeluser/models/userdata.dart';
import 'package:veeluser/widgets/app_drawer.dart';
import 'package:veeluser/widgets/dashboardrides.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';

import '../map/gmap.dart';

class Dashboard extends StatefulWidget {
  static const routeName = 'DashBoard';

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Future<void> getUrlSP() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String Url = await preferences.getString('imageUrl').toString();
    imgUrl = Url;
    print('Image Url Stored in Prefs is:${imgUrl}');
    if (imgUrl == null) print('null${imgUrl}');
  }

  var imgUrl;

  var loading = false;

  void Loading() {
    setState(() {
      Timer(Duration(seconds: 3), () {
        loading = false;
      });
    });
  }
  _launchCaller() async {
    const url = "tel:1122";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
  Timer(Duration(seconds: 3), () {
    loading = false;
  });

  // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: appDrawer(),
      body:loading? CircularProgressIndicator():Stack(
        children: [
          ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: 235.sp, top: 1.h, bottom: 1.h),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.sp),
                              child: Image.asset(
                                'assets/taxi_profile_con.png',height: 38.sp,width: 38.sp,
                                fit: BoxFit.contain,
                              )),
                        ),
                        Container(
                          height: 18.h,
                          width: 100.w,
                          child: Image.asset(
                            'assets/sloganveel.jfif',
                            width: 100.w,
                            height: 18.h,
                            fit: BoxFit.fill,
                          ),
                          // decoration: BoxDecoration(
                          //     // border: Border.all(color: Colors.black, width: 1),
                          //     borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                        ),
                        SizedBox(
                          height: 0.5.h,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MapSample()));
                            // launch(
                            //   'https://www.google.com/maps',
                            // );
                          },
                          child: Container(
                            margin:  EdgeInsets.only(left: 2.0.sp,right: 2.sp),
                            height: 6.8.h,
                            width: 100.w,
                            color: Colors.grey.withOpacity(0.4),
                            child: Container(
                              padding: EdgeInsets.only(top: 12.0.sp,left: 12.sp),
                              child: Text('QUICK RIDE !',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ),
                        
                  child: InkWell(
                    onTap: (){
                      setState(() {
                        _launchCaller();
                      });
                    },
                    child: Container(
                        height: 4.5.h,
                        width: 80.w,
                        // padding: EdgeInsets.only(right: 30.sp),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: Colors.red,
                        ),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                                padding: EdgeInsets.only(right: 42.0.sp, left: 20.sp),

                                child: Image.asset('assets/ambulance.png')),
                            Center(
                                child: Text(
                              'Ambulance',
                              style: TextStyle(fontSize: 17, color: Colors.white),
                            )),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
