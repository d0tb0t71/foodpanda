import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/provider/profile_provider.dart';
import 'package:provider/provider.dart';

import 'order_details.dart';

class OrderList extends StatefulWidget {
  OrderList({super.key, required this.uid});

  String uid;

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("Order List"),
        backgroundColor: Colors.pinkAccent,
        actions: [],
      ),
      body: Container(
          height: size.height,
          child: Expanded(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("orders")
                    .doc("order")
                    .collection(pro.currentUserUid)
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
                        "assets/images/ordder_icon2.png",
                        height: 60,
                        width: 60,
                      ),
                      Spacer(),
                      Text(data.docs[index]["foodName"],
                          style: TextStyle(color: Colors.white, fontSize: 17)),
                      Spacer(),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.white, minimumSize: Size(70, 40)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => OrderDetails(
                                          foodName: data.docs[index]
                                              ["foodName"],
                                          foodPrice: data.docs[index]
                                              ["foodPrice"],
                                          orderBy: data.docs[index]["orderBy"],
                                          mobile: data.docs[index]["mobile"],
                                          address: data.docs[index]["address"],
                                        ))));
                          },
                          child: Text("Details",
                              style: TextStyle(color: Colors.black)))
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
