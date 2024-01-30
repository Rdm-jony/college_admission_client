import 'dart:convert';

import 'package:college_admission/Dashboard/Users/Model/UserModel.dart';
import 'package:http/http.dart' as http;

class UsersRepo {
  static Future<List<UserModel>> fatchAllUsers() async {
    List<UserModel> users = [];
    try {
      var response =
          await http.get(Uri.parse("http://192.168.200.133:5000/allUsers"));
      if (response.statusCode == 200) {
        List jsonReponse = jsonDecode(response.body);
        for (var i = 0; i < jsonReponse.length; i++) {
          UserModel user = UserModel.fromJson(jsonReponse[i]);
          users.add(user);
        }
        return users;
      }
    } catch (e) {}
    return [];
  }

  static Future<bool> userAddToAdmin(userId, role) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.200.133:5000/users/admin/${userId}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"role": role}));
      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        if (jsonReponse["modifiedCount"] == 1) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }
}
