import 'package:flutter/material.dart';
import 'package:foodpanda/login_register/admin_login.dart';
import 'package:foodpanda/login_register/admin_register.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Page"),),
      body:  Center(
        child : Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
                onPressed: (() => Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AdminLogin())))),
                child: Text("Log In")),
            SizedBox(height:  10,),
            ElevatedButton(
                onPressed: (() => Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AdminRegister())))),
                child: Text("Register")),

          ],
        )
      ),
    );
  }
}
