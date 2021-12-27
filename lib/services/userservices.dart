import 'dart:convert';

import 'package:http/http.dart' as http;

class UserServices {
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

  dynamic insertRate(body) async {
    try {
      var response = await http
          .post(Uri.parse("http://10.0.2.2:5000/user/insertRate"), body: body);
      return response.body;
    } catch (e) {
      print(e);
    }
  }
}
