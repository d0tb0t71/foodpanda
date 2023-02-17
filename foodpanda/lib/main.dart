import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:foodpanda/customer_page.dart';
import 'package:foodpanda/home_screen.dart';
import 'package:foodpanda/progress_view.dart';
import 'package:foodpanda/provider/auth_provider.dart';
import 'package:foodpanda/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import 'dash_board.dart';
import 'firebase_options.dart';

import 'admin_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => Authentication()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Initial(),
      ),
    );
  }
}

class Initial extends StatefulWidget {
  const Initial({Key? key}) : super(key: key);

  @override
  State<Initial> createState() => _InitialState();
}

class _InitialState extends State<Initial> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text("Error")));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return const MiddleOfHomeAndSignIn();
        }
        return const Scaffold(
            body: Center(child: Text("Something Went Wrong")));
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class MiddleOfHomeAndSignIn extends StatefulWidget {
  const MiddleOfHomeAndSignIn({Key? key}) : super(key: key);

  @override
  _MiddleOfHomeAndSignInState createState() => _MiddleOfHomeAndSignInState();
}

class _MiddleOfHomeAndSignInState extends State<MiddleOfHomeAndSignIn> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ProgressView();
        }
        if (snapshot.data != null) {
          Timer(Duration(seconds: 5), () {
            Navigator.pop(context);
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => DashBoard()));
          });

          return ProgressView();
        }
        return const MyHomePage(title: "Foodpanda");
      },
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [

          Image.asset("assets/images/foodpanda_bg.png" , fit: BoxFit.fill,),

          Center(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
                minimumSize: Size(200, 60)
              ),
                onPressed: (() => Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AdminPage())))),
                child: Text("Admin")),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
                minimumSize: Size(200, 60)
              ),
                onPressed: (() => Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => CustomerPage())))),
                child: Text("Customer")),
            SizedBox(height: 30,)
          ],
        ),
      ),
        ],
      )
    );
  }
}
