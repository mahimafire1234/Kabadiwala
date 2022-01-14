import 'dart:convert';

import 'package:http/http.dart' as http;

class UserServices {
  static var baseUri = "http://10.0.2.2:5000/user/";
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

  Future<dynamic> insertRate(body) async {
    try {
      var response =
      // await http.post(Uri.parse("http://10.0.2.2:5000/category/insertRate"),
          await http.post(Uri.parse("http://127.0.0.1:5000/category/insertRate"),
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

  Future<dynamic> updateRate(body,company_id,object_id) async {
    try {
      var response =
      // await http.post(Uri.parse("http://10.0.2.2:5000/category/insertRate"),
      await http.put(Uri.parse("http://127.0.0.1:5000/category/updateRate/${company_id}/${object_id}"),
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
