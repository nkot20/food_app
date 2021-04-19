import 'package:flutter/material.dart';
import 'package:food_app2/helper/constants.dart';
import 'package:food_app2/helper/helperfunction.dart';
import 'package:food_app2/screen/login_page.dart';
import 'package:food_app2/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthMethods authMethods = new AuthMethods();
  Widget categoriesContainer({@required String image, @required String title}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 14),
          height: 80,
          width: 80,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(image),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: TextStyle(fontSize: 15, color: Colors.white),
        )
      ],
    );
  }

  Widget bottomContainer(
      {@required String name, @required String image, @required price}) {
    return Container(
      height: 270,
      width: 220,
      decoration: BoxDecoration(
          color: Color(0xff3a3e3e), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: AssetImage(image),
          ),
          ListTile(
            leading: Text(
              name,
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
            trailing: Text(
              price,
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.white,
                ),
                Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget drawerItem(
      {@required String name, @required IconData icon, Function onTap()}) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(name, style: TextStyle(fontSize: 17, color: Colors.white)),
      onTap: onTap,
    );
  }

  onTapPage() {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  @override
  void initState() {
    getUserInfo();
  }

  getUserInfo() async {
    Constants.myName = await HelperFunctions.getUserNameSharedPreference();
    Constants.myEmail = await HelperFunctions.getUserEmailSharedPreference();
    Constants.numberUser =
        await HelperFunctions.getUserNumberSharedPreference();
    Constants.myLastName =
        await HelperFunctions.getUserLastNameSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Container(
          color: Color(0xff2b2b2b),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/sombre.jpg'))),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage('images/pp.jpg'),
                    ),
                    accountName: Text(Constants.myName + Constants.myLastName),
                    accountEmail: Text(Constants.myEmail)),
                drawerItem(name: "Profile", icon: Icons.person, onTap: null),
                drawerItem(
                    name: "Panier", icon: Icons.add_shopping_cart, onTap: null),
                drawerItem(name: "Autres", icon: Icons.shop, onTap: null),
                drawerItem(
                    name: "A propos", icon: Icons.account_balance, onTap: null),
                Divider(
                  thickness: 2,
                  color: Colors.white,
                ),
                ListTile(
                  leading: Text(
                    "Communication",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
                drawerItem(name: "Changer", icon: Icons.lock, onTap: null),
                drawerItem(
                    name: "Déconnection",
                    icon: Icons.exit_to_app,
                    onTap: () {
                      HelperFunctions.saveUserLoggedInSharedPreference(false);
                      authMethods.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    }),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/pp.jpg'),
            ),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search Food",
                  hintStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: Color(0xff3a3e3e),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10))),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                categoriesContainer(image: "images/eru.jpg", title: "Toutes"),
                categoriesContainer(image: "images/ndole.jpg", title: "Ndoles"),
                categoriesContainer(image: "images/okok.png", title: "Okok"),
                categoriesContainer(
                    image: "images/pouletDg.jpg", title: "Poulet"),
                categoriesContainer(image: "images/eru.jpg", title: "Toutes"),
                categoriesContainer(image: "images/ndole.jpg", title: "Ndoles"),
                categoriesContainer(image: "images/okok.png", title: "Okok"),
                categoriesContainer(
                    image: "images/pouletDg.jpg", title: "Poulet"),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            height: 510,
            child: GridView.count(
              shrinkWrap: false,
              primary: false,
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              children: [
                bottomContainer(
                    name: "eru", image: "images/eru.jpg", price: "2000FCFA"),
                bottomContainer(
                    name: "ndole",
                    image: "images/ndole.jpg",
                    price: "4000FCFA"),
                bottomContainer(
                    name: "oko", image: "images/okok.png", price: "3000FCFA"),
                bottomContainer(
                    name: "poulet",
                    image: "images/pouletDg.jpg",
                    price: "2000FCFA"),
              ],
            ),
          )
        ],
      ),
    );
  }
}
