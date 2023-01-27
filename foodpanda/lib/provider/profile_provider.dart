import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class ProfileProvider extends ChangeNotifier {
  String profileUrl = '';

  String name = '';
  String email = '';
  String address = '';
  String mobile = '';
  String role = '';
  String currentUserUid = '';

  getUserInfo() async {
    if (FirebaseAuth.instance.currentUser != null) {
      DocumentSnapshot userInfo = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      currentUserUid = FirebaseAuth.instance.currentUser!.uid;
      name = userInfo["name"];
      email = userInfo["email"];
      address = userInfo["address"];
      mobile = userInfo["mobile"];
      role = userInfo["role"];

      print("----------------------------------------------- ");
      print(name);
      print(email);
      print(address);
      print(mobile);
      print(role);
      print(currentUserUid);


      notifyListeners();
    }
  }
}
