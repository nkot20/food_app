import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  Widget button({@required String name, Color color, Color textColors}) {
    return Container(
        height: 45,
        width: 300,
        child: RaisedButton(
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.green, width: 2),
          ),
          onPressed: () {},
          child: Text(
            name,
            style: TextStyle(color: textColors),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("ndole.jpg"),
            ),
          ),
          Expanded(
              child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Bienvenu à KamTraiteurServices",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Column(
                  children: [
                    Text("Commander de la nourriture dans notre restaurant"),
                    Text("Faire votre réservation en temps réel")
                  ],
                ),
                button(
                    name: 'Page de Connection',
                    color: Colors.green,
                    textColors: Colors.white),
                button(
                    name: 'Creer un compte',
                    color: Colors.white,
                    textColors: Colors.green)
              ],
            ),
          ))
        ],
      ),
    );
  }
}
