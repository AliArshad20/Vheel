import 'package:flutter/cupertino.dart';

class RidesModel extends ChangeNotifier {
  final String title;
  final String imagepath;
  final String description;

  RidesModel(
      {required this.description,
      required this.title,
      required this.imagepath});
}

List<RidesModel> Rides = [
  RidesModel(
    title: 'Rental Rides',
    imagepath: 'assets/car_rental.png',
    description: 1.toString(),
  ),
  RidesModel(
      title: 'Pink Ride',
      imagepath: 'assets/pink_ride.png',
      description: 'Pink Ride is for womens and is coming soon!'),
  RidesModel(
      title: 'Kids Happy Ride',
      imagepath: 'assets/happy_hour.png',
      description: 'Happy Hour Ride is for childs and is coming soon!'),
  RidesModel(
      title: 'Delivery',
      imagepath: 'assets/delivery_truck.png',
      description: ''),
  RidesModel(
      title: 'Handicap Ride',
      imagepath: 'assets/handicap_ride.png',
      description: 'Handicap Ride is for handicaps and is coming soon!'),
  RidesModel(
      title: 'Child Seat Ride',
      imagepath: 'assets/childseat_ride.png',
      description: ''),
];
