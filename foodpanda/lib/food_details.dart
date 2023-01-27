import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/provider/auth_provider.dart';
import 'package:foodpanda/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class FoodDetails extends StatelessWidget {
  FoodDetails(
      {super.key,
      required this.foodName,
      required this.foodPrice,
      required this.foodDes,
      required this.shopID});

  String foodName;
  String foodPrice;
  String foodDes;
  String shopID;

  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text(foodName)),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                "assets/images/settings.png",
                height: 200,
                width: 200,
              ),
              Spacer(),
              Text(
                foodName,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
              ),
              Text(
                "Price : " + foodPrice,
                style: TextStyle(fontSize: 20),
              ),
              Spacer(),
              Text(
                foodDes,
                style: TextStyle(fontSize: 17),
              ),
              Spacer(),
              if (pro.role != "admin")
                ElevatedButton(
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection("orders")
                          .doc("order")
                          .collection(pro.currentUserUid)
                          .doc()
                          .set(
                        {
                          "foodName": foodName,
                          "foodPrice": foodPrice,
                          "orderBy": pro.name,
                          "address": pro.address,
                          "mobile": pro.mobile,
                        },
                      );

                      FirebaseFirestore.instance
                          .collection("orders")
                          .doc("order")
                          .collection(shopID)
                          .doc()
                          .set(
                        {
                          "foodName": foodName,
                          "foodPrice": foodPrice,
                          "orderBy": pro.name,
                          "address": pro.address,
                          "mobile": pro.mobile,
                        },
                      );
                    },
                    child: Text("Order Now")),
            ]),
      ),
    );
  }
}
