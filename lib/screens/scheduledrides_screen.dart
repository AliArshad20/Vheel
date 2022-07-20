import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:veeluser/widgets/app_drawer.dart';

class ScheduledRides extends StatelessWidget {
  static const routeName = 'Rides...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: appDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(

            padding: EdgeInsets.only(top: 30.0.sp, right: 130.sp,
            ),child: Text(
              'Scheduled Rides',
              style: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            padding: EdgeInsets.only(right: 180.sp, top: 8.sp,),
            child: Text(
              'Outside city',
              style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              height: 39.5.h,
              width: 103.w,
              // margin: EdgeInsets.all(12.sp),
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Image.asset('assets/location.png',height: 42.h,width: 103.w,
                  fit: BoxFit.fitHeight,)
                  // Center(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(top: 190.0),
                  //     child: Text(
                  //       'Loading...',
                  //       style: TextStyle(
                  //           fontSize: 20,
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.w400),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(
          //     right: 320,
          //   ),
          //   child: Text(
          //     'Inside city',
          //     style: TextStyle(
          //         fontSize: 20,
          //         color: Colors.black,
          //         fontWeight: FontWeight.w400),
          //   ),
          // ),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Container(
          //     height: 39.43.h,
          //     width: 103.w,
          //     child: ListView(
          //       scrollDirection: Axis.vertical,
          //       children: [
          //         Center(
          //           child: Image.asset('assets/sgd.png',height: 43.h,width: 103.w,
          //           fit: BoxFit.fitWidth,
          //           ),
          //         )
          //       ],
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
