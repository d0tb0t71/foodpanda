import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  late String uid;

  @override
  void initState() {
    getUserType();
    getUid();
    // TODO: implement initState
    super.initState();
  }

  getUid() {
    uid = FirebaseAuth.instance.currentUser!.uid;
  }

  getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    userType = prefs.getString('userType')!;

    if (userType == "admin") {
      setState(() {});
    }

    print(userType);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Foodpanda Homescreen"),
      ),
      body: Container(
          height: size.height,
          child: Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .doc(uid)
                    .collection("allProducts")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  final data = snapshot.data;
                  if (data != null) {
                    return buildList(data)!;
                  } else {
                    return const Center(child: Text("Something went wrong"));
                  }
                }),
          )),
      floatingActionButton: userType == "admin"
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddProduct()));
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
            )
          : Container(),
    );
  }

  ListView buildList(QuerySnapshot<Object?> data) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return data.size != null
            ? Container(
                color: Colors.amber,
                margin: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/settings.png",
                      height: 50,
                      width: 50,
                    ),
                    Spacer(),
                    Text(data.docs[index]["name"]),
                    Spacer(),
                    ElevatedButton(onPressed: () {}, child: Text("Details"))
                  ],
                ),
              )
            : Text("No Data");
      },
      itemCount: data.size,
    );
  }
}
