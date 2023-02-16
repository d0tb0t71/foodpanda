import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  OrderDetails(
      {super.key,
      required this.foodName,
      required this.foodPrice,
      required this.orderBy,
      required this.mobile,
      required this.address});

  String foodName;
  String foodPrice;
  String orderBy;
  String mobile;
  String address;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Order Details") , backgroundColor: Colors.pinkAccent,),
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              Image.asset(
                "assets/images/order_icon.png",
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
                " Order By : ${orderBy}",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Mobile : ${mobile}",
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "Address : ${address}",
                style: TextStyle(fontSize: 17),
              ),
              Spacer(),
            ]),
      ),
    );
  }
}
