import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_braintree/flutter_braintree.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:veeluser/map/gmap.dart';
import 'package:veeluser/map/gogglemap.dart';
import 'package:veeluser/screens/history_screen.dart';
import 'package:veeluser/screens/payment_history.dart';
import 'package:veeluser/widgets/app_drawer.dart';
import 'dashboard_screen.dart';
import 'package:http/http.dart' as http;

class FindRide extends StatefulWidget {
  static const routeName = 'FindRide';
  final String Origin1;
  final Destination1;

  const FindRide({Key? key, required this.Origin1, required this.Destination1})
      : super(key: key);

  @override
  State<FindRide> createState() => _FindRideState();
}

String UserId = '';

class _FindRideState extends State<FindRide> {
  Future<void> placeRide(
      String UserId, Origin, Destination, email, bool paid) async {
    final post = await http.post(
      Uri.parse(
          'https://veeluser-default-rtdb.firebaseio.com/UserInfo/$UserId/UserRides.json'),
      body: jsonEncode({
        // 'UserID': UserId,
        'User Location': Origin,
        'Destination': Destination,
        'Ride time': email,
        'Token Id': DateTime.now().toString().substring(20, 24),
        'Paid': paid,
        // 'Referral code': refcode,
      }),
    );
  }

  Future<void> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = await preferences.getString('Id').toString();
    UserId = userId;
    print('Image Url Stored in Prefs is:${UserId}');
  }

  final name1 = TextEditingController();
  final name2 = TextEditingController();
  final email = TextEditingController();
  final refCode = TextEditingController();

  final LastName = FocusNode();
  final Email = FocusNode();
  final ReferralCode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  String? Nonce;

  Future<void> Payment() async {
    var request = await BraintreeDropInRequest(
      tokenizationKey: 'sandbox_zj26wj8w_jbsyxhjvfdty27fk',
      // sandbox_hcpsx5t6_phhg2nxbzjbtc9jy rajayogan collectDeviceData: true,
      paypalRequest:
          BraintreePayPalRequest(amount: '10', displayName: 'Veeluser'),
      cardEnabled: true,
    );
    BraintreeDropInResult? result = await BraintreeDropIn.start(request);
    if (result != null) {
      Nonce = result.paymentMethodNonce.nonce;
    } else {
      print('Selection was canceled.');
    }
    Navigator.pop(context);
  }

  void saveForm(bool paid) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      getUserId();
      if (UserId.isNotEmpty)
        await placeRide(
          UserId,
          widget.Origin1,
          widget.Destination1,
          email.text.toString(),
          paid,
          // refCode.text.toString(),
        );
      Navigator.pushNamed(context, RidesHistory.routeName);
    } else
      print('error');
  }

  String Latlng = '';

  @override
  void initState() {
    getUserId();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final user = Provider.of<UserData>(context);
    // late String? latlng=ModalRoute.of(context)!.settings.arguments as String;
    // if (latlng != null) {
    //   print(' its me  '+latlng);
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: appDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.only(
                top: 30.0.sp,
                right: 185.sp,
              ),
              child: Text('Find Ride',
                  style:
                      TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w400)),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    //       InkWell(
                    //         onTap: (){
                    //           Navigator.push(context, MaterialPageRoute(builder: (context)=>MapSample()));
                    //           },
                    //         child: Container(
                    //           height: 10.h,
                    //           width: 90.w,
                    //           color: Colors.black26,
                    //           child: Row(
                    //             children: [
                    //               Text('Provide loction',style: TextStyle(fontSize: 25),),
                    // Icon(Icons.location_searching),
                    //               // Container(
                    //               //     height: .h,
                    //               //     width: 12.w,
                    //               //     child: Image.asset('assets/location.png'))
                    //             ],
                    //           ),
                    //         ),
                    //       ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       top: 20, right: 18, bottom: 10, left: 18),
                    //   child: TextFormField(
                    //       controller: name1,
                    //       style: TextStyle(fontSize: 19),
                    //       decoration: InputDecoration(
                    //         hintText: 'Your location',
                    //         prefixIcon: Padding(
                    //             padding: const EdgeInsets.all(12.0),
                    //             child: Icon(Icons.my_location)),
                    //         border: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(10)),
                    //         ),
                    //       ),
                    //       keyboardType: TextInputType.text,
                    //       textInputAction: TextInputAction.next,
                    //       onFieldSubmitted: (_) {
                    //         FocusScope.of(context).requestFocus(LastName);
                    //       },
                    //       validator: (value) {
                    //         if (value!.isEmpty) {
                    //           return 'Please provide ride starting point';
                    //         }
                    //         // if (value.length < 3) {
                    //         //   return 'Please provide name with at least three characters';
                    //         // }
                    //         // if (value.length > 16) {
                    //         //   return 'Please provide a valid first name';
                    //         // }
                    //       }),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(
                    //       right: 18, bottom: 10, left: 18),
                    //   child: TextFormField(
                    //       controller: name2,
                    //       style: TextStyle(fontSize: 19),
                    //       decoration: InputDecoration(
                    //         hintText: 'Destination',
                    //         prefixIcon: Padding(
                    //             padding: const EdgeInsets.all(12.0),
                    //             child: Icon(Icons.add_location_alt_outlined)),
                    //         border: OutlineInputBorder(
                    //           borderRadius:
                    //               BorderRadius.all(Radius.circular(10)),
                    //         ),
                    //         // icon: Icon(Icons.email_outlined),
                    //         // labelText: 'Email',
                    //       ),
                    //       focusNode: LastName,
                    //       keyboardType: TextInputType.name,
                    //       textInputAction: TextInputAction.next,
                    //       onFieldSubmitted: (_) {
                    //         FocusScope.of(context).requestFocus(Email);
                    //       },
                    //       validator: (value) {
                    //         if (value!.isEmpty) {
                    //           return 'Please provide destination address';
                    //         }
                    //       }),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 18, bottom: 10, left: 18),
                      child: TextFormField(
                        controller: email,
                        style: TextStyle(fontSize: 19),
                        decoration: InputDecoration(
                          hintText: 'Ride time',
                          suffix: Text('HH:MM'),
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.share_arrival_time_outlined)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        focusNode: Email,
                        keyboardType: TextInputType.streetAddress,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(ReferralCode);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide the time for your ride';
                          }
                          if (value.length != 5) {
                            return 'Please enter time in correct format as HH:MM';
                          }
                          if (!value.contains(":")) {
                            return 'Please enter time in correct format as HH:MM';
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 18, bottom: 10, left: 18),
                      child: TextFormField(
                          controller: refCode,
                          style: TextStyle(fontSize: 19),
                          decoration: InputDecoration(
                            hintText: 'Date',
                            suffix: Text('DD/MM/YYYY'),
                            prefixIcon: Icon(Icons.date_range),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            // icon: Icon(Icons.email_outlined),
                            // labelText: 'Email',
                          ),
                          focusNode: ReferralCode,
                          keyboardType: TextInputType.url,
                          textInputAction: TextInputAction.done,
                          // onFieldSubmitted: (_) {
                          //   FocusScope.of(context).requestFocus(ReferralCode);
                          // },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please provide date for your ride';
                              // }
                            }
                            if (!value.contains("/")) {
                              return 'Please enter date in correct format as DD/MM/YYYY';
                            }
                            if (value.length != 10) {
                              return 'Please enter date in correct format as DD/MM/YYYY';
                            }
                          }),
                    ),
                    SizedBox(
                      height: 1.7.h,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  //this right here
                                  backgroundColor: Colors.white,
                                  title: Text('Bill'),
                                  content: Row(
                                    children: [
                                      // Text('Pay '),
                                      Text(
                                        "You have to pay 12\$.",
                                        softWrap: true,
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    Center(
                                        child: Column(
                                      children: [
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black)),
                                            child: Text('Pay Now'),
                                            onPressed: () async {
                                              Payment().then((value) {
                                                if (Nonce != null) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                    duration:
                                                        Duration(seconds: 3),
                                                    content: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Your payment processed successfully',
                                                          style: TextStyle(
                                                              fontSize: 16.sp),
                                                        ),
                                                        CircularProgressIndicator(),
                                                      ],
                                                    ),
                                                  ));
                                                  saveForm(true);
                                                }
                                                if (Nonce == null) {
                                                  '          error        ';
                                                }
                                              });
                                            }),
                                        ElevatedButton(
                                            style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        Colors.black)),
                                            child: Text('Pay later'),
                                            onPressed: () async {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                duration: Duration(seconds: 3),
                                                content: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      'You will have to pay after ride',
                                                      style: TextStyle(
                                                          fontSize: 16.sp),
                                                    ),
                                                    CircularProgressIndicator(),
                                                  ],
                                                ),
                                              ));
                                              saveForm(false);
                                              Navigator.pop(context);
                                            }),
                                      ],
                                    )),
                                  ],
                                );
                              });
                        }
                      },
                      child: Text(
                        'Order Ride',
                        style: TextStyle(fontSize: 19.sp),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.sp))),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black),
                        minimumSize: MaterialStateProperty.all(Size(90.w, 6.h)),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
