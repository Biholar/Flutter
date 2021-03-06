// ignore_for_file: deprecated_member_use, prefer_const_constructors
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin/screens/homescreen.dart';
import 'package:flutter_signin/utilities/auth.dart';
import 'package:flutter_signin/utilities/firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthorizationPage extends StatefulWidget {
  AuthorizationPage({Key? key}) : super(key: key);

  @override
  _AuthorizationPageState createState() => _AuthorizationPageState();
}

class _AuthorizationPageState extends State<AuthorizationPage> {
  @override
  Widget build(BuildContext context) {
    Widget _logo() {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Code Storage',
              style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Icon(
              FontAwesomeIcons.qrcode,
              size: 150,
              color: Theme.of(context).primaryColor,
            ),
          ],
        ),
      );
    }

    Widget _button() {
      return TextButton(
        onPressed: () async {
          await Auth.signInWithGoogle(context);
        },
        style: TextButton.styleFrom(
          primary: Theme.of(context).primaryColor,
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Icon(FontAwesomeIcons.google),
            SizedBox(width: 20),
            Text(
              'Sign in with Google',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
                fontSize: 20,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _logo(),
            _button(),
          ],
        ),
      ),
    );
  }
}
