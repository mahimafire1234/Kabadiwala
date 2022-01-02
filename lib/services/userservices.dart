import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_sprint1/services/Category.dart';

class UserServices{
  Future<String?> signup(body) async {
    try {
      var response = await http
          .post(Uri.parse("http://192.168.100.252:5000/user/register"),
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

  Future<String?> insertRate(body) async {
    try {
      var response = await http
          .post(Uri.parse("http://10.0.2.2:5000/category/insertRate"),
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