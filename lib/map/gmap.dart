

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:veeluser/screens/getride_screen.dart';


class VeelMap extends StatefulWidget {
static const routeName='//';
  @override
  State<VeelMap> createState() => VeelMapState();
}

class VeelMapState extends State<VeelMap> {
  Completer<GoogleMapController> _controller = Completer();
  var latlng;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 4.4746,
  );

  static const cameraPosition = CameraPosition(
    // bearing: 192,
    target: LatLng(32.076591332455973653343, 72.698683849278007),
    zoom:11,
    tilt: 50,
  );
  MapType _currentMapType = MapType.normal;

  Marker? _origin;
  // Marker? _destination;

  void _addMarker(LatLng pos){
    if(_origin ==null || _origin!=null){
      setState(() {
        _origin=Marker(markerId: MarkerId('origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        // _destination=null;
        print(pos);
        latlng=pos;
      });
    }
    // else{
    //   setState(() {
    //     _destination=Marker(markerId: MarkerId('destination'),
    //       icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    //       position: pos,
    //     );
    //     print(pos);
    //   });
    // }
    }
  // LatLng() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('imageUrl', );
  //   preferences.setString('Id', userId);
    // print(UserIdSP('Name'));
  // }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.arrow_back,color: Colors.black,),
          title: Text('Google Maps',style: TextStyle(color: Colors.black,fontSize: 24),),
          backgroundColor: Colors.grey[50],
        ),
        body: Stack(
          children: [
            GoogleMap(
              compassEnabled: true,
              onLongPress: _addMarker,
              markers: {
                if(_origin!=null)  _origin!,
                // if(_destination!=null)  _destination!,
              },
              mapType:_currentMapType,
              initialCameraPosition: cameraPosition,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: (){
                  if(latlng!=null){
                    Navigator.pushReplacementNamed(context, FindRide.routeName,);
                  }
                },
                child: Container(
                  margin: EdgeInsets.only(bottom:28.sp),
                   decoration: BoxDecoration(
                       color: Colors.white.withOpacity(0.8),
                       borderRadius: BorderRadius.all(Radius.circular(5.sp))
                   ),
                  width: 30.w,
                  height: 5.h,
                  child: Center(child: Text('Done',style: TextStyle(fontSize: 23),)),
                ),
              ),
            )
          ],
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(top: 12.0.h,left: 3.h),
          child: Align(
            alignment: Alignment.topRight,
            child: FloatingActionButton(
              backgroundColor: Colors.white70.withOpacity(0.8),
              onPressed: (){
                setState(() {
                  _currentMapType=_currentMapType ==  MapType.normal
                      ? MapType.satellite
                      : MapType.normal;
                });},
              child:Icon(Icons.satellite,color: Colors.black.withOpacity(0.6),size: 27,),
            ),

          ),
        ),
      ),
    );
  }}



// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class GMap extends StatelessWidget {
//   static const cameraPosition = CameraPosition(
//     target: LatLng(37.42796133580664, -122.085749655962),
//     zoom: 10.4746,
//   );
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:GoogleMap(
//         myLocationButtonEnabled: false,
//         zoomControlsEnabled: false,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(37.42796133580664, -122.085749655962),
//           zoom: 11.4746,
//         ),
//
//       ),
//     );
//   }
// }
