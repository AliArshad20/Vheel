import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserData with ChangeNotifier {
  Future<void> UserInfo(
      String UserId, name1, name2, email, refcode, File image) async {
    final post = http.post(
      Uri.parse(
          'https://veeluser-default-rtdb.firebaseio.com/UserInfo/$UserId.json'),
      body: jsonEncode({
        'UserID': UserId,
        'First Name': name1,
        'Last Name': name2,
        'Email': email,
        'Referral code': refcode,
        // 'User photo': photo,
      }),
    );
    // FirebaseStorage Storage = FirebaseStorage.instance;
    // Reference reference = Storage.ref().child('pathname' + DateTime.now().toString());
    // await reference.putFile(image);
    // String ImageUrl = await reference.getDownloadURL();
    // print(ImageUrl);

    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child('User Images/'+UserId);
    await ref.putFile(image);
    String imageUrl = await ref.getDownloadURL();
    // print(imageUrl);
    notifyListeners();
  }

  imageUrl() async{
   String ImageUrl= await FirebaseStorage.instance
        .ref()
        .child('User Images/'+getUserIdSP())
        .getDownloadURL().toString();
   return ImageUrl;
  }

     getUserIdSP() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    String? IdValue= preferences.getString('IdValue');
    return IdValue;
  }


     Future<String?> prefs() async{
       SharedPreferences preferences=await SharedPreferences.getInstance();
       if(preferences.containsKey('IdValue')){
         return 'ok';
       };
         if(!preferences.containsKey('IdValue')){
           return 'nodata';}
         else 'nothing';
       }

  Future<void> postNumb(String numb) async {
    final response = await http.post(Uri.parse(
        'https://veeluser-default-rtdb.firebaseio.com/UserInfo.json'),
        body: jsonEncode({
          'phoneNumb':numb,
        })
    );

  }


}
