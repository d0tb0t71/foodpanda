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

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("assets/images/single-person.png"),
                Text("Name : "),
                Text(
                  pro.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Email : "),
                Text(pro.email,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text("Address : "),
                Text(pro.address,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                Text("Mobile Number : "),
                Text(pro.mobile,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.red, minimumSize: Size(size.width, 40)),
                    onPressed: () {
                      auth_pro.signOut(context: context);
                    },
                    child: Text("Log Out"))
              ]),
        ),
      ),
    );
  }
}
