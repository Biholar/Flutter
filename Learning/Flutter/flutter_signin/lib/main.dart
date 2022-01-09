import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/authscreen.dart';
import 'package:flutter_signin/screens/homescreen.dart';
import 'doamain/code.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  runApp(Base());
}

class Base extends StatelessWidget {
  SharedPreferences? _prefs;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Storage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Roboto',
          splashColor: Color.fromRGBO(20, 20, 30, 1),
          cardColor: Color.fromRGBO(50, 50, 50, 1),
          primaryColor: Color.fromRGBO(30, 40, 50, 1),
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white))),
      home: FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.containsKey('userEmail')) {
              var email = snapshot.data!.getString('userEmail');
              return HomePage(userEmail: email!);
            } else {
              return AuthorizationPage();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
