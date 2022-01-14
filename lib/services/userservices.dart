import 'dart:convert';

import 'package:http/http.dart' as http;

class UserServices {
  // static var baseUri = "http://192.168.100.252:5000";
  static var baseUri = "http://192.168.137.50:5000";
  Future<String?> signup(body) async {
    try {
      var response =
          await http.post(Uri.parse("http://10.0.2.2:5000/user/register"),
              headers: {
                'Content-type': 'application/json',
                "Accept": "application/json",
              },
              body: json.encode(body));
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> signin(body) async {
    try {
      var response = await http.post((Uri.parse("$baseUri/user/login")),
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

  Future<String?> insertRate(body) async {
    try {
      var response =
          await http.post(Uri.parse("http://10.0.2.2:5000/category/insertRate"),
              headers: {
                'Content-type': 'application/json',
                "Accept": "application/json",
              },
              body: json.encode(body));
      return response.body;
    } catch (e) {
      print(e);
    }
  }
}
