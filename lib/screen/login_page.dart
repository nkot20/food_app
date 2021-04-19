import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app2/helper/helperfunction.dart';
import 'package:food_app2/screen/home_page.dart';
import 'package:food_app2/screen/sign_up_page.dart';
import 'package:food_app2/services/auth.dart';
import 'package:food_app2/services/database.dart';

class LoginPage extends StatefulWidget {
  static Pattern pattern =
      r'^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  RegExp regExp = RegExp(LoginPage.pattern);
  TextEditingController email = TextEditingController();
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  TextEditingController passWord = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  QuerySnapshot snapshotUserInfo;

  Widget textFiled(
      {@required String hintText,
      @required IconData icon,
      @required Color iconColor,
      @required bool obscureText,
      @required TextEditingController controller}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          prefixIcon: Icon(icon, color: iconColor),
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.white),
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
    );
  }

  validation() {
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      globalKey.currentState
          .showSnackBar(SnackBar(content: Text("L'email n'est pas valide")));
      return;
    } else if (!regExp.hasMatch(email.text)) {
      globalKey.currentState
          .showSnackBar(SnackBar(content: Text("L'email n'est pas correcte ")));
      return;
    }

    if (email.text.trim().isNotEmpty &&
        email.text.trim() != null &&
        passWord.text.trim().isNotEmpty &&
        passWord.text.trim() != null &&
        regExp.hasMatch(email.text)) {
      signInMe();
    }
  }

  signInMe() {
    databaseMethods.getUserByEmail(email.text).then((val) {
      snapshotUserInfo = val;
      HelperFunctions.saveUserNameSharedPreference(
          snapshotUserInfo.docs[0].data()["firstName"]);
      HelperFunctions.saveUserLastNameSharedPreference(
          snapshotUserInfo.docs[0].data()["lastName"]);
      HelperFunctions.saveUserEmailSharedPreference(
          snapshotUserInfo.docs[0].data()["email"]);
      HelperFunctions.saveUserNumberSharedPreference(
          snapshotUserInfo.docs[0].data()["number"]);
    });

    authMethods
        .signInWithEmailAndPassword(email.text, passWord.text)
        .then((val) {
      if (val != null) {
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else {
        globalKey.currentState.showSnackBar(
            SnackBar(content: Text("L'email ou le mot de passe incorrecte ")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: null,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Text(
                "Se connecter",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Column(
              children: [
                textFiled(
                    hintText: "Email",
                    icon: Icons.person_outline,
                    iconColor: Colors.white,
                    obscureText: false,
                    controller: email),
                SizedBox(
                  height: 30,
                ),
                textFiled(
                    hintText: "Mot de passe",
                    icon: Icons.lock_outline,
                    iconColor: Colors.white,
                    obscureText: true,
                    controller: passWord)
              ],
            ),
            Container(
              height: 60,
              width: 200,
              child: RaisedButton(
                color: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                onPressed: () {
                  validation();
                },
                child: Text(
                  "CONNECTION",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Nouvel utilisateur ?",
                    style: TextStyle(color: Colors.grey)),
                GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: Text("S'inscrire. ",
                        style: TextStyle(color: Colors.red)))
              ],
            )
          ],
        ),
      ),
    );
  }
}
