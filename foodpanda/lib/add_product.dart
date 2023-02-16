import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController productID = TextEditingController();
  TextEditingController productName = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDescription = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose

    productID.dispose();
    productName.dispose();
    productPrice.dispose();
    productDescription.dispose();

    super.dispose();
  }

  addProduct(String productID, String productName, String productPrice,
      String productDes) async {
    String? uid = await FirebaseAuth.instance.currentUser?.uid;

    await FirebaseFirestore.instance
        .collection("products")
        .doc(uid!)
        .collection("allProducts")
        .doc(productID)
        .set(
      {
        "name": productName,
        "price": productPrice,
        "des": productDes,
      },
    ).then((value) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Product"),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Center(
          child: Container(
        padding: EdgeInsets.all(20),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          TextField(
            controller: productID,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Procuct ID',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: productName,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Name',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: productPrice,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Price',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: productDescription,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Product Description',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.pinkAccent, minimumSize: Size(100, 40)),
              onPressed: () {
                addProduct(productID.text, productName.text, productPrice.text,
                    productDescription.text);
              },
              child: Text("Add Product"))
        ]),
      )),
    );
  }
}
