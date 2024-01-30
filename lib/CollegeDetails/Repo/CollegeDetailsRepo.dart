import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class CollegeDetailsRepo {
  static Future<bool> sendFeedback(userFeedback) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    try {
      var response = await http.post(
          Uri.parse("http://192.168.200.133:5000/feedback/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(userFeedback));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["insertedId"] != null) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> sendFormdata(formData, collegeId) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    try {
      var response = await http.post(
          Uri.parse("http://192.168.200.133:5000/formdata/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"collegeId": collegeId}));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["acknowledged"] == true) {
          return await sendToFormCollection(formData, collegeId);
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  static Future<bool> sendToFormCollection(formData, collegeId) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.200.133:5000/formCollection/${collegeId}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(formData));
      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        if (jsonReponse["acknowledged"] == true) {
          return true;
        }
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
}
