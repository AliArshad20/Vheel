import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:veeluser/models/myRides_model.dart';
import 'package:veeluser/widgets/app_drawer.dart';

class PaymentHistory extends StatefulWidget {
  static const routeName = 'RidesHistory';

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  String UserId = '';

  Future<void> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = await preferences.getString('Id').toString();
    UserId = userId;
  }

  var _isLoading = false;

  var _isInIt = true;

  void didChangeDependencies() async {
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

      _isInIt = false;
    } catch (error) {
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
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30.0.sp, right: 76.sp),
            child: Text(
              'Your Payment History',
              style: TextStyle(
                  fontSize: 21.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.w400),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Container(
            color: Colors.grey,
            child: ListTile(
              title: Text('    Date                        '
                  'Token no.'),
              trailing: Padding(
                padding: const EdgeInsets.only(right: 4.0, bottom: 4),
                child: Text('Payment'),
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: myRides.length,
            itemBuilder: (BuildContext context, int index) => ListTile(
              title: Text(DateTime.now().toString().substring(0,10)+'                    '+
                  myRides[index].token),
              trailing: Padding(
                padding: EdgeInsets.only(right: 0.1.sp, bottom: 4),
                child:myRides[index].paid? Text('12 \$'):Text('pending(12\$)'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
