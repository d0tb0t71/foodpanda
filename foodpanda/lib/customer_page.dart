import 'package:flutter/material.dart';
import 'package:foodpanda/admin_login.dart';
import 'package:foodpanda/customer_login.dart';
import 'package:foodpanda/customer_register.dart';

class CustomerPage extends StatelessWidget {
  const CustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Customer Page"),),
      body:  Center(
        child : Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            ElevatedButton(
                onPressed: (() => Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => CustomerLogin())))),
                child: Text("Log In")),
            SizedBox(height:  10,),
            ElevatedButton(
                onPressed: (() => Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => CustomerRegister())))),
                child: Text("Register")),

          ],
        )
      ),
    );
  }
}
