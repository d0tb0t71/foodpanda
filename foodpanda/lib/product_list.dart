import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/add_product.dart';
import 'package:foodpanda/profile_page.dart';
import 'package:foodpanda/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'food_details.dart';
import 'order_list.dart';

class ProductList extends StatefulWidget {
  ProductList({super.key, required this.shopID});

  String shopID;

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    var pro = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Product List"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Container(
          height: size.height,
          child: Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("products")
                    .doc(widget.shopID)
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
      floatingActionButton: pro.role == "admin"
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
                height: 80,
                color: Colors.pinkAccent,
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                child: Center(
                  child: Row(
                    children: [
                      Image.asset(
                        "assets/images/settings.png",
                        height: 60,
                        width: 60,
                      ),
                      Spacer(),
                      Text(data.docs[index]["name"]),
                      Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white, minimumSize: Size(80, 40)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => FoodDetails(
                                          foodName: data.docs[index]["name"],
                                          foodPrice: data.docs[index]["price"],
                                          foodDes: data.docs[index]["des"],
                                          shopID: widget.shopID,
                                        ))));
                          },
                          child: Text(
                            "Details",
                            style: TextStyle(color: Colors.black),
                          ))
                    ],
                  ),
                ),
              )
            : Text("No Data");
      },
      itemCount: data.size,
    );
  }
}
