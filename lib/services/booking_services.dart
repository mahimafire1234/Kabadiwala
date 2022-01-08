import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:login_sprint1/services/Category.dart';
import 'package:login_sprint1/services/shared_preference.dart';

class BookingServices{
  var baseUri = "http://10.0.2.2:5000/booking/";
  // var baseUri = "http://127.0.0.1:5000/booking/";

  Future<String?> book(body, token) async {
    try {
      var response = await http
          .post(Uri.parse("$baseUri"),
          headers: {
            'Content-type' : 'application/json',
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: json.encode(body));
      return response.body;
    } catch (e) {
      print(e);
    }
  }

}