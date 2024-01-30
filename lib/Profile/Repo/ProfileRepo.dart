import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileRepo {
  static Future<Map> fatchProfileData() async {
    final email = FirebaseAuth.instance.currentUser?.email;
    try {
      var response = await http
          .get(Uri.parse("http://192.168.200.133:5000/profile/${email}"));
      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        return jsonReponse;
      }
    } catch (e) {}
    return {};
  }

  static Future<bool> upLoadImageToDb() async {
    final metadata = SettableMetadata(contentType: "image/jpeg");
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;

        await referenceImageToUpload.putFile(File(file.path.toString()));

        var imageUrl = await referenceImageToUpload.getDownloadURL();
        return upDateImage(imageUrl);
      } else {
        // User canceled the picker
      }
    } catch (e) {}
    return false;
  }

  static Future<bool> upDateImage(imageUrl) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    try {
      var response = await http.put(
          Uri.parse("http://192.168.200.133:5000/profile/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({"image": imageUrl}));
      if (response.statusCode == 200) {
        var jsonReponse = jsonDecode(response.body);
        if (jsonReponse["modifiedCount"] == 1) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }

  static Future<bool> updateUser(updateUserInfo) async {
    final email = FirebaseAuth.instance.currentUser?.email;
    try {
      var response = await http.put(
          Uri.parse("http://192.168.200.133:5000/updateuser/${email}"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(updateUserInfo));
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        if (jsonResponse["acknowledged"]) {
          return true;
        }
      }
    } catch (e) {}
    return false;
  }
}
