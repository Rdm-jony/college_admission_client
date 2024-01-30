import 'dart:convert';

import 'package:college_admission/Model/CollegeDataModel/CollegeDataModel.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';

class MyCollegeRepo {
  static Future<List<CollegeDataNodel>> facthCollegeData() async {
    List<CollegeDataNodel> myCollegs = [];
    final email = FirebaseAuth.instance.currentUser?.email;
    try {
      var response = await http
          .get(Uri.parse("http://192.168.200.133:5000/myColleges/${email}"));
      if (response.statusCode == 200) {
        List jsonReponse = jsonDecode(response.body);
        for (var i = 0; i < jsonReponse.length; i++) {
          CollegeDataNodel college = CollegeDataNodel.fromJson(jsonReponse[i]);
          myCollegs.add(college);
        }
        return myCollegs;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
