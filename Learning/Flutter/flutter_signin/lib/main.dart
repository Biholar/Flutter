import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/auth.dart';
import 'package:flutter_signin/screens/home.dart';
import 'doamain/code.dart';

void main() => runApp(Base());

class Base extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Storage',
      theme: ThemeData(
          fontFamily: 'Roboto',
          splashColor: Color.fromRGBO(20, 20, 30, 1),
          cardColor: Color.fromRGBO(50, 50, 50, 1),
          primaryColor: Color.fromRGBO(30, 40, 50, 1),
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white))),
      home: AuthorizationPage(),
    );
  }
}
