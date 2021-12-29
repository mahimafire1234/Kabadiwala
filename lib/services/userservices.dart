import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_sprint1/services/Category.dart';

class UserServices{
  Future<String?> signup(body) async {
    try {
      var response = await http
          .post(Uri.parse("http://10.0.2.2:5000/user/register"),
          headers: {
            'Content-type' : 'application/json',
            "Accept": "application/json",
          },
          body: json.encode(body));
      return response.body;
    } catch (e) {
      print(e);
    }
  }



}