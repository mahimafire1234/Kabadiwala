import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_sprint1/constraints/constraints.dart';

class UserServices {
  static var baseUri = BASEURI + "/user";
  Future<dynamic> signup(body) async {
    try {
      var response =
      await http.post(Uri.parse("$baseUri/register"),
          headers: {
                'Content-type': 'application/json',
                "Accept": "application/json",
              },
              body: json.encode(body));
      print(response);
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> signin(body) async {
    try {
          var response = await http.post(Uri.parse("$baseUri/login"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
          },
          body: json.encode(body));

      return response.body;
    } on Exception {
      print("network connection problem");
    }
  }

  static Future<String?> getUserData(token) async {
    try {
      var response = await http.get(Uri.parse("$baseUri/"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          });
      return response.body;
    } on Exception {
      print("network connection problem");
      return null;
    }
  }

  static Future<String?> update(token, filePath, body, imageFrom) async {
    try {
      http.MultipartRequest request = http.MultipartRequest("PATCH", Uri.parse("$baseUri/"));

      if(filePath != "" && imageFrom != "api"){
        http.MultipartFile multipartFile = await http.MultipartFile.fromPath(
            'image', filePath);
        request.files.add(multipartFile);
        print("entered");
      }else if(imageFrom != "api" && filePath == ""){
        request.fields["image"] = "";
      }

      body.forEach((key, value){
        request.fields[key] = value;
      });
      request.headers.addAll({
        'Content-type': 'application/json',
        "Accept": "application/json",
        "Authorization": "Bearer $token"
      }) ;
      http.StreamedResponse response = await request.send();
      var res = await response.stream.bytesToString();
      return res;
    } on Exception {
      print("network connection problem");
      return null;
    }
  }

  static Future<String?> changePassword(token, body) async {
    try {
      var response = await http.patch(Uri.parse("$baseUri/password"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
        body: json.encode(body)
      );
      return response.body;
    } on Exception {
      print("network connection problem");
      return null;
    }
  }



}
