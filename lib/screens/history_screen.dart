import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:veeluser/models/myRides_model.dart';
import 'package:sizer/sizer.dart';
import '../widgets/app_drawer.dart';

class RidesHistory extends StatefulWidget {
  static const routeName = 'Rhis';

  @override
  State<RidesHistory> createState() => _RidesHistoryState();
}

class _RidesHistoryState extends State<RidesHistory> {
  String UserId = '';

  Future<void> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = await preferences.getString('Id').toString();
    UserId = userId;
  }
  var _isLoading = false;
  var _isInIt = true;

  void didChangeDependencies() async{
   try {
     getUserId();
     if (_isInIt) {
       setState(() {
         _isLoading = true;
       });
       await getUserId().then((value) => fetchData(UserId)).then((value) {
         if (fetchData(UserId) == null) {
           setState(() {
             _isLoading = false;
           });
         }
         setState(() {
           _isLoading = false;
         });
       });
       //  if (fetchData(UserId) == null){
       //   setState(() {
       //     _isLoading = false;
       //   });
       // }

     }

    _isInIt = false;}
   catch (error){
     setState(() {
       _isLoading = false;
     });

   }
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: appDrawer(),
      body:
      _isLoading
          ? Center(child: CircularProgressIndicator()) :
      SingleChildScrollView(
        child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.only(top: 30.sp,  right: 168.sp,),
                      child: Text(
                        'My Rides',
                        style: TextStyle(
                            fontSize: 21.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      physics:ClampingScrollPhysics(),
                      itemCount:myRides.length,
                      itemBuilder: (BuildContext ctx, int index) => Container(
                            height: 22.h,
                            margin: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.sp),
                                border: Border.all(
                                    width: 1.sp,
                                    color: Colors.black.withOpacity(0.6))),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              SizedBox(
                                                height: 6.h,
                                              ),
                                              Icon(
                                                Icons.add_location_outlined,
                                                size: 22.sp,
                                              ),
                                              Container(
                                                // width: 50.w,
                                                child: Text(
                                                  ' ' + myRides[index].location,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontSize: 8.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Icon(
                                                Icons.add_location,
                                                size: 22.sp,
                                              ),
                                              Container(
                                                // width: 60.w,
                                                child: Text(
                                                  ' ' + myRides[index].destination,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(fontSize: 8.sp),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: 2.w,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(right: 1),
                                        child: Image.asset(
                                          'assets/current_ride.png',
                                          height: 50.sp,
                                          width: 50.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Ride Time:   '
                                          '                   ',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        Text(
                                          myRides[index].time,
                                          // DateTime.now().toString().substring(0, 16),
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Car Model:',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        Text(
                                          'ABC-313',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0, right: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Token Id:',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                        Text(
                                          myRides[index].token,
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                          )),
                ],
              ),
      ),
    );
  }
}
