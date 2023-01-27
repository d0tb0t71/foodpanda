import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/provider/auth_provider.dart';
import 'package:foodpanda/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
//TODO Add your own Collection Name instead of 'users'

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);
    var auth_pro = Provider.of<Authentication>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Container(
        child: Column(children: [
          Image.asset("assets/images/single-person.png"),
          Text(pro.name),
          Text(pro.email),
          Text(pro.address),
          Text(pro.mobile),
          ElevatedButton(
              onPressed: () {
                auth_pro.signOut(context: context);
              },
              child: Text("Log Out"))
        ]),
      ),
    );
  }
}
