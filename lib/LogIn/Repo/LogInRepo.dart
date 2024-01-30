import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class LogInRepo {
  static Future<String> signUpWithEmail(userInfo) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userInfo["email"],
        password: userInfo["password"],
      );
      if (credential.user?.uid != null) {
        return await saveUser(userInfo);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return e.code;
      } else if (e.code == 'email-already-in-use') {
        return e.code;
      }
    } catch (e) {
      print(e);
    }
    return "something wrong.check your internet connection";
  }

  static Future<String> saveUser(userInfo) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.200.133:5000/user"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(userInfo));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["insertedId"] != null) {
          return "true";
        }
      }
    } catch (e) {}
    return "something wrong.check your internet connection";
  }

  static Future<String> signInWthEmail(emailAddress, password) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      if (credential.user?.uid != null) {
        return "true";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return e.code;
      } else if (e.code == 'wrong-password') {
        return e.code;
      }
    }
    return "something wrong.check your internet connection";
  }
}
