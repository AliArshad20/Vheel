import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veeluser/widgets/app_drawer.dart';

class Support extends StatelessWidget {
  static const routeName = 'Support';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      drawer: appDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(15.sp),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'You can get help right in the app.'
                  ' To speak to an agent, go to Help'
                  ' in the Driver app, then navigate'
                  ' to the issue you’re experiencing'
                  ' to see the support options available.'
                  'People who drive using the Uber app '
                  'wanted the option of contacting us by'
                  ' phone when they needed help or had a'
                  ' question. Thanks to their feedback, '
                  'Uber offers in-app and phone support'
                  ' for drivers on the road or off.Whether'
                  ' you have a question about your account'
                  ' or want to report an incident, you can '
                  'contact us.To speak directly with a '
                  'trained agent on the phone, go to Help '
                  'in the Driver app, then navigate to the '
                  'issue you’re experiencing to see the'
                  'support options available.',
                  style: TextStyle(
                    fontSize: 16.sp,
                  ),
                  softWrap: true,
                ),
                InkWell(
                    onTap: () {
                      launch(
                          'https://www.uber.com/us/en/drive/driver-app/phone-support/');
                    },
                    child: Container(
                        child: Text(
                      'Learn more',
                      style: TextStyle(fontSize: 28, color: Colors.blue),
                    ))),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
