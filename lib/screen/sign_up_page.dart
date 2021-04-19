import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app2/helper/helperfunction.dart';
import 'package:food_app2/screen/home_page.dart';
import 'package:food_app2/screen/login_page.dart';
import 'package:food_app2/services/auth.dart';
import 'package:food_app2/services/database.dart';
import 'package:food_app2/widget/text_field.dart';

class SignUp extends StatefulWidget {
  static Pattern pattern =
      r'^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$';
  static Pattern number = r'^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{3})$';

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  RegExp regExp = RegExp(SignUp.pattern);
  RegExp regExpNumber = RegExp(SignUp.number);
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  String alreadyEmail = "";
  TextEditingController firstName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passWord = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController number = TextEditingController();
  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  void validation() {
    if (firstName.text.trim().isEmpty || firstName.text.trim() == null) {
      globalKey.currentState
          .showSnackBar(SnackBar(content: Text("Le nom n'est pas valide")));
      return;
    }

    if (lastName.text.trim().isEmpty || lastName.text.trim() == null) {
      globalKey.currentState
          .showSnackBar(SnackBar(content: Text("Le prénom n'est pas valide")));
      return;
    }
//^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$
//
    if (email.text.trim().isEmpty || email.text.trim() == null) {
      globalKey.currentState
          .showSnackBar(SnackBar(content: Text("L'email n'est pas valide")));
      return;
    } else if (!regExp.hasMatch(email.text)) {
      globalKey.currentState.showSnackBar(
          SnackBar(content: Text("Le format de l'email n'est pas correcte ")));
      return;
    }

    if (number.text.trim().isEmpty || email.text.trim() == null) {
      globalKey.currentState
          .showSnackBar(SnackBar(content: Text("Le numéro n'est pas valide")));
      return;
    } else if (!regExpNumber.hasMatch(number.text)) {
      globalKey.currentState.showSnackBar(
          SnackBar(content: Text("Le format du numéro n'est pas correct")));
      return;
    }

    if (passWord.text.trim().isEmpty || passWord.text.trim() == null) {
      globalKey.currentState.showSnackBar(
          SnackBar(content: Text("Le mot de passe n'est pas valide")));
      return;
    }

    if (firstName.text.trim().isNotEmpty &&
        firstName.text.trim() != null &&
        lastName.text.trim().isNotEmpty &&
        lastName.text.trim() != null &&
        email.text.trim().isNotEmpty &&
        email.text.trim() != null &&
        passWord.text.trim().isNotEmpty &&
        passWord.text.trim() != null &&
        regExp.hasMatch(email.text) &&
        number.text.trim().isNotEmpty &&
        email.text.trim() != null &&
        regExpNumber.hasMatch(number.text)) {
      signUpMe();
    }
  }

  signUpMe() {
    Map<String, String> userInfoMap = {
      "firstName": firstName.text,
      "lastName": lastName.text,
      "email": email.text,
      "number": number.text
    };

    authMethods
        .signUpwithEmailAndPassword(email.text, passWord.text)
        .then((user) {
      // print("${val.uid}");
      User currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser.email != null) {
        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
        HelperFunctions.saveUserEmailSharedPreference(email.text);
        HelperFunctions.saveUserNameSharedPreference(firstName.text);
        HelperFunctions.saveUserLastNameSharedPreference(lastName.text);
        HelperFunctions.saveUserNumberSharedPreference(number.text);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
        //sendVerificationEmail(user);
      } else {
        globalKey.currentState.showSnackBar(SnackBar(
            content: Text("L'adresse email existe déja. Connectez-vous")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "S'inscrire",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
              Container(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyTextField(
                      hintText: "Nom",
                      obscureText: false,
                      controller: firstName,
                    ),
                    MyTextField(
                      hintText: "Prénom",
                      obscureText: false,
                      controller: lastName,
                    ),
                    MyTextField(
                      hintText: "Numéro de téléphone _ _ _-_ _ _-_ _ _",
                      obscureText: false,
                      controller: number,
                    ),
                    MyTextField(
                      hintText: "Email",
                      obscureText: false,
                      controller: email,
                    ),
                    MyTextField(
                      hintText: "Mot de passe",
                      obscureText: true,
                      controller: passWord,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 130,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.grey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      },
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    width: 140,
                    height: 50,
                    child: RaisedButton(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      onPressed: () {
                        validation();
                      },
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
