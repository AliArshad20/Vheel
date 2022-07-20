import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:sizer/sizer.dart';
import 'package:veeluser/payment_methood/Braintree.dart';
import 'package:veeluser/widgets/app_drawer.dart';

class Wallet extends StatelessWidget {
  static const routeName = 'Wallet';

  const Wallet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: appDrawer(),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 100.w,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.only(top: 180.sp, left: 4.w, right: 4.w),
                elevation: 6,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20.sp),
                      child: Text(
                        'Your Account Balance is',
                        style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      // padding: const EdgeInsets.only(left: 100.0,right: 100,top: 24),
                      padding: EdgeInsets.only(top: 6, bottom: 21),
                      child: Text(
                        '  Loading...',
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 21),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 1,
                            width: 100.w,
                            child: Center(
                              child: AlertDialog(
                                insetPadding: EdgeInsets.only(
                                    top: 225.sp,
                                    bottom: 220.sp,
                                    left: 23.sp,
                                    right: 23.sp),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                //this right here
                                titlePadding: EdgeInsets.only(
                                    left: 80.sp, top: 24, right: 30.sp),
                                title: Text(
                                  'Coming soon!!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                content: Text(
                                  'American Express payment gateway is comming soon!',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                actionsPadding:
                                    EdgeInsets.only(right: 28, bottom: 14),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Image.asset(
                    'assets/american_express.png',
                    height: 32.sp,
                    width: 40.sp,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 1,
                            width: 100.w,
                            child: Center(
                              child: AlertDialog(
                                insetPadding: EdgeInsets.only(
                                    top: 225.sp,
                                    bottom: 220.sp,
                                    left: 23.sp,
                                    right: 23.sp),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                //this right here
                                titlePadding: EdgeInsets.only(
                                    left: 80.sp, top: 24, right: 30.sp),
                                title: Text(
                                  'Coming soon!!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                content: Text(
                                  'MasterCard payment gateway is comming soon!',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                actionsPadding:
                                    EdgeInsets.only(right: 28, bottom: 14),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Image.asset(
                    'assets/master.png',
                    height: 32.sp,
                    width: 40.sp,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 1,
                            width: 100.w,
                            child: Center(
                              child: AlertDialog(
                                insetPadding: EdgeInsets.only(
                                    top: 225.sp,
                                    bottom: 220.sp,
                                    left: 23.sp,
                                    right: 23.sp),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                //this right here
                                titlePadding: EdgeInsets.only(
                                    left: 80.sp, top: 24, right: 30.sp),
                                title: Text(
                                  'Coming soon!!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                content: Text(
                                  'VisaCard payment gateway is comming soon!',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                actionsPadding:
                                    EdgeInsets.only(right: 28, bottom: 14),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Image.asset(
                    'assets/visa.png',
                    height: 32.sp,
                    width: 40.sp,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 1,
                            width: 100.w,
                            child: Center(
                              child: AlertDialog(
                                insetPadding: EdgeInsets.only(
                                    top: 225.sp,
                                    bottom: 220.sp,
                                    left: 23.sp,
                                    right: 23.sp),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                //this right here
                                titlePadding: EdgeInsets.only(
                                    left: 80.sp, top: 24, right: 30.sp),
                                title: Text(
                                  'Coming soon!!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                content: Text(
                                  'JazzCash payment gateway is comming soon!',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                actionsPadding:
                                    EdgeInsets.only(right: 28, bottom: 14),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Image.asset(
                    'assets/jazzcash.jpeg',
                    height: 32.sp,
                    width: 40.sp,
                  ),
                ),
                InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SizedBox(
                            height: 1,
                            width: 100.w,
                            child: Center(
                              child: AlertDialog(
                                insetPadding: EdgeInsets.only(
                                    top: 225.sp,
                                    bottom: 220.sp,
                                    left: 23.sp,
                                    right: 23.sp),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                //this right here
                                titlePadding: EdgeInsets.only(
                                    left: 80.sp, top: 24, right: 30.sp),
                                title: Text(
                                  'Coming soon!!',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                ),
                                content: Text(
                                  'EasyPaisa payment gateway is comming soon!',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300),
                                ),
                                actionsPadding:
                                    EdgeInsets.only(right: 28, bottom: 14),
                                actions: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "Ok",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Image.asset(
                    'assets/easy_paisa.png',
                    height: 32.sp,
                    width: 40.sp,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
