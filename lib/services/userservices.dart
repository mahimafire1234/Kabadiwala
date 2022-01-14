import 'dart:convert';

import 'package:http/http.dart' as http;

class UserServices {
  static var baseUri = "http://10.0.2.2:5000";
  Future<dynamic> signup(body) async {
    try {
      var response =
          // await http.post(Uri.parse("http://10.0.2.2:5000/user/register"),
      await http.post(Uri.parse("http://127.0.0.1:5000/user/register"),
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
      // var response = await http.post((Uri.parse("$baseUri/user/login")),
      // var response = await http.post(Uri.parse("http://10.0.2.2:5000/user/login"),
          var response = await http.post(Uri.parse("http://127.0.0.1:5000/user/login"),
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
