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


}
