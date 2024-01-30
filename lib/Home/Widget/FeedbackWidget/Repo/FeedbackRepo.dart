import 'dart:convert';

import 'package:college_admission/Home/Widget/FeedbackWidget/Model/FeedbackDataModel.dart';
import 'package:http/http.dart' as http;

class FeedbackRepo {
  static Future<List<FeedbackDataModel>> fatchFeedback() async {
    List<FeedbackDataModel> feedBacks = [];
    try {
      var response =
          await http.get(Uri.parse("http://192.168.200.133:5000/feedback"));
      if (response.statusCode == 200) {
        List jsonResponse = jsonDecode(response.body);
        for (var i = 0; i < jsonResponse.length; i++) {
          FeedbackDataModel feedback =
              FeedbackDataModel.fromJson(jsonResponse[i]);
          feedBacks.add(feedback);
        }
        return feedBacks;
      }
    } catch (e) {}
    return [];
  }
}
