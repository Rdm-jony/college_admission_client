import 'dart:convert';

import 'package:college_admission/Model/CollegeDataModel/CollegeDataModel.dart';
import 'package:http/http.dart' as http;

class BannerRepo {
  static Future<List<CollegeDataNodel>> faltchBannerData() async {
    List<CollegeDataNodel> colleges = [];
    try {
      var response =
          await http.get(Uri.parse("http://192.168.200.133:5000/bannerData"));
      if (response.statusCode == 200) {
        final List jsonResponse = jsonDecode(response.body);
        for (var i = 0; i < jsonResponse.length; i++) {
          CollegeDataNodel college = CollegeDataNodel.fromJson(jsonResponse[i]);
          colleges.add(college);
        }
        return colleges;
      }
    } catch (e) {}
    return [];
  }
}
