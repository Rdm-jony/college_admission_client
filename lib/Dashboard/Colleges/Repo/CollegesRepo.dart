import 'dart:convert';

import 'package:college_admission/Model/CollegeDataModel/CollegeDataModel.dart';
import 'package:http/http.dart' as http;

class CollegesRepo {
  static Future<List<CollegeDataNodel>> fatchCollegesData() async {
    List<CollegeDataNodel> colleges = [];
    try {
      var response =
          await http.get(Uri.parse("http://192.168.200.133:5000/allCollege"));
      if (response.statusCode == 200) {
        List jsonReponse = jsonDecode(response.body);
        for (var i = 0; i < jsonReponse.length; i++) {
          CollegeDataNodel college = CollegeDataNodel.fromJson(jsonReponse[i]);
          colleges.add(college);
        }
        return colleges;
      }
    } catch (e) {}
    return [];
  }

  static Future<bool> collegeAddToTop(collegeId, isTop) async {
    try {
      var response = await http.post(
          Uri.parse(
              "http://192.168.200.133:5000/colleges/addToTop/${collegeId}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"top": isTop}));
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
