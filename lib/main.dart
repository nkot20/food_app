import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app2/screen/home_page.dart';
import 'package:food_app2/screen/login_page.dart';
import 'package:food_app2/screen/sign_up_page.dart';
import 'package:food_app2/screen/welcome_page.dart';

import 'helper/helperfunction.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool userIsLoggedIn = false;

  @override
  void initState() {
    getLoggedState();
  }

  getLoggedState() async {
    await HelperFunctions.getUSerLoggedInSharedPreference().then((value) {
      setState(() {
        userIsLoggedIn = value;
        if (userIsLoggedIn == null) {
          userIsLoggedIn = false;
        }
      });
    });
    print('user is logger in: $userIsLoggedIn');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food app',
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff2b2b2b),
          appBarTheme: AppBarTheme(color: Color(0xff2b2b2b))),
      home: userIsLoggedIn ? HomePage() : LoginPage(),
    );
  }
}
