import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app2/screen/home_page.dart';
import 'package:food_app2/screen/login_page.dart';
import 'package:food_app2/screen/sign_up_page.dart';
import 'package:food_app2/screen/welcome_page.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food app',
      theme: ThemeData(
          scaffoldBackgroundColor: Color(0xff2b2b2b),
          appBarTheme: AppBarTheme(color: Color(0xff2b2b2b))),
      home: LoginPage(),
    );
  }
}
