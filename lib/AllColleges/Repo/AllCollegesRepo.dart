import 'dart:convert';

import 'package:college_admission/Model/CollegeDataModel/CollegeDataModel.dart';
import 'package:http/http.dart' as http;

class AllCollegesRepo {
  static Future<List<CollegeDataNodel>> fatchAllCollegesData() async {
    List<CollegeDataNodel> allColleges = [];
    try {
      var response =
          await http.get(Uri.parse("http://192.168.200.133:5000/allCollege"));
      if (response.statusCode == 200) {
        List jsonReponse = jsonDecode(response.body);
        for (var i = 0; i < jsonReponse.length; i++) {
          CollegeDataNodel college = CollegeDataNodel.fromJson(jsonReponse[i]);
          allColleges.add(college);
        }
        return allColleges;
      }
    } catch (e) {
      print(e);
    }
    return [];
  }

  static Future<List<CollegeDataNodel>> fatchSearchItem(searchText) async {
    print(searchText);
    List<CollegeDataNodel> searchColleges = [];
    try {
      var response = await http.get(Uri.parse(
          "http://192.168.200.133:5000/searchColleges/${searchText}"));
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        for (var i = 0; i < jsonResponse.length; i++) {
          CollegeDataNodel product = CollegeDataNodel.fromJson(jsonResponse[i]);
          searchColleges.add(product);
        }
        return searchColleges;
      }
    } catch (e) {}
    return [];
  }
}
