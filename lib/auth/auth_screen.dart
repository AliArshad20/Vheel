import 'dart:async';

import 'package:country_code_picker/country_code.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'aliauth.dart';

class AuthScreen extends StatelessWidget {
  static const routeName = '...';

  TextEditingController _phoneNumb = TextEditingController(text: '+92');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 150.sp,
                  right: 130.sp,
                ),
                child: Text('Welcome To',
                    style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400)),
              ),
            ],
          ),
          Container(
            padding:EdgeInsets.only(bottom: 8.sp,left: 18.sp),
            child: Text('Veel',
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w400)),
          ),
          // Padding(
          //   padding: const EdgeInsets.only(right: 240.0),
          //   child: Text('Enter phone number',
          //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400)),
          // ),
          Form(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    height: 8.h,
                    child: TextFormField(
                      // initialValue: '+92',
                      controller: _phoneNumb,
                      style: TextStyle(fontSize: 16.sp),
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Container(
                          width: 32.w,
                          child: CountryCodePicker(
           onChanged: (code){
             print(code);
           },
                              // onInit: _,
                              // comparator: CountryCode(),
                              showOnlyCountryWhenClosed: true,
                              hideMainText: true,
                              initialSelection: 'PK',
                              favorite: ['+92', 'PK'],
                              showDropDownButton: true,
                              searchDecoration: InputDecoration(),
                              boxDecoration: BoxDecoration(
                                color: Colors.white,
                              )),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.sp))),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          "Please enter your phone number";
                        }
                        if (!value.startsWith("+")) {
                          'Please enter a number in valid format';
                        }
                        if (value.length < 10) {
                          'Please provide a valid phone number';
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              'See Our Privacy Policy',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ),
          Center(
            child: Text(
              '&',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400),
            ),
          ),
          Center(
            child: Text(
              'Terms And Conditions',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.sp,left: 18.sp,right: 18.sp),
            child: ElevatedButton(
              onPressed: () {
                if (_phoneNumb.text.toString().isNotEmpty &&
                    _phoneNumb.text.toString().length == 13) {
                  Navigator.pushReplacementNamed(context, AuthHandler.routeName,
                      arguments: _phoneNumb.text.toString());

                  // Timer(Duration(seconds: 10),() {
                  //   });
                } else
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please enter a valid number')));
              },
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all(Size(272.5.sp, 34.sp)),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ))),
              child: Text('Send OTP',
                  style: TextStyle(fontSize: 21.sp, fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }
}
