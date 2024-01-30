import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AddCollegeRepo {
  static Future<String> uploadCollegeImage(imagepath) async {
    print(imagepath);
    try {
      var metaData = SettableMetadata(contentType: "image/jpeg");
      var uniqueName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref();
      Reference root = ref.child("collegeImage");
      Reference child = root.child(uniqueName);

      kIsWeb
          ? await child.putData(imagepath)
          : await child.putFile(File(imagepath));
      var imageUrl = await child.getDownloadURL();
      print(imageUrl);
      return imageUrl;
    } catch (e) {}
    return "";
  }

  static Future<bool> sendAddCollegeOnfo(collegeInfo) async {
    try {
      var response = await http.post(
          Uri.parse("http://192.168.200.133:5000/addCollege"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(collegeInfo));
      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        if (jsonReponse["insertedId"] != null) {
          return true;
        }
      }
    } catch (e) {}
    return true;
  }
}
