import 'dart:convert';

import 'package:http/http.dart' as http;

class BookingServices {
  static var baseUri = "http://10.0.2.2:5000/booking/";
  // var baseUri = "http://127.0.0.1:5000/booking/";

  Future<String?> book(body, token) async {
    try {
      var response = await http.post(Uri.parse("$baseUri"),
          headers: {
            'Content-type': 'application/json',
            "Accept": "application/json",
            "Authorization": "Bearer $token"
          },
          body: json.encode(body));
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getAllBooking(token) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "getAllBooks"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } on Exception {
      Exception("invalid login");
    }
  }

  static Future<dynamic> approved(id, status, token) async {
    try {
      var response = await http.put(
        Uri.parse(baseUri + "approved/$id/$status"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> declined(id, status, token) async {
    try {
      var response = await http.put(
        Uri.parse(baseUri + "declined/$id/$status"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getApprovedOnly(id, token) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "get_approved"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> getDeclinedOnly(id, token) async {
    try {
      var response = await http.get(
        Uri.parse(baseUri + "get_decline"),
        headers: {
          'Content-type': 'application/json',
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );
      return response.body;
    } catch (e) {
      print(e);
    }
  }
}
