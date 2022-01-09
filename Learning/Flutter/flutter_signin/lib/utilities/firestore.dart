import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter_signin/doamain/code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirestoreSync {
  static late SharedPreferences prefs;
  static Future<void> addUser(String email) async {
    var res;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        res = documentSnapshot.data();
      } else {
        res = null;
      }
    });
    if (res == null) {
      DocumentReference<Map<String, dynamic>> users =
          FirebaseFirestore.instance.collection('users').doc("$email");

      Map<String, dynamic> user = {"email": email};
      await users.set(user);
    }
  }

  static addCode(Code code) async {
    prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("userEmail");
    code.firebaseId = makeId(code.title);

    if (email != null) {
      DocumentReference<Map<String, dynamic>> userModels = FirebaseFirestore
          .instance
          .collection('users')
          .doc(email)
          .collection('codes')
          .doc(code.firebaseId);

      Map<String, dynamic> userModel = code.toMap();
      userModels.set(userModel);
      return code;
    }
  }

  static String makeId(String text) {
    var bytes1 = utf8.encode(text + DateTime.now().toString());
    var digest1 = sha256.convert(bytes1);
    return digest1.toString();
  }

  static Future getCodes() async {
    prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("userEmail");
    List<Code> listOfModels = [];
    if (email != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(email)
          .collection("codes")
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) async {
          var data = doc.data() as Map<String, dynamic>;
          listOfModels.add(Code.fromMap(data));
        });
      });
    }
    return listOfModels;
  }

  static Future updateCode(context, Code code) async {
    prefs = await SharedPreferences.getInstance();
    var email = prefs.getString("userEmail");
    if (email != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc("$email")
          .collection("codes")
          .doc("${code.firebaseId}")
          .update(code.toMap());
    }
  }
}
