import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../home_screen.dart';

class CustomerLogin extends StatefulWidget {
  const CustomerLogin({super.key});

  @override
  State<CustomerLogin> createState() => _CustomerLoginState();
}

class _CustomerLoginState extends State<CustomerLogin> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    email.dispose();
    password.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    var pro = Provider.of<Authentication>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Login"),
      ),
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  pro.signIn(email.text, password.text, context);
                },
                child: const Text("Log In Now")),
          ],
        ),
      )),
    );
  }
}
