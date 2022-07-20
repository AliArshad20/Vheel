import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MyRides extends ChangeNotifier {
  final String location;
  final String destination;
  final String time;
  final String token;
  final bool paid;

  MyRides({required this.location,
        required this.destination,
        required this.time,
        required this.token,
        required this.paid,
      });
}

List<MyRides> myRides = [
  // MyRides(
  //   location: 'sgd',
  //   destination: 'bhg',
  //   time: '12:00AM',
  // ),
];

Future<void> fetchData(String UserId) async {
  print('UserId is' + UserId);
  try {
    final response = await http.get(
      Uri.parse(
          'https://veeluser-default-rtdb.firebaseio.com/UserInfo/$UserId/UserRides.json'),
    );

    final extractedData = json.decode(response.body) as Map<String, dynamic>;

    final List<MyRides> rides = [];
    extractedData.forEach((key, extractedData) {
      rides.add(MyRides(
          location: extractedData['User Location'],
          destination: extractedData['Destination'],
          time: extractedData['Ride time'], token: extractedData['Token Id'],
        paid: extractedData['Paid']
      ));
    });
    myRides = rides;
  } catch (error) {
    throw error;
  }
  ;
}
