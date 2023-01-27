import 'package:flutter/material.dart';
import 'package:foodpanda/home_screen.dart';
import 'package:foodpanda/provider/profile_provider.dart';
import 'package:foodpanda/shop_list.dart';
import 'package:provider/provider.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  @override
  Widget build(BuildContext context) {
    var pro = Provider.of<ProfileProvider>(context);

    if (pro.role == "admin") {
      return HomeScreen();
    } else {
      return ShopList();
    }
  }
}
