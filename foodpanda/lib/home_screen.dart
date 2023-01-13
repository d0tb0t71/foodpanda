import 'package:flutter/material.dart';
import 'package:foodpanda/add_product.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userType = "customer";

  @override
  void initState() {
    getUserType();
    // TODO: implement initState
    super.initState();
  }

  getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('userType')!;

    if(userType == "admin"){
      setState(() {
        
      });
    }


    print(userType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Foodpanda Homescreen"),
      ),
      body: Container(
        child: Column(
          children: [],
        ),
      ),
      floatingActionButton: userType == "admin" ? FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => AddProduct()));
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
      ) : Container(),
    );
  }
}
