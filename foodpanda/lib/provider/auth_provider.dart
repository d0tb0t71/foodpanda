import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/main.dart';

import '../home_screen.dart';

class Authentication with ChangeNotifier {
  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<String> signIn(
    String email, String password, BuildContext context) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) {
            Navigator.push(
            context, MaterialPageRoute(builder: (builder) => MiddleOfHomeAndSignIn()));
          });

      return "Success";
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          return "Your email address appears to be malformed.";
        case "wrong-password":
          return "Wrong password";

        case "user-not-found":
          return "User with this email doesn't exist.";

        case "user-disabled":
          return "User with this email has been disabled.";

        default:
          return "An undefined Error happened.";
      }
    } catch (e) {
      return "An Error occur";
    }
  }

  Future<String> signUp({
    required String name,
    required String email,
    required String password,
    required String address,
    required String mobile,
    required String role,
    required context,
  }) async {
    try {
      _firebaseAuth
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(value.user!.uid)
              .set(
            {
              "name": name,
              "email": value.user!.email,
              "role": role,
              "address": address,
              "mobile": mobile,
              "uid": value.user!.uid
            },
          );
        },
      ).then((value) {
        Navigator.push(
            context, MaterialPageRoute(builder: (builder) => HomeScreen()));
      });

      return "Success";
    } on FirebaseAuthException catch (e) {
      Navigator.of(context, rootNavigator: true).pop();
      switch (e.code) {
        case "weak-password":
          return "Your password is too weak";

        case "invalid-email":
          return "Your email is invalid";

        case "email-already-in-use":
          return "Email is already in use on different account";

        default:
          return "An undefined Error happened.";
      }
    } catch (e) {
      return "An Error occur";
    }
  }

  Future signOut({required context}) async {
    await _firebaseAuth.signOut().then((value) {
      Navigator.push(context,
          MaterialPageRoute(builder: (_) => MyHomePage(title: "Foodpanda")));
    });
    notifyListeners();
  }

  Future<String> resetPassword(String email, BuildContext context) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      return "Success";
    } catch (e) {
      return "Error";
    }
  }

  Future deleteUser() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .delete();
      user.delete();
    }
  }
}
