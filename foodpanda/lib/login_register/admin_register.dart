import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminRegister extends StatefulWidget {
  const AdminRegister({super.key});

  @override
  State<AdminRegister> createState() => _AdminRegisterState();
}

class _AdminRegisterState extends State<AdminRegister> {
  TextEditingController email = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController cPassword = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    email.dispose();
    name.dispose();
    address.dispose();
    password.dispose();
    cPassword.dispose();

    super.dispose();
  }

  register(String name, String email, String mobile, String address,
      String password, String cPassword) async {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: email.trim(), password: password.trim())
        .then((value) => FirebaseFirestore.instance
                .collection("admin")
                .doc(value.user!.uid)
                .set(
              {
                "name": name,
                "email": value.user!.email,
                "mobile": mobile,
                "address": address,
                "uid": value.user?.uid
              },
            ))
        .then((value) async {
      // Obtain shared preferences.
      final prefs = await SharedPreferences.getInstance();

      await prefs.setString('userType', 'admin');

      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin Register"),
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Full Name',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: mobile,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mobile',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: address,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Address',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: cPassword,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Confirm Password',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () {
                register(name.text, email.text, mobile.text, address.text,
                    password.text, cPassword.text);
              },
              child: Text("Register Now"))
        ]),
      )),
    );
  }
}
