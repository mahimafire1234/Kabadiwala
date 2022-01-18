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

}
