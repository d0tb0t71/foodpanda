import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen.dart';

class CustomerRegister extends StatefulWidget {
  CustomerRegister({super.key, required this.role});

  String role;

  @override
  State<CustomerRegister> createState() => _CustomerRegisterState();
}

class _CustomerRegisterState extends State<CustomerRegister> {
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

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<Authentication>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Register"),
        backgroundColor: Colors.pinkAccent,
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
              labelText: 'Shop Name',
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
            style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
                minimumSize: Size(100, 40)
              ),
              onPressed: () {
                pro.signUp(
                    name: name.text,
                    email: email.text,
                    password: password.text,
                    address: address.text,
                    mobile: mobile.text,
                    role: widget.role,
                    context: context);
              },
              child: Text("Register Now"))
        ]),
      )),
    );
  }
}
