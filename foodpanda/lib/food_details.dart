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
      appBar: AppBar(
        title: Text(foodName),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: size.height,
          width: size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Image.asset(
                  "assets/images/food_icon.png",
                  height: 300,
                  width: 300,
                ),
                Spacer(),
                Text(
                  "Product Name : ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Container(
                  height: 50,
                  width: size.width,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      foodName,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: size.width,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      "Price : " + foodPrice,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Spacer(),
                Text("Description : "),
                Container(
                  width: size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        foodDes,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                ),
                Spacer(),
                if (pro.role != "admin")
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          minimumSize: Size(size.width, 40)),
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
                if (pro.role == "admin")
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: Size(size.width, 40)),
                      onPressed: () {},
                      child: Text("Delete Product")),
              ]),
        ),
      ),
    );
  }
}
