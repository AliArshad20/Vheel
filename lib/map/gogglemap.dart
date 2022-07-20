import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;
import 'package:veeluser/screens/dashboard_screen.dart';

import '../screens/getride_screen.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}
final lat =TextEditingController();
final lon =TextEditingController();
double a=double.parse('${lat.text.toString()}');
double b=double.parse('${lon.text.toString()}');

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  static final cameraPosition = CameraPosition(
    target: LatLng(32.076591332455973653343, 72.698683849278007),
    zoom: 11.4746,
  );
  bool search = false;
  MapType _currentMapType = MapType.normal;

  Marker? _origin;
  Marker? _destination;

  LatLng Origin = LatLng(32.076591332455973653343, 72.698683849278007);
  LatLng Destination = LatLng(32.076591332455973653343, 72.698683849278007);

  final orig = TextEditingController();
  final dest = TextEditingController();
  final customLocation = TextEditingController();

  // final longituide= TextEditingController();
  // final Search = LatLng(latitude, longitude);

  void _addMarker(LatLng pos) {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: MarkerId('origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _destination = null;
        Origin = pos;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: MarkerId('destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          position: pos,
        );
        print(pos);
        Destination = pos;
      });
    }
  }

  String UserId = '';

  Future<void> getUserId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userId = await preferences.getString('Id').toString();
    UserId = userId;
    print('Image Url Stored in Prefs is:${UserId}');
  }

  //
  // Future<void> latlng() async {
  //   if (UserId.isNotEmpty)
  //     final post = await http.post(
  //       Uri.parse(
  //           'https://veeluser-default-rtdb.firebaseio.com/UserInfo/$UserId/UserRides.json'),
  //       body: jsonEncode({
  //         'User Location': Origin,
  //         'Destination': Destination,
  //       }),
  //     );
  // }

  bool manualInput = false;
  bool manualLoc = false;
  final _formKey = GlobalKey<FormState>();

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  static final _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(92, 39),
      tilt: 59.440717697143555,
      zoom: 13.151926040649414);

  @override
  Widget build(BuildContext context) {
    getUserId();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, Dashboard.routeName);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          title: Text(
            'Google Maps',
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
          backgroundColor: Colors.grey[50],
        ),
        body: Stack(
          children: [
            GoogleMap(
              onLongPress: _addMarker,
              markers: {
                if (_origin != null) _origin!,
                if (_destination != null) _destination!,
              },
              mapType: _currentMapType,
              initialCameraPosition:
                  // search? :
                  cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: InkWell(
                onTap: () {
                  setState(() {
                    manualInput = manualInput == false ? true : false;
                    manualLoc = manualLoc == false ? true : false;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 28.sp, left: 3.5.w),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(5.sp))),
                  width: 10.w,
                  height: 5.h,
                  child: Center(child: Icon(Icons.expand_more_sharp)),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  search = search == false ? true : false;
                });
              },
              child: Container(
                margin: EdgeInsets.only(left: 6.w, top: 10.h),
                height: 37.sp,
                width: 37.sp,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(35.sp))),
                child: Icon(
                  Icons.search,
                  size: 27.sp,
                ),

                // color: Colors.white,
              ),
            ),
            if (search == true)
              Container(
                // height: 8.3.h,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.all(Radius.circular(10.sp))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextFormField(
                        style: TextStyle(fontSize: 19),
                        controller: lat,
                        decoration: InputDecoration(
                          hintText: ' LatLng(longitude,latitude)',
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.my_location)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide proper Latitude and longitude';
                          }
                          if (!value.startsWith('LatLng')) {
                            return 'Please provide proper Latitude and longitude';
                          }
                          // if (value.length < 3) {
                          //   return 'Please provide name with at least three characters';
                          // }
                          // if (value.length > 16) {
                          //   return 'Please provide a valid first name';
                          // }
                        }),TextFormField(
                        style: TextStyle(fontSize: 19),
                        controller: customLocation,
                        decoration: InputDecoration(
                          hintText: ' LatLng(longitude,latitude)',
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Icon(Icons.my_location)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                        //   if (customLocation.text.toString() ==
                        //       'LatLng(39,92)') {
                        //     _goToTheLake();
                        //   }
                        //   if (customLocation.text.toString() !=
                        //       'LatLng(39,92)') {
                        //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        //       duration: Duration(seconds: 2),
                        //       content: Row(
                        //         mainAxisAlignment:
                        //             MainAxisAlignment.spaceBetween,
                        //         children: [
                        //           Text(
                        //             "Can't find location",
                        //             style: TextStyle(fontSize: 13.sp),
                        //           ),
                        //         ],
                        //       ),
                        //     ));
                        //   }
                        //   // FocusScope.of(context).requestFocus(LastName);
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please provide proper Latitude and longitude';
                          }
                          if (!value.startsWith('LatLng')) {
                            return 'Please provide proper Latitude and longitude';
                          }
                          // if (value.length < 3) {
                          //   return 'Please provide name with at least three characters';
                          // }
                          // if (value.length > 16) {
                          //   return 'Please provide a valid first name';
                          // }
                        }),
                  ],
                ),
              ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () async {
                  if (_origin != null && _destination != null) {
                    // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    //   duration: Duration(seconds: 1),
                    //   content: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       Text(
                    //         'Processing Data...',
                    //         style: TextStyle(fontSize: 13.sp),
                    //       ),
                    //       CircularProgressIndicator(),
                    //     ],
                    //   ),
                    // ));
                    // await latlng();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindRide(
                                Origin1: Origin.toString(),
                                Destination1: Destination.toString())));
                    // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }
                  if (manualLoc == true) {
                    if (_formKey.currentState!.validate())
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FindRide(
                                    Origin1: orig.text.toString(),
                                    Destination1: dest.text.toString(),
                                  )));
                  }
                  if (_origin == null &&
                      _destination == null &&
                      manualLoc == false &&
                      customLocation.text.toString().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 4),
                      content: Text(
                        'Please provide location and destination',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ));
                  }
                  if (_origin != null && _destination != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(minutes: 2),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Processing Data...',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    ));
                    // await latlng();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => FindRide(
                                Origin1: Origin.toString(),
                                Destination1: Destination.toString())));
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  }
                  // if (customLocation.text.toString() == 'LatLng(39,92)') {
                  //   _goToTheLake();

                  setState((){
                    // if(a!=null&&b!=null)
                    print(lat);
                  });
                  // }
                  if (customLocation.text.toString() != 'LatLng(39,92)' &&
                      _origin == null &&
                      _destination == null &&
                      manualLoc == false) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      duration: Duration(seconds: 2),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Can't find location",
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ],
                      ),
                    ));
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 28.sp),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.all(Radius.circular(5.sp))),
                  width: 30.w,
                  height: 5.h,
                  child: Center(
                      child: Text(
                    'Done',
                    style: TextStyle(fontSize: 23),
                  )),
                ),
              ),
            ),
            if (manualInput == true)
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      // padding: EdgeInsets.only(top: 5.w),
                      width: 90.w,
                      height: 7.h,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              BorderRadius.all(Radius.circular(7.sp))),

                      child: Center(
                          child: Text(
                        'Manual Input',
                        style: TextStyle(color: Colors.white, fontSize: 22.sp),
                      )),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 8.sp, right: 16.sp, bottom: 1.h, left: 16.sp),
                        child: Container(
                          // height: 8.3.h,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.sp))),
                          child: TextFormField(
                              style: TextStyle(fontSize: 19),
                              controller: orig,
                              decoration: InputDecoration(
                                hintText: ' Origin',
                                prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(Icons.my_location)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                              ),
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                // FocusScope.of(context).requestFocus(LastName);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide ride starting point';
                                }
                                // if (value.length < 3) {
                                //   return 'Please provide name with at least three characters';
                                // }
                                // if (value.length > 16) {
                                //   return 'Please provide a valid first name';
                                // }
                              }),
                        ),
                      ),
                    ),
                    // if(manualInput==true)
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: 16.sp, bottom: 28.w, left: 16.sp),
                        child: Container(
                          // height: 8.3.h,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.sp))),
                          child: TextFormField(
                              // initialValue: Destination.toString(),
                              controller: dest,
                              style: TextStyle(fontSize: 19),
                              decoration: InputDecoration(
                                hintText: 'Destination',
                                prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child:
                                        Icon(Icons.add_location_alt_outlined)),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                // icon: Icon(Icons.email_outlined),
                                // labelText: 'Email',
                              ),
                              // focusNode: LastName,
                              keyboardType: TextInputType.name,
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                // FocusScope.of(context).requestFocus(Email);
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please provide destination address';
                                }
                              }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 22.0.h, left: 3.h),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              backgroundColor: Colors.white70.withOpacity(0.8),
              onPressed: () {
                setState(() {
                  _currentMapType = _currentMapType == MapType.normal
                      ? MapType.satellite
                      : MapType.normal;
                });
              },
              // label: Text('Type'),
              child: Icon(
                Icons.satellite,
                color: Colors.black.withOpacity(0.6),
                size: 23.sp,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
