import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:veeluser/map/gogglemap.dart';
import 'package:veeluser/models/rides_model.dart';
import 'package:veeluser/screens/getride_screen.dart';

class RidesDesign extends StatelessWidget {
  final String imagepath;
  final String title;
  final String description;

  const RidesDesign({
    Key? key,
    required this.imagepath,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.black,
      onTap: () {
        if (description == 1.toString()) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MapSample()));
        }
        if (description.isNotEmpty && description != 1.toString())
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
                      titlePadding:
                          EdgeInsets.only(left: 80.sp, top: 24, right: 30.sp),
                      title: Text(
                        'Coming soon!',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      content: Text(
                        description,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w300),
                      ),
                      actionsPadding: EdgeInsets.only(right: 28, bottom: 14),
                      actions: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Ok",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
      },
      child: Card(
        elevation: 6,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              color: Colors.white70),
          child: GridTile(
              footer: Container(
                height: 40.sp,
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.all(Radius.circular(7))
                // ),
                child: GridTileBar(
                  backgroundColor: Colors.black,
                  title: Center(
                      child: Text(
                    title,
                    style: TextStyle(fontSize: 16),
                  )),
                ),
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: 44.0.sp, top: 10.sp),
                child: Image.asset(
                  imagepath,
                  fit: BoxFit.fitHeight,
                ),
              )),
        ),
      ),
    );
  }
}
