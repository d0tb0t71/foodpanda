import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/product_list.dart';
import 'package:foodpanda/profile_page.dart';
import 'package:foodpanda/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import 'order_list.dart';

class ShopList extends StatefulWidget {
  const ShopList({super.key});

  @override
  State<ShopList> createState() => _ShopListState();
}

class _ShopListState extends State<ShopList> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Shop List"),
        backgroundColor: Colors.pinkAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) =>
                            OrderList(uid: pro.currentUserUid))));
              },
              icon: Icon(Icons.list)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => ProfileScreen())));
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text("Something went wrong"));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final data = snapshot.data;

            return _buildConsumer(data!, context);
          },
        ),
      ),
    );
  }

  Widget _buildConsumer(QuerySnapshot data, BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context, listen: false);
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(bottom: 65),
      itemBuilder: (context, index) {
        if (data.docs[index]["role"] == "admin") {
          return Container(
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.fromLTRB(5, 5, 5, 0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
                width: 1.7,
              ),
              color: Colors.pinkAccent,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => ProductList(
                                  shopID: data.docs[index]["uid"],
                                ))));
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/shop_icon.png",
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "${data.docs[index]["name"]}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
      itemCount: data.docs.length,
    );
  }
}
