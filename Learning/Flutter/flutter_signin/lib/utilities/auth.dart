import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin/screens/authscreen.dart';
import 'package:flutter_signin/screens/homescreen.dart';
import 'package:flutter_signin/utilities/firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  static GoogleSignIn _googleSignIn = GoogleSignIn();

  static Future signInWithGoogle(BuildContext context) async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);

    if (googleUser != null) {
      if (googleUser.email != null) {
        var _prefs = await SharedPreferences.getInstance();
        _prefs.setString('userEmail', googleUser.email);
        await FirestoreSync.addUser(googleUser.email);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => HomePage(
              userEmail: googleUser.email,
            ),
          ),
        );
      }
    }
  }

  static Future logOut(context) async {
    await _googleSignIn.signOut();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => AuthorizationPage()),
        (Route<dynamic> route) => false);
  }
}
